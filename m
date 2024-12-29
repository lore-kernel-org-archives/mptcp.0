Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C823BE
	for <mptcp@lists.linux.dev>; Sun, 29 Dec 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735431737; cv=none; b=Ludgx7TlVCDrZ1xGw8VlaCXyzW0Rgz8qZ1LItSVGlFnvSN+vlbNbmGdMvNHaypvgSScp6y1vTX3d8fxw9rnseI1c3cgMqcHwLOtxcj6miTeRsL02LuFWMp6HC9ZLEZKCKhVIem0TK5opH61OrsLa1ACctwjBN4U+jxBUivGV+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735431737; c=relaxed/simple;
	bh=8X1AAE7GWyvq3hb3NTy4FaXjiIGzu1m8m4KwxZhW/zE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPfxDDokYvywyQG+wr67z9tn30vhIUahPy1PtNDCf1DQbqJ8Ki6psgQwtE712zNmW8JoZ6WaQRaJZ0ejlNirjxtgPv9CG7YfQTyO2Yi866D8NF44RC8YCH6f3nk9LJPrdGnYMQt4+GXPKjNbEYy4qztXlQ/l21503isK9bJaRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6pxPNj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6pxPNj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CCFC4CECD;
	Sun, 29 Dec 2024 00:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735431737;
	bh=8X1AAE7GWyvq3hb3NTy4FaXjiIGzu1m8m4KwxZhW/zE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Y6pxPNj5JwbCKAVWsVNtfoLk1jS3u69IQKikhd2JsHSgEhUUgcYiaHNJ15FlntQEy
	 Rh6VUyBLfikNqilWBuY/D+/GbfrgqUZhEmnwweR0KbKK6158ndBq97G569mvvGTf1/
	 tzNfgfQTj1ywBw7rv/HuJnWJ6MNAVbeiLgVdsRQnHkxq+spWjPj+mijMnhR/N7rv6A
	 +ybkqewlZ+p9ymcvCibv33rLUsvvs0z9lnMsQnUgxc2tv5OwudWghMUuAfItHfAp0+
	 1aSYHe82symu3iHY1aO3L8qaPVxz1YCR3o075G5pZyt1LgltV0KE+fzxbgwlRAxQ7O
	 VCpwRsOzBszDg==
Message-ID: <43d8893a8e925cf281fb1aa92c8594dba3272bfe.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 29 Dec 2024 08:22:13 +0800
In-Reply-To: <bb281101-ad9c-4710-ae8e-eab3abd6819b@kernel.org>
References: 
	<ef87c8dd40c8dac4b946bf77e272d01ca64cc9dd.1734941967.git.tanggeliang@kylinos.cn>
	 <bb281101-ad9c-4710-ae8e-eab3abd6819b@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-12-28 at 17:16 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/12/2024 09:24, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
> > is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
> > directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
> > if it's NULL.
> > 
> > So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
> > mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
> > mptcp_pm_nl_subflow_create_doit(),
> > mptcp_pm_nl_subflow_destroy_doit()
> > and mptcp_userspace_pm_get_sock().
> > 
> > 'Suggested-by: Jakub Kicinski <kuba@kernel.org>'
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > v5:
> >  - drop 'struct nlattr *' variables as Matt suggested (thanks)
> 
> Thank you for the v5!
> 
> > v4:
> >  - use GENL_REQ_ATTR_CHECK in more functions as Matt suggested
> > (thanks)
> > 
> > v3:
> >  - use GENL_REQ_ATTR_CHECK in mptcp_userspace_pm_get_sock only
> >  - drop GENL_SET_ERR_MSG as Matt suggested (thanks)
> > 
> > v2:
> >  - use GENL_REQ_ATTR_CHECK in get_addr(), dump_addr() and
> > set_flags()
> >    too.
> > ---
> >  net/mptcp/pm_userspace.c | 69 ++++++++++++++++++++----------------
> > ----
> >  1 file changed, 35 insertions(+), 34 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 740a10d669f8..42dda8877372 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -175,17 +175,17 @@ bool mptcp_userspace_pm_is_backup(struct
> > mptcp_sock *msk,
> >  
> >  static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct
> > genl_info *info)
> >  {
> > -	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> >  	struct mptcp_sock *msk;
> >  
> > -	if (!token) {
> > -		GENL_SET_ERR_MSG(info, "missing required token");
> > +	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
> >  		return NULL;
> > -	}
> >  
> > -	msk = mptcp_token_get_sock(genl_info_net(info),
> > nla_get_u32(token));
> > +	msk = mptcp_token_get_sock(genl_info_net(info),
> > +				   nla_get_u32(info-
> > >attrs[MPTCP_PM_ATTR_TOKEN]));
> >  	if (!msk) {
> > -		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid
> > token");
> > +		NL_SET_ERR_MSG_ATTR(info->extack,
> > +				    info-
> > >attrs[MPTCP_PM_ATTR_TOKEN],
> > +				    "invalid token");
> 
> Arf, sorry, I didn't notice the 'struct nlattr *' variables were used
> in
> multiple places: I guess I only looked at mptcp_pm_nl_remove_doit()
> where in the v4, we had:
> 
>  	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
>  	id_val = nla_get_u8(id);
> 
> ... and 'id' was only used there. But maybe that's not normal to use
> 'id' only once: probably because we used GENL_SET_ERR_MSG() instead
> of
> NL_SET_ERR_MSG_ATTR() which seems better, no?
> (same in mptcp_pm_nl_announce_doit())
> 
> I can send a quick patch for that, and place your v4 on top of it.

Thanks Matt, that's much better. Please apply v4 for me then.

-Geliang

> 
> (...)
> 
> Cheers,
> Matt

