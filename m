Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431979;
	b=vbeauJ5EY3J6q8B/JEutz0gilpy9AtkpezHVwwigyVuHOkOl3ZklSk63voUDi3MmZus9
	 oeKIzf+XaJZXtiLgyNFPDHNfVlMGLwMGH+4F+OlDi9ls6IsM6LCX8cOdK8VzB3qKbEfd7
	 ZdN/KLVFlF/g7Z7UvRI/IbFncs998Pb4QvpinztwN/pEzYlbqC6vu3lMC9mYB7m53etd/
	 VwszYlaKsdcUsiCy+sYPAaVoJJC5IeWZHwpKATw51+IdQSHG7rA1a8Xl2EvfUaGYsJr6L
	 OZbhMigtg4nFo2mCaWAT8rvITXMlSiuZW0lsPVpUdUW5AduVnv1eLen6Ezrad0A7BKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431979;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ynEN3XNdSzF/ZsCnx96KBbXt8LkZcfEUwdrePqAMK80=;
	b=xmPg/wMp0sr8iYQTnRaF9D/2qG+dmq7PnnVAf4vAjX3w8ZY5ySW+mCDrcwMXUK3xJAsO
	 3PTuBSMTqs3+hI2KtypO5xnLrIwsn4lSTxhs3dth/fZLb1xcdoNLHKg1JABwaDLSsmQuN
	 J++q9AnJQYA/HfAR0O0mriiY0J9ki3E+vHi+WK/4z88SuAzfz7q4KaRiqO6MnLjrYBwyx
	 jxlr4IuVkiWY8frb2hQ34IYyAVk/ruT25tM3avrn8P2+28qb4oy4T+yt1eCmyprQ+vb8C
	 585buHPq4p5HNJoC0oyJbncMW0KKjYFRvEhsLlCkW5YoE/s1Cw4ioqKHjm3EhBDq77Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL+TKJmX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFC606A329
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL+TKJmX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1812F1F000C5;
	Mon, 19 Oct 2026 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431978;
	bh=ynEN3XNdSzF/ZsCnx96KBbXt8LkZcfEUwdrePqAMK80=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gL+TKJmXPwtcawX2Ri5Q1vjW//0RaHiFloURcHGH9r8HrT8W0U1h+Lp2zR5nV7jhk
	 S5azHIdIW7dBfXnmkrgA6T6Z9vVo7x+b2jUg6wwPJnwYW1ZzmaMugqiQCsKi6xCS0l
	 r5cph3dYXvvH4ecAYzKJzEZuPhkDw54ECHt7iwkboC5y8C9y5vazqwDnVA44gQcwjS
	 60k/aeI49wgaB6ERMVIYhzhNsRVPzZB8IrqyA4MoLJqsOunJTHIHNkxshUo5CY/lQE
	 4GIkA9eZTa0pCkRmWLHcR0PtUl+XOFXTTfuMa1cUtZ9ybjiy5v22V/IUdcsFom/Tp3
	 KnzGtAr3kazrw==
Subject: Re: [PATCH mptcp-next v6 2/6] netlink: specs: mptcp: add the
 subflow-retries attribute
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 19 Oct 2026 17:46:17 +0000
Message-ID: <179243197759.3133.3716885953083097764@kernel.org>
In-Reply-To: <20261018041748.1655711-3-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-3-anilkaushikwireless@gmail.com>
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

- [Low] The concern: commit "netlink: specs: mptcp: add the subflow-
  retries attribute" adds MPTCP_PM_ATTR_SUBFLOW_RETRIES to the uAPI…

--

netlink: specs: mptcp: add the subflow-retries attribute

This commit adds the subflow-retries attribute to the MPTCP PM netlink
spec for the set-limits and get-limits commands. ynl-regen regenerates the
uapi header and the generated policy files. The new policy limits the value
to 127 (MAX_TCP_SYNCNT).

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
With only this commit applied, does the kernel accept
MPTCP_PM_ATTR_SUBFLOW_RETRIES and then silently drop it?

The policy checks the value (max 127). But mptcp_pm_nl_set_limits_doit()
in net/mptcp/pm_kernel.c still parses only MPTCP_PM_ATTR_RCV_ADD_ADDRS and
MPTCP_PM_ATTR_SUBFLOWS. A set-limits request that carries the new attribute
returns success and the value is not stored.

The same applies to mptcp_pm_nl_get_limits_doit(): it does not put the
attribute in its reply, although the spec lists it in the get-limits reply.

The next commit in this series, "mptcp: pm: in-kernel: add the
subflow-retries limit", fixes this. In that commit, set-limits does:

	attr = info->attrs[MPTCP_PM_ATTR_SUBFLOW_RETRIES];
	retries = nla_get_u32_default(attr, pernet->limit_subflow_retries);

and get-limits does:

	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
			READ_ONCE(pernet->limit_subflow_retries)))

So this only affects a kernel built at exactly this commit, for example
while bisecting. Would it be better to fold the spec change into that
commit? Or is the usual netdev split, with the ynl-regen patch landing
before its user, acceptable here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018041748.1655711-1-anilkaushikwireless%40gmail.com
