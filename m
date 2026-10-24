Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822280;
	b=m6D9ecutt6HRBfjnO6lf9A8pl5MRH/g+/84A8ZsbQjhA25KxuF2Kz8IlxRRoYyA83J4u
	 BPoXuZtITd6dztYY7ZHWL0pXHwRL3GMk+JN16gvS3SOOKTbHXGLYPnyy0wCfyKluuQKhJ
	 GWG+/8H8sZ9cgwEJl0OrktMiqPw429viLBZ3wkOxxHjxedk6827dBmDTu01fmQyUhJCSW
	 kMsJpdXn+gP5zQkfSrugNqCF+d4jtYw065/YMuZEGLLlnhzi26Hn7Sv1p86e0wvu3aOhT
	 gpfZS3b3xoUtR5JHKD/Xp/CZevxI9XVrbHOuQmryaYtTdfUH39+1YNNnXLzN/k7Tptg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822280;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IDhNDxbIvzOT7XlvKikbL22Laa7owyADOUuX3ok6xo4=;
	b=L4/6cXXeeAmj3iraaD4Bi3fZvB4k2z0vtpv2Ej6vJGU9MjDV2Ya7WsTIHadVUej/N0SZ
	 CtejZW9H96TLPR11XIIkqiF5GQxh4Mq7nFf8SjXPx+S7Olz4jeGGx1V5uBqi3gT/CLqdc
	 6G8Dh9b9ey42QQvubGy11mWtn+AoM9XyWC5Zrz6dNOCGY99sXK/Z6J1sj3p00xEpmfnGG
	 Inngbj1bofgM+VkjMe5e/cH8tdSd1hUsk44rlkiYIdY5d5Pma8F3zxqSL2jbcTCl+wS4H
	 Y1KQwrNK7Q+OUNhS14FlKhRt/1F8lvxU9CG7L0+eWluW+n+8C/EXOke04VNqnXHSz8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYIzHTM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813FD606A31B
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYIzHTM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C891F01825;
	Sat, 24 Oct 2026 06:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792822280;
	bh=IDhNDxbIvzOT7XlvKikbL22Laa7owyADOUuX3ok6xo4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VYIzHTM5Eo5ZqyRwTdbFX9URjVPDbIgJMa/TpHphFLhZufAxdZb3eJLwY9Oj2gs6A
	 Eu0tXxR/i53fuMRb4vgfiFzzew9hQ5IMxV4qqK/uH/1IgJ/XEGvZpmzHhnQ4Fv58yd
	 Ee6PSuwlM/2d9AXesJfS5tcwYa5XtfOkL1AW6ddVp/3Ll25wQrvggPJBdHjSI8x1lE
	 ZPdSBq/HzvCY9QjeFkBhoDMqMAr8TuGxrjMr6BPWciKUYqqajBI4FfEeWObRE5d372
	 W/sMcQ9BhkmZ2df013XOZkyTJJyQ9DTeCKU/L1Z8wbNecHCIO3zII0g07nIiOiH8um
	 lEC6t3iS10cEA==
Subject: Re: [PATCH mptcp-next v8 5/6] selftests: mptcp: pm_nl_ctl: support
 the subflow-retries limit
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 24 Oct 2026 06:11:19 +0000
Message-ID: <179282227953.3132.7976238140611050653@kernel.org>
In-Reply-To: <20261022151130.2285198-6-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-6-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The 'subflow retries above hard limit' subtest in
  tools/testing/selftests/net/mptcp/pm_netlink.sh cannot show what the…

--

selftests: mptcp: pm_nl_ctl: support the subflow-retries limit

With this patch, 'pm_nl_ctl limits' can set the subflow-retries limit
through an optional third argument, and it prints the limit when the
kernel reports it. pm_netlink.sh is extended to check the default value,
that a value above the maximum is refused, and that the value can be set.

> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 21bfe1311f118..99072ad8052d9 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh

[ ... ]

> @@ -75,6 +80,22 @@ get_limits_nb() {
>  	fi
>  }
>  
> +# The subflow retries limit is only set and shown with pm_nl_ctl for now.
> +# Prints its default value if it is supported.
> +get_default_retries() {
> +	if mptcp_lib_is_ip_mptcp; then
> +		return
> +	fi
> +
> +	if ip netns exec "${ns1}" ./pm_nl_ctl limits |
> +	   grep -q "^subflow_retries"; then
> +		echo 127
> +	elif mptcp_lib_expect_all_features; then
> +		# missing feature: the defaults limits check will fail
> +		echo 127
> +	fi
> +}

[ ... ]

> @@ -224,7 +247,27 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
>  
>  set_limits ${max_limits} ${max_limits}
>  flush_endpoint  ## to make sure it doesn't affect the limits
> -check "get_limits" "$(format_limits ${max_limits} ${max_limits})" "set limits"
> +max_limits_out="$(format_limits ${max_limits} ${max_limits} \
> +		 "${default_retries}")"
> +check "get_limits" "${max_limits_out}" "set limits"
> +
> +if [ -n "${default_retries}" ]; then
> +	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} \
> +		128 2>/dev/null
> +	check "get_limits" "${max_limits_out}" \
> +		"subflow retries above hard limit"

[Severity: Low]
Can this subtest tell a refused value apart from a clamped one?

The commit message says pm_netlink.sh checks "that a value above the
maximum is refused". Since v8, the per-netns default is the same value
as the policy maximum.

In net/mptcp/pm_kernel.c:pm_nl_init_net():

	pernet->limit_subflow_retries = 127;

In net/mptcp/mptcp_pm_gen.c, mptcp_pm_set_limits_nl_policy has:

	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),

get_default_retries() also hardcodes 127, so max_limits_out already
contains "subflow_retries 127" when the request with 128 is sent. The
exit status and stderr of pm_nl_ctl are thrown away.

If the kernel refuses 128, the readback shows 127. If 128 were accepted
and clamped to 127, the readback would also show 127. Both outcomes pass
this check, so it only fails if 128 is stored as-is.

The earlier "rcv addrs above hard limit" and "subflows above hard limit"
checks work because the stored value differs from what the bad request
would set.

Could the 128 attempt be moved after the "set subflow retries" step, so
the check can verify the value stays at 0? Checking that pm_nl_ctl exits
non-zero for the 128 request would also work.

> +
> +	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} 0
> +	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
> +		"set subflow retries"

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022151130.2285198-1-anilkaushikwireless%40gmail.com
