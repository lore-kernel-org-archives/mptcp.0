Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B144A92C8
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789339; cv=none; b=VjxolZdEy4sJB3/A7nPrAG9JiNUsZdupyYHe8r6v53v+S1GPMjNXwCeA3ngUsOGUxEmSj1UmNayWPM12vLoZVIr9ugNy3BDLJCsg6Ywr/PHS/Q5ojHGyt/TOdiWsmtHxYzNk6ULDfua3rb7QXNeb80HoZYvBtmlA1iN8sjEtddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789339; c=relaxed/simple;
	bh=0r8oTzOUqurqwWMpEPA8VGM6zx7PP0qIsmL5oRwG8jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SF2Ye/Pu8g2gbKyFUxrsEff3wjKYwomIuk3qW6yW69VOFaLmWDyxYDW7BcUFEEjuTTYcCgp1xoa0/ZwM7qDNAXHwH93NfGfSxQ8IGC9RgXt0UvE3b7WeI/cdGx6345yLqYFyuaZ9xbyx1hQHa7Z2jXKNNaIKZvKl5WpdbdeRnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr9o/D4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr9o/D4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82551F00A3A;
	Mon,  7 Sep 2026 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789337;
	bh=jJ+ndCZNHT0zDxYtMGHvipLR4TlMKPnMFQNGeNYe0UQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dr9o/D4m5aWfOMIZIuItB2ZIbjE6/Fbh7NdnM4RTMVVBNqxzGtzrADh0ftgSM1EFj
	 AQhQ+f+SZveyvFTt1bZ/lDwfEl/gqlmeHbiOE3sAir7iuhotdaNXOXJD6PkT6/ROXl
	 WxWKRAQf3IYvveeyXMp5N13ROiAUZXvX3W0yatl7lnRJeqR0+5cfbViPZw2ggSgutN
	 dyL1HT9Zd1aIyQNea3AL+a3lLjzjBaQD4+VQGYshflf4TMoCHu6YJ6Mf+7kA1y4VFA
	 2HYJz6ZO79KGctQK76uJJUKGqg6ZW2hBftPTixNQ/eYJT4xk2QPklVVTBE6jcVnTAR
	 2mkJcizj3sBag==
Message-ID: <f61eb670-8db3-4c97-92fd-b66294ef222e@kernel.org>
Date: Mon, 7 Sep 2026 15:55:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 1/3] mptcp: fix data-race in __mptcp_retrans
 / mptcp_incoming_options
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, quanyeyang@proton.me,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
 <20260907-mptcp-snd-una-race-v3-1-65ba0d5f0221@proton.me>
 <87fb99e7-df73-46b8-97a1-4d6173121ab5@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <87fb99e7-df73-46b8-97a1-4d6173121ab5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/09/2026 15:38, Paolo Abeni wrote:
> On 9/7/26 12:15 PM, quanyeyang@proton.me wrote:
>> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
>>
>> SyzKaller found this data-race:
>>
>>   BUG: KCSAN: data-race in __mptcp_retrans / mptcp_incoming_options
>>
>>   write (marked) to 0xffff888015e8e5f0 of 8 bytes by interrupt on cpu 0:
>>    __mptcp_snd_una_update net/mptcp/options.c:1055 [inline]
>>    mptcp_incoming_options+0x6a3/0x1ac0 net/mptcp/options.c:1183
>>    tcp_data_queue+0x101b/0x2440 net/ipv4/tcp_input.c:5583
>>    tcp_rcv_established+0x684/0x1fc0 net/ipv4/tcp_input.c:6654
>>    tcp_v4_do_rcv+0x35c/0x690 net/ipv4/tcp_ipv4.c:1866
>>    tcp_v4_rcv+0x1d91/0x25a0 net/ipv4/tcp_ipv4.c:2263
>>    ip_protocol_deliver_rcu+0x46/0x280 net/ipv4/ip_input.c:207
>>    ip_local_deliver_finish+0x190/0x270 net/ipv4/ip_input.c:241
>>    NF_HOOK include/linux/netfilter.h:318 [inline]
>>    NF_HOOK include/linux/netfilter.h:312 [inline]
>>    ip_local_deliver+0xe3/0x210 net/ipv4/ip_input.c:262
>>    dst_input include/net/dst.h:480 [inline]
>>    ip_rcv_finish net/ipv4/ip_input.c:492 [inline]
>>    NF_HOOK include/linux/netfilter.h:318 [inline]
>>    NF_HOOK include/linux/netfilter.h:312 [inline]
>>    ip_rcv+0x200/0x220 net/ipv4/ip_input.c:612
>>    __netif_receive_skb_one_core+0xeb/0x110 net/core/dev.c:6178
>>    __netif_receive_skb+0x1f/0xc0 net/core/dev.c:6291
>>    process_backlog+0x168/0x360 net/core/dev.c:6642
>>    __napi_poll+0x71/0x460 net/core/dev.c:7706
>>    napi_poll net/core/dev.c:7769 [inline]
>>    net_rx_action+0x6f8/0x810 net/core/dev.c:7926
>>    handle_softirqs+0xc9/0x2e0 kernel/softirq.c:622
>>    run_ksoftirqd kernel/softirq.c:1063 [inline]
>>    run_ksoftirqd+0x20/0x30 kernel/softirq.c:1055
>>    smpboot_thread_fn+0x287/0x520 kernel/smpboot.c:160
>>    kthread+0x1f2/0x240 kernel/kthread.c:436
>>    ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
>>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>
>>   read to 0xffff888015e8e5f0 of 8 bytes by task 24 on cpu 1:
>>    mptcp_rtx_head net/mptcp/protocol.h:487 [inline]
>>    __mptcp_retrans+0x169/0x8f0 net/mptcp/protocol.c:2759
>>    mptcp_worker+0x6a6/0xb30 net/mptcp/protocol.c:2980
>>    process_one_work+0x3ee/0x970 kernel/workqueue.c:3275
>>    process_scheduled_works kernel/workqueue.c:3358 [inline]
>>    worker_thread+0x3c3/0x730 kernel/workqueue.c:3439
>>    kthread+0x1f2/0x240 kernel/kthread.c:436
>>    ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
>>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> I think this race is not present in the current tree, after commit
> 96d846e3e2a7 ("mptcp: let the retrans scheduler do its job").
Thank you for having checked. Good point, this old patch is maybe
outdated, I didn't check.

Note that on syzkaller side, the last occurrence I had for this issue
was on the 13th of May, and your patch was in on tree on the 3rd of
June. I guess it is indeed not needed then. (I don't know why I didn't
see it after the 13th of May, but there were no reproducers.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

