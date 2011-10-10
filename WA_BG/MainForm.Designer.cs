namespace WA_BG
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.uiRunButton = new System.Windows.Forms.Button();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.uiStopButton = new System.Windows.Forms.Button();
            this.uiShortcuts = new System.Windows.Forms.ListView();
            this.columnHeaderShortcut = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeaderTimeout = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeaderComment = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.uiRemoveShortcutButton = new System.Windows.Forms.Button();
            this.uiAddShortcutButton = new System.Windows.Forms.Button();
            this.uiSaveButton = new System.Windows.Forms.Button();
            this.uiLoadButton = new System.Windows.Forms.Button();
            this.uiEditShortcutButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // uiRunButton
            // 
            this.uiRunButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.uiRunButton.Location = new System.Drawing.Point(380, 553);
            this.uiRunButton.Name = "uiRunButton";
            this.uiRunButton.Size = new System.Drawing.Size(75, 23);
            this.uiRunButton.TabIndex = 0;
            this.uiRunButton.Text = "Run";
            this.uiRunButton.UseVisualStyleBackColor = true;
            this.uiRunButton.Click += new System.EventHandler(this.btnRun_Click);
            // 
            // listBox1
            // 
            this.listBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.listBox1.FormattingEnabled = true;
            this.listBox1.Location = new System.Drawing.Point(12, 354);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(362, 251);
            this.listBox1.TabIndex = 1;
            // 
            // uiStopButton
            // 
            this.uiStopButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.uiStopButton.Enabled = false;
            this.uiStopButton.Location = new System.Drawing.Point(380, 582);
            this.uiStopButton.Name = "uiStopButton";
            this.uiStopButton.Size = new System.Drawing.Size(75, 23);
            this.uiStopButton.TabIndex = 2;
            this.uiStopButton.Text = "Stop";
            this.uiStopButton.UseVisualStyleBackColor = true;
            this.uiStopButton.Click += new System.EventHandler(this.btnStop_Click);
            // 
            // uiShortcuts
            // 
            this.uiShortcuts.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.uiShortcuts.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeaderShortcut,
            this.columnHeaderTimeout,
            this.columnHeaderComment});
            this.uiShortcuts.FullRowSelect = true;
            this.uiShortcuts.GridLines = true;
            this.uiShortcuts.Location = new System.Drawing.Point(12, 25);
            this.uiShortcuts.Name = "uiShortcuts";
            this.uiShortcuts.Size = new System.Drawing.Size(362, 310);
            this.uiShortcuts.TabIndex = 4;
            this.uiShortcuts.UseCompatibleStateImageBehavior = false;
            this.uiShortcuts.View = System.Windows.Forms.View.Details;
            this.uiShortcuts.ItemSelectionChanged += new System.Windows.Forms.ListViewItemSelectionChangedEventHandler(this.uiShortcuts_ItemSelectionChanged);
            this.uiShortcuts.DoubleClick += new System.EventHandler(this.uiEditButton_Click);
            // 
            // columnHeaderShortcut
            // 
            this.columnHeaderShortcut.Text = "Shortcut";
            this.columnHeaderShortcut.Width = 120;
            // 
            // columnHeaderTimeout
            // 
            this.columnHeaderTimeout.Text = "Timeout";
            this.columnHeaderTimeout.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // columnHeaderComment
            // 
            this.columnHeaderComment.Text = "Comment";
            this.columnHeaderComment.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.columnHeaderComment.Width = 170;
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 338);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Keypress log:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(9, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(55, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Shortcuts:";
            // 
            // uiRemoveShortcutButton
            // 
            this.uiRemoveShortcutButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiRemoveShortcutButton.Enabled = false;
            this.uiRemoveShortcutButton.Location = new System.Drawing.Point(380, 54);
            this.uiRemoveShortcutButton.Name = "uiRemoveShortcutButton";
            this.uiRemoveShortcutButton.Size = new System.Drawing.Size(75, 23);
            this.uiRemoveShortcutButton.TabIndex = 7;
            this.uiRemoveShortcutButton.Text = "Remove";
            this.uiRemoveShortcutButton.UseVisualStyleBackColor = true;
            this.uiRemoveShortcutButton.Click += new System.EventHandler(this.uiRemoveShortcutButton_Click);
            // 
            // uiAddShortcutButton
            // 
            this.uiAddShortcutButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.uiAddShortcutButton.Location = new System.Drawing.Point(380, 25);
            this.uiAddShortcutButton.Name = "uiAddShortcutButton";
            this.uiAddShortcutButton.Size = new System.Drawing.Size(75, 23);
            this.uiAddShortcutButton.TabIndex = 8;
            this.uiAddShortcutButton.Text = "Add";
            this.uiAddShortcutButton.UseVisualStyleBackColor = true;
            this.uiAddShortcutButton.Click += new System.EventHandler(this.uiAddShortcutButton_Click);
            // 
            // uiSaveButton
            // 
            this.uiSaveButton.Location = new System.Drawing.Point(380, 312);
            this.uiSaveButton.Name = "uiSaveButton";
            this.uiSaveButton.Size = new System.Drawing.Size(75, 23);
            this.uiSaveButton.TabIndex = 9;
            this.uiSaveButton.Text = "Save";
            this.uiSaveButton.UseVisualStyleBackColor = true;
            this.uiSaveButton.Click += new System.EventHandler(this.uiSaveButton_Click);
            // 
            // uiLoadButton
            // 
            this.uiLoadButton.Location = new System.Drawing.Point(380, 283);
            this.uiLoadButton.Name = "uiLoadButton";
            this.uiLoadButton.Size = new System.Drawing.Size(75, 23);
            this.uiLoadButton.TabIndex = 10;
            this.uiLoadButton.Text = "Load";
            this.uiLoadButton.UseVisualStyleBackColor = true;
            this.uiLoadButton.Click += new System.EventHandler(this.uiLoadButton_Click);
            // 
            // uiEditShortcutButton
            // 
            this.uiEditShortcutButton.Enabled = false;
            this.uiEditShortcutButton.Location = new System.Drawing.Point(380, 83);
            this.uiEditShortcutButton.Name = "uiEditShortcutButton";
            this.uiEditShortcutButton.Size = new System.Drawing.Size(75, 23);
            this.uiEditShortcutButton.TabIndex = 11;
            this.uiEditShortcutButton.Text = "Edit";
            this.uiEditShortcutButton.UseVisualStyleBackColor = true;
            this.uiEditShortcutButton.Click += new System.EventHandler(this.uiEditButton_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(467, 612);
            this.Controls.Add(this.uiEditShortcutButton);
            this.Controls.Add(this.uiLoadButton);
            this.Controls.Add(this.uiSaveButton);
            this.Controls.Add(this.uiAddShortcutButton);
            this.Controls.Add(this.uiRemoveShortcutButton);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.uiShortcuts);
            this.Controls.Add(this.uiStopButton);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.uiRunButton);
            this.MinimumSize = new System.Drawing.Size(450, 650);
            this.Name = "MainForm";
            this.Text = "WA - BG";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MainForm_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button uiRunButton;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Button uiStopButton;
        private System.Windows.Forms.ListView uiShortcuts;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button uiRemoveShortcutButton;
        private System.Windows.Forms.Button uiAddShortcutButton;
        private System.Windows.Forms.ColumnHeader columnHeaderShortcut;
        private System.Windows.Forms.ColumnHeader columnHeaderTimeout;
        private System.Windows.Forms.Button uiSaveButton;
        private System.Windows.Forms.Button uiLoadButton;
        private System.Windows.Forms.Button uiEditShortcutButton;
        private System.Windows.Forms.ColumnHeader columnHeaderComment;
    }
}

