Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084C27A107
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181533; cv=none; b=iWJePSNDrWiqdBf6wWRklWb4CJ8rxUF8D0boO95keUlMkML/4UEMpS8nbAnxokB4UahUgdynbv0swaYsHPrEajsRk1I2OSGaPkIpxOCEkmE2m4F2D3xY9Z08clVtccXdU16EGOGtAdAK4kcBdd01Sp1WV6yNWD3p767JmGTHhMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181533; c=relaxed/simple;
	bh=5Nf3W3UxcrFgAljQQi0+xHHHpFTQ9tPesE0mavSfNYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ol2JuKn9hUh3DPzWglq/SmIkAF+Hmu45t3J8qxoYH5ONOCMDzMJDk3hVmbQSCuAqEY+Q77HdeO/q1JOwKfJsLwM67ni18EyEa37x3l1q0nmWUdHLjCTGGC/pbObYmDj6yxqvoycIHP04LD/zAjwjGLiWYcC908n+QFg7lEN7/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfVzGXeL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfVzGXeL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764181531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9IG0Jl1bxGATqDvnf+TyD2ZRHvVUKotUHw2MeMlTCNg=;
	b=QfVzGXeLYTgA+LX8o+ho3Gl792VOGJFhzf0wzz6WtndnP5TYV4E284tBFmRNwiAEkhUL52
	+0kBHbYwBGlSYCFGpPJV09kovxaXOX9Eo9KMagJMYdgZrldumzxcqtwfcl8wDm6VG+gBJ8
	oBLR2AYuDw2KrZiINlUFR534L14sXPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-yHp7PQnSNzmqJ_VvbD_3qA-1; Wed, 26 Nov 2025 13:25:28 -0500
X-MC-Unique: yHp7PQnSNzmqJ_VvbD_3qA-1
X-Mimecast-MFC-AGG-ID: yHp7PQnSNzmqJ_VvbD_3qA_1764181527
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2ffe9335so72155f8f.1
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764181527; x=1764786327;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKnEfrXS+Z1LXWR8HkrLZ2kH+kN1nxekLTph9gumPo8=;
        b=CxCfwE8+bAdXoyR91aTwJPzMuUQwpnf3lI3G6VGiqHPLrX8i83hJ3YnWbdPgeV84sp
         3sA2wkZQKVc9i7R5fk4tYYQuVAidyV/zdzE5sZ6cuOMVeufkxQ8poD8bWf6r3kUEcdi9
         LVPa1FQVKqmCbwPtj6iaCfQ5x4fXka4d933sDvCJFc/gkKTdNgKx88mxrV4+Niu9//7v
         b9prjoNlaVosMtif6nfcOmbpq69m8z6PH/HhZhiMiV8hZ2tmceJYW+0/edysjVqpkgHS
         MBHe+lTvK6r7BONSRJkSJoVrIDL+gO5cRIzy9+7Fkog9CFe7iI0MJ22XFDKygl1vJhZ7
         gTxA==
X-Forwarded-Encrypted: i=1; AJvYcCWrgXJmLHwsy9U31p+kEdNdQ5iIx1LTLhVJQmurdHBVMkFUhA6L/Fu+/OIlKFqH1BwifK6uNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwD+PpkNLZiuJp72BF74zr+9KHN0N5axwmWzXisfkBwTJYCv3e3
	LoRb+/EtoL/xGaXP5fkcKF3Dq4D6dS5ieDwQxF+V+C+FE7m8IBMgyX5uy4/2LCyH4aN0NvYXIiG
	IwK99yHZbMGBD8aMNs6ro3sk9bjfTbYRvCTlf3cG2PMqenHKudMUXXNLO
