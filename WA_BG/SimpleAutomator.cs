using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WAutomator;
using System.Windows.Forms;
using System.Diagnostics;

namespace WA_BG
{
    public class SimpleAutomator : Automator
    {
        //// Мои кнопки
        //private static KeyEventArgs[] m_radamsaKeys = new KeyEventArgs[] { 
        //        new KeyEventArgs(Keys.D5), 
        //        new KeyEventArgs(Keys.D6),
        //        new KeyEventArgs(Keys.D7), 
        //        new KeyEventArgs(Keys.D8), 
        //        new KeyEventArgs(Keys.D9), 
        //        new KeyEventArgs(Keys.T),
        //        new KeyEventArgs(Keys.J)
        //    };

        //// Для Бубы
        //private static KeyEventArgs[] m_bubaKeys = new KeyEventArgs[] { 
        //        new KeyEventArgs(Keys.D6), 
        //        new KeyEventArgs(Keys.D7),
        //        new KeyEventArgs(Keys.D8), 
        //        new KeyEventArgs(Keys.D9), 
        //        new KeyEventArgs(Keys.D0), 
        //        new KeyEventArgs(Keys.Z),
        //        new KeyEventArgs(Keys.I)
        //    };

        //private int m_keypressCount = 0;

        public bool UseAlternateKeys { get; set; }
        internal ShortcutItem[] Shortcuts { get; set; }

        // -----------------------------------

        public SimpleAutomator(Process controlledProcess, Action<string> logAction = null, Action tickAction = null)
            : base(controlledProcess, logAction, tickAction)
        {
        }

        // -----------------------------------

        protected override void TickHandler(object source, EventArgs args)
        {
            //KeyEventArgs[] keys = UseAlternateKeys ? m_bubaKeys : m_radamsaKeys;

            //// Задержка до следующего вызова
            //Timer.Interval = TimeSpan.FromMilliseconds(MasterTickOffset);

            //// Пока реализуем обычный кликер

            //if (++m_keypressCount >= keys.Length)
            //    m_keypressCount = 0;

            //int keyId = m_keypressCount;

            //FireLogAction(string.Format("interval = {0}, keyId = {1}", Timer.Interval.TotalMilliseconds, keyId));
            //FireTickAction();

            //SendKey(keys[keyId]);

            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();

            FireTickAction();

            DateTime now = DateTime.Now;
            FireLogAction("Timestamp: " + now.Minute + ":" + now.Second + "." + now.Millisecond);

            KeyEventArgs activeKey = null;
            for (int i = 0; i < Shortcuts.Length; ++i)
            {
                if (--Shortcuts[i].TimeLeft <= 0)
                {
                    // Только одну кнопку жмем за раз
                    if (null == activeKey)
                    {
                        FireLogAction("    Key = " + Shortcuts[i].ShortcutText);
                        Shortcuts[i].TimeLeft = Shortcuts[i].Timeout;
                        activeKey = Shortcuts[i].Shortcut;
                    }
                }
            }

            if (null != activeKey)
                SendKey(activeKey);

            stopwatch.Stop();

            // Задержка до следующего вызова (учитываем время, потраченное на обработку)
            Timer.Interval = TimeSpan.FromMilliseconds(500);
        }
    }
}
