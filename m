Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6301FAC25
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879188; cv=none; b=NrHi01XP2v/rvDGMeK+DJ5SPoyDlDIsYFZKivsJy0mnJhb4S0YxM8gSs1JyKIpx+dj/wZkbe50MqarKOKCpveAV4KH16NOizv+eLFzXIouxKCRCNAga3zo8y2cuXt4OZ7NjZfckhppP1o7CVjFFVhDRwqECS36sUAbb1u38BXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879188; c=relaxed/simple;
	bh=B5pY+ufn/xH67GEdVxsTK/WgzZnh8fXYnsrdNUXqfj8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S2SJ9j0iyV/lAHFMMQfwI6uMdVNJb8Fadc5D8AtlclHtooHVYd4tcYhdNytEy0Ys7fXwMrLsnj1Q1+v3y/6pn6WziBy6WapvSDcNPtNqtrKKy+3J7e6aN/GZqEFOnHYNgIUJ8RXGfgRJMR7XUH7Sn3D1bfqwapJnLRllOAzw8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844eac513efso459739739f.2
        for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 10:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879185; x=1737483985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8M7djTKBUTreTUQBw+M+8bCMKZY3JTKZMEuUeT5Mp4=;
        b=ot+5f9+w1EU2hkDRgB5kAmlD6z4BjAj6Hmh/j3MdhARtNwcDn81txD7YUhDhb+3aA3
         4xVqGRP9bW7oocpooYBqhaLeTT7UMk5jW9u3I6ehheTN/Fx4RsoBWXZuIUXd0uwkEQha
         a7UgR+XZ3qfQ33X6KbDOorgS1Jj0SIkqoST9QdF1xX0mjVeaRbZlUqJkWA2SxMTuI7Cj
         Y+n3zKDPYEklNUQidpw3tnuJD0COkqaKs671VwpqbJewZAu355UTC/nA9YNesVytIjYH
         NMoJXlnsWlNJ9UMc/GhMdkUUcX8CrVr6rp86lt+a/+cciG/bsx+i27xOssZPPSxlw8Yf
         YD9g==
X-Forwarded-Encrypted: i=1; AJvYcCUK0OeJWGkRbteE/GGfmYId7QIT5kRArSLuD2yjaHE3FqxYND16j6NSiWA8Nz6IxEoyiGtRRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm99y1l/YqLmMpXFIhdawaSKv/g4tIzyiIYldJs6Hoxj8buR58
	uPyrbAMfGwihS9vkpERjfKWNvN0qTbN4qQUeaayE63ZAN+4OnYVlbC0UQKVIZMxDQsWtIfUTEmB
	+jmh4IVtakYRI+zz0YN+RlhOl924hmcG0M/Yho2OrqDzuuzhsfYV3VY0=
X-Google-Smtp-Source: AGHT+IHxRrg/Wtu6yDvyty8sz+Sd+V3FjLWBseH/20TLQ635MG+ieNY5U079Qs03yvoZovBowvUy9+eJvE+NJV5HvqDGiDBGVXf0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:3a7:e8df:3fde with SMTP id
 e9e14a558f8ab-3ce3a942c00mr178661215ab.9.1736879185189; Tue, 14 Jan 2025
 10:26:25 -0800 (PST)
Date: Tue, 14 Jan 2025 10:26:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6786ac51.050a0220.216c54.00a6.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_set_flags (2)
From: syzbot <syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1bf27c4e176 dt-bindings: net: pse-pd: Fix unusual charact..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=177e41df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=cd16e79c1e45f3fe0377
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11262218580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a94cbba6b696/disk-d1bf27c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d5069c51683/vmlinux-d1bf27c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1729677ba0b0/bzImage-d1bf27c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 __mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
Modules linked in:
CPU: 0 UID: 0 PID: 6499 Comm: syz.1.413 Not tainted 6.13.0-rc5-syzkaller-00172-gd1bf27c4e176 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
RIP: 0010:mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
Code: 01 00 00 49 89 c5 e8 fb 45 e8 f5 e9 b8 fc ff ff e8 f1 45 e8 f5 4c 89 f7 be 03 00 00 00 e8 44 1d 0b f9 eb a0 e8 dd 45 e8 f5 90 <0f> 0b 90 e9 17 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c c9 fc ff ff 48
RSP: 0018:ffffc9000d307240 EFLAGS: 00010293
RAX: ffffffff8bb72e03 RBX: 0000000000000000 RCX: ffff88807da88000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000d307430 R08: ffffffff8bb72cf0 R09: 1ffff1100b842a5e
R10: dffffc0000000000 R11: ffffed100b842a5f R12: ffff88801e2e5ac0
R13: ffff88805c214800 R14: ffff88805c2152e8 R15: 1ffff1100b842a5d
FS:  00005555619f6500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002840 CR3: 00000000247e6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5fe8785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff571f5558 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5fe8975fa0 RCX: 00007f5fe8785d29
RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000007
RBP: 00007f5fe8801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5fe8975fa0 R14: 00007f5fe8975fa0 R15: 00000000000011f4
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