X-Gm-Gg: ASbGncuAulK7W9qF6o1PS2c2QFh7eriyJNayZITDF9MjpbjZ58vyYgyF3H+2dkIOekD
	KSZI64nd4ctRgrhPu/mloq2DFOkW1yKwGtOC+GKlfce/1mhxXGLZTgBFd6LdfcTL9rC8Kz6JLFI
	QiG0UGWFHaz+2iJyWAjTXi4tSmvg0NyB370SU16moLc85ZAjuLmadzzfDBy809SWYeYj9kQf0pI
	/I4kvU/q9vBdb2Gs6eplrStnMGycPu4sxNcWMsYiF6gD2CCsTs8te+nh1hcO6YQEooWbMO26edg
	4aSlYcx9pJD/FKP3SBWfsAWv+k/iGGqiScZOnpaBjzfyHVI2PiXj6mrGhl80gcr/hNuxeV/8zbY
	+mTmabFg3+/OPxw==
X-Received: by 2002:a05:6000:2c10:b0:429:d33e:def1 with SMTP id ffacd0b85a97d-42cc1d0cef2mr23164795f8f.29.1764181526961;
        Wed, 26 Nov 2025 10:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuTQ3KV2rkSyQaUGr7B8RZuHdRjbsAwhLQtQco5/BAQhy5jv9/IugUC/70BA5UKkvl5RtYXA==
X-Received: by 2002:a05:6000:2c10:b0:429:d33e:def1 with SMTP id ffacd0b85a97d-42cc1d0cef2mr23164763f8f.29.1764181526525;
        Wed, 26 Nov 2025 10:25:26 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35c2sm40874906f8f.25.2025.11.26.10.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:25:25 -0800 (PST)
Message-ID: <f697f3a0-859e-48bb-b0cd-28f176a24e2f@redhat.com>
Date: Wed, 26 Nov 2025 19:25:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready (4)
To: syzbot <syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com>,
 mptcp@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <691f80f4.a70a0220.2ea503.003a.GAE@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <691f80f4.a70a0220.2ea503.003a.GAE@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N0j23Uhp43JAP_rpaNWE6Gfs2YrVb54AoOaDGzV2q30_1764181527
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------7a40tNKByIm29War11PEdkgI"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7a40tNKByIm29War11PEdkgI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 9:58 PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8e621c9a3375 Merge tag 'net-6.18-rc7' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12887a12580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ff6b771b4f7a5bce83b
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c9a12580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117a2a12580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6be75789d60e/disk-8e621c9a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/62e7a40cfe48/vmlinux-8e621c9a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3e523caa536d/bzImage-8e621c9a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 15 at net/mptcp/subflow.c:1519 subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1519
> Modules linked in:
> CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1519
> Code: 89 ee e8 88 f8 72 f6 40 84 ed 75 21 e8 9e fd 72 f6 44 89 fe bf 07 00 00 00 e8 d1 f8 72 f6 41 83 ff 07 74 09 e8 86 fd 72 f6 90 <0f> 0b 90 e8 7d fd 72 f6 48 89 df e8 e5 ad ff ff 31 ff 89 c5 89 c6
> RSP: 0018:ffffc90000147380 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888030aa72c0 RCX: ffffffff8b4959ef
> RDX: ffff88801d2cbc80 RSI: ffffffff8b4959fa RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
> R10: 0000000000000004 R11: 00000d230000000c R12: ffff888033463c00
> R13: 1ffff92000028e70 R14: ffff88802f9bbc00 R15: 0000000000000004
> FS:  0000000000000000(0000) GS:ffff888124a0d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f841c04df98 CR3: 0000000078b7e000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  tcp_data_ready+0x110/0x550 net/ipv4/tcp_input.c:5355
>  tcp_data_queue+0x1aa6/0x5000 net/ipv4/tcp_input.c:5445
>  tcp_rcv_state_process+0xfb6/0x6490 net/ipv4/tcp_input.c:7159
>  tcp_v4_do_rcv+0x68e/0x10a0 net/ipv4/tcp_ipv4.c:1954
>  tcp_v4_rcv+0x3077/0x4db0 net/ipv4/tcp_ipv4.c:2374
>  ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x3f2/0x720 net/ipv4/ip_input.c:239
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  NF_HOOK include/linux/netfilter.h:312 [inline]
>  ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:260
>  dst_input include/net/dst.h:474 [inline]
>  ip_rcv_finish net/ipv4/ip_input.c:453 [inline]
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  NF_HOOK include/linux/netfilter.h:312 [inline]
>  ip_rcv+0x2e0/0x600 net/ipv4/ip_input.c:573
>  __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:6079
>  __netif_receive_skb+0x1d/0x160 net/core/dev.c:6192
>  process_backlog+0x439/0x15e0 net/core/dev.c:6544
>  __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7594
>  napi_poll net/core/dev.c:7657 [inline]
>  net_rx_action+0x97f/0xef0 net/core/dev.c:7784
>  handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
>  run_ksoftirqd kernel/softirq.c:1063 [inline]
>  run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1055
>  smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

