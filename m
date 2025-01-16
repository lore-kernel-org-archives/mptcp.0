Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51D4414
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737052628; cv=none; b=atJFcfjKHsn2fbcVtyOD61Edv07wSvSfTIEHCwm1dFinrmeCGki57KS5BrRQWDC3zA8qhNrMNO/luYmJQYQqhukDSxxB62oIM0DZCQILHfapAIQgzWz1GntgxGvqReQM6yzZKy2Zv30ANqPDEHMmKWMdz+sAp90IP4SMu8tkhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737052628; c=relaxed/simple;
	bh=a2MrFDjDWPNm8qUklsM5v5j8FRM4Sp2Ir6ZNFkabpuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B42zWw36XY85QAQCx05Ecc50UswvTLDpBgd4eW3IvgqbknWNIrQv5TW/MUI6PO4yQm9Z46J8Ef75u7kLE6D37z30Oyg2cf1YkmBeqvMr86Eo8nZ94vbYMwCqVSKcKp5c8teLVG9lR7R6sj4ilTeWscSSZTbLF6cn5k6pSk829xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erabIj+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erabIj+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737052625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxeTyoR0nn0d/sw5EcqMB+5/rDNJoST53XT04iMl8Rw=;
	b=erabIj+EvZMrYOFHzSujRn7VE0V+XWjONqhemIB2v3GaHvVUpNUThs+vF9A1xjcSgexaxx
	/EBN6o3ayO9WkZLkcrle0RoES4uR0OGInRt4Wz/1qFwXuTQrsHkCJegBJJiVZpsBSqUAjH
	ydoGvV/2jgMKcIWtAkrvvuEmmK2CVSE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-nUo9PWfgO5G32-X3mkwlaA-1; Thu, 16 Jan 2025 13:37:04 -0500
X-MC-Unique: nUo9PWfgO5G32-X3mkwlaA-1
X-Mimecast-MFC-AGG-ID: nUo9PWfgO5G32-X3mkwlaA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4359eb032c9so8430355e9.2
        for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 10:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737052623; x=1737657423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxeTyoR0nn0d/sw5EcqMB+5/rDNJoST53XT04iMl8Rw=;
        b=o7f1yxzb4GL9iMyYcrdKBy3igsmb707WqvnPgEuBFfN2RwsxYBcRFj5/G0mlWaH44O
         O3n3Eroo+EXEwAJ3C0VwjH4YpKiAB4jhNYXSbA1jj0rjt6YsQeUujStqH2ThHLuADBcZ
         8oS0iZkW9UzwpuksyLWgSHlj0HeP+jwSwDOflnIL7CmnafmXu0+417zp8nKDisK8Cu9i
         AcZu7ehM9L8gXAJiLQKb0pFzGvAJ5SIbDvP1Ssse8WXPMaV/LIvipxcC87WWghnvrJ4L
         5y/SMQd/LA90/FTn9OzYFScnuesaQdPa02gHtrPk3p0tgjv3yX258cshnCjn5/gAqtZM
         zR8w==
X-Forwarded-Encrypted: i=1; AJvYcCV7h/aY5MSrGZnItKCOn3jNpbk5Hm1gGdxRwSQH36IKWDXXA31rBXvos3SkKLNnZOeHjSIOsg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8YK0bwHLh3T7i9FtmGGTPeUQcoZgdQ5UzOvnOii8AFjuh3Xsd
	cRU/G5blVPA0tX8A/LWDIY4oiF3157KN+CwtxYdLzMAnLBNSNF4XK8gg1FXdq3iSHgJqIpRPr9N
	zNEOBl7JnspSqiBTY2Cc7nX+b9HBrYq14FFBNYs5APfMlD32FIuT0
X-Gm-Gg: ASbGncsw+Hno8Zaamu2jw2zo3k7SrYY+oyIVNuxLZVF30/Dc/zstBSPkutwJOi+RYg4
	Fz1Yj63uIavhgeqBcexulZjtCS8WP7ci+QXJwZ/UhrtMC8dl6ZnKwAUrLp2q97MUqL5clP5htsb
	+YnT2ZocJNRAYXICOP7h3Uq8XtLOJdUIpcOp0Ufotk7bkl4cQ6mYlap6ExkdCTggxDxcWsOZE+v
	BlC4iiBDlZ425yH2ifZr2Wfi6CMysWoMy2ZtWx/7crzPuK/uotDsUZP91S3wRHZ10+PnIXwvyyx
	5FHd09NPADw=
X-Received: by 2002:a05:600c:3544:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-436e26ae55bmr306298325e9.4.1737052623346;
        Thu, 16 Jan 2025 10:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyFymf+ayDOaM8AHrX9OmsahzJWvWrZictbV0qCcmq2aygmZQpp0tMx3cp4UB4tGe21hRtzw==
