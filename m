Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA743C1090
	for <mptcp@lists.linux.dev>; Mon,  6 Jul 2026 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356421; cv=none; b=FCP3rLs+Fg9fZ2H9a1SxUA53adutUufBhMt4OjIoAXaF2Lu3fckE7/jOu0Ag3Y2eZgI26NOxwl6EWjecN009jv3JD+fWW9gcnvV56wzceLbGOVA7HxX3WbkvVU8V6himjUyD5/F75CJS41ao7ENpfwfM+niHOdme54Ya6qhLGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356421; c=relaxed/simple;
	bh=l/gTMhdc/NsEyuv1toPi4xVZ7iyCWS9mgzffjqk1z9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfSf8NO3WX6u+YwnGfLmr3h4zy0tvS73tls6JGbZ6+M8sSCNsr560S6yFiNf0f/56ArhJUnVxwD/lgMB09YGHUeNV1s33LnP+ZskFi3nEVHWHvb+P0jS6urJMTVXMWCgZuPrGQILVuDyxzcFxR6NUW4InjlMAhowt9W0gRPOjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqgFRaQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqgFRaQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661EB1F000E9;
	Mon,  6 Jul 2026 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783356419;
	bh=XZwnnm2WePFJrIkNWLdlK+HDv0tPTQQ0p/8nODJwFJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GqgFRaQD2p/2Y+izCwsSTN/sTAbQ84+MdZdGcox2/xpWBmecAxTsRhrwSWM2bJPF0
	 BkAuR+hnHDm8yUh9KD9JNt25ydb3iYWPbjmPjl3lscNaU8vT72JLda+53DST3rALRD
	 a/0IBckTCRJyUjlGdtsQ6AIFwYR/FeZqGDruHFWQ7is9Ziglmgx81wKhu9aXFSyrph
	 z68Te8oZ77mdTXvkPUfd5lRmEVOIYpBXvWESi6vt8jm6PdEHt237HJLAO56cthAVq2
	 n0OlnTFElG34cvJ9gI4tNoIyiFz5L35VjXI1QmcZY2ob2yp15a7KQOTTcrip1NEh4l
	 +UOPAnuzRCM8w==
Message-ID: <6d0b954c-4028-4c1e-bf02-5bf5f43f58af@kernel.org>
Date: Mon, 6 Jul 2026 18:46:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing id
 0 endpoint
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, martineau <martineau@kernel.org>,
 pabeni <pabeni@redhat.com>, "shardul.b" <shardul.b@mpiricsoftware.com>,
 janak <janak@mpiric.us>, kalpanjani009 <kalpanjani009@gmail.com>,
 shardulsb08 <shardulsb08@gmail.com>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
 <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
 <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
 <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
 <19e830d30d7.701114c6187254.5018026155515510877@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <19e830d30d7.701114c6187254.5018026155515510877@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

Sorry for the delay.

On 01/06/2026 13:59, Kalpan Jani wrote:
>> do you mind sharing what you have so far. Maybe someone else can help
>> you to reproduce the issue.
> 
> Attached is the WIP packetdrill test (server side, based on the existing
> add_addr/mp_join server tests, with an extra MP_JOIN subflow). I have not
> been able to reproduce the WARN with it yet, so please treat it as a
> work-in-progress rather than a finished test -- the status and the open
> question are written at the top of the file.
> 
> The trigger is "ip mptcp endpoint delete id 0 <saddr>", which is the only
> op that reaches mptcp_nl_remove_id_zero_address(). (flush is not usable: it
> goes through mptcp_pm_flush_addrs_and_subflows(), which already calls
> mptcp_pm_announced_remove(), so that path was never buggy.)
> 
> Where I am stuck is getting ADD_ADDR(id 0) announced in the first place.
> The signal endpoint on the MPC address has its id bit cleared by
> mptcp_mpc_endpoint_setup(), so it is not announced on connect. "delete id 0"
> frees the bit again, but I could not confirm that the PM worker re-runs and
> announces id 0 on an otherwise idle connection. Without that announcement no
> pending anno_list entry is created, so the second "delete id 0" has nothing
> stale to leave behind and the WARN does not trigger.
> 
> So my question: what is the minimal way to get the id-0 address actually
> announced via packetdrill? Does this need the MP_JOIN subflow and/or a data
> exchange to wake the PM worker between the operations, or is there a simpler
> approach I am missing?

With the in-kernel PM, I think you need to:

- create a subflow using a second local IP address (maybe optional): use
  multi-ep.sh (or add an IP address and inject a SYN+MPJ)

- remove the endpoint linked to the initial subflow: ip mptcp endp del

- re-create the same endpoint: ip mptcp endp add (or adapt multi-ep.sh
  to avoid the flush)

That's what the mptcp_join.sh's "delete re-add signal" subtest does if I
remember well.

>> I will wait for this test before applying the v3.
> 
> Understood, I will keep working on it. One thing I wanted to ask directly:
> is a deterministic packetdrill test a hard requirement for applying v3, or
> could the fix go in on the reasoning + the syzbot report alone? The change
> only makes the id-0 removal path symmetric with the non-zero id path (tear
> down the pending ADD_ADDR and decrement add_addr_signaled), so it is fairly
> contained and independent of whether I can script a reliable trigger.

Having a reproducer (packetdrill, selftests, syzbot repro) are not just
added to avoid having the same issue later on, but it also helps the
reviewers to understand what is being fixed. Here, we don't have a
syzbot reproducer, so I think it is even more important to prove that
something is being fixed here: maybe syzbot found another path, and
having such test here would really help for later to exercise one "known
path".

> (Note: the anno-list helpers were renamed in current export, so v3 no longer
> applies as-is; I can send a trivially rebased v4 that swaps
> mptcp_remove_anno_list_by_saddr() for mptcp_pm_announced_remove() if useful.)
I see that you sent a v5 for this. I guess you did the rebase, and you
added a reproducer in the selftest. It should be enough for now. But
here, I would like to get your feedback if you don't mind: now that you
have a clearer view on what needed to be tested, do you think there
was/is a blocking point to get such validation in packetdrill? I do
think Packetdrill tests are often better in terms of maintenance,
clarity, and execution time to reproduce exactly what is needed (not
just with MPTCP), so I think it is important to make sure this tool is
still adapted, and understood by multiple people.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

