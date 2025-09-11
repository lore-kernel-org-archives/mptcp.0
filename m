Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887C2E6114
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581468; cv=none; b=V66FPFXCJeNEd1bOffWTk/Pkp3pDXJHFp/q/qVSEkuXekUbuH0h+q33Dv10SKMBNlbJ7JK+yu65hpv3NSGOwcTc+gfvQ6twvJxpfXv3Gl9/rMSDKgicuxIVd9ZVg8x7tmpZ6j3QZjq96RsjsxTIKQ+nsOuwNmGtp59CZGCcjMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581468; c=relaxed/simple;
	bh=3XVFVOdrik57ET1azcaVVTOVAdDlVMdYgImnrfcK9SA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asP0SFOjbPEgnWU4WhH3E1ZPUex1tdooxSUBOc9xkA/OoVc8dSZdvRJdHbJUWFQiNp1VpBOflSfGeHhZ/MfCbPcDKqpEf+jvi2WOFSOyHS2XJLEpiNoGcIjgcJJyev9z4sAoaRUxHZLBsB+2Ptlh68Bk4SWzSyIwV96WjuIpc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSADbe/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSADbe/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020F2C4CEF0;
	Thu, 11 Sep 2025 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757581467;
	bh=3XVFVOdrik57ET1azcaVVTOVAdDlVMdYgImnrfcK9SA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=oSADbe/OkPQZoTRiRjD/XU6R9+hgOJUpLEHu5SfEUdITjMMRU8fM2n8B8hkUVtrKF
	 vz1ZAqyUaeIfJdBe5k32AHRbmSlpwKd40d60CiQ6RPUk2fDuhUAJfsQzxr6HQmLr2C
	 4IzDwlewoiD1gDNjuHxKt3BP7AlsWP7OQC0MLPTcYpPYRVGWdPdr9mTxHn3oITSep3
	 xi5MfyADn2psWdGyEJoGbE9t9R9sNN35uLVh+7qAt/M/39SrJEKGBQ2Dh5q5EhnEzJ
	 qMMuev+datITAjsgMbj5ROPJ9acwEWLZmiInw2bA3n1+XE19lA6019ROUtlIkS5/ZJ
	 rKZ7U61JGbYqQ==
Message-ID: <e740db7c89cf40416c2688ad8ff8a617c7bbafec.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: pm: get server-side
 flag
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Thu, 11 Sep 2025 17:04:23 +0800
In-Reply-To: <1f62d970-631e-4031-a386-2b1db50642fb@kernel.org>
References: 
	<20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
	 <20250909-mptcp-pm-user-server-side-flag-v1-4-cb8e2b8d1c0c@kernel.org>
	 <20639f7f4b2616afaa4c4e511a13aa8ad49c8d90.camel@kernel.org>
	 <1f62d970-631e-4031-a386-2b1db50642fb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-09-11 at 10:35 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 11/09/2025 10:16, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0) wrote:
> > > server-side info linked to the MPTCP connect/established events
> > > can
> > > now
> > > come from the flags, in addition to the dedicated attribute.
> > > 
> > > The attribute is now deprecated -- in favour of the new flag, and
> > > will
> > > be removed later on.
> > > 
> > > Print this info only once.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > index
> > > 93fea3442216c8fef43731a99c1d5710f234b150..d4981b76693bbddca741694
> > > 37a5
> > > 40ad6294cf1d5 100644
> > > --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > @@ -2,6 +2,7 @@
> > >  
> > >  #include <errno.h>
> > >  #include <error.h>
> > > +#include <stdbool.h>
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > > @@ -113,6 +114,8 @@ static int capture_events(int fd, int
> > > event_group)
> > >  		error(1, errno, "could not join the "
> > > MPTCP_PM_EV_GRP_NAME " mcast group");
> > >  
> > >  	do {
> > > +		bool server_side = false;
> > > +
> > >  		FD_ZERO(&rfds);
> > >  		FD_SET(fd, &rfds);
> > >  		res_len = NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
> > > @@ -187,18 +190,22 @@ static int capture_events(int fd, int
> > > event_group)
> > >  				else if (attrs->rta_type ==
> > > MPTCP_ATTR_ERROR)
> > >  					fprintf(stderr,
> > > ",error:%u",
> > > *(__u8 *)RTA_DATA(attrs));
> > >  				else if (attrs->rta_type ==
> > > MPTCP_ATTR_SERVER_SIDE)
> > > -					fprintf(stderr,
> > > ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
> > 
> > It is a little strange that server_side is displayed at the end. It
> > changes the original display order.  It is better to display it in
> > the
> > original position, but check whether the server_side flag is false:
> 
> I'm not sure to understand why it is strange: the output is read by
> scripts, the order should not matter, right?

I mean the original display order of "./pm_nl_ctl events" is:

type:1,token:2327950928,server_side:1,family:10,saddr6:::ffff:10.0.1.1,
daddr6:::ffff:10.0.1.2,sport:10000,dport:40004,loc_id:0,rem_id:0

With this patch, the order is changed:

type:1,token:1072969578,family:10,saddr6:::ffff:10.0.1.1,daddr6:::ffff:
10.0.1.2,sport:10000,dport:42484,loc_id:0,rem_id:0,server_side:1

If an application still uses code like this to parse server_side, an
error will occur.

sscanf(str, "type:%u,token:%u,server_side:%u",
       &type, &token, &server_side);

So it makes sense to keep the original order. But up to you.

Thanks,
-Geliang

> 
> Plus the order depends on what was received by the kernel, not where
> they are printed here.
> 
> Do you really think it is worth it changing this patch and making
> longer
> just to keep an order that we don't currently fully control here?
> 
> Cheers,
> Matt
