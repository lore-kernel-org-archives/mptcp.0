Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115307;
	b=BKZrhFhp+XPchjn/1tS7ah+D9zHYIvWusDThI1Kl/IajS1mNy0IvAQAkxS0i4TQ91SFq
	 GBExlCX7x3MTXao6keUQockcXouVxg/iT29aEQTZFgwPxw2qk0yzp1wz22KGquk4pwHZj
	 yv9PiNJ7FmBv6hsDQ6omkJNLrzfcRg9YoTgI4dodqIc2AYGXCdec+exKwgkmizfVG3ExY
	 Kf07QUm5v5AAKwlZYvIsrEriKLd6zCObXyUDYoy2KCCX1kmBqwqeCIioFrT/NlkgszlZT
	 yB3HXuELkvuJODsa5DZsCeCQ7b2wDAH/7rF/pGYS13ePRLuk12gQIOPkvns6jV7/rYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115307;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=nDfU60/+6X969jmzlAI7Zz64zuiRF4it/HoyjlZB9+A=;
	b=ydzdJKBD/8ZmDct74IGfOCAFiRy5TKqgGIrleL5kJ3V1VQhtwiilmQcGsV9VsEuMsrHS
	 Ef0EvwEbKmI/pE6PLSkYCcW3LBJVqbJDaPq20E5mA6ddMuOO24/a5eSkxXlAEoRfhCQOZ
	 +V+xn7VnnmzHkDSA6H9uWA0FdFdzjeIIbqDMQw2pYKldN0fNOPvDuoKV+A+dvSON7HI68
	 7La8yhxDo3Xamew/o/wL9YBTz6UOcYloHBVgLOhjbi7DV+/j+Nt8yBEuze6om8FxkUxhl
	 o+mjwvSRHs/mNMqyuXlZk4Ti55OwIvcDCpjUMaR8Wlq0jdTofv9+obh+g5A+uBHN8Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bc65WvQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA726606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bc65WvQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C01F000C5;
	Thu, 19 Nov 2026 19:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115307;
	bh=nDfU60/+6X969jmzlAI7Zz64zuiRF4it/HoyjlZB9+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bc65WvQrt9iWIcaxXvaNzDMulKwKIWB1yb8bTuypSF2g5U1s4cgjriv9UrKcU1T+o
	 iTZgY73jqqaskJ7uvcuClxrNEj2XEHCGE9TcI4g8PbP4ZrS+JIL9+Eh8UGeHs2N2dG
	 vzUvzMrWmV1rb4VE6e7hrZTwyPUvYF/SuG+e95wdseK4U1Wm5pxJGWRuvJYr8q9hM/
	 XVXpt2b0cqZhx5gT5UxSt3O25zdUIl212lwt2sle1ModvBAtxZKVv/Ict6op7dRUXt
	 XNBolUf8+3uCUEzAkKvAExuPHkB7CRuJr1OFin6D7ufXG1kY0el7dVwzDVZuTaen92
	 /g50rqPnWlnAQ==
Message-ID: <487f100c-3a38-4267-98d3-a3fb41413890@kernel.org>
Date: Thu, 19 Nov 2026 20:08:24 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: kernel: c-flag: keep
 local_addr_used in sync
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Yiming Qian <yimingqian591@gmail.com>
References: <20261029-mptcp-pm-cflag-clear-when-used-v3-1-fa96c11f97b0@kernel.org>
 <0a3dcc9785f4f067bb051edafd0a780bbe2231b5.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0a3dcc9785f4f067bb051edafd0a780bbe2231b5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 30/10/2026 03:12, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2026-10-29 at 21:43 +0100, Matthieu Baerts (NGI0) wrote:
>> The ID was marked as used before incrementing local_addr_used counter
>> when the families were not matching.
>>
>> Marking endpoints as used while they are not can have an impact on
>> the
>> local_addr_used counter when endpoints not linked to the initial
>> subflow
>> are removed -- CAP_NET_ADMIN is required -- and active connections
>> have
>> such badly marked endpoints. In this case, the local counter will be
>> decremented while it shouldn't. If the counter was already at 0, this
>> warning will be emitted:
>>
>>   WARNING: net/mptcp/pm_kernel.c:1080 at
>> __mark_subflow_endp_available+0x46/0x50, CPU#0: a.out/149
>>   RIP: 0010:__mark_subflow_endp_available (net/mptcp/pm_kernel.c:1080
>> (discriminator 2) net/mptcp/pm_kernel.c:1076 (discriminator 2))
>>   Call Trace:
>>    mptcp_pm_nl_del_addr_doit (net/mptcp/pm_kernel.c:1112
>> net/mptcp/pm_kernel.c:1227)
>>    genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
>>
>> The fix is easy: increment local_addr_used similar to what is done in
>> mptcp_pm_create_subflow_or_signal_addr() for the non C-flag case.
>>
>> Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with
>> C-flag")
>> Reported-by: Yiming Qian <yimingqian591@gmail.com>
>> Closes:
>> https://lore.kernel.org/20261006114409.117190-1-yimingqian591@gmail.com
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Good catch. The fix correctly restores the consistency between
> id_avail_bitmap and local_addr_used, matching the non-C-flag path.
> 
> Additionally, I don't think the Perf failure (Perf: Unstable: 1 failed
> test(s): error:sched-bbr) reported by the CI is related to this patch.

Indeed.

> 	Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

New patches for t/upstream-net and t/upstream:
- 3d3d69e81e35: mptcp: pm: kernel: c-flag: keep local_addr_used in sync
- Results: 7b224f1d89a9..11f82b7f71e5 (export-net)
- Results: 6d74f37dcbe7..b17f0edeea4e (export)

Tests are now in progress:

- export-net: https://github.com/multipath-tcp/mptcp_net-next/commit/09ec755949ab4b5821fb9c830b3047c61605f26f/checks
- export: https://github.com/multipath-tcp/mptcp_net-next/commit/e1edd6bbff8ff5f16743f58a41193e327149903d/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

