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
        private Queue<int> m_queue = new Queue<int>();
        internal ShortcutItem[] Shortcuts { get; set; }

        // -----------------------------------

        public SimpleAutomator(Process controlledProcess, Action<string> logAction = null)
            : base(controlledProcess, logAction)
        {
        }

        // -----------------------------------

        public override void Start()
        {
            m_queue.Clear();

            base.Start();
        }

        protected override void TickHandler(object source, EventArgs args)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();

            DateTime now = DateTime.Now;
            FireLogAction("Timestamp: " + now.Minute + ":" + now.Second + "." + now.Millisecond);

            for (int i = 0; i < Shortcuts.Length; ++i)
            {
                // Если данный жлемент не в очереди, его следует обработать
                if (!m_queue.Contains(i))
                {
                    if (--Shortcuts[i].TimeLeft <= 0)
                    {
                        // Подошло время, засунем в очередь на нажатие
                        m_queue.Enqueue(i);
                    }
                }
            }

            // Когда очередь не пуста, надо жать кнопки
            if (m_queue.Count > 0)
            {
                int index = m_queue.Dequeue();

                FireLogAction("    Key = " + Shortcuts[index].ShortcutText + " (" + Shortcuts[index].Comment + ")");
                Shortcuts[index].TimeLeft = Shortcuts[index].Timeout;

                SendKey(Shortcuts[index].Key);
            }

            stopwatch.Stop();

            // Задержка до следующего вызова (учитываем время, потраченное на обработку)
            Timer.Interval = TimeSpan.FromMilliseconds(500);
        }
    }
}
