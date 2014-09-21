#include <linux/module.h>
#include <acpi/acpi.h>
#include <linux/suspend.h>

MODULE_LICENSE("GPL");

static acpi_handle root_handle;

static int kill_nvidia(void)
{
  acpi_status status;
  // The device handle
  acpi_handle handle;
  struct acpi_object_list args;
  // For the return value
  struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };

  status = acpi_get_handle(root_handle, "\\_SB.PCI0.P0P1.VGA._OFF", &handle);
  if (ACPI_FAILURE(status))
  {
      printk("%s: cannot get ACPI handle: %s\n", __func__, acpi_format_exception(status));
      return -ENOSYS;
  }

  args.count = 0;
  args.pointer = NULL;

  status = acpi_evaluate_object(handle, NULL, &args, &buffer);
  if (ACPI_FAILURE(status))
  {
      printk("%s: _OFF method call failed: %s\n", __func__, acpi_format_exception(status));
      return -ENOSYS;
  }
  printk("kfree buffer.pointer"); 
  kfree(buffer.pointer);

  printk("%s: disabled the discrete graphics card\n",__func__);
  return 0;
}

static int power_event(struct notifier_block *this, unsigned long event,
                     void *ptr)
{
      switch (event) {
      case PM_POST_HIBERNATION:
              kill_nvidia();
              return NOTIFY_DONE;
      case PM_POST_SUSPEND:
      case PM_HIBERNATION_PREPARE:
      case PM_SUSPEND_PREPARE:
      default:
              return NOTIFY_DONE;
      }
}

static struct notifier_block power_notifier = {
      .notifier_call = power_event,
};

static int __init asus_nvidia(void)
{
  int ret = register_pm_notifier(&power_notifier);
  if (ret) return ret;
  return kill_nvidia();
}

static int dummy(void)
{
    printk("Module_exit triggered");
    return 0;
}

module_init(asus_nvidia);
module_exit(dummy);