I can't repro it locally. Running a debug patch to collect more status
which hopefully should help understanding the race.

--------------7a40tNKByIm29War11PEdkgI
Content-Type: text/x-patch; charset=UTF-8; name="dbg.patch"
Content-Disposition: attachment; filename="dbg.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9zdWJmbG93LmMgYi9uZXQvbXB0Y3Avc3ViZmxvdy5jCmlu
ZGV4IDg2Y2U1OGFlNTMzZC4uOGZhYzlhMGNlNDhiIDEwMDY0NAotLS0gYS9uZXQvbXB0Y3Avc3Vi
Zmxvdy5jCisrKyBiL25ldC9tcHRjcC9zdWJmbG93LmMKQEAgLTE1MjQsOCArMTUyNCwxNiBAQCBz
dGF0aWMgdm9pZCBzdWJmbG93X2RhdGFfcmVhZHkoc3RydWN0IHNvY2sgKnNrKQogCQlyZXR1cm47
CiAJfQogCi0JV0FSTl9PTl9PTkNFKCFfX21wdGNwX2NoZWNrX2ZhbGxiYWNrKG1zaykgJiYgIXN1
YmZsb3ctPm1wX2NhcGFibGUgJiYKLQkJICAgICAhc3ViZmxvdy0+bXBfam9pbiAmJiAhKHN0YXRl
ICYgVENQRl9DTE9TRSkpOworCWlmICghX19tcHRjcF9jaGVja19mYWxsYmFjayhtc2spICYmICFz
dWJmbG93LT5tcF9jYXBhYmxlICYmCisJICAgICFzdWJmbG93LT5tcF9qb2luICYmICEoc3RhdGUg
JiBUQ1BGX0NMT1NFKSkgeworCQlzcGluX2xvY2tfYmgoJm1zay0+ZmFsbGJhY2tfbG9jayk7CisJ
CXByX2VycigiZmFsbGFiYWNrIHVuZGVyIGxvY2sgJWQgcmVxIG1wYyAlZCByZXEgbXBqICVkIHN0
YXRlICVkIHBhcmVudCBzdGF0ZSAlZCBzZW5kICVsbGQgcmVjZWl2ZWQgJWxsZFxuIiwKKwkJCV9f
bXB0Y3BfY2hlY2tfZmFsbGJhY2sobXNrKSwgc3ViZmxvdy0+cmVxdWVzdF9tcHRjcCwKKwkJCXN1
YmZsb3ctPnJlcXVlc3Rfam9pbiwgc3RhdGUsIHBhcmVudC0+c2tfc3RhdGUsCisJCQltc2stPmJ5
dGVzX3NlbnQsIG1zay0+Ynl0ZXNfcmVjZWl2ZWQpOworCQlzcGluX3VubG9ja19iaCgmbXNrLT5m
YWxsYmFja19sb2NrKTsKKwkJV0FSTl9PTigxKTsKKwl9CiAKIAlpZiAobXB0Y3Bfc3ViZmxvd19k
YXRhX2F2YWlsYWJsZShzaykpIHsKIAkJbXB0Y3BfZGF0YV9yZWFkeShwYXJlbnQsIHNrKTsK
--------------7a40tNKByIm29War11PEdkgI--

