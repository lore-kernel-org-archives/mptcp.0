Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136192;
	b=H6GhExcHTEapqw1XXmE/AUkZmV65UJl0zrCL8GzgTxjbuqYWAOKx47XrAwoF3RohPl79
	 /ulJm1We5Bn9FvxVlDLdoTzc9+BQZPhLu3V42f7N60slhuxCuZRuajaIGP/d7DyoySQ5n
	 8E+3tEQZWZOVh1zyO48a1zl3bFwQHikNmCy7jJzqOTPVc2dprldiWcMtbHdhEDhcivTqW
	 57zIpQzL52BCBh8VAKVgLZRppyra6fRrmc/gDKUY+SRUx/jxuxOiM5pQggwil5p7IqfcH
	 RtQMl29tLHcHXhE25cqelDhfT9UQExQhaBroU0GSYQRnjbRk4YaU5hGFjZhrNcw+OgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136192;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KwtfS7ttern4Y9T5XDagaM0xwHMJ8q3ZdgBfQgSUY5E=;
	b=rOpax6V0IkpuIibgfEpJJNNGENivnygG4FhHPC8F6GHDpBBuzBk/6WCZC6kbNXIDxiUr
	 3WAtkrIXf1Fr/Ud0GbIf4wkHTO492qPLVuqFZTnP331hb1T9pJRe7hU1iEYW4LO6Pt6p3
	 ACVqhjdKLtvn9r919wYLrVg1Zmrbw1dGiANLq2S48GduBTvvI6mpe8nYuPZQUYeTaShWV
	 rdET7tgJ1CmGHzk8/ioz8P731Rp8G9w3QejwW3jEvs6v1Qv/nTnAWz7tYYfdpJdV5y91+
	 SJAqLNcPH2RYjSkuiEQ6feuwaJXVvz1g4zFP6qurNtJGqqBggntEMsF+tJ8mfnYvYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2r7Yte1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFA606A323
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2r7Yte1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E7F1F01284;
	Tue, 27 Oct 2026 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136192;
	bh=KwtfS7ttern4Y9T5XDagaM0xwHMJ8q3ZdgBfQgSUY5E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D2r7Yte12nYfGEwA6I1Kuipo4Q4XOiJD3FTyam1/10VaIa25E2WW96VEZIgE/cis8
	 xokgOJYLPYle0xTlkC5obTzHa8dZZfTa59cBRTeK5qjmIHCDS8OiAeKLzpZI1SRrra
	 Ytlo+Ble0ofujy9g4h5E1mADsUISRvwH8AsF/QX5tkPPUTkkTOo8DKJ6nqmvgQF+mG
	 Qb0fQpVA/PqCEh50/deNndEqMe90fkugkHu30BWiuArsire3l+qpQdFK/D0VcCmHMm
	 kBgQyllukLbZ3QcT0SJx/Q2swlXqxICFKo+iwHd1DjRn1llFvecrBg6TJSlhe9YmSl
	 F3U5jDn80rbVw==
Subject: Re: [PATCH mptcp-next v10 5/6] selftests: mptcp: pm_nl_ctl: support
 the subflow-retries limit
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 27 Oct 2026 21:23:11 +0000
Message-ID: <179313619181.3132.18061699774792669925@kernel.org>
In-Reply-To: <20261026063657.2955783-6-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-6-anilkaushikwireless@gmail.com>
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

- [Low] Coverage gap in pm_netlink.sh, from commit "selftests: mptcp:
  pm_nl_ctl: support the subflow-retries limit".
- [Low] The 'subflow retries above hard limit' subtest in pm_netlink.sh
  (lines 259-263) runs `pm_nl_ctl limits ${max_limits} ${max_limits} 128…

--

selftests: mptcp: pm_nl_ctl: support the subflow-retries limit

This commit lets 'pm_nl_ctl limits' take an optional third value that sets
the subflow-retries limit, and makes it print that limit when the kernel
reports it. pm_netlink.sh is extended to check the default value, that a
value above the maximum is refused, and that the limit can be set.

> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 21bfe1311f118..9a62091819626 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh

[ ... ]

> @@ -224,7 +247,28 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
>  
>  set_limits ${max_limits} ${max_limits}
>  flush_endpoint  ## to make sure it doesn't affect the limits
> -check "get_limits" "$(format_limits ${max_limits} ${max_limits})" "set limits"
> +max_limits_out="$(format_limits ${max_limits} ${max_limits} \
> +		 "${default_retries}")"
> +check "get_limits" "${max_limits_out}" "set limits"
> +
> +if [ -n "${default_retries}" ]; then
> +	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} 0
> +	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
> +		"set subflow retries"

[Severity: Low]
Would it be worth checking here that a 2-value set keeps the retries
limit?

If SET_LIMITS has no MPTCP_PM_ATTR_SUBFLOW_RETRIES attribute,
mptcp_pm_nl_set_limits_doit() keeps the current value:

net/mptcp/pm_kernel.c:mptcp_pm_nl_set_limits_doit() {
    ...
	attr = info->attrs[MPTCP_PM_ATTR_SUBFLOW_RETRIES];
	retries = nla_get_u32_default(attr, pernet->limit_subflow_retries);
    ...
}

iproute2 and mptcp_lib_pm_nl_set_limits() only send RCV_ADD_ADDRS and
SUBFLOWS. Every normal limits update therefore goes through this path.

In pm_netlink.sh, every 2-value set_limits call runs while
subflow_retries is still 127. That value is the default, the maximum and
MAX_TCP_SYNCNT. In the new block, every SET_LIMITS call passes the third
value.

Suppose SET_LIMITS without the attribute reset limit_subflow_retries to
MAX_TCP_SYNCNT. Would any of the new checks catch that?

One way to cover it: after setting 0 here, run
set_limits ${max_limits} ${max_limits} and check that subflow_retries 0
is still reported.

> +
> +	# not from the default: a refused value differs from a clamped one
> +	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} \
> +		128 2>/dev/null
> +	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
> +		"subflow retries above hard limit"

[Severity: Low]
Could this subtest also check that the pm_nl_ctl command fails?

Here stderr is thrown away and the exit status is not checked. The only
check is the get_limits call that follows, which confirms the state did
not change.

pm_nl_ctl already exits non-zero when it gets a netlink error ACK.
nl_error() reports the error, and do_nl_req() then does:

	if (err)
		error(1, 0, "bailing out due to netlink error[s]");

As written, a kernel that ignored an out-of-range SUBFLOW_RETRIES and
returned success would still pass. NLA_POLICY_MAX(NLA_U32, 127) in
mptcp_pm_set_limits_nl_policy is meant to reject that request.

The comment above the command is accurate for what it tests: starting
from 0 does tell a refused value apart from a clamped one. The existing
'rcv addrs above hard limit' and 'subflows above hard limit' subtests
also check only the state.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026063657.2955783-1-anilkaushikwireless%40gmail.com
