Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09748164D
	for <mptcp@lists.linux.dev>; Wed, 21 Jan 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989809; cv=none; b=hkHVZsHDRl1bW8IDqnQ718Sgfy/vJuQJGcJObPtFpLgTNVQomynMB5gSian97e9s+mFl/J7ibvxvC2fDnwVS6W2c4QeWpmvWgxIR/6JH576iAHRXUw3KC4GKv/B7rxciucgJnD4BsbftBNzni9zd58uy/t5ylhti6OBXaEqVCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989809; c=relaxed/simple;
	bh=a8lRbOZtGBevnU6kM7N4iWrnq0zLG+iolcddCE+0i+w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NFnmnZVRG/w82iGZBULLF6M5BRNeniP0VjliAFZefiSiWDL6wnnBj58Ot8vfNTIIniV4r/WIu5tFxvRrw+75fySBVd0OtxcLTb3XwOJ2rxfzYxWJCrzs+/cDU+DNKvXHpHLSvm5jn67t2cStBaR98mE02KUILC9vJvz8QzJYK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-66112077695so8273074eaf.2
        for <mptcp@lists.linux.dev>; Wed, 21 Jan 2026 02:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989806; x=1769594606;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdyniw39ghninlZtPjfoFJ6njLUlXXDlw/5pb7W19XE=;
        b=RR+muDrz1F/zrzweC+ndSIELHXNeUbgRXKZOx97iPXTo1R+3oyV5PrYNRCx2rrJRiC
         n1DafI7A4k+63FdMIl7lOrwFOnqtMPpd6AUT1RStSkJPrZ4RsixTKgJVg5XVsDmEA+KD
         Y6fUX4wz1lDEIyqynBqS0yZecnA4ZupDxuvfWunmAV+haDVNTWkGc7IhttZ0cz/iAhZY
         +WtWFb8UpP8Nwuc/CPsT5/146lEq82cMAzNxQWKWGXbhRstb4S4Fjz9NMPY5vfpRhoSs
         ZwKQ4jX/hBK9iI4L9e3m1pyicMfcRgKsA7itDrCO/mheuOUt4U//ix6RmdtX/WKAkSRH
         dFuw==
X-Forwarded-Encrypted: i=1; AJvYcCVWAK//HByFohtrixVo3SZLKCjx9FtBIWxBCnSk0CZL3ym8y5hQKBoZW12QcBGy3i0YOYOnUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye6YDC7ameeLwIb+l6XvW4PGExbCraJjZBfOynxOAwbvwvjyjk
	I7UMWM4CdqvwfpVS4hR7C3d/HRCcYXSMP1kY0YQGwdQNNNOSm4xbw71LytZHLPfTsVh8DMPkFHd
	/vhgML1Th1cYA9Lg+w+z2vj7TK+GjOmcNm9QeWOBVUFuxeNdmSBaS3/LoXfQ=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2229:b0:65d:bb62:805 with SMTP id
 006d021491bc7-66118924814mr7532463eaf.41.1768989805924; Wed, 21 Jan 2026
 02:03:25 -0800 (PST)
Date: Wed, 21 Jan 2026 02:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com>
Subject: [syzbot] [mptcp?] KASAN: stack-out-of-bounds Read in mptcp_pm_nl_get_local_id
From: syzbot <syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22cc16c04b78 riscv, bpf: Fix incorrect usage of BPF_TRAMP_..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=10be528a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=5498a510ff9de39d37da
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43a53493cb5f/disk-22cc16c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9726fb9e1980/vmlinux-22cc16c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efd2bc050ab6/bzImage-22cc16c0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in __lookup_addr net/mptcp/pm_kernel.c:283 [inline]
BUG: KASAN: stack-out-of-bounds in mptcp_pm_nl_get_local_id+0x183/0x330 net/mptcp/pm_kernel.c:905
Read of size 2 at addr ffffc90003237354 by task syz.8.3557/19241

CPU: 0 UID: 0 PID: 19241 Comm: syz.8.3557 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __lookup_addr net/mptcp/pm_kernel.c:283 [inline]
 mptcp_pm_nl_get_local_id+0x183/0x330 net/mptcp/pm_kernel.c:905
 mptcp_pm_get_local_id+0x4ab/0x5b0 net/mptcp/pm.c:925
 subflow_chk_local_id+0x101/0x220 net/mptcp/subflow.c:641
 subflow_v6_rebuild_header+0x16/0x50 net/mptcp/subflow.c:664
 tcp_connect+0x205/0x4f50 net/ipv4/tcp_output.c:4312
 tcp_v6_connect+0x1222/0x18a0 net/ipv6/tcp_ipv6.c:336
 mptcp_connect+0x56b/0x830 net/mptcp/protocol.c:3977
 __inet_stream_connect+0x2ae/0xe70 net/ipv4/af_inet.c:679
 tcp_sendmsg_fastopen+0x3a7/0x5e0 net/ipv4/tcp.c:1064
 mptcp_sendmsg_fastopen+0x17d/0x580 net/mptcp/protocol.c:1780
 mptcp_sendmsg+0x179f/0x19b0 net/mptcp/protocol.c:1880
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe5/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x820 net/socket.c:2592
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5218b8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5219a1c038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5218de6090 RCX: 00007f5218b8f749
RDX: e07e872420dfef8a RSI: 0000200000000780 RDI: 0000000000000003
RBP: 00007f5218c13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5218de6128 R14: 00007f5218de6090 R15: 00007ffd434acc78
 </TASK>

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc90003230000 allocated at copy_process+0x4ea/0x3950 kernel/fork.c:2052
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x7f2bc8e1d pfn:0x6bcdf
memcg:ffff88801df3ec02
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 00000007f2bc8e1d 0000000000000000 00000001ffffffff ffff88801df3ec02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 19239, tgid 19239 (syz.8.3557), ts 697879712329, free_ts 697878067160
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_frozen_pages_noprof mm/mempolicy.c:2557 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2577
 vm_area_alloc_pages mm/vmalloc.c:3649 [inline]
 __vmalloc_area_node mm/vmalloc.c:3863 [inline]
 __vmalloc_node_range_noprof+0x795/0x16a0 mm/vmalloc.c:4051
 __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:4111
 alloc_thread_stack_node kernel/fork.c:354 [inline]
 dup_task_struct+0x228/0x9a0 kernel/fork.c:923
 copy_process+0x4ea/0x3950 kernel/fork.c:2052
 kernel_clone+0x21e/0x820 kernel/fork.c:2651
 __do_sys_clone3 kernel/fork.c:2953 [inline]
 __se_sys_clone3+0x256/0x2d0 kernel/fork.c:2932
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 19240 tgid 19239 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 bpf_check+0x164a7/0x1c300 kernel/bpf/verifier.c:25396
 bpf_prog_load+0x13ba/0x1a10 kernel/bpf/syscall.c:3088
 __sys_bpf+0x507/0x860 kernel/bpf/syscall.c:6164
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc90003237200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003237280: 00 00 00 00 f1 f1 f1 f1 00 01 f2 f2 00 01 f2 f2
>ffffc90003237300: 00 f2 f2 f2 00 f2 f2 f2 00 00 f3 f3 00 00 00 00
                                                 ^
 ffffc90003237380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003237400: f1 f1 f1 f1 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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
