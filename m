Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9F16132F
	for <mptcp@lists.linux.dev>; Sat, 25 Oct 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410124; cv=none; b=HOdEv7op+tXszErRrInnaYZMAlaoDp/5jTmue8E6j6pYeDvTzAEd23Nu5FrO2UzlcaiWcX/s8DI/LpEDQGhLbMYe6ooDA3MiiaUNwvvpluctE/DEcvdLvoyFwnKQMyXK+YjgHaK8STOAHELyBQyqJofw9NQjNd3+xpeOisw66Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410124; c=relaxed/simple;
	bh=iyOBRl5QZhzw+5Ro5vJB2OJl2o9qrxD7/mSjzKjx6KI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LAPEFbdh7YnBiWTDr6udwWLE6hf846WnqpJf/F08iwsX/Phzn8dFSRvytYwO/hU5+/kaPav9HM3KoM+sThrBkAdQSAzSIBrOgoqoKYaLYRfAmbJ0MAStMMNH7lIAZVT61ybOgEgW2YnuElXsMxQx6SVF4lo+iQE1N8SpJfuYMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430afceae09so35080905ab.0
        for <mptcp@lists.linux.dev>; Sat, 25 Oct 2025 09:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410122; x=1762014922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/TBpiav1G79AIOTkdY4adnGJwgmMIA5+MCuyC38fbg=;
        b=CNY/i4o1qhWyKy9Prz7/ZPqbQWu002JYmoCUi/+HOvv2BnnVcVSzvw0n1hq/cAbRQd
         N6cjSoJmaXeXLCeU4RfH9U6Ojpl+o1CyBxjIeyDn1clkafwNcoqq/ijxs3vEAC2c3rZO
         Jnb+MJOCk6yFJuBcvxGB/Eqsa4etDORgHdhNHnqEIDfiYgDKozkP7OyJ8bkUPOX2yC8+
         JCCKvTmgt/SaEs9JnIoTgVXVzt8K5Wwc16FZD3n3BYiCwXrm2MV6j+7QSNfUhaHPcPTV
         T+TXtTDm0NOgJWDEMFFuPiJZsurwCho27o+eS6eoTec7aLzXgVokvsoESLFPPSq5a2S7
         ViIg==
X-Forwarded-Encrypted: i=1; AJvYcCW7eaHZUB7PNNlPf0/eaK36bu0Q36rRDuYw7p2fcsb9CZ5zh0UMea8q/Q/+BGgurtkCMHX5hA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHxq6G9zY97OLxuIPfLQGnQapfqRvodzGMJRA8bV3zf8ZosJ04
	sKtgh7BJPeMsmekRDllVdHjD7lun3C7pLcZpfe/U9orxXbMB6DjJPOxTLFa5lVJ+1KVj3HGsP+x
	xKChYehlyrMRC+hiVQFryIswtUzHZp+do/YGPC4iVLN/6rN+71EW5s755DSA=
X-Google-Smtp-Source: AGHT+IGeqEzwanU1biO5d+ivaOCUX5hEsxCyYT+xT+jf2Li+zt8m+I5UT6TpcYDR9S2JPh6BYwnuqkplXrB0G8rg6VjlCJJZR0ul
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f04:b0:430:c49d:750c with SMTP id
 e9e14a558f8ab-431ebed79admr77062145ab.27.1761410122404; Sat, 25 Oct 2025
 09:35:22 -0700 (PDT)
Date: Sat, 25 Oct 2025 09:35:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcfc4a.050a0220.346f24.02fb.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_del_addr_doit
From: syzbot <syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6548d364a3e8 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da4e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f953a3e1b3e60637
dashboard link: https://syzkaller.appspot.com/bug?extid=f56f7d56e2c6e11a01b6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6472a8e035a/disk-6548d364.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1547185ddf28/vmlinux-6548d364.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4610741deb8/bzImage-6548d364.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.7.6472'.
netlink: 8 bytes leftover after parsing attributes in process `syz.7.6472'.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 27976 at net/mptcp/pm_kernel.c:1053 __mark_subflow_endp_available net/mptcp/pm_kernel.c:1053 [inline]
WARNING: CPU: 0 PID: 27976 at net/mptcp/pm_kernel.c:1053 mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_kernel.c:1088 [inline]
WARNING: CPU: 0 PID: 27976 at net/mptcp/pm_kernel.c:1053 mptcp_pm_nl_del_addr_doit+0xe2c/0x11d0 net/mptcp/pm_kernel.c:1190
Modules linked in:
CPU: 0 UID: 0 PID: 27976 Comm: syz.7.6472 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_kernel.c:1053 [inline]
RIP: 0010:mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_kernel.c:1088 [inline]
RIP: 0010:mptcp_pm_nl_del_addr_doit+0xe2c/0x11d0 net/mptcp/pm_kernel.c:1190
Code: 01 00 00 49 89 c6 e8 93 b2 82 f6 e9 ed fb ff ff e8 89 b2 82 f6 48 89 df be 03 00 00 00 e8 ac 8d 53 f9 eb 9c e8 75 b2 82 f6 90 <0f> 0b 90 e9 90 fe ff ff 89 d9 80 e1 07 38 c1 0f 8c d9 fb ff ff 48
RSP: 0018:ffffc9000c3e71a0 EFLAGS: 00010283
RAX: ffffffff8b3d917b RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc90019844000 RSI: 0000000000009d14 RDI: 0000000000009d15
RBP: ffffc9000c3e73b0 R08: ffff88802f74eea7 R09: 1ffff11005ee9dd4
R10: dffffc0000000000 R11: ffffed1005ee9dd5 R12: ffff888068e67080
R13: ffff88802f74ee98 R14: ffff88802f74e400 R15: 1ffff11005ee9dd3
FS:  00007f57ed7746c0(0000) GS:ffff888125d06000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000c038 CR3: 000000004ebf8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57ec98efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f57ed774038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f57ecbe6090 RCX: 00007f57ec98efc9
RDX: 000000002000c094 RSI: 0000200000000000 RDI: 0000000000000009
RBP: 00007f57eca11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f57ecbe6128 R14: 00007f57ecbe6090 R15: 00007ffeff6c13c8
 </TASK>


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
