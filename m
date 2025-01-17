Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068C1F76A1
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094523; cv=none; b=OQfaWv1tnzThQmi1c8XkLHT+S9U8fh/iS8GqnmtWITHqURWR7TEXKnxcGZaAUskXpPCaKpahrm4lCVTTUv1xfczZtPt6hTueUPVINbUWSazVNFxcx7kFxz7EBFQGl75UzebbK0S/DHCZX1dulJN9cATneXs4HZdyG4FXJRs+DZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094523; c=relaxed/simple;
	bh=OYsILdFszZF+dWbM30QUP26skJ2iPRKqo+DJedWMxmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ad7oLG2kVIjS2+B8crvPpPN4NK0bDueQAOtPcqsb/pB7LXU7tgfm/XcFI8ykzbcKptlzm2sNo67UkSlGm8twyNBqy/U3MSSbU6NX1veQ53vQhVJ2fLpkMNdptTqfVMhAEAnOXjiwPOnKcL6s4e2N6jTKICBkr/P2WT/Fkjj3FN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI3CN64k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI3CN64k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAB0C4CEE0;
	Fri, 17 Jan 2025 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737094521;
	bh=OYsILdFszZF+dWbM30QUP26skJ2iPRKqo+DJedWMxmg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HI3CN64keng/MFyt/BGolW1sKEwBpJjDf/CEhCHHp9jDzoyj0m/KT0D/i//oCk3fi
	 7GN+2TnKBImsNF9OAHDG8teEIUA4xB0Xg9HHvl05vk/giiQwJlW0N/C174eE99dJCW
	 WY4YN9J8W92+RFbdEm9mQLEjeV52d/LR2+NIe+nOz4jiYQ6bsyeNH/NnF/6ftY3vCM
	 SNBh697YFJnxs7CFG38+d2TBQ2slehVxZ32vhJ65pF6XBzkqXbIyoghlNbegTmrf/m
	 z0MnW2D8evcLTEvs+1gwqRT/VmfoTyW5RNkhXgbGtzmzjP1fBL5cozSi2GUoArhVc8
	 cRuyH2gGPg5Qw==
Message-ID: <e07d9d597036de3ba59510446586dfe54bc9fe33.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 3/6] mptcp: drop inet6_sk in
 mptcp_nl_find_ssk
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 17 Jan 2025 14:15:17 +0800
In-Reply-To: <09ec2f1c-1a9e-4a6a-a316-3bbf2d713130@kernel.org>
References: <cover.1736935086.git.tanggeliang@kylinos.cn>
	 <27f1c41a7a532e09596979e895af8dcbaca9313a.1736935086.git.tanggeliang@kylinos.cn>
	 <c12ee9591c031a519dc706987fd78ae8752421f7.camel@kernel.org>
	 <09ec2f1c-1a9e-4a6a-a316-3bbf2d713130@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-01-16 at 08:31 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> 16 Jan 2025 03:41:25 Geliang Tang <geliang@kernel.org>:
> 
> > On Wed, 2025-01-15 at 17:59 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > In mptcp_nl_find_ssk(), 'issk' has already been got through
> > > inet_sk(). No
> > > need to use inet6_sk() to get 'pinfo' again, just use issk-
> > > >pinet6
> > > instead.
> > > This patch also drops this 'pinfo' variable.
> > > 
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > >  net/mptcp/pm_userspace.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > > index e53426a5fc52..de17b18b78fe 100644
> > > --- a/net/mptcp/pm_userspace.c
> > > +++ b/net/mptcp/pm_userspace.c
> > > @@ -465,9 +465,7 @@ static struct sock *mptcp_nl_find_ssk(struct
> > > mptcp_sock *msk,
> > >             break;
> > >  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > >         case AF_INET6: {
> > > -           const struct ipv6_pinfo *pinfo =
> > > inet6_sk(ssk);
> > > -
> > > -           if (!ipv6_addr_equal(&local->addr6, &pinfo-
> > > > saddr) ||
> > > +           if (!ipv6_addr_equal(&local->addr6, &issk-
> > > > pinet6->saddr) ||
> > 
> > CI reports a warning here:
> > 
> > WARNING: line length of 84 exceeds 80 columns
> > #27: FILE: net/mptcp/pm_userspace.c:468:
> 
> Please note that this is a recommendation and not a strict rule.
> It means that if going a bit over 80 helps for the clarity, that's
> fine: no need to break lines and have something hard to read.
> 
> So up to you: check how it looks like when breaking the lines
> before 80 characters.

If so, I prefer not to break the lines and ignore this warning
(recommendation). 

Thanks,
-Geliang

> 
> Cheers,
> Matt

