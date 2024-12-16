Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515F19066D
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334998; cv=none; b=l5kxPbwxfAS3DlZkBzAp1W72qhViiC7N+XKYOeS0F8EpJkzKmg5ossRhvjK0MbwOifskkucB4sVlT+B8qC8bPjNuOfDmY2QkQAD3s2NypiHYliY+zPEVexXtjcskUN2/IgoyLg8ZQ4qYo1WypYxh5+SMlzonRFELu7lkK47IMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334998; c=relaxed/simple;
	bh=Hv7X1TwWKY2lSpMxFRRgDEe6YXfOTcxkbS6eykj9rWo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qzI424VsJ7qL3NY/Nx0td3rCVslnuyNjrzkR9FSuHz2UDNMZ+W2ABxlurh0Emt5qFAC4hIYGz+Ck4XEQnHA2ff+WY/I3iIz0EYHt6jFd/4DnLnAe4HRx4WRL4gy+7+qXpB1SJS8Zdmx9rFHk9xJnC+5GizAgOu4TrceX0xzddsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k747HCjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k747HCjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AD0C4CED0;
	Mon, 16 Dec 2024 07:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734334996;
	bh=Hv7X1TwWKY2lSpMxFRRgDEe6YXfOTcxkbS6eykj9rWo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k747HCjyF2n2Hg+5NldPRidhoEC8lwjCMlePPdv3x8OgewNqz4LT8b/t8IoKLPV2G
	 Xu+55Lj8Is5rizScued1x/s8sEMmnm+wRsNrQFodYk36RudTe9LXyVMFWD8KgDJy7p
	 cjaR/U3FCB6eSPVwM/6K83X50VmftjrnAXuTa8CG4tH7PFeM1DTsREb9pcfc18HHLb
	 fRQanEJz4xDbEp7b0WoXeCJsHOVsIZ3pWAv1QfOOqqc3jy27XfjuKxOrAZ1cfqx+Wz
	 8xgk0OPe4NqBt3sqz4JgQHwzUpp/3LV2Draf32yIDLhiGAnyECemRmtCrXTk/hBLJd
	 6gyyAf5vuhgEQ==
Date: Mon, 16 Dec 2024 08:43:13 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Message-ID: <3645a211-995b-4e5a-828c-f9a0f6d730f5@kernel.org>
In-Reply-To: <a5dc0d188ebb30b3d541178a821b08f1124246ba.1734330271.git.tanggeliang@kylinos.cn>
References: <a5dc0d188ebb30b3d541178a821b08f1124246ba.1734330271.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2] mptcp: use GENL_REQ_ATTR_CHECK for token
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3645a211-995b-4e5a-828c-f9a0f6d730f5@kernel.org>

Hi Geliang,

Thank you for this patch.

16 Dec 2024 07:25:43 Geliang Tang <geliang@kernel.org>:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> A more general way to check if MPTCP_PM_ATTR_TOKEN exists in 'info'
> is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN) instead of
> directly reading info->attrs[MPTCP_PM_ATTR_TOKEN] and then checking
> if it's NULL.
>
> So this patch uses GENL_REQ_ATTR_CHECK() for 'token' in 'info' in
> mptcp_pm_get_addr(), mptcp_pm_dump_addr(), mptcp_pm_set_flags() and
> mptcp_userspace_pm_get_sock().
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
> - use GENL_REQ_ATTR_CHECK in get_addr(), dump_addr() and set_flags()
> =C2=A0=C2=A0 too.
> ---
> net/mptcp/pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 18 +++++++++---------
> net/mptcp/pm_userspace.c |=C2=A0 5 +++--
> 2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 16c336c51940..7c8525ff4107 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -435,25 +435,25 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, str=
uct sock_common *skc)
>
> int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
> {
> -=C2=A0=C2=A0 if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_userspace_pm_get_addr(=
skb, info);
> -=C2=A0=C2=A0 return mptcp_pm_nl_get_addr(skb, info);
> +=C2=A0=C2=A0 if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))

If I'm not mistaken, this will set an error if the attribute is not defined=
.

We should not use it here not to set errors when it is normal not to
set the token.

Same below.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_pm_nl_get_addr(skb, in=
fo);
> +=C2=A0=C2=A0 return mptcp_userspace_pm_get_addr(skb, info);
> }
>
> int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
> {
> =C2=A0=C2=A0=C2=A0 const struct genl_info *info =3D genl_info_dump(cb);
>
> -=C2=A0=C2=A0 if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_userspace_pm_dump_addr=
(msg, cb);
> -=C2=A0=C2=A0 return mptcp_pm_nl_dump_addr(msg, cb);
> +=C2=A0=C2=A0 if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_pm_nl_dump_addr(msg, c=
b);
> +=C2=A0=C2=A0 return mptcp_userspace_pm_dump_addr(msg, cb);
> }
>
> int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
> {
> -=C2=A0=C2=A0 if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_userspace_pm_set_flags=
(skb, info);
> -=C2=A0=C2=A0 return mptcp_pm_nl_set_flags(skb, info);
> +=C2=A0=C2=A0 if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_pm_nl_set_flags(skb, i=
nfo);
> +=C2=A0=C2=A0 return mptcp_userspace_pm_set_flags(skb, info);
> }
>
> void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock=
 *ssk)
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 740a10d669f8..cc2b7c50d4d6 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -175,14 +175,15 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock=
 *msk,
>
> static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_i=
nfo *info)
> {
> -=C2=A0=C2=A0 struct nlattr *token =3D info->attrs[MPTCP_PM_ATTR_TOKEN];
> =C2=A0=C2=A0=C2=A0 struct mptcp_sock *msk;
> +=C2=A0=C2=A0 struct nlattr *token;
>
> -=C2=A0=C2=A0 if (!token) {
> +=C2=A0=C2=A0 if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENL_SET_ERR_MSG(info, "missin=
g required token");

It is no longer needed to set the error message if the missing argument
has been already set.

Cheers,
Matt

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> =C2=A0=C2=A0=C2=A0 }
>
> +=C2=A0=C2=A0 token =3D info->attrs[MPTCP_PM_ATTR_TOKEN];
> =C2=A0=C2=A0=C2=A0 msk =3D mptcp_token_get_sock(genl_info_net(info), nla_=
get_u32(token));
> =C2=A0=C2=A0=C2=A0 if (!msk) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NL_SET_ERR_MSG_ATTR(info->exta=
ck, token, "invalid token");
> --
> 2.45.2

