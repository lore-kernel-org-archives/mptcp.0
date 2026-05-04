Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6F351C3B
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893243; cv=none; b=QQOOOE0Vu9BbTrUh4LT/wlfbGQj0eUCGwHsROXj1s1kQkqvX4TMXIYRh2wK4IcKOs4mg3hxsLCA2vQf9uKFXxWabRy/z33aI8e9QnTjEcvmUqwi336r+9mQJcVx1QW6ktYkwSmFGtI/E8AY42lBai+nmncuwTHFfNCSi2zn6NLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893243; c=relaxed/simple;
	bh=ffA07dVGqyKTJs6I2sJ5tNGcKQ9OO1TRa8nXa1DMkoE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rxFVDXNwVp/aTFoHeJ6w6jmtvlyeZDiLIl+bD9Vt5zwJ+/jQ404PoO5qKHgPimQ/EJazPdysDsp5Fql+lwpAPJvehXgHHsUUoDAFtJxsb84KMlK00u2n5Ir47zSkB5UK95e7uKk57w7JjGcdKdaLJdeSpou16YgkK9yQNwe2V/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dcdcacd141so5706017a34.2
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 04:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893241; x=1778498041;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMPkJTU7y3aDjTVQ8S+y7wzCSdd73w6yojQBO6HIlRA=;
        b=oa46uXpQ/C5kFpV7yrjKWly9hBWXMbz/phbvu2sA8PdfZxUdODGNKqRlebeWh8vUYM
         GGdd/c5A2NTnKDYkJn+xwAWtF+TmpCQvIzmBKCCAJmDGAeSiR27v84iuJ0ojP9V+2AWU
         aaiYTJVgH6I/+JDK5SF+cFDSmkm6pwjTfChwwmf4Duz9NWbMnnde4Sfzt9AWCoCujJsr
         WTnJxH3KGOcs/pIcqzQaZzs/5851hM8Td1BnF93+VnSd3RQjg3COIjBccmAPqHZuCIcn
         TATRmNauSQSDC+O0WG6MNnR5+uRJbLZV/v+0ubSU7e1Sb4ZoaJjl41OrVS6E8Ch20Su5
         nr9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/wwTH52+tQT5MDh60uX3nfSkOfpZEq4qBBQCOof1JrmAU1YKlbuIbgnM3Uz2FhQom2TBl3Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4grAjo5k9xacKwKTxka8mDPErEqAtIZnxBppCy9N0qFy2tfHD
	BeHwGfTmvhHjFCjmhxmGwA/GOgd/L8zfwz69dgviXQ48tc2DEmHY2VgsO3MkZRZwY0QIVq2382N
	Yn3mY5dNU1U2Ayb7moSLi8QDtB0XPRDuaome2Vw7QFeZvAqPOtBHgUxzvz68=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1885:b0:694:980c:9606 with SMTP id
 006d021491bc7-69697dfb0dfmr4449543eaf.32.1777893241517; Mon, 04 May 2026
 04:14:01 -0700 (PDT)
Date: Mon, 04 May 2026 04:14:01 -0700
In-Reply-To: <67030b5e-0435-49fc-8adb-8dd8536ad853@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f87f79.050a0220.3460d5.0002.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
From: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>
To: kuniyu@google.com, linux-kernel@vger.kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in mptcp_write_options

=====================================================
BUG: KMSAN: uninit-value in mptcp_write_options+0x410/0x32e0 net/mptcp/options.c:1462
 mptcp_write_options+0x410/0x32e0 net/mptcp/options.c:1462
 mptcp_options_write net/ipv4/tcp_output.c:457 [inline]
 tcp_options_write+0x1399/0x1920 net/ipv4/tcp_output.c:833
 __tcp_transmit_skb+0x36fe/0x5fe0 net/ipv4/tcp_output.c:1656
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
 tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
 __mptcp_subflow_send_ack net/mptcp/protocol.c:538 [inline]
 mptcp_subflow_send_ack net/mptcp/protocol.c:546 [inline]
 mptcp_send_ack net/mptcp/protocol.c:555 [inline]
 mptcp_check_data_fin+0xa61/0xf00 net/mptcp/protocol.c:643
 mptcp_worker+0xde4/0x1ea0 net/mptcp/protocol.c:2980
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb65/0x1e40 kernel/workqueue.c:3385
 worker_thread+0xee4/0x1590 kernel/workqueue.c:3466
 kthread+0x53f/0x600 kernel/kthread.c:436
 ret_from_fork+0x20f/0x8d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 mptcp_established_options_dss net/mptcp/options.c:616 [inline]
 mptcp_established_options+0x2265/0x3580 net/mptcp/options.c:876
 tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
 __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
 tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
 __mptcp_subflow_send_ack net/mptcp/protocol.c:538 [inline]
 mptcp_subflow_send_ack net/mptcp/protocol.c:546 [inline]
 mptcp_send_ack net/mptcp/protocol.c:555 [inline]
 mptcp_check_data_fin+0xa61/0xf00 net/mptcp/protocol.c:643
 mptcp_worker+0xde4/0x1ea0 net/mptcp/protocol.c:2980
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb65/0x1e40 kernel/workqueue.c:3385
 worker_thread+0xee4/0x1590 kernel/workqueue.c:3466
 kthread+0x53f/0x600 kernel/kthread.c:436
 ret_from_fork+0x20f/0x8d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Local variable opts created at:
 __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499

CPU: 0 UID: 0 PID: 4890 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events mptcp_worker
=====================================================


Tested on:

commit:         6d35786d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123d6696580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c3f61154f3bb7e5
dashboard link: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1663f21f980000

