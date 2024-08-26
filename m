Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729D82D7F
	for <mptcp@lists.linux.dev>; Mon, 26 Aug 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662227; cv=none; b=GRRz+vZEQ4x2ZN5WuTr3nHYXrNQNiaDI+Cd/ZVVuqSaIXGZ7FejzfnSNK/lUKtmN/SpySgYsP+TnV2xOnn0mZZ1D1Ye0ofcAE/po2elAGZiYyd28/zY94FiLC8ylvVc797lSpnruLbtlZtqxA/KRzi0kaYxIpW3wmpkuiOm50qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662227; c=relaxed/simple;
	bh=7vFJJ3txwB2z0MEcMHTFI2WBhYC02WWYy3xpouFHJKE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GCr0LHOhly4KrotHWZfEhWSytfWg3rh1ylpNsQXK/INRNAfEVJYACLqA6gPUvuyCQamlGRlqLrSGR3fbaCvOt13dgGkTm+axGVumEsSbyadK7YGmtnO80SgD8OPffpsyYZekS1BEGBuZ+Afi3b4UVR9vOjrF/MtO+17DSGw5s/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4a4e4a78so50042885ab.2
        for <mptcp@lists.linux.dev>; Mon, 26 Aug 2024 01:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662225; x=1725267025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bii5ClLr5UsuXWOo+Lybiof65kgdF6FcoRGyCA9/LM=;
        b=KzF0uwsy3frxisLA2k0665Vyp4GRiiDrFvE2cE25zbzoU8GW+ZvkUAGO+xkR0CGf8n
         /cDO3MpT9WPMKuBsjUEKOuqb0/Mb+vykuDre7gqZmDSm3wmA1bWm+L02f+SgiXBkcemu
         +00uA7P4WU8xtFshhvfqWf6W12TEyNKP4fFmZvOhBGXUxy00iuBSP+lXqWaJcAuHC2YR
         g7izsqZ4bk/RiUwVdBcuP7Coy6Ynto81I62mOfPqC4yk+XXqsy7B1Ecvp0mogLLkaY0B
         dUk+26Ed7ORlW305TO6XqKDWu7IxzCnaJcWZRqzUnGVfzwuuI+C48st+BT5cZqwEkSoP
         1/TA==
X-Forwarded-Encrypted: i=1; AJvYcCVwem+slZmpmsVzBB2Wkr11z7m7S0belju+h36/y/fG0hSKB4rViw2f5XcC0XIxDEyTyIc+4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHHodiF7jz2Roei6jawbrz8uy4C57hG9hGIWAYfls6mhdMYSOM
	O7WI8NtP97Oz94Wl6zDfWH4Ur6CDu4oPHJJmtOAzo8fx9y2aHazo7oVOZpmkPO2CezvTuq7+EEm
	X7B5ZnTL+BIkwRiZ8wg3elSxgshKUrqnqLYefIIvqGH7WUC/qB4TbdSY=
X-Google-Smtp-Source: AGHT+IGqLiPf7C/UCIC9sKZ2/snIZVM1VZbI5kIbw2a0v9194pReQWwwrsPRldTGuX+/CK7Z5p6MlV6ubhU2nWZZE/aQEKRndF4W
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:397:fa4e:3df0 with SMTP id
 e9e14a558f8ab-39e3c9e7c0cmr8404455ab.3.1724662225139; Mon, 26 Aug 2024
 01:50:25 -0700 (PDT)
Date: Mon, 26 Aug 2024 01:50:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049861306209237f4@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_set_flags
From: syzbot <syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8af174ea863c net: mana: Fix race of mana_hwc_post_rx_wqe a..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1718a993980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=455d38ecd5f655fc45cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a653d5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86225fd99eec/disk-8af174ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc4394f330d4/vmlinux-8af174ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f30959324a7/bzImage-8af174ea.xz

The issue was bisected to:

commit 322ea3778965da72862cca2a0c50253aacf65fe6
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Date:   Mon Aug 19 19:45:26 2024 +0000

    mptcp: pm: only mark 'subflow' endp as available

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=159fb015980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=179fb015980000
console output: https://syzkaller.appspot.com/x/log.txt?x=139fb015980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
Fixes: 322ea3778965 ("mptcp: pm: only mark 'subflow' endp as available")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 __mark_subflow_endp_available net/mptcp/pm_netlink.c:1467 [inline]
WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1948 [inline]
WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 mptcp_nl_set_flags net/mptcp/pm_netlink.c:1971 [inline]
WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 mptcp_pm_nl_set_flags+0x926/0xd50 net/mptcp/pm_netlink.c:2032
Modules linked in:
CPU: 1 UID: 0 PID: 5507 Comm: syz.3.20 Not tainted 6.11.0-rc4-syzkaller-00138-g8af174ea863c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1467 [inline]
RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1948 [inline]
RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:1971 [inline]
RIP: 0010:mptcp_pm_nl_set_flags+0x926/0xd50 net/mptcp/pm_netlink.c:2032
Code: 00 00 00 49 89 c5 e8 29 b4 ef f5 e9 08 fd ff ff e8 1f b4 ef f5 4c 89 f7 be 03 00 00 00 e8 02 1c 0d f9 eb a0 e8 0b b4 ef f5 90 <0f> 0b 90 e9 14 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c 19 fd ff ff 48
RSP: 0018:ffffc90003adf2a0 EFLAGS: 00010293
RAX: ffffffff8ba3d735 RBX: 1ffff11005fae2ca RCX: ffff888016b73c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003adf470 R08: ffffffff8ba3d621 R09: 1ffff11005fae2cb
R10: dffffc0000000000 R11: ffffed1005fae2cc R12: ffff88802fd71608
R13: ffff88802fd70bc0 R14: 0000000000000000 R15: ffff88802fd71650
FS:  00007fe0b3ff86c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0485fd5fb8 CR3: 000000002e73e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0b3179e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0b3ff8038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe0b3316058 RCX: 00007fe0b3179e79
RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000009
RBP: 00007fe0b31e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe0b3316058 R15: 00007ffd9b67c0d8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
