Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EF1BC066
	for <mptcp@lists.linux.dev>; Fri, 20 Dec 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688249; cv=none; b=o8h6JHrCW0ucdKMhwdePFBAlnfDxaTzKEVoAiY6ttmyUbmDYs+G6Gr8bLskIt21E4v0+Q/r7wflnLkqy0/6CribkuXfgjt9Uh4fG1TARv6bto52rzeZL1/UdZuj8uQLZ8C9PZV9VR2ZbmX71TiczzsUMufBJ5pvj+RHMumcqDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688249; c=relaxed/simple;
	bh=s5JhzHdjZT9bz6zpqLQl/iRCHZwSnPfUKqtQFjL0tb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5HFrUWX92Ca3RzjysLwtkGEEQ8Tjru9aOc6IQXxDLNeXO3+t06mkX95HZ2sYAXNR80buX4EIYBJOQZPJj79/N17gg6irEqUUKzhztjMGgoHXKpqbaCNzZZN45ovNX/MOxjQK7yyw8MZZPYPH7jwL3ltJhCzp739g77WMK4kYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMb2+gGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMb2+gGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8EEC4CECD;
	Fri, 20 Dec 2024 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688249;
	bh=s5JhzHdjZT9bz6zpqLQl/iRCHZwSnPfUKqtQFjL0tb4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gMb2+gGh422qqH/xkYuLY9hZ0KgmxY8WAJKa13I9PwSxRm+TXRCm1Dgx3jmNZsBQ9
	 3KoU8K7wifOcgggpFQ5SpEK73VN79ldBvg3z2zOTfhOd4zdBp86BMXPfZrdGxuAIOw
	 EFNHfm+qjWn/IdLxdR6wmGB3d05M4a52v6yEwpmsv+HZXyKGIzGrw+ZSzfuOUrLfj2
	 La8F99nqm2MsIwfl14kMMGsT3mCKQRt1jZicWlaODfcjsC+yoLyXm/z0lFFUp4rVk8
	 dGAIjgvB8ebxbXSWFxUxBP1nD7QSvz87/qW00SOI9LL+kCfHvrv3f4KlTSeF0Fjd9p
	 jyks2mnEcc9zA==
Message-ID: <f10fd4d16e3fe406dbac0c8dc17d37c5ab2431b6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3] mptcp: use GENL_REQ_ATTR_CHECK for token
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 20 Dec 2024 17:50:44 +0800
In-Reply-To: <93b46bed-cc91-46bc-9cc3-fff79cb3dac9@kernel.org>
References: 
	<d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn>
	 <93b46bed-cc91-46bc-9cc3-fff79cb3dac9@kernel.org>
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

Hi Matt,

On Mon, 2024-12-16 at 12:24 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 16/12/2024 09:31, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > A more general way to check if MPTCP_PM_ATTR_TOKEN exists in 'info'
> > is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN) instead of
> > directly reading info->attrs[MPTCP_PM_ATTR_TOKEN] and then checking
> > if it's NULL.
> > 
> > So this patch uses GENL_REQ_ATTR_CHECK() for 'token' in 'info' in
> > mptcp_userspace_pm_get_sock().
> > 
> > 'Suggested-by: Jakub Kicinski <kuba@kernel.org>'
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > v3:
> >  - use GENL_REQ_ATTR_CHECK in mptcp_userspace_pm_get_sock only
> >  - drop GENL_SET_ERR_MSG as Matt suggested (thanks)
> 
> Thank you for the v3. While at it, do you want to do a similar change
> everywhere we do:
> 
>   struct nlattr *X = info->attrs[MPTCP_PM_ATTR_Y]:
>   if (!X) {
>       GENL_SET_ERR_MSG(info, "missing ...");
>       return Z;
>   }
> 
> e.g. in mptcp_pm_nl_announce_doit() (addr), mptcp_pm_nl_remove_doit()
> (id), mptcp_pm_nl_subflow_create_doit() (raddr, laddr),
> mptcp_pm_nl_subflow_destroy_doit() (raddr, laddr).
> (and maybe mptcp_pm_parse_pm_addr_attr(), but it needs more changes
> around to pass the attribute ID, probably best not to change that)

Thanks for this suggestion, I updated this in v4.

> 
> Also, do you know if 'pm_nl_ctl' will continue to indicate a helpful
> message if such attribute is missing (that's a message more for

'pm_nl_ctl' can't display nl error msg, this is a bug in nl_error():

 $ sudo ip mptcp endpoint del id 100
 Error: address not found.
 $ sudo ./pm_nl_ctl del 100
 netlink error -22 (Invalid argument)
 ./pm_nl_ctl: bailing out due to netlink error[s]

Look at this test, nl error msg "address not found" in
mptcp_pm_nl_del_addr_doit() can be displayed in 'ip mptcp', but not in
'pm_nl_ctl'. I'll try to fix it.

> userspace app dev)? Or does it need to be modified to display the
> missing argument set by GENL_REQ_ATTR_CHECK()?

I think no need to modify this, since after GENL_REQ_ATTR_CHECK(), we
will also call NL_SET_ERR_MSG_ATTR/GENL_SET_ERR_MSG to set nl error msg
in the error paths.

Thanks,
-Geliang

> 
> Cheers,
> Matt

