Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2118C11
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737077344; cv=none; b=uY6PLW7OcIpL2kWjp8oMfMnDTG549fBlovGXbRp9BJwVMuAeWIORqHm3Of1W2Psd4aBPJUrfGe2vQwvkq0mzPIq3xFzjXLnAr9hP7mFYjui5/C0GCNWf+SEq5zqGwkcsXnoVfDblC0eyay/UNfWUMOFLHVpZ5eL0wxSH+gpRirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737077344; c=relaxed/simple;
	bh=3ZFxfSvBQyEWeLUHZKpPapEsit59YpD/Gg49L87DLeE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ucAicDj/COAVhdCMqoQZlBrOVdm090o3Ltr3UqG6JmFF3U1HTrkb4fYpXa+xcJcfY2xsUuEjQXqYQdVIOfgNHHXGT2MW2msp00rx7TBitNvOzAzwojDGvvMrILqX/RhHsg2EYkinojP8ZIenii4Pt55lgugZEFOepumx4fUXC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce8db7c342so31231315ab.3
        for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 17:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737077342; x=1737682142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07Ytoi0hjK8+ls/adsIB+4E4oErAve/HtgMUwetnTK0=;
        b=NZOfoDo1MKIiL6WyGpBQ789HuJ0+0RQVJx7I8GWuKiOGWyEKwgh433bAdCaoCm1ObO
         CMim0y0cs/kxkAVq1qoj2JsJntau8TY6uNfzsVH/nEFrO6gYMVIuh6J7Ujq/PRXUbkps
         Olz0eiNU64ic11hSkJ6fV7veGTwwfD2NmYGwtQTyWTk8kQlcaMDAnumKl/e3Ne+HDhnu
         vX8tkfKQakLAmy41wyW7iB+CRqkghNTY0YBaghBJG2dN0yQZEaQ0IdSfsGA+RUFAKbli
         h8BPJUCm8jloqX2ZVLo8I0JuNSn8YQEp4BWuAtP6kmqopWRuGgDWKYVeRFZsyeGMyT5z
         Jf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWimSQ2aKzB9lzu7pDFheyY5SMtB9ofWGJahVmOv5eY+82ENOO1l5QWrhj+iDLGa1vpjoUS3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT3oY3pLCiBKRH196QAzhJ1xdKe+Wq9OjYbk328B90mu5c6l76
	6QthSAD9Y2eBioz7yqm9mGVDkNneUvJTxbFW/K8xUqKimDXZn0qzbaX33VtirLt87EGK8ff8wXH
	OeH03eLAENzjP2BrCx7e4diHYvc0KsOLKLyOv3qLpFwDgzfLYEb+U6a8=
X-Google-Smtp-Source: AGHT+IHRosOg6XqK/UHm2Ig3CQJIr8Z4g7TDpqnPxD5Ss0HrPcacL3fxs8GA+WdhqrR5bPSX+EwaZbJAgct8hjk3q/JVdO5bBlmd
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:cda1:0:b0:3ce:7968:ead3 with SMTP id
 e9e14a558f8ab-3cf743f7c31mr7335685ab.7.1737077342596; Thu, 16 Jan 2025
 17:29:02 -0800 (PST)
Date: Thu, 16 Jan 2025 17:29:02 -0800
In-Reply-To: <1ac7d9c7-9f30-4915-ac6d-fe12b188d3b0@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6789b25e.050a0220.20d369.004d.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
From: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __mptcp_clean_una

MPTCP: snd_una 52e55b5d657ac4e2 snd_nxt 52e55b5d657ac4e2 write_seq 52e55b5d657ac4e2 idsn 52e55b5d657ac4e1 dfrag seq 3d10b145d4f45513 len 32728
------------[ cut here ]------------
WARNING: CPU: 0 PID: 204 at net/mptcp/protocol.c:1030 __mptcp_clean_una+0xede/0x1160 net/mptcp/protocol.c:1030
Modules linked in:
CPU: 0 UID: 0 PID: 204 Comm: kworker/u8:6 Not tainted 6.13.0-rc7-syzkaller-gce69b4019001-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: krdsd rds_tcp_accept_worker
RIP: 0010:__mptcp_clean_una+0xede/0x1160 net/mptcp/protocol.c:1030
Code: 68 0f 54 f6 4c 8b 03 48 c7 c7 80 62 30 8d 48 8b 74 24 28 4c 89 f2 4c 89 f9 4c 8b 4c 24 38 41 55 e8 57 29 55 f5 48 83 c4 08 90 <0f> 0b 90 e9 ff f3 ff ff 44 89 f1 80 e1 07 38 c1 0f 8c 3f f9 ff ff
RSP: 0000:ffffc90000006da0 EFLAGS: 00010296
RAX: 000000000000008e RBX: ffff888078274c28 RCX: e4b9e8819bb74600
RDX: 0000000000000100 RSI: 0000000000000303 RDI: 0000000000000000
RBP: ffffc90000006eb0 R08: ffffffff817f1b5c R09: 1ffff92000000d50
R10: dffffc0000000000 R11: fffff52000000d51 R12: ffff888061554648
R13: 0000000000007fd8 R14: 52e55b5d657ac4e2 R15: 52e55b5d657ac4e2
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84b8a1d3d7 CR3: 0000000067206000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 mptcp_incoming_options+0xc49/0x2540 net/mptcp/options.c:1144
 tcp_data_queue+0xf9/0x7310 net/ipv4/tcp_input.c:5233
 tcp_rcv_established+0xed0/0x1f20 net/ipv4/tcp_input.c:6264
 tcp_v4_do_rcv+0x96d/0xc70 net/ipv4/tcp_ipv4.c:1916
 tcp_v4_rcv+0x2dc0/0x37f0 net/ipv4/tcp_ipv4.c:2351
 ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5817
 process_backlog+0x662/0x15b0 net/core/dev.c:6149
 __napi_poll+0xcb/0x490 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7093
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 do_softirq+0x11b/0x1e0 kernel/softirq.c:462
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:389
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x1775/0x3f50 net/core/dev.c:4493
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:236
 ip_local_out net/ipv4/ip_output.c:130 [inline]
 __ip_queue_xmit+0x12ca/0x1ef0 net/ipv4/ip_output.c:536
 __tcp_transmit_skb+0x2582/0x3ba0 net/ipv4/tcp_output.c:1468
 tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
 tcp_write_xmit+0x17b5/0x6bf0 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0x9b/0x360 net/ipv4/tcp_output.c:3012
 __tcp_close+0xa7f/0xde0 net/ipv4/tcp.c:3130
 tcp_close+0x28/0x110 net/ipv4/tcp.c:3221
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:640 [inline]
 sock_release+0x82/0x150 net/socket.c:668
 rds_tcp_accept_one+0x1b3/0xbe0 net/rds/tcp_listen.c:234
 rds_tcp_accept_worker+0x3f/0xa0 net/rds/tcp.c:533
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         ce69b401 Merge tag 'net-6.13-rc8' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=175b27c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fb9a18580000

