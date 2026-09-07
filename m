Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BD468C3D
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788335; cv=none; b=BLOLw9YgaXpbV5VmgU0v39VaL44+60dnyfpeaWb81e9HwHmOj8+AAnkPmWho579vRoAaJDiGFrxEV3bd6MEImq80frxbUMGg1wGIL+aapRwiRkWhHFbt0ZB/9EsEUX/aWlwtYp7A5d2iIPciySdDAIayJrhGIOdT0a6TvQgd1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788335; c=relaxed/simple;
	bh=Any2UXzsfyd7AqmNuE5M1mJE0C9rEefwiv64bVG3BHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=M67qO8J3skvNNc0CDzTZQVMT/hYJ/ZaW53Jglvx0lRnFmiKbr5Jm+vcMZppaE+gPvJqMpqx4Oi0VM1VZYmPDolMEMgH78HLYI62/dmNSCX2UBHdsiMLTlk+eNgkXe0M/vEK1zb0MHVIReWRyZxJFrZ7v+LowB3cX9SDkkf8glG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMUmh5CO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMUmh5CO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788788332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6DO94cXjpUj8AJT8LloeHfEvJJNnO+5SbSZSh9uGJc=;
	b=MMUmh5COktGJ++r/p2w+m5oD5IJV/NN1wYOthYRBwY+lv2mOnThnGiS6j3NiRebQUaF0yZ
	Ks92Pol/6dON43ondgBABgbFBZ7pCz9IzuCzIjq9zwNJQeMFjo2BniSHPhTPAG/PSJj2UO
	jJM4D/FiWIK5ktxPNluiUCTc7oJ5YW4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-X0NaMVo3Nket_V9OuxCU8A-1; Mon, 07 Sep 2026 09:38:51 -0400
X-MC-Unique: X0NaMVo3Nket_V9OuxCU8A-1
X-Mimecast-MFC-AGG-ID: X0NaMVo3Nket_V9OuxCU8A_1788788330
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767b782so28417325e9.2
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 06:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788330; x=1789393130;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6DO94cXjpUj8AJT8LloeHfEvJJNnO+5SbSZSh9uGJc=;
        b=ZmSiSTDONw/n0I070ax5ZLQB9KrDOnIIDI9TmVYjibpZ4irOm6lMSS172eToaWc4qm
         g92+5rSCLt3TziaWUp/5XOWclVTXCEr6pc8+i1Af9ihu4i9xNRUsF6EvWULr7/lTSUl8
         4/H9NxJWqko8C0d1RUlXh9Zbt9Ez5G/btb1xDTFOZyAtVAnil4xwfWHMA8Uo0cR4SuMH
         9MqaPN6A0ViOCLH7Pvn4D/avNjAwXR6Dog7VAJpDt3qE7MdBp5RLTx3vMWLIdPKzsxN6
         C4d+kTpNP5rzbFF9lc/Rvz86O02tiskTanqX5wyYLO2DgaSTkokUSRedi5QxxtTKKCuo
         uADg==
X-Forwarded-Encrypted: i=1; AKwUvBzAkMmUGwJCM7ZOwZnluKkYpZuGSu//40iEMJYHMW/mkl44gZ6ZwcicA3DIbp0RYymbKQ+h7Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kTFPBeLnOOaDmJszsGTivMU6gkC9otxkO3rzRiEinzsQumcasX
	P7OKrsgjO2nB7d4ryTsFYPct243kiYjXURzabbfr1D6iUkZ7vN+169kxzjMjFfDU5mqClVfeCv8
	ZLxeqZIHCoaKowZpk2e7EWOkxrgBYtUuwdoEX+vu9M6bNUUTNHUspwrsF
X-Gm-Gg: AYBFou32Uy/JSnIzcabiWDt0y4CSSfT3UEBQANBLiyBNUvKy1ss6T6gtjzCLKnvUE3y
	2BOyenlF+9U0oPwWFv5tvYXLRsNmpBw/WVSNV2avtu45wdXOiLV1oIXjNX6Sl0o5H4xnQNNfV2O
	/hScJPeZA45pCPL7IdWYPQLkS3AJLO8HCBZ956vwMFrmZbe7jc9lS4QURlGRkSle6JGsSGj0KjO
	qzWL5vbBNpYglPYne6yRuzyn0chS7JgihXnwB+52+phHk2UM10zVsT2wdcmO27RY9GFSYYLucOK
	RP+uwVHSGseISVKD8KrbAyF/+hp/JfctyirEXvnOwP+ip40LiH8K4xNWNL9Q2Joi2NIDiO/1/6z
	OHXhugB33Xzqd05jtZuTSi/Nnnu+nRUVuHo98NAonuR1yFX1oz2JNNNTmOvuI6FYpdwO9wZGm5A
	==
