Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5E2F25E8
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230584; cv=none; b=dJssOHQ6E9cAgtSTBwbBufGlPRX07E5OzR/hkb+WQZl/pP5qSAdhjGCYi4wS6PsSjd8GRB24qiyA3KE0ZoIESAWmy9EiOqtJya/71/MtPULr5D9GoZ+zPItZXguQqNf4AP9h6FDfqYkJxg8xcccX5LMMRtrhoRSIORxz/rbkDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230584; c=relaxed/simple;
	bh=e588VsWTuw3+EaCUH8TV3r45eksvV8wsWUpYpPVCuGQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T74Eu0uPt6H9LfpfdqfS2gNcuD2iyu2ALYrHhSRgA6+KadxcgSbDRXazxTtdrLo+Ai767Dqe75YiZeIM8sh3cbSfGzvDqSLWmtt/2+0oYeSlp79KTPmNJduK8K/hJM9EUQ7htIy0DemOit31k1cx1umZDodDuCwEizPxPNbwe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433795a17c1so5475905ab.2
        for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 00:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764230581; x=1764835381;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuaZcLvFv4x8BjV4C0o4QGmEcqaLhD+NRyK+vv8hgco=;
        b=ZZb2MNqn3UoIHmB5aeUyI+r3t3raEVDPjAtA+O32iyjFi6fTHbpA4WxSOBRmUjbZGe
         wdaT2Nbd+Ab65p/oEU1+4e7s7ZIFO0QO9I9DgyfV+NRXGCpUjFt0etAoC1tD/MJeVnsB
         RhXq+BvCYCL28TGHOwJ26DykBG69j0iRjg8J8uQLx0lBZY7nIYqhJ4r7MwKdyJYru3ZL
         uJCrzmMTUWydr9+Xwez+1hhixUmxc17N7tsD4ps+l6ucc8n5dVPSspAmN4sw1YvP2bOS
         8NEzQFlzCG8ntuwHDVCw0BFO06HZqhlX6skVUCr1mI66qGGnX6Mwtl3c7xh7W3JjQ7FP
         sMcg==
X-Forwarded-Encrypted: i=1; AJvYcCV+I+bJEzMu3H/yaMMikbepFCQt1qZHLXLYq6v8vLqsS4dPcetag9nU5f4NTxA+RWCNyNv65w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBIsdnVLUknDPrTWpM1WtrC37ijKkxAcCuXomGQteB1Q3x119m
	/wUfmGPlkFtPNkJGzSNkPHUlfyLOZJwz5rnBtX51r4IgGwbLjqGqOEJWmw5deuUbPk+gxErLXk5
	7dapoBqpeu4rCWTn84ZcGj1FWPoeJIjD+DL3lAaD2RCBXaAplTainLEroH8M=
X-Google-Smtp-Source: AGHT+IHABskrkfFnigGWM6iEJ65zKYDr2khSelrfI3c5VbQiWYJI2j+2uFXBgw1KwHnmYLnSlaMzKZdDQOf5yLJ44hELwzRVDXA1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c8:b0:433:7900:f1c5 with SMTP id
 e9e14a558f8ab-435b9845f4cmr200436125ab.7.1764230581670; Thu, 27 Nov 2025
 00:03:01 -0800 (PST)
Date: Thu, 27 Nov 2025 00:03:01 -0800
In-Reply-To: <e5ede3d8-fba7-4e30-afae-85f6fffbfec7@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692805b5.a70a0220.d98e3.00f8.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready (4)
From: syzbot <syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in subflow_data_ready

MPTCP: fallaback under lock 0 req mpc 1 req mpj 0 state 16 parent state 7 send 0 received 0
------------[ cut here ]------------
WARNING: CPU: 1 PID: 23 at net/mptcp/subflow.c:1527 subflow_data_ready+0x59d/0x980 net/mptcp/subflow.c:1527
Modules linked in:
CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:subflow_data_ready+0x59d/0x980 net/mptcp/subflow.c:1527
Code: e0 48 c7 c7 c0 71 ee 8c 44 89 f9 8b 54 24 1c 48 c1 ee 02 45 0f b7 c0 83 e6 01 e8 2e 6c 51 f6 48 8b 7c 24 10 e8 44 ee 16 00 90 <0f> 0b 90 58 5a e8 e9 fb 72 f6 48 89 df e8 51 ac ff ff 31 ff 89 c5
RSP: 0018:ffffc900001d7348 EFLAGS: 00010202
RAX: 0000000000000101 RBX: ffff8880343cd940 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffffff8da29344 RDI: ffffffff8bf078c0
RBP: ffff8880312b1538 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90824bd7 R11: 0000000000000001 R12: ffff8880312b0c00
R13: 1ffff9200003ae70 R14: 0000000000000004 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124b0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ced887d58 CR3: 0000000064f00000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tcp_data_ready+0x110/0x550 net/ipv4/tcp_input.c:5355
 tcp_data_queue+0x1aa6/0x5000 net/ipv4/tcp_input.c:5445
 tcp_rcv_state_process+0xfb6/0x6490 net/ipv4/tcp_input.c:7159
 tcp_v4_do_rcv+0x68e/0x10a0 net/ipv4/tcp_ipv4.c:1954
 tcp_v4_rcv+0x3077/0x4db0 net/ipv4/tcp_ipv4.c:2374
 ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x3f2/0x720 net/ipv4/ip_input.c:239
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:260
 dst_input include/net/dst.h:474 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:453 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_rcv+0x2e0/0x600 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:6079
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6192
 process_backlog+0x439/0x15e0 net/core/dev.c:6544
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x97f/0xef0 net/core/dev.c:7784
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1055
 smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         8e621c9a Merge tag 'net-6.18-rc7' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14916f42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
dashboard link: https://syzkaller.appspot.com/bug?extid=0ff6b771b4f7a5bce83b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158f657c580000

