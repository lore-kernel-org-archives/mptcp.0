Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51F3BFE3C
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301965; cv=none; b=oZOsG4HvhUin5r5/lNH7oJVY94R8xLhNxZMtiXkTYO5A6Dv2L9IPMvHM94Gwm9LXc4RvzaHeNqLDB+3k11ZtWCOWJmc930z/CJPc7TINh7+cn99tNkxntSsv86TLkTL0kvLhciBELnOgcWu4rfgJ6qXNDlXeX8YhoMVx14g96lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301965; c=relaxed/simple;
	bh=/ZdBJglgkNRx1Z4tCWayIHw4JmlQiqgA3GS52MMHXQ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LT7s7rL7GOZl6f7NExCRuRwJGj9AIKIXvOohKQ/avfMBBWpeorI7XakV0+JGLSoF0OGuL6hduyKLMPq/Zl/Ukv7TbvGueBOI3q9RmU5on54iCDM8nKnptnUXTfU468wnbuFQqR6f0I34MHL81BRe4ZpsfydI8uREuT0GwB3eWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSleCVaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSleCVaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277A61F000C5;
	Sun, 18 Oct 2026 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792301964;
	bh=RCXh5gXivv8e6JFUH5t91ZQkzh2aB5eaRdgbHXMlWLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DSleCVaqV+cyVIkYX0N/c5ZN7lQesAK4VjoChSBPBi2ftZF72M5Q0AYL1+iXeUay4
	 PPDmPyHq7XmsY5mvj0oLCj3wPAMlmu1tD9ex1vMVByWwgZk4duwIk0QAPabgmlwVAk
	 BELaBpqmqxLH35H/3xmw00yjcS3lhRwPgnR4i3w0CtXmH3Wx8xmD7C912YmYqRlq10
	 b9M9gPHtHMzZmg6O27ArbPxTmM+GJIylboQHkBV0GsM0SXzQo6NfDHm6Y4ga3dxUah
	 Tuze1ACRqOsLIQV9KWeJf/jNkQZshebxYRd6qOpuTyhZTSEn1BswvyS1B2q+RX6DVC
	 VqviHhYDpbTmg==
Subject: Re: [PATCH mptcp-next v5 4/7] mptcp: pm: in-kernel: add the
 subflow-retries limit
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 18 Oct 2026 05:39:23 +0000
Message-ID: <179230196371.3133.8705467098989676424@kernel.org>
In-Reply-To: <20261016160926.1155262-5-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-5-anilkaushikwireless@gmail.com>
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

- [Low] The new MPTCP_PM_ATTR_SUBFLOW_RETRIES netlink attribute is
  validated only by open-coded C, and its range is not declared in the…

--

mptcp: pm: in-kernel: add the subflow-retries limit

This adds a new in-kernel PM limit, subflow-retries, which is set and read
with the other limits through MPTCP_PM_CMD_SET_LIMITS and
MPTCP_PM_CMD_GET_LIMITS. It is the number of SYN retransmissions for a
subflow re-created after an error. The default is 15 and the maximum is
MAX_TCP_SYNCNT. The value is also exposed in struct mptcp_info, replacing
the reserved field.

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index b662eb914958c..f4e23deda1403 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

[ ... ]

> @@ -1435,8 +1444,15 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (ret)
>  		goto unlock;
>  
> +	retries = pernet->limit_subflow_retries;
> +	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOW_RETRIES, &retries,
> +			  MAX_TCP_SYNCNT);
> +	if (ret)
> +		goto unlock;

[Severity: Low]
Could this range be declared in the netlink policy, instead of being
checked only here?

In mptcp_pm_nl_set_limits_doit(), this parse_limit() call is the only
place that enforces the 0..127 (MAX_TCP_SYNCNT) range. The spec entry
added earlier in the series, in Documentation/netlink/specs/mptcp_pm.yaml,
is a plain u32 with no max check:

        name: subflow-retries
        type: u32
        doc: |
          SYN retransmissions of a subflow re-created after an error, 0 to
          not re-create it.

So the generated mptcp_pm_set_limits_nl_policy in net/mptcp/mptcp_pm_gen.c
becomes:

	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = { .type = NLA_U32, },

Policy introspection (genl ctrl getpolicy) and spec-driven clients such
as YNL would then report the full u32 range as valid. The kernel still
returns -EINVAL for any value above 127.

Would adding "checks: max: 127" to the spec entry help here? It would
generate NLA_POLICY_MAX(NLA_U32, 127), so the spec, the policy dump and
the kernel would all agree. The netlink guidelines prefer a declared
NLA_POLICY_* over open-coded validation.

The existing subflows and rcv-add-addrs limits have the same gap. This
attribute is new, though, and its maximum is different from theirs
(MAX_TCP_SYNCNT vs MPTCP_PM_SUBFLOWS_MAX).

The spec doc also doesn't give the maximum or the default of 15. Could
those be added too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016160926.1155262-1-anilkaushikwireless%40gmail.com
