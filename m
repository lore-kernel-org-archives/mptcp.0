Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822279;
	b=lvqmrCZhBcgEo+pqynwBf5TXY1XBVBVFGd4tJShTUVi2Ip44N/JcD1FxmJuS0B/DiQ/J
	 RPagSy7FQuTrgZzCm41jY5lauFC6gaaccMptBDpNC4hdHylyX94KkvUtgDtbcPug42RIC
	 udT60HNkxpatoQnEbBtWOi4Puhh+ZUSI/MNcCp/HF2LQWC7+J9N2YJNCpUAfrfp49/X0a
	 0amr8kjz7GzmcC9bELVA0YiN2sa1ONmTKuFA94J841tYEun0w60pOYQsq9+O8kB5k/5xX
	 isb/JztxMHWQt8nkm1d+K+/MNEgxCwfYAzxhDJ3eF8Qlh91CmMiqa2dcaCtFvzmaNHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822279;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/HU52o4sZoJReYDKmkWLn+RiZDrK6u0rFyBE4SLdMow=;
	b=tAKavxp1+IArm4qmCUmnD2m9tiCNzQLZC75CrTCt/RkcyVUA4X5bGlJOqcqjLF5UB9sp
	 b86uC+utel9A5BtEIe2ZCBrKMxmVII6IGWF6EdZDknT+c08IHdZYPIOTjzk//1vtW7cbr
	 26A4ybzOcd1EovP8s/G5aD+gBqIDvJ2rBs5TXA4QHpNc18Y7R8TDEDU7acsmEqNSQVnCS
	 0NvpqU6NeVQZ2JqM1KzP+pYZRyWp8Cv9RmyK/MVr4fyzfZTQqOkppw2FapY4hVKKN1XOx
	 zszb3wKKg3Xh40qhhx03li6QAeuaOA3A4hB8W6IYld1EzlI0iVuswKX6gUmV+9SFrxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wg9oFbCO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE083606A31A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wg9oFbCO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4451F01825;
	Sat, 24 Oct 2026 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792822278;
	bh=/HU52o4sZoJReYDKmkWLn+RiZDrK6u0rFyBE4SLdMow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wg9oFbCOuPngc2anHFewpgoqRtAWAwU8QvsyTCjIQfqLz6HcFqDJt+heo0rfXgbdk
	 N4lthpJxahHVTDl0oCzZB6Oe/W4QC+Fu5k5FnVSEYCtqQGQeH+NLZ7f00XD7SKCEdB
	 +INEyJifb4BB9QaFHjzEAcRPVUZvPqM7RONcS3w8DnTsd9h9WKykHgzY73N5FQbC/5
	 pLx0Q7eNix797yhvQTaROZZ87cn6Mku2fhr7XAoXbXJTOXH1ZaN9QKPP9ELw4WCC9y
	 KNnc7pdEBynGFzUtLUJi0kFSdN/4lufZL6QUQ8MYoG3XqQDXokB/8uOC6bUasrh7Z5
	 oIUmzAvTEk8CQ==
Subject: Re: [PATCH mptcp-next v8 2/6] netlink: specs: mptcp: add the
 subflow-retries attribute
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 24 Oct 2026 06:11:17 +0000
Message-ID: <179282227793.3132.6836095031824377951@kernel.org>
In-Reply-To: <20261022151130.2285198-3-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-3-anilkaushikwireless@gmail.com>
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

- [Low] Concern as raised: the commit "netlink: specs: mptcp: add the
  subflow-retries attribute" adds MPTCP_PM_ATTR_SUBFLOW_RETRIES to the…

--

netlink: specs: mptcp: add the subflow-retries attribute

This commit adds the MPTCP_PM_ATTR_SUBFLOW_RETRIES attribute to the
mptcp_pm netlink spec and the uapi header. It also adds the attribute to
the set-limits and get-limits policies, with a maximum of 127. The
in-kernel PM is meant to use it for the SYN retries of subflows that are
re-created after an error.

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
At this commit, nothing in net/mptcp/pm_kernel.c handles the new
attribute yet:

- mptcp_pm_nl_set_limits_doit() never reads
  MPTCP_PM_ATTR_SUBFLOW_RETRIES.
- mptcp_pm_nl_get_limits_doit() does not put it in the reply.

The spec still lists the attribute in the get-limits reply and gives
127 as the default.

Is that acceptable for a kernel built from this commit alone, for
example when a bisect stops here?

This is mostly a note, because the rest of the series appears to cover
it. The next commit, "mptcp: pm: in-kernel: add the subflow-retries
limit", adds the parsing, the storage, the reply and the default of 127.
After that, "mptcp: pm: in-kernel: retry subflows closed after an error"
uses the value.

SET_LIMITS and GET_LIMITS also use GENL_DONT_VALIDATE_STRICT, so
genl_family_rcv_msg_attrs_parse() parses them with NL_VALIDATE_LIBERAL.
That means the attribute was already ignored, not rejected, before this
patch, so userspace sees no change in behavior at this commit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022151130.2285198-1-anilkaushikwireless%40gmail.com
