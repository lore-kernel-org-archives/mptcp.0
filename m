Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2753ACA7C
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301967; cv=none; b=s1hwYVzV6w1hhmcIt45d+yVS2Y27z1Ho+YWLyGNrxQSorAfaOu8ASSDKzzyokOP+7GGgLgIccFLvfQboZLnaS+wf9Oh7jRrwdFCTIoOnTghA4VtqE/N/H5z+Pjqve5OVrYJEfq4tfFO32/oTSB5gxmQXEtwbn+PE5VQXT3XbjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301967; c=relaxed/simple;
	bh=Ppfv1pnBga+MQhnm4y2YFZ5CZYiZIo8ftZmM59x7jUk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1EkHnejJoI/KcBplCjo02jwUEeWMc2K5VkYFAI7J9dG77SStDswajaAUlHZI6Idtruemfp/09jnO7ncxS/bScXmAcEGlzR8k6jI4FM84fUmxCAacrlKx37Q1MPvl6gpi5JeV+y4Dv7hkEyFkF5MIoWQlTlIOJSdvcXgKDrcgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUHrGDJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUHrGDJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6811F000C4;
	Sun, 18 Oct 2026 05:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792301965;
	bh=UXqwSeILcDDO0UExNDlya+/Trw5LwuvBOwJG9Ol92eA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bUHrGDJZixxXpWryxBEGWoD3MN35MGLLKt5wxWwnU0ridPYAYtXxdvYIVp4La6HUQ
	 nkxLJLd+ZIf8Hjv8Dbgufd8opsL5HYyfL3RX472+rD44ODTp8FEC+KO04DAKAi1Wap
	 mc1PadHVfIO4CXsSA57n4WFmg0hgd+bsHBluf9UIeS2tT3an8Hkl3GnHf2N9KDdA/D
	 PF4wUwPWMurSGSorDQ14v2YvDQrIL6WH2TwRBItrOp64SXs6reN7wQ2f/uSmbGybR5
	 6q7qE9E9uR81SWz9+p9v+l+fZJavOtUmhzi+EabqI31LEVWFSBdI31t06m5AZR430i
	 V1Lv31vkx2sGA==
Subject: Re: [PATCH mptcp-next v5 6/7] selftests: mptcp: pm_nl_ctl: support
 the subflow-retries limit
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 18 Oct 2026 05:39:25 +0000
Message-ID: <179230196529.3133.6142254982525099118@kernel.org>
In-Reply-To: <20261016160926.1155262-7-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-7-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new subflow-retries subtests in
  tools/testing/selftests/net/mptcp/pm_netlink.sh test only one side of…

--

selftests: mptcp: pm_nl_ctl: support the subflow-retries limit

This commit lets 'pm_nl_ctl limits' take an optional third value that
sets the subflow-retries limit. It also prints that limit from the
GET_LIMITS reply when the kernel reports it. pm_netlink.sh gets new
subtests for the default value, for an out-of-range value being refused,
and for setting a new value.

> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 21bfe1311f118..ddf2899e4830b 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh

[ ... ]

> @@ -224,7 +247,22 @@ check "get_limits" "${default_limits}" "subflows above hard limit"
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
> +
> +	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} 0
> +	check "get_limits" "$(format_limits ${max_limits} ${max_limits} 0)" \
> +		"set subflow retries"

[Severity: Low]
This isn't a bug, but should these subtests also check that the largest
valid value is accepted?

The values sent here are 128 (refused), 0, and then the default 15 when
the limit is restored. On the kernel side, mptcp_pm_nl_set_limits_doit()
in net/mptcp/pm_kernel.c does:

	retries = pernet->limit_subflow_retries;
	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOW_RETRIES, &retries,
			  MAX_TCP_SYNCNT);

parse_limit() only refuses the value when *limit > max, so 127 should be
accepted. Nothing in the test sends 127.

If the check broke in a way that still refuses 128 and accepts 0, these
subtests would still pass. Two examples are an off-by-one (>= instead
of >), which would refuse 127, and a smaller cap such as 15.

The earlier tests for the rcv-add-addrs and subflows limits cover both
sides of the boundary: max_limits + 1 is refused, and max_limits is
accepted in "set limits".

Could a step be added that sets 127 and checks it with format_limits
before the default is restored?

A smaller point: the out-of-range request sends rcv_addr and subflows
equal to the values already in place (max_limits). That means the test
can't show that the whole request is refused together. The current
kernel stores all three values only after every parse_limit() call
succeeds, so this is a gap in the test, not a bug.

> +	ip netns exec "${ns1}" ./pm_nl_ctl limits ${max_limits} ${max_limits} \
> +		"${default_retries}"
> +fi
>
>  flush_endpoint
>  add_endpoint 10.0.1.1

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016160926.1155262-1-anilkaushikwireless%40gmail.com
