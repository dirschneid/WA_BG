using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Threading;
using System.Drawing;
using System.Windows.Threading;

namespace WAutomator
{
    public class ByTimeAutomator : Automator
    {
        private Dictionary<int, KeyEventArgs> m_timemap;

        // -----------------------------------

        public ByTimeAutomator(Process controlledProcess, Dictionary<int, KeyEventArgs> timemap, Action<string> logAction = null, Action tickAction = null)
            : base(controlledProcess, logAction, tickAction)
        {
            m_timemap = timemap;
        }

        // -----------------------------------

        protected override void TickHandler(object source, EventArgs args)
        {
            // Задержка до следующего вызова
            Timer.Interval = TimeSpan.FromMilliseconds(MasterTickOffset);

            FireTickAction();
        }
    }
}
