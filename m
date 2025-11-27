Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB901CEAA3
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229557; cv=none; b=RFDfSZE0+k1tEX6PxbsdnQdeI9Cmp2bbZxQ5dMjtVnL4pvPddjsbg+0RPVBLHGwTrKNw5Wc8uut4grny6RJoHtZhoCH/Fr2ORVywCl/FO5QnCHLgjdAXUgR5I4txB5j/Qg4b3NXIJubqZ66Yr1wN9hgy+CujmGEeQsSwVkLr4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229557; c=relaxed/simple;
	bh=ygkyFPIqLc+64OCrw5PQ+gEeKoIiPnEZfEyLeFWZaHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mo9sDbT/XUzWEtG8f7aMU1sAIixg9zEv4yhTo9T3Xu74eZj2D6UrUHUIUKslbHTmTgJH7gocKUPUo/EKAlOTp782YSqywjI1S8pbdrFAMRol/kpc81kZupRlv7JPTirr2r6PH1c54xF7BNHXaA+ZUaJD9XFvZY9R+eQAlRKy8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkrkB/ky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkrkB/ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764229554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KytwDjSTn8RRbi6+AyiRTks0tpSyUnPHyCNUa/+hkKc=;
	b=KkrkB/ky/WOGw7PTki+xxS7EkOe1U97XfNttrfz6SIBFovNwPCP8e4WhAWHyxSKJvG7SpM
	9fChYE7cIysazUjI7/Xd6kjghBv2gqUkEbunGCKuLxNvWljtZXN41HLVrQkJr2LSAPzhCz
	oSGBqYMXGm2sViNOse8sdZ0yhnHYSTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-E8Ws3rqBNlCS9lT9nptpYQ-1; Thu, 27 Nov 2025 02:45:52 -0500
X-MC-Unique: E8Ws3rqBNlCS9lT9nptpYQ-1
X-Mimecast-MFC-AGG-ID: E8Ws3rqBNlCS9lT9nptpYQ_1764229549
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c521cf2aso434952f8f.3
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 23:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229549; x=1764834349;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re6YXRsKd5rSlQorh68Ri9Y2MX9sY3I+XiILrdnghdo=;
        b=nfj7LJsdPkwFO00sL3kVXEFOOUCGocsjzZXm4XPLMQhvYVPOVTh9hizKFUIpUfSzbW
         aNQQ33UeV3+OxHBhwQ0kNXiLLd7HJXDnV8OHHj/eTzoMIqkmsrtsqmZ80Dhlu1t89zF9
         8b9ib1QVZKXcfcrLeuANbhJMVyTZkpheB1NqIWlXTZLASXnSyjLHnvGmzPKfQ9xb3XDN
         DR86U+wGnhJA1tBEaYskDwGh81swP5ZPuZQVwcjmcduXElVCR9GPZrS4ZCQWYw5Gi6/9
         LVhKale+86NE/v4jG5/M8A3WzI0dSTt4cCXAw9d+wn2IPAEfgRTqRNYH2EV3O9DsB9yh
         PaNw==
X-Forwarded-Encrypted: i=1; AJvYcCUeOg7Kc09VS2P5MWbNg5RqHwWuS+65zhvmcRHhUvwvJXeubSduGspfbBGcHVNYyUu/sIlS6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl7wTkgSLaid0AAKJ12a51X2yt34apKP3gtRd4GBFZx8EOC4hr
	DRMThJ0ZFAmszkmcGYXALw7RV+LcZ7ErqCFoLbmvWO9oRUw1GedVXDZWdiEjzOjjKA13AuMRKdd
	74eYvj2Dsh42f+b9BmyEP6uak387bUdW0al6cCCHpMQOzeyghC1h/yPzX
X-Gm-Gg: ASbGncuHQey6jX3ecN+/9C6kjBWp/Q+ffxUih+w55yB/wYchTdRoRPNLBSyblLb7W74
	+/r5cRXXh1Z83/vuO60PBRzprAqo8V6moYL2iUi37rTyd0rus9wb7RzOTamO8z/jnU0Gf2Syz45
	/RkaAtuP5ofFWS8cibYO9SKz+RK16Q2Geq0fbnH8p/bvE6oxxLGyPhJwS2VEvSaMVo5iX6s8rA2
	nbrSWwkk7dqI28R3EwTogkj6eOso8uEUsBsZ8HJJdiuIfKnkD02P3MFSVTmHrOz5Vvjt+XZvOlU
	qLhNadPzxH4xkNCUleaAXh9S1OvOD9U3H3MqvfFie3ByIeLQn//00+ZG//+mdUTjUPb2ZxgiBOR
	jp3z/j27cMywx2Q==
X-Received: by 2002:a05:6000:2013:b0:42b:3ccc:91d6 with SMTP id ffacd0b85a97d-42cc1ac9c98mr23096022f8f.7.1764229548963;
        Wed, 26 Nov 2025 23:45:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdEXFQ6bUdxqrAKQgGy5GPlFpi97ilomA6A3JFZoOdbXkRGJax6VJ6G3HDQUTzcvMkqzvT2g==
X-Received: by 2002:a05:6000:2013:b0:42b:3ccc:91d6 with SMTP id ffacd0b85a97d-42cc1ac9c98mr23095983f8f.7.1764229548461;
        Wed, 26 Nov 2025 23:45:48 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3022sm2129631f8f.4.2025.11.26.23.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 23:45:47 -0800 (PST)
Message-ID: <e5ede3d8-fba7-4e30-afae-85f6fffbfec7@redhat.com>
Date: Thu, 27 Nov 2025 08:45:46 +0100
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
X-Mimecast-MFC-PROC-ID: fBF743uEEMhGeFDRpBNkCuLJ_t6JC1zTspDGNj_6jDE_1764229549
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------xH4KkwtTRZRkVOXo1hFEaEV1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------xH4KkwtTRZRkVOXo1hFEaEV1
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

The previous test was supposed to crash and dump some useful information.
I'm not sure if the result means the issue is no more present on net-next,
harder to reproduce or the repro is unstable.

Let's try again, on top of the same tag used to find the repro.

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
8e621c9a3375


--------------xH4KkwtTRZRkVOXo1hFEaEV1
Content-Type: text/x-patch; charset=UTF-8; name="dbg.patch"
Content-Disposition: attachment; filename="dbg.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9zdWJmbG93LmMgYi9uZXQvbXB0Y3Avc3ViZmxvdy5jCmlu
ZGV4IGFmNzA3Y2UwZjYyNC4uMDlmMjRhNDU2ZjczIDEwMDY0NAotLS0gYS9uZXQvbXB0Y3Avc3Vi
Zmxvdy5jCisrKyBiL25ldC9tcHRjcC9zdWJmbG93LmMKQEAgLTE1MTYsOCArMTUxNiwxNiBAQCBz
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
--------------xH4KkwtTRZRkVOXo1hFEaEV1--

