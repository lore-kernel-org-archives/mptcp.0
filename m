Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890913C3C2
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667367; cv=none; b=NQktozo0dgLV/6t1rG0/n4cFYjhWwgfDvaHOWxUpZJf+kkiSwJMtysG4D8ECuLblJH0EoJJlPGHKJedWR9//jPXVUTlhOguX1xp7XQ0PQ8aVa3xTnty2CvInLvyvh45Te8tm6/VR+UvFxGcHY2hDoX98KHRIs8HBXElwxwPvO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667367; c=relaxed/simple;
	bh=J+6Y1eW9+OJvsd2VYwDLgv05eC4js7lmjMuWaqGhlKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcpsuM51U5uqfk5ZbxI6xfQh26eYRAlIMCPHg/sYqAoEL+d/GVFdqIdQhS0AYr7q98oWW5ix0tf+CM2a5cZ5c7C6+LAbjXhQdS5F7P41C13G8XYZgHHmilQ/cMN1k0VTQhzCioCc0p0GRmEhJamCjrQ/iCyk0xyNl7IQfN3gAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNBmmtrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNBmmtrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E0DC4CEE9;
	Tue, 11 Mar 2025 04:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741667366;
	bh=J+6Y1eW9+OJvsd2VYwDLgv05eC4js7lmjMuWaqGhlKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HNBmmtrSeRzGze5D0rV96nc1d7FUBs8x+PNXvDAkDFIz9RzLNwBUm8UI+5ggXyXCF
	 N/QJk4iNt+cVWoOf8i1LeSJZv8BrpRJ1mFBpMCtVoIgWUbeI8+PAg9xF9lZYswrcx0
	 cCazv6myrD8EYHxsO/clB8nUPYexLjZnQDvGLkE63im0aRgXEcHS0MI80FDuZupDu/
	 iQHXe/3XLO39aBFx0G9KWsLERI6frZD6lwil8iuGmHfCC/gbmlMD80+ei2S/MKXXIQ
	 AeUiV2uKJ9VWG5gAH+J04eoihhkGupl6SjwWaOrxvrr7x4T7GG6YExolC4nABz2TOD
	 ouBwqGlKfFIuw==
Message-ID: <3e249c4d4a92a174722bb57887cee1fc07ef667d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v10 09/12] mptcp: sysctl: map path_manager to
 pm_type
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 11 Mar 2025 12:29:23 +0800
In-Reply-To: <d3133a7a-110d-49a7-93eb-b49c49c765bc@kernel.org>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
	 <a38a4f3b6cc2ac7082401a22bc33eb0d844f0b37.1741258415.git.tanggeliang@kylinos.cn>
	 <d3133a7a-110d-49a7-93eb-b49c49c765bc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-03-11 at 00:19 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/03/2025 12:01, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch maps the newly added path manager sysctl "path_manager"
> > to the old one "pm_type".
> > 
> > 	path_manager   pm_type
> > 
> > 	"kernel"    -> MPTCP_PM_TYPE_KERNEL
> > 	"userspace" -> MPTCP_PM_TYPE_USERSPACE
> > 	others      -> __MPTCP_PM_TYPE_NR
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/ctrl.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > index 1f405be6bc00..6a35e6bb0a63 100644
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
> > @@ -200,6 +200,9 @@ static int mptcp_set_path_manager(char
> > *path_manager, const char *name)
> >  static int proc_path_manager(const struct ctl_table *ctl, int
> > write,
> >  			     void *buffer, size_t *lenp, loff_t
> > *ppos)
> >  {
> > +	struct mptcp_pernet *pernet = container_of(ctl->data,
> > +						   struct
> > mptcp_pernet,
> > +						   path_manager);
> >  	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
> >  	char pm_name[MPTCP_PM_NAME_MAX];
> >  	const struct ctl_table tbl = {
> > @@ -211,8 +214,16 @@ static int proc_path_manager(const struct
> > ctl_table *ctl, int write,
> >  	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
> >  
> >  	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
> > -	if (write && ret == 0)
> > +	if (write && ret == 0) {
> > +		u8 pm_type = __MPTCP_PM_TYPE_NR;
> > +
> > +		if (strncmp(pm_name, "kernel", MPTCP_PM_NAME_MAX)
> > == 0)
> > +			pm_type = MPTCP_PM_TYPE_KERNEL;
> > +		else if (strncmp(pm_name, "userspace",
> > MPTCP_PM_NAME_MAX) == 0)
> > +			pm_type = MPTCP_PM_TYPE_USERSPACE;
> > +		pernet->pm_type = pm_type;
> 
> This should be done after mptcp_set_path_manager(), and if there were
> no
> errors (ret == 0), because if the name is not valid, the path-manager
> will not be modified, so pm_type should not be modified as well.

Good catch! Done in v11.

> 
> BTW, did you check that setting "pm_type = __MPTCP_PM_TYPE_NR" is OK?
> Can we display 2, but not allow to set 2 for pm_type here? In other
> words, please check that this is OK with your modifications:
> 
>   # sysctl net.mptcp.pm_type=2
>   sysctl: setting key "net.mptcp.pm_type": Invalid argument
>   # sysctl -q net.mptcp.path_manager = "$BPF_PM"
>   # sysctl -n net.mptcp.pm_type
>   2

I did check this and it matches the expectation.

Thanks,
-Geliang

> 
> >  		ret = mptcp_set_path_manager(*path_manager,
> > pm_name);
> > +	}
> >  
> >  	return ret;
> >  }
> Cheers,
> Matt

