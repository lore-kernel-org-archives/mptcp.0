Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E638BF72
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770374; cv=none; b=GtXeYhNK+/zHCR6EdtWPJny4rt6P3wQVVifumLHYF3+caAm46TDNThKluSzSmpN5Q8595+CmvXArI2Zo9ffkQlpm+Wwvu2jFzku6N1bwEnhWrzMyrq31bS4A2v1Rk9rO4ZydrKjxd5XqCwtpDi7CpMjEod3BFsEaiGuO5zwN5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770374; c=relaxed/simple;
	bh=oahBO1025qVPSPugkA64I7iVejIAS2a4Gsh5Tbhx5fk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZS6bsO0sZAPmctxaz8pc0eGBjN2tyrEIikvTi33qXeT5SIZgLoBg5Zc/07XWfWQ6WVQzSPZDilrRf0lzFipulQs+WrUMk0JsEzkEIYwdZK0ZO0FZiQDqLUTs9YoS7ntxTIFOcyLBHxG5l83LXBLsQRwdj9UgoazV0G5Y8DRVdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4d2f0f77124so2107090b6e.3
        for <mptcp@lists.linux.dev>; Sun, 11 Oct 2026 18:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770372; x=1792375172;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKk9txmv0mZCyRJL6L+tG/6jg3Fga3i3/ojfl8+Y39s=;
        b=Epwkly+s38AN+sW8yp+77TGGPSmFys0GLHz3QUNnNIvCSUkZBr8cZm2xCXZKZbO6hN
         5zZMj1m7x+2GRYqAvsXApXjrAEVAViqc06EkOzQW7KaRfPKWoKMIZtoXw4O/k8efikyq
         0GgyRJkmrvZunChs91F8aJ4PWCrX/sJETwWCdWfRaksS9OTKquHbOm5HJQfl2IHqgHNj
         pP/kNsix84XqLmW9ZDrbT2HIIhBuRinPEgYhgKGqKv4Q25JRwI/uLVjv6cWE5wZRkIh9
         P+GXLLiltvmi93T+NYRaant7Wntt9mVTQJz7ndEomAFgEzZnhSrdRiemKGfoMsvyoGyD
         16/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwfsK57y0R/f5+g/9vzZFsealyGFaoY+4ECCPLIjsCBeBveH6i3ORcOQJuSLxqz2byTus3Ctg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKf1iQRfnY4MfdgnBYZeN2GBWlXFLDUOd19vrEp7VykdLxiP3YS
	w1qKOx+oFrwRDKeDoqa3HdyDvpp3n+Dn+iLXMBDBtsy5aVRMjKbB41G1QQj0nTFrGLQU8crbVVQ
	m8wXQRX9ZCRs2ZZ8ESq2PAH1h2t4UNOvzj+dk/uzEb5pknIFt+TxbWmAv4YI=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3c2:b0:4ed:7045:d3bc with SMTP id
 5614622812f47-50c50f29bf2mr7110424b6e.32.1791770372245; Sun, 11 Oct 2026
 18:59:32 -0700 (PDT)
