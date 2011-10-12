using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Diagnostics;

namespace WA_BG
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            const string ProcessName = "WoW";

            Process[] processes = Process.GetProcessesByName(ProcessName);
            if (processes.Length == 0)
            {
                MessageBox.Show("Загрузите " + ProcessName);
                return;
            }

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm(processes[0]));
        }
    }
}
