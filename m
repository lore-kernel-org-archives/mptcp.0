Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446232;
	b=XAiXgixCxV1HBX5COvawUU14n0zwlV2ShsqJPGl3r1aoe2YVlnH0Aaas8i4hcUFTdMxL
	 kKf0DMnmrgjxTRsXvMfwpag90w4ivSBiz8Eu8OvrVJxyQYxgdwE7CcRRu76qzIM51N6Dp
	 WBbojlDqiEurOHFVr8MiYHGNiWoMWDoIu6zoNjGoqU8X3oGhf6LYzAKk1tMUjtGvGqgod
	 DS2UCZQJxh+2ZwY+kbyNBu4hbkf1QtBia9n519q0ipU06KlYw6gU6Ukuqvtj0Ug8/d4K2
	 tHrYuf+DDPF40LFQC+VhoH2uRRK9wGd+rYvv91VVvsSPjnUpC7gUXmcOxK8BF6W5mcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446232;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0vv0rAesrX4NQT3w9gG9/Xekp0H2PvXuBwVBYnqB/9E=;
	b=dABFluHfylm7auvGlsJYSVzTn5eCV5bytggnSwBEmYTy6x1Cahr0xItCn1khMiVO14XB
	 0xvDsZv+75D9IhDVfexaqCWzj/y+fBKG8lfD61STVl9ZYpo3v3t+Lei6SbrdqpQ+r8GKh
	 RO5ELZmle/hI0OLtAJvO89q2esWchFmVLRO5d09VRvHx5plJHO6kdHt+DiB2wUL6YjEPc
	 bNUnSzxLNnQH1cPxNcqHQVttgPwZhwGu/wmbJhDuoBi6apjNDWZuHUVX8EDmZzJvNx3NG
	 P3haB1rii5tlOH/I4PmDkLA/R5KSOmXnaQ9e9Ejia/X2mBs6VvdPzsT+ZruRjejPSVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJm5CS5L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB53606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJm5CS5L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30691F00A1A;
	Sat, 31 Oct 2026 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446231;
	bh=0vv0rAesrX4NQT3w9gG9/Xekp0H2PvXuBwVBYnqB/9E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KJm5CS5LpTF1ClFLRHQMXqpfdZAIgkquE3mm6BevRdziMr2LsEOAIlfCTbm4j/brV
	 QzCFwwkIDlddmiJRFRi/ED4a8Zdw4Ox3MtFEHv/MerI8JRavlwDzfm7rxMd5hyuPcv
	 V5H7DSFFjG2gn8Jlotxq80mF+VzQlzxrCGkp1qZERcyM3I1u9oa509XAyuwt5IEZZ9
	 ZmfytEbweQxd87gpuRDil/Sp/m2/4ZRT96At5hsCHPudKvXbWR0iJgcRoCXUxt9Hfa
	 RwsKhJp+NACtz2dNDfyeHWyP4ae4MV1x6GAisZ9mEdvTiVPf2dWBSY8FcpPmo/8/fJ
	 NXTdlshP4VOew==
Subject: Re: [PATCH mptcp-net v4 7/8] selftests: mptcp: join: new ID0 subflow
 from the right IP
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:31 +0000
Message-ID: <179344623122.3128.4686293710004811543@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-7-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-7-555066fa4292@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In userspace_tests()
  (tools/testing/selftests/net/mptcp/mptcp_join.sh, test "userspace pm…

--

selftests: mptcp: join: new ID0 subflow from the right IP

This patch updates the "userspace pm create id 0 subflow" test so that the
ID0 subflow is created from the initial address 10.0.1.2. It still tries
10.0.3.2 first, which the kernel is now expected to reject. The expected
dump output becomes an empty list, because the initial address is not
dumped.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..190ab48acbc61 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4214,10 +4214,11 @@ userspace_tests()
>  		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
> -		userspace_pm_add_sf $ns2 10.0.3.2 0
> +		# from an IP not linked to ID0: failure expected, no new MPJ
> +		userspace_pm_add_sf $ns2 10.0.3.2 0 2>/dev/null
> +		userspace_pm_add_sf $ns2 10.0.1.2 0
>  		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
> -		userspace_pm_chk_dump_addr "${ns2}" \
> -			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
> +		userspace_pm_chk_dump_addr "${ns2}" "" "id 0 subflow"
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2

[Severity: Medium]
Does anything here check that the 10.0.3.2 request actually fails?

userspace_pm_add_sf() returns the exit status of pm_nl_ctl csf. That
status is 1 when the kernel rejects the request. Here it is ignored and
stderr goes to /dev/null. The status of the 10.0.1.2 call is not checked
either.

All the checks that follow only count subflows:

    wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
    chk_join_nr 1 1 1
    chk_mptcp_info subflows 1 subflows 1
    chk_subflows_total 2 2

So they cannot tell which of the two requests created the extra subflow.

The new empty dump expectation cannot tell them apart either.
mptcp_userspace_pm_dump_addr() skips every entry that matches
is_init_id0(), and that check ignores the address:

net/mptcp/pm_userspace.c:is_init_id0() {
	return entry->addr.id == 0 && entry->addr.port == 0;
}

Suppose the initial ID0 entry were missing from the userspace PM list.
That can happen if the GFP_ATOMIC sock_kmalloc() in
mptcp_pm_userspace_created() fails, or if a later change breaks that path.
In that case, mptcp_userspace_pm_append_new_local_addr() would accept the
10.0.3.2 request and create an ID0 subflow from the wrong IP. The
10.0.1.2 request would then fail with -EINVAL, because the ID matches but
the address does not.

Would every assertion above still pass in that case?

The commit message says the wrong IP is kept:

    "to check that the kernel is correctly not allowing the creation of
    an ID0 subflow with the wrong IP address"

As written, though, the test passes whether or not the kernel enforces
this. It only fails if both requests succeed.

Could the failure be asserted explicitly, for example:

	if userspace_pm_add_sf $ns2 10.0.3.2 0 2>/dev/null; then
		fail_test "ID0 subflow from wrong IP accepted"
	fi

Alternatively, could the test check that the saddr4 of the SUB_ESTABLISHED
event is 10.0.1.2?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
