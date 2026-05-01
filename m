Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06622236E3
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777616136; cv=none; b=Os9LBTj58Oaf4GE/lB09ijyqjk4rraUiOasuutP8PMi20T0e+biv7j6bA7JtwEQdijtdQyr6LOQVxlKGNp5Oad8FVgMOVRve03HEiwEv75egbhlI+oaQ5kSazmI25XUWug8ItpuofK3+XyNga3yU2enAo+rTSz9NkwSzo4Yg59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777616136; c=relaxed/simple;
	bh=qZ4WU2pBlLmoGsXwq3Ezn4egfYWE9pBO/xwux0q5+PY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=beqC/HxUaNPXZHve0+LDXRqxmAWm+b6e4mhspqAlT5y97qBowIF2gp6OfYlOndbB0EL+9eMyZVdf7tpNZkWfZzSdWLoQ3Uk5CmRz7FkMqZHz4XjoipWf2dqODrKLDHcD+EDfvEmndtT5hohiiLCXd5cTHNpM/I90v2aWJBfEOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7dbc09d4e43so4202124a34.1
        for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 23:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777616134; x=1778220934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnYtTOTH4t5DEazx+JuK0nr+p0ULTXMDrk/Z6Bp4+xc=;
        b=nfz9ro4o7zYF/WE7TG80CPR9f9wFdOO7gkzT08Rvrm6fxVw87ZUlX3CoOy+yFo4dw3
         T/41w+BUnMjt3ZK0sPhxY/CpQhEDzsb6tdSoy8GoorvFthkZbo3VJb/Lb1A8cGJswkAD
         yEXygG1EhzqFbOytqfQJB0t4SOfoeGAE7Mb+GHAm6aTkQHIhkWsnVSqRuruChxKfOb+X
         bKoWREZA3vCKtxkz5zOmh8fZ/T6kXXbPKBzNtriEyLMcVckA+z1rfNs9QziGQrm4hiUI
         sPjcTGEY4lHMFzOn9+0PIiHLowA8SAETVBBNEfhmYD19FllPhk7nJQol4govwGmtYjN0
         D1vQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f4PxI4YUqfT1N6TD1PK/NLpc00ZnYjCvxMR6E0TBlTQNZ3nBMIw/enyjgTxitDrXQQDWKIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJkC5buQtjeKzaTUvHMCr849GZb8fBQeOxlNBQeng8ANpT+kCy
	6yB6WQ8ca7/MheTebag/RIi8wm5znFzaYxIY0dVTFAp+Ck7o90Ud28NmvQB/a8qe0u29AUj28Of
	Wtrvg0kccgoaqNI2II3nJC9x7T0Id9DLhaQovFwj+WoDMAjac8Q0I1id9Iwo=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160a:b0:694:95ae:c546 with SMTP id
 006d021491bc7-6967bcc8597mr2734595eaf.2.1777616133780; Thu, 30 Apr 2026
 23:15:33 -0700 (PDT)
Date: Thu, 30 Apr 2026 23:15:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f44505.050a0220.3cbe47.0008.GAE@google.com>
Subject: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
From: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08d0d3466664 Merge tag 'net-7.1-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f6976c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c3f61154f3bb7e5
dashboard link: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8688db3eb9ae/disk-08d0d346.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72c570681077/vmlinux-08d0d346.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21669c9bddcd/bzImage-08d0d346.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options_dss net/mptcp/options.c:590 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 mptcp_write_data_fin net/mptcp/options.c:542 [inline]
 mptcp_established_options_dss net/mptcp/options.c:590 [inline]
 mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
 __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
 tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
 mptcp_subflow_shutdown+0x164/0x690 net/mptcp/protocol.c:3137
 mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
 __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
 __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
 mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
 inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_close+0xd6/0x2f0 net/socket.c:1514
 __fput+0x60e/0x1010 fs/file_table.c:510
 ____fput+0x25/0x30 fs/file_table.c:538
 task_work_run+0x208/0x2b0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 __do_fast_syscall_32+0x2c7/0x460 arch/x86/entry/syscall_32.c:310
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable opts created at:
 __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499

CPU: 0 UID: 0 PID: 24584 Comm: syz.4.6812 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