X-Received: by 2002:a05:600c:4f12:b0:499:da8b:1476 with SMTP id 5b1f17b1804b1-49cf825a5bcmr243414745e9.14.1788788329830;
        Mon, 07 Sep 2026 06:38:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4f12:b0:499:da8b:1476 with SMTP id 5b1f17b1804b1-49cf825a5bcmr243414415e9.14.1788788329418;
        Mon, 07 Sep 2026 06:38:49 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm161412015e9.8.2026.09.07.06.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:38:48 -0700 (PDT)
Message-ID: <87fb99e7-df73-46b8-97a1-4d6173121ab5@redhat.com>
Date: Mon, 7 Sep 2026 15:38:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v3 1/3] mptcp: fix data-race in __mptcp_retrans
 / mptcp_incoming_options
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
 <20260907-mptcp-snd-una-race-v3-1-65ba0d5f0221@proton.me>
Cc: Geliang Tang <geliang@kernel.org>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260907-mptcp-snd-una-race-v3-1-65ba0d5f0221@proton.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yj8ngfJlPZxskcbKVe2KQF5q8MZu19OI70Tqf5Z3E0A_1788788330
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/26 12:15 PM, quanyeyang@proton.me wrote:
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> 
> SyzKaller found this data-race:
> 
>   BUG: KCSAN: data-race in __mptcp_retrans / mptcp_incoming_options
> 
>   write (marked) to 0xffff888015e8e5f0 of 8 bytes by interrupt on cpu 0:
>    __mptcp_snd_una_update net/mptcp/options.c:1055 [inline]
>    mptcp_incoming_options+0x6a3/0x1ac0 net/mptcp/options.c:1183
>    tcp_data_queue+0x101b/0x2440 net/ipv4/tcp_input.c:5583
>    tcp_rcv_established+0x684/0x1fc0 net/ipv4/tcp_input.c:6654
>    tcp_v4_do_rcv+0x35c/0x690 net/ipv4/tcp_ipv4.c:1866
>    tcp_v4_rcv+0x1d91/0x25a0 net/ipv4/tcp_ipv4.c:2263
>    ip_protocol_deliver_rcu+0x46/0x280 net/ipv4/ip_input.c:207
>    ip_local_deliver_finish+0x190/0x270 net/ipv4/ip_input.c:241
>    NF_HOOK include/linux/netfilter.h:318 [inline]
>    NF_HOOK include/linux/netfilter.h:312 [inline]
>    ip_local_deliver+0xe3/0x210 net/ipv4/ip_input.c:262
>    dst_input include/net/dst.h:480 [inline]
>    ip_rcv_finish net/ipv4/ip_input.c:492 [inline]
>    NF_HOOK include/linux/netfilter.h:318 [inline]
>    NF_HOOK include/linux/netfilter.h:312 [inline]
>    ip_rcv+0x200/0x220 net/ipv4/ip_input.c:612
>    __netif_receive_skb_one_core+0xeb/0x110 net/core/dev.c:6178
>    __netif_receive_skb+0x1f/0xc0 net/core/dev.c:6291
>    process_backlog+0x168/0x360 net/core/dev.c:6642
>    __napi_poll+0x71/0x460 net/core/dev.c:7706
>    napi_poll net/core/dev.c:7769 [inline]
>    net_rx_action+0x6f8/0x810 net/core/dev.c:7926
>    handle_softirqs+0xc9/0x2e0 kernel/softirq.c:622
>    run_ksoftirqd kernel/softirq.c:1063 [inline]
>    run_ksoftirqd+0x20/0x30 kernel/softirq.c:1055
>    smpboot_thread_fn+0x287/0x520 kernel/smpboot.c:160
>    kthread+0x1f2/0x240 kernel/kthread.c:436
>    ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
>   read to 0xffff888015e8e5f0 of 8 bytes by task 24 on cpu 1:
>    mptcp_rtx_head net/mptcp/protocol.h:487 [inline]
>    __mptcp_retrans+0x169/0x8f0 net/mptcp/protocol.c:2759
>    mptcp_worker+0x6a6/0xb30 net/mptcp/protocol.c:2980
>    process_one_work+0x3ee/0x970 kernel/workqueue.c:3275
>    process_scheduled_works kernel/workqueue.c:3358 [inline]
>    worker_thread+0x3c3/0x730 kernel/workqueue.c:3439
>    kthread+0x1f2/0x240 kernel/kthread.c:436
>    ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

I think this race is not present in the current tree, after commit
96d846e3e2a7 ("mptcp: let the retrans scheduler do its job").

/P

