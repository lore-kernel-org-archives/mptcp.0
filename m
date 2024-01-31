Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A35221
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667329; cv=none; b=HhbhAihun15PkcvuM0hBuhz0aJTjSmTPtJIg9HzTqEvwQC5rMiltEPcKJtbsXiP7tmrDOqeqAPv4ykPvKNPsJq/kkNshGDh9udkwcD2HLioPwvHon6HQd1uffIG13x/wC669CjACUEoOvgiw3IDF4i3UKEtkew7KXskYld8wnSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667329; c=relaxed/simple;
	bh=nA0hlhdrfNkn+TtAZV1+bWlkv1r4BJ1ZlsOlB/541qY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NJjefY6TizmsxtDCs8u0iqEPDfakqjrD4MHLQ0w+TvelzJqreV+IKDP7UzfrTL9nVt4BIvhfS3i6lkAZZrKeeOIULV/N4u5o2KEoEuqpJD9Hft4sMx58NGYNwZ0l/LI2QE+aSrvpm5/iL2IVSytXb2kXyLcrWfO9RcqF/AN9vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szjni9lg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szjni9lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52404C433C7;
	Wed, 31 Jan 2024 02:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706667329;
	bh=nA0hlhdrfNkn+TtAZV1+bWlkv1r4BJ1ZlsOlB/541qY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Szjni9lgg9iY0O7qAx0a2yNVrkixXO3Fyt5BSZbRJjxXO7Oc90C6pGh7Kl2Y/ZjqY
	 9fvK2iKon74oLfAsysA3LdBa3clA3uszpOKVmrK0eno//m/vI29YkQ1Ty03Fys0p3M
	 E7A6TfjYDILnY9Y2j/mY8LO7ISjwCcJlzd5w+uuixBSWWiX1M4qz7pGIYaSLVDij9O
	 h0WnD8AOkYzM/dXJWT30FMFVcDHdLw2+pAsd7Hp1GuoUcwdUVSCWKRE7jwWlkDfNl3
	 68KQn/Jddy0tYelSGJpkyzilGXuMXN8mxS9Y+bmWz3fUWdcQG+PLe7eLAaMMDu+7mP
	 TGMvTILBl8Odw==
Date: Tue, 30 Jan 2024 18:15:28 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 01/23] mptcp: add pm_has_addr_attr_id
 helper
In-Reply-To: <9d4caf4cbb5f75d8bc057cdd2f073c243a2dcf92.1705558030.git.tanggeliang@kylinos.cn>
Message-ID: <a4e54887-1155-26af-c8e1-9f4f28ca2be7@kernel.org>
References: <cover.1705558030.git.tanggeliang@kylinos.cn> <9d4caf4cbb5f75d8bc057cdd2f073c243a2dcf92.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Jan 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds a new helper mptcp_pm_has_addr_attr_id() to check whether
> an address ID is set from PM or not. It will be used in the next two
> commits.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Hi Geliang -

In cases like this where a new helper is added (and does not replace 
existing open coded sections), I think it's better to have a single patch 
that both adds the helper and the call to it.

Please squash patches 1 & 2.

- Mat


> ---
> net/mptcp/pm.c       | 12 ++++++++++++
> net/mptcp/protocol.h |  2 ++
> 2 files changed, 14 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4ae19113b8eb..6856d10368be 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -533,6 +533,18 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
> 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> }
>
> +bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
> +			       struct genl_info *info)
> +{
> +	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> +
> +	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> +					 mptcp_pm_address_nl_policy, info->extack) &&
> +	    tb[MPTCP_PM_ADDR_ATTR_ID])
> +		return true;
> +	return false;
> +}
> +
> void mptcp_pm_data_init(struct mptcp_sock *msk)
> {
> 	spin_lock_init(&msk->pm.lock);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d442d876f465..0d634e01c47d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -887,6 +887,8 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
> int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> 			 bool require_family,
> 			 struct mptcp_pm_addr_entry *entry);
> +bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
> +			       struct genl_info *info);
> bool mptcp_pm_addr_families_match(const struct sock *sk,
> 				  const struct mptcp_addr_info *loc,
> 				  const struct mptcp_addr_info *rem);
> -- 
> 2.40.1
>
>
>
