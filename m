Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655494;
	b=zOfPF6cxE40wCzZAlHUekdAzVtdqiuE8zmhSQyOp/jflEXqtN9d4pqs4hR9/d9kEKkVV
	 ++z6pAzfI+UUGeCFJR33lh57ROYohKPgjCWRJc0srwr0Fg0IemDu6WKFSpH/EMKR3f0SM
	 WBT8cIAQNLrIdufdnf7S2JQRnF+gAJ10KDTaRoHooKCa0iOGWprEHrcZ5fhYu4lGvg+rj
	 R55ZxaLIMOKoQnBZu3N5Q2leANLh36Cw81+uZQZdN9PWRibgtgJeMQufEY45K6/hBq6Rx
	 nMrbMh+ku/ClFzY9JRJtQP3m87af9dx/9HZ2seodTYWS+4yg2xDLDYs5YR/pNjpp72A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655494;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0oKfJrpQxgQXoic1EHiLkXWwSAHuzXD6gFL57+UpFMs=;
	b=a35HXGBzo7OSeauTD9DcAf7T0ajbCXXf3LeAOPzuVgSdTIot5RIR0z9hKEfPjwxPXRjT
	 VZ6JSiM2RilHxZnUvQlRwk/O3yduhB0iJbr1y1kbFvjznPNzmav5uRDjU/RrVwrSKGhuS
	 HrwK4ffPFr2hvJvPTTzHFLjv4lz/1y4Py2tLaW290Pc/RM9BTCZ3b9zo1ZD1pwdBhd8hT
	 aOQW6C4l3rrPfliDdLE09U5BCyIhbDYEOkUTb5wZSis5IkLxclKAEvQKyfaNHzdNY1/w6
	 BGbUTBNaCimGvEbbVVRZmFwpdQPb7X1CDmrpPddNnRICc+8n9PVhwRB1E2fU9g5ChBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLhOfnFw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21189606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLhOfnFw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7E71F00A16;
	Mon,  2 Nov 2026 21:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655493;
	bh=0oKfJrpQxgQXoic1EHiLkXWwSAHuzXD6gFL57+UpFMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TLhOfnFwJ8VL78k5sfxkBbBOHuAJHkbQ5KJzFIUdDRSvLN7LDlT5a+bXZ46xtR8oe
	 h+vNYEbkLqoLvd7vlqhcLnOZLKnS06VxdJblqmZ7dbIS/W4AlqvcWmMwF8svkaib32
	 QljIu593j+I/+ZjHfxeBeRftCN6qu1KCdrIEgmmkl5ojUctfBDU2nwFHHVQf0EG5ac
	 iNF1tqZCYiP6O/biwqoxVFlhUPzapIfzYqhoLA1pa0g80HdlM6p6p9qodjxSa8XD7O
	 phTVRVRB1O70Y6ctLO/BshKxYrnHfSaiaTuCSxnS9D21xf8BCJOauh+ISQ4EY9OjGB
	 fHq6JNO29Ey8g==
Subject: Re: [PATCH mptcp-next v14 2/6] netlink: specs: mptcp: add the
 subflow-retries attribute
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 02 Nov 2026 21:38:13 +0000
Message-ID: <179365549318.3128.12712517228991053551@kernel.org>
In-Reply-To: <20261101072051.3853492-3-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-3-anilkaushikwireless@gmail.com>
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

- [Low] In this commit only, the uAPI header, the YAML spec and the
  generated policies in net/mptcp/mptcp_pm_gen.c add…

--

netlink: specs: mptcp: add the subflow-retries attribute

This commit adds a new subflow-retries u32 attribute to the mptcp_pm netlink
spec. The attribute is added to the set-limits and get-limits commands, with
a policy maximum of 127. The uapi header and the generated policy files are
regenerated with ynl-regen.

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
>  
>  /* MPTCP_PM_CMD_GET_LIMITS - do */
> -const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
> +const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOW_RETRIES + 1] = {
>  	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
>  	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
> +	[MPTCP_PM_ATTR_SUBFLOW_RETRIES] = NLA_POLICY_MAX(NLA_U32, 127),
>  };

[Severity: Low]
This only matters at this one bisect point. Is it intended that the kernel
accepts MPTCP_PM_ATTR_SUBFLOW_RETRIES here before any handler uses it?

With this patch, the policy and the raised .maxattr let SET_LIMITS accept a
valid value from 0 to 127. However, net/mptcp/pm_kernel.c is not changed, so
mptcp_pm_nl_set_limits_doit() still stores only the two existing limits:

net/mptcp/pm_kernel.c:mptcp_pm_nl_set_limits_doit() {
    ...
	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
    ...
}

The request is acknowledged with success, but the subflow-retries value is
dropped.

The same goes for GET_LIMITS. The spec lists subflow-retries in the reply,
but mptcp_pm_nl_get_limits_doit() never puts it in the message:

net/mptcp/pm_kernel.c:mptcp_pm_nl_get_limits_doit() {
    ...
	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
			READ_ONCE(pernet->limit_extra_subflows)))
		goto fail;

	genlmsg_end(msg, reply);
    ...
}

As a result, the default of 127 and the meaning of 0 in the spec doc are not
implemented yet at this commit.

The next patch in the series, "mptcp: pm: in-kernel: add the
subflow-retries limit", fixes this. It adds pernet->limit_subflow_retries,
initialised to MAX_TCP_SYNCNT in pm_nl_init_net(). It parses the attribute
in set_limits with nla_get_u32_default() and sends it in get_limits with
nla_put_u32(). The mismatch therefore exists only between the two patches.

Retry behaviour does not exist yet at this commit. The ops also use
GENL_DONT_VALIDATE_STRICT, so older kernels already ignored this attribute
silently.

Would it be worth merging this patch with the next one, or mentioning the
ordering in the commit message?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101072051.3853492-1-anilkaushikwireless%40gmail.com
