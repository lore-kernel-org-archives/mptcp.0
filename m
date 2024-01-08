Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1654BC4
	for <mptcp@lists.linux.dev>; Mon,  8 Jan 2024 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr8soBsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D33CC433C8;
	Mon,  8 Jan 2024 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704734682;
	bh=aIZotvGcIXLSPw3BFQLTb7neTGynt/3vDdHqejvYOvk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lr8soBsaYAFh/DWb6adwf45VC0j8HCv6ZIcDnXs3ddXw4s/Q8tip89IXrmwmsUUf7
	 J2tgxQztGyR1Rrab95MEsSNY9ALc8ZTe691rWH7ivLlMqVg5J4tMKUv6eB4OQBvyxy
	 TO2hwwIz2vqzxqVZvnrc/FzOf/kDrIUmjEWmNpwmrdIXuVGIw+5ifZbto3kcPnA1+2
	 W3rP+19yuA2alValCCMQNuHC5q11VwRrQzDXOXl28qLaTXJ8hMh9xcPXmwgXKBPmXT
	 nOiGtNI1A/ce5KWIrHkUUqdXYNAQxN/wDIx/KjBYSjzAXu97f/yFXTWboErY4FgP+L
	 cEFCCZOdBk/lg==
Message-ID: <c115c8ee-2752-49f3-8566-d15b799298df@kernel.org>
Date: Mon, 8 Jan 2024 18:24:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] bpf: Add mptcp_sched_ops CFI
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
References: <9e2fbdc6e5a9c59d4b8eded4bfb2ae71a768afad.1704530434.git.geliang.tang@linux.dev>
 <c2889577-25a3-4721-a754-61d082474d36@kernel.org>
 <9754c6ba4f1ef8b1463d1a50ea3a8cb35f14248f.camel@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9754c6ba4f1ef8b1463d1a50ea3a8cb35f14248f.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 08/01/2024 13:37, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-01-08 at 11:14 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 06/01/2024 09:40, Geliang Tang wrote:
>>> '''
>>> The cfi_stubs pointer is added in the commit 2cd3e3772e41
>>> ("x86/cfi,bpf:
>>> Fix bpf_struct_ops CFI"), this patch initializes it as dummy stubs
>>> __bpf_mptcp_sched_ops.
>>> '''
>>>
>>> Note:
>>>
>>> BPF tests on export branch fail with this error:
>>>
>>>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>  #PF: supervisor read access in kernel mode
>>>  #PF: error_code(0x0000) - not-present page
>>>  PGD 0 P4D 0
>>>  Oops: 0000 [#1] PREEMPT SMP PTI
>>>  CPU: 3 PID: 1512 Comm: test_progs Tainted: G        W IOE     
>>> 6.7.0-rc5 #37
>>>  Hardware name: LENOVO 4180PG2/4180PG2, BIOS 83ET76WW (1.46 )
>>> 07/05/2013
>>>  RIP: 0010:bpf_struct_ops_map_update_elem+0x4ee/0x610
>>>
>>> This patch fixes this error. It can be applied after the commit
>>> "bpf: Add bpf_mptcp_sched_ops"
>>
>> Thank you for having checked and fixed that!
>>
>> Is it OK for you if I squash it in "bpf: Add bpf_mptcp_sched_ops"
>> commit?
> 
> Yes, it's better to squash it. Please do this when merging it.
> 
> I'm not sure whether "get_subflow" should be initialized here too. If
> it should be, I'll send another squash-to patch to fix this.

Good point, I guess it should. When I look at bpf_tcp_ca.c, it looks
like they implemented all function pointers. Except get_info(), but this
one is marked as unsupported.

I just added it when applying your patch. Please tell me if I did it wrong.

While at it, I also updated your email address (I really thought I did
it before, but apparently not...)

New patches for t/upstream:
- 810cc99b7dd6: bpf: Add mptcp_sched_ops CFI
- 197ce89d9597: mptcp: bpf: add get_subflow for CFI
- Results: ca5de126f347..10ca1d146a6a (export)

- ca17d989b252: tg:msg: update Geliang's email address
- 9553337100f5: tg:msg: update Geliang's email address
- 404ca606684e: tg:msg: update Geliang's email address
- 75f8cc7247d5: tg:msg: update Geliang's email address
- d86fc89e4e11: tg:msg: update Geliang's email address
- e8708c02eace: tg:msg: update Geliang's email address
- 039488fe8e2e: tg:msg: update Geliang's email address
- 9bbd8dbced1d: tg:msg: update Geliang's email address
- 8f03f584b792: tg:msg: update Geliang's email address
- b500d1b51c5b: tg:msg: update Geliang's email address
- 4e489b19e9f0: tg:msg: update Geliang's email address
- e2029e1cfb8b: tg:msg: update Geliang's email address
- 134f88acf139: tg:msg: update Geliang's email address
- b708aa7547e1: tg:msg: update Geliang's email address
- a814d467f027: tg:msg: update Geliang's email address
- 2b1c988725e8: tg:msg: update Geliang's email address
- Results: 10ca1d146a6a..bd5be2c4e44b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240108T172308

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
