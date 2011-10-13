using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WAutomator;
using System.Windows.Forms;
using System.Diagnostics;
using System.Drawing;

namespace WA_BG
{
    public class KeypressAutomator : Automator
    {
        private Queue<int> m_queue = new Queue<int>();
        internal ShortcutItem[] Shortcuts { get; set; }
        internal decimal Interval { get; set; }

        // -----------------------------------

        public KeypressAutomator(Action<string> logAction = null)
            : base(null, logAction)
        {
        }

        // -----------------------------------

        public override void Start(Process controlledProcess)
        {
            m_queue.Clear();

            for (int i = 0; i < Shortcuts.Length; i++)
            {
                Shortcuts[i].ResetTimeout();
            }

            base.Start(controlledProcess);
        }

        protected override void TickHandler(object source, EventArgs args)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();

            DateTime now = DateTime.Now;
            FireLogAction("Timestamp: " + now.Minute + ":" + now.Second + "." + now.Millisecond);

            for (int i = 0; i < Shortcuts.Length; ++i)
            {
                // Если данный элемент не в очереди, его следует обработать
                if (!m_queue.Contains(i))
                {
                    Shortcuts[i].TimeLeft -= Interval; // В секундах с дробной частью
                    if (Shortcuts[i].TimeLeft <= 0)
                    {
                        // Если нужно, прверим цвет
                        if (Shortcuts[i].CheckColor)
                        {
                            Color color = GetPixeColor(Shortcuts[i].CoordX, Shortcuts[i].CoordY);
                            if (!Shortcuts[i].IsColorEqualTo(color))
                            {
                                Shortcuts[i].TimeLeft = -1; // Дабы не "уйти" далеко в минус
                                continue;
                            }
                        }

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
                Shortcuts[index].ResetTimeout();

                SendKey(Shortcuts[index].Key);
            }

            stopwatch.Stop();

            // Задержка до следующего вызова (учитываем время, потраченное на обработку)
            var interval = TimeSpan.FromMilliseconds(decimal.ToDouble(Interval * 1000) - 20) - stopwatch.Elapsed;
            Timer.Interval = interval.Ticks <= 0 ? TimeSpan.Zero : interval;
        }
    }
}