Date: Sun, 11 Oct 2026 18:59:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acc3f04.a150a118.27e199.003f.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in __mptcp_move_skbs_from_subflow (3)
From: syzbot <syzbot+a0f240a492551e97b466@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    af32da41b032 Merge tag 'net-7.3-rc7' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14b48c9c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4118aaa2d227be26
dashboard link: https://syzkaller.appspot.com/bug?extid=a0f240a492551e97b466
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/67d1818d6d97/disk-af32da41.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/903b9a3843fb/vmlinux-af32da41.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b878ac72b487/bzImage-af32da41.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0f240a492551e97b466@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: net/mptcp/protocol.c:855 at __mptcp_move_skbs_from_subflow+0x11cf/0x19a0 net/mptcp/protocol.c:855, CPU#1: syz.4.337/7111
Modules linked in:
CPU: 1 UID: 0 PID: 7111 Comm: syz.4.337 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
RIP: 0010:__mptcp_move_skbs_from_subflow+0x11cf/0x19a0 net/mptcp/protocol.c:855
Code: b6 04 26 84 c0 0f 85 57 05 00 00 41 c6 07 00 e9 e6 f5 ff ff e8 92 5d f7 f5 90 0f 0b 90 48 8b 5c 24 30 eb 0c e8 82 5d f7 f5 90 <0f> 0b 90 4d 89 ec 48 8b 7c 24 68 e8 11 13 01 00 e9 50 fd ff ff e8
RSP: 0018:ffffc90000a18120 EFLAGS: 00010246
RAX: ffffffff8bd0b1be RBX: ffff88802a7bf8e0 RCX: ffff888035d8be80
RDX: 8000000000000300 RSI: 0000000000000100 RDI: 0000000000004500
RBP: ffffc90000a18328 R08: 0000000000000100 R09: 1ffff110048f1958
R10: dffffc0000000000 R11: ffffed10048f1959 R12: 0000000000007fe4
R13: dffffc0000000000 R14: 000000002f8eae63 R15: 0000000000004500
FS:  00007f14a00f66c0(0000) GS:ffff888123bbf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000287000 CR3: 000000007ec44000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 move_skbs_to_msk net/mptcp/protocol.c:971 [inline]
 mptcp_data_ready+0x3f5/0xc20 net/mptcp/protocol.c:1028
 subflow_data_ready+0x2bc/0x7f0 net/mptcp/subflow.c:1540
 tcp_data_queue+0x1e94/0x5fa0 net/ipv4/tcp_input.c:5700
 tcp_rcv_established+0xb05/0x2940 net/ipv4/tcp_input.c:6696
 tcp_v4_do_rcv+0x727/0x13b0 net/ipv4/tcp_ipv4.c:1854
 tcp_v4_rcv+0x27d4/0x3170 net/ipv4/tcp_ipv4.c:2248
 ip_protocol_deliver_rcu+0x21d/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:325
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:325
 __netif_receive_skb_one_core net/core/dev.c:6297 [inline]
 __netif_receive_skb net/core/dev.c:6410 [inline]
 process_backlog+0xa6b/0x18b0 net/core/dev.c:6761
 __napi_poll+0xaa/0x330 net/core/dev.c:7830
 napi_poll net/core/dev.c:7893 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:8050
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 do_softirq+0x77/0xd0 kernel/softirq.c:546
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x140 kernel/softirq.c:473
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 __dev_queue_xmit+0x1efb/0x3920 net/core/dev.c:4993
 dev_queue_xmit include/linux/netdevice.h:3464 [inline]
 neigh_hh_output include/net/neighbour.h:544 [inline]
 neigh_output include/net/neighbour.h:558 [inline]
 ip_finish_output2+0xbda/0x10b0 net/ipv4/ip_output.c:236
 NF_HOOK_COND include/linux/netfilter.h:314 [inline]
 ip_output+0x29f/0x450 net/ipv4/ip_output.c:437
 __ip_queue_xmit+0x10df/0x1b10 net/ipv4/ip_output.c:533
 __tcp_transmit_skb+0x2d18/0x47c0 net/ipv4/tcp_output.c:1717
 tcp_transmit_skb net/ipv4/tcp_output.c:1734 [inline]
 tcp_write_xmit+0x1bfa/0x6400 net/ipv4/tcp_output.c:3062
 __tcp_push_pending_frames+0x96/0x380 net/ipv4/tcp_output.c:3245
 mptcp_push_release net/mptcp/protocol.c:1668 [inline]
 __mptcp_push_pending+0x60f/0x900 net/mptcp/protocol.c:1809
 mptcp_sendmsg+0x11ea/0x1d10 net/mptcp/protocol.c:2110
 sock_sendmsg_nosec+0x90/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f149f19e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14a00f6028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f149f425fa0 RCX: 00007f149f19e1d9
RDX: 0000000000040010 RSI: 00002000000008c0 RDI: 0000000000000007
RBP: 00007f149f235888 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f149f426038 R14: 00007f149f425fa0 R15: 00007ffe2ec5e878
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