X-Received: by 2002:a05:600c:3544:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-436e26ae55bmr306298155e9.4.1737052622965;
        Thu, 16 Jan 2025 10:37:02 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499821sm67474515e9.2.2025.01.16.10.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 10:37:02 -0800 (PST)
Message-ID: <e2a7532a-ec79-4d09-ba45-55bda7e60092@redhat.com>
Date: Thu, 16 Jan 2025 19:37:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: pm: only set fullmesh for subflow endp
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
References: <20250116-mptcp-issue-540-v1-1-b0ba2c126eb8@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250116-mptcp-issue-540-v1-1-b0ba2c126eb8@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u9Iv87qT7r2SfSwhbHVi1B5lV2fsdEFVVAiuCCtLXOY_1737052623
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 7:15 PM, Matthieu Baerts (NGI0) wrote:
> With the in-kernel path-manager, it is possible to change the 'fullmesh'
> flag. The code in mptcp_pm_nl_fullmesh() expects to change it only on
> 'subflow' endpoints, to recreate more or less subflows using the linked
> address.
> 
> Unfortunately, the set_flags() hook was a bit more permissive, and
> allowed 'implicit' endpoints to get the 'fullmesh' flag while it is not
> allowed before.
> 
> That's what syzbot found, triggering the following warning:
> 
>   WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 __mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
>   WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
>   WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
>   WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 6499 Comm: syz.1.413 Not tainted 6.13.0-rc5-syzkaller-00172-gd1bf27c4e176 #0
>   Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>   RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
>   RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
>   RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
>   RIP: 0010:mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
>   Code: 01 00 00 49 89 c5 e8 fb 45 e8 f5 e9 b8 fc ff ff e8 f1 45 e8 f5 4c 89 f7 be 03 00 00 00 e8 44 1d 0b f9 eb a0 e8 dd 45 e8 f5 90 <0f> 0b 90 e9 17 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c c9 fc ff ff 48
>   RSP: 0018:ffffc9000d307240 EFLAGS: 00010293
>   RAX: ffffffff8bb72e03 RBX: 0000000000000000 RCX: ffff88807da88000
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: ffffc9000d307430 R08: ffffffff8bb72cf0 R09: 1ffff1100b842a5e
>   R10: dffffc0000000000 R11: ffffed100b842a5f R12: ffff88801e2e5ac0
>   R13: ffff88805c214800 R14: ffff88805c2152e8 R15: 1ffff1100b842a5d
>   FS:  00005555619f6500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020002840 CR3: 00000000247e6000 CR4: 00000000003526f0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>    genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
>    netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
>    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>    netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>    netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
>    netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
>    sock_sendmsg_nosec net/socket.c:711 [inline]
>    __sock_sendmsg+0x221/0x270 net/socket.c:726
>    ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
>    ___sys_sendmsg net/socket.c:2637 [inline]
>    __sys_sendmsg+0x269/0x350 net/socket.c:2669
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   RIP: 0033:0x7f5fe8785d29
>   Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>   RSP: 002b:00007fff571f5558 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>   RAX: ffffffffffffffda RBX: 00007f5fe8975fa0 RCX: 00007f5fe8785d29
>   RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000007
>   RBP: 00007f5fe8801b08 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>   R13: 00007f5fe8975fa0 R14: 00007f5fe8975fa0 R15: 00000000000011f4
>    </TASK>
> 
> Here, syzbot managed to set the 'fullmesh' flag on an 'implicit' and
> used -- according to 'id_avail_bitmap' -- endpoint, causing the PM to
> try decrement the local_addr_used counter which is only incremented for
> the 'subflow' endpoint.
> 
> Note that 'no type' endpoints -- not 'subflow', 'signal', 'implicit' --
> are fine, because their ID will not be marked as used in the 'id_avail'
> bitmap, and setting 'fullmesh' can help forcing the creation of subflow
> when receiving an ADD_ADDR.
> 
> Fixes: 73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink")
> Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/6786ac51.050a0220.216c54.00a6.GAE@google.com
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/540
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index fef01692eaed404e272359df691264f797240d10..7131dc2f312d923a31bb4b0460b6b4663376fbd0 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1986,7 +1986,8 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
>  		return -EINVAL;
>  	}
>  	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
> -	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> +	    ((entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) ||
> +	     (entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
>  		spin_unlock_bh(&pernet->lock);
>  		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
>  		return -EINVAL;

LGTM, thanks!

slight preference for:

		entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL ||
			        MPTCP_PM_ADDR_FLAG_IMPLICIT)

but definitely not strong opinion about it.

/P

