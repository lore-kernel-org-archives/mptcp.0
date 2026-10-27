Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071734;
	b=uBsGMXoruHZ9DzvuZBKt/kgn/VZDTZ72tPnCFWgQEpwQuLjAibuiZbumFeeA+y1+2PBY
	 MKVTDQmzXLOk0jcayArTL5D7GUhoLZp7dpPr425rodYOOkmeXvSbV+qJ8TogRDP71XqK5
	 l+/vpSRSYSWd6YrTh+KLo8hJwVjtZmeImo+ydZE/dCT4k56Roz4GjACF84fr0r8l7FZuU
	 IrG1swJC8d1z1byiSK6DShQRQrT5p4eZJuwQV6tndTDF6CaoXymPp5/RJI5cJaEH7BVL8
	 7GYafIV0gsb3dOAZnBOLNb8JjpuWiFfnU0K9/3WSGUHrZp0ySTlf1/KUoDrNS8R/BLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071734;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uu6113aZW7MHWiCWNl7BB8mJLrd4h0TS674ZSh635+c=;
	b=Nqqm/Xj8bDBp7uDUOL4cmT3MfKHya6qUm16NwMnlp/d/EdfjmKVHdtEdyDNIR6yoFqmU
	 PIbzA5R6ih0ngW5Y2gevw+Y9C4zqUX3eNjin4gayuEwFzGPoDtLtlzc1s+bIHXQJjJ+hV
	 0vwb8WLnzkfwUmcObPcNh6op8IuTCaxT7BiMSkFDZ8l2eVOKyKmozsmrh7jRugE85YFTR
	 qi6JvLY3S1l41NfD4akv+/kusp24x8kJUmVXKKP0u2AjrQMg+ej0gY1rYjwnf61kR0ToY
	 oy84ANDa/pFAze+1cZxXouo8biyJpQUAfoOpDDPaeRqCcPe5pQBT+pgXYsQzXRAzDDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUaP9guO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE90606A31E
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUaP9guO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAEC1F01825;
	Tue, 27 Oct 2026 03:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793071733;
	bh=uu6113aZW7MHWiCWNl7BB8mJLrd4h0TS674ZSh635+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eUaP9guOKEGU4/eICgWAopoWhLgGsntD8hqZShqM1hel1LBY+LtRmQs4h9MgY+9rr
	 BLauObCx+2euDazlwn3S/1aIiNE2Ah56iD9R4ttTW+wJFMsmVAqpVFpsq2XOazQKRk
	 6HlBc72URMaWsHX8xvCw5MpsUahjWPdiTkAGJYQsOkFuA3KxvLC5LkBPt10SYNipj6
	 uAM4sf1PgQFnP1C4GrzYctvRDM9bW6e97Bpg0AKG8tJshPgc8xWVWiT4gc1Z0G6Fdj
	 LjWXkIrEYsq9QAElVrAfZKBYi2PmmBDkES+VwEehtKrE9ngJD4WzBCyyIdNXWwqiVK
	 oyg81KFfoRN5g==
Subject: Re: [PATCH mptcp-next v9 2/6] netlink: specs: mptcp: add the
 subflow-retries attribute
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 27 Oct 2026 03:28:53 +0000
Message-ID: <179307173322.3132.3564923250694548321@kernel.org>
In-Reply-To: <20261025134909.2794368-3-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-3-anilkaushikwireless@gmail.com>
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

- [Low] At this commit, MPTCP_PM_ATTR_SUBFLOW_RETRIES has been added to
  include/uapi/linux/mptcp_pm.h and…

--

netlink: specs: mptcp: add the subflow-retries attribute

This commit adds the subflow-retries attribute to the mptcp_pm netlink
spec and the uapi header. It also adds the attribute to the set-limits
and get-limits commands, and regenerates the policies with ynl-regen.

> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index 39f3facc38e55..690d3c5dfdd21 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -196,6 +196,16 @@ attribute-sets:
>          name: addr-remote
>          type: nest
>          nested-attributes: address
> +      -
> +        name: subflow-retries
> +        type: u32
> +        checks:
> +          max: 127
> +        doc: |
> +          SYN retries of a subflow re-created after a timeout, like the
> +          TCP_SYNCNT socket option, so with tcp_syn_linear_timeouts on top.
> +          The default is the maximum, MAX_TCP_SYNCNT (127), about 4 hours
> +          with the default RTO settings. 0 to not re-create it.

[ ... ]

> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index c180930a8e0e4..e2d4af1bc1d5d 100644
> --- a/net/mptcp/mptcp_pm_gen.c
> +++ b/net/mptcp/mptcp_pm_gen.c
> @@ -44,15 +44,17 @@ const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR +
>  };
>  
>  /* MPTCP_PM_CMD_SET_LIMITS - do */
> -const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
> +const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
>  	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
> +	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
>  };

[Severity: Low]
After this change genl accepts and validates the attribute. At this commit,
though, mptcp_pm_nl_set_limits_doit() and mptcp_pm_nl_get_limits_doit() in
net/mptcp/pm_kernel.c only handle MPTCP_PM_ATTR_RCV_ADD_ADDRS and
MPTCP_PM_ATTR_SUBFLOWS.

Does that mean set-limits takes a subflow-retries value from 0 to 127,
returns success and then discards it? It also looks like the get-limits
reply leaves the attribute out, although the spec lists it as a reply
attribute.

The documented default (127) and the "0 to not re-create it" behaviour also
don't exist yet at this point in the series.

Because .maxattr is raised to MPTCP_PM_ATTR_SUBFLOW_RETRIES, a set-limits
or get-limits request with subflow-retries above 127 now fails with -ERANGE.
Before this change, attribute type 7 was above maxattr and was ignored
under GENL_DONT_VALIDATE_STRICT. Is that change intended at this commit?

Later in the series, "mptcp: pm: in-kernel: add the subflow-retries limit"
adds the missing pieces. mptcp_pm_nl_set_limits_doit() parses the
attribute:

    attr = info->attrs[MPTCP_PM_ATTR_SUBFLOW_RETRIES];
    retries = nla_get_u32_default(attr, pernet->limit_subflow_retries);

mptcp_pm_nl_get_limits_doit() emits it, and pm_nl_init_net() sets the
default to MAX_TCP_SYNCNT. Then "mptcp: pm: in-kernel: retry subflows
closed after an error" uses the value and treats 0 as "do not re-create".
So the gap is only visible when bisecting.

The commit message says the attribute "will be used by the in-kernel PM",
so the split seems deliberate. Would it be worth folding the uapi and spec
change into the implementation patch, so that no single commit exposes
the attribute without handling it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025134909.2794368-1-anilkaushikwireless%40gmail.com
