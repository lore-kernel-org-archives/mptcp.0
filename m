Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5D219A8B
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585143; cv=none; b=oMVlgLrb34SgRso9cGwA5apdqfVZumbMcYqRJTTB2k8okR8m0bttKicK0CB2kZ4vGuc/hym+HVZuuUREbWpqQr3klcT45bIQPAWrmk5ApKEafWmtWgfw6qHHdd5jRkzRKZ7AcGAdW4x/3Fib12Jh6YEXkJusOV9rwcQwNUZjKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585143; c=relaxed/simple;
	bh=jjcw7ROpxUrnzILh7t5eOAOA3scCjhWtpm7X45gCtpU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3JLLTkz9kRN8HYD4e53bIC9lm7il9JO1onUKYFRKKUHIKEh3xOxPOk5J6rqzw0MUHqcHuk7tBI1GFRcH1+BFHz94VVhBqBxCbMnpeY7pk4ecQNEwpEcy80N8RaTqrWbRvipe1IWvZV+syFqLTK+54s77/8Z7N7QFQBxGUClHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKUKn8Ax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKUKn8Ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D75C4CEF0;
	Thu, 11 Sep 2025 10:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757585142;
	bh=jjcw7ROpxUrnzILh7t5eOAOA3scCjhWtpm7X45gCtpU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=sKUKn8AxaE4pP+OqDCkHa61u0NnGYM1PJosygpJ7//D9aPlzMaYmDD7LBeOu6l0Sy
	 ksppwbgxWjft5YLk4Yh70JbYZMms6qu/tR29FjqCi74PAwcvEZ103NywbmJDWZxbcc
	 OnTiKv6PUycDr5kkNK5MfCANx2xf092U/DFEgXpwttoq8xRAwDSVmvQjqiiJaOo639
	 sSO+gTjxb7+aE9vrSZv5f0jG0m1Ng9XcslSzqaTd/stOyps90WLnm8gc7wqlUoz/eW
	 s/Sr3mcwNjXoGLRR02+bdxN4ideNezWEVBdfFWVtgYZU36JFcWhSgQsgCyTQxYR+cR
	 nNjLics8sj9GQ==
Message-ID: <51c4f038acf4a596bc9c90c32c9ab6dd74312b00.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: pm: get server-side
 flag
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Thu, 11 Sep 2025 18:05:38 +0800
In-Reply-To: <0cbcf551-9839-436c-93bb-d7275a12a1a5@kernel.org>
References: 
	<20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
	 <20250909-mptcp-pm-user-server-side-flag-v1-4-cb8e2b8d1c0c@kernel.org>
	 <20639f7f4b2616afaa4c4e511a13aa8ad49c8d90.camel@kernel.org>
	 <1f62d970-631e-4031-a386-2b1db50642fb@kernel.org>
	 <e740db7c89cf40416c2688ad8ff8a617c7bbafec.camel@kernel.org>
	 <0cbcf551-9839-436c-93bb-d7275a12a1a5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-09-11 at 11:35 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 11/09/2025 11:04, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Thu, 2025-09-11 at 10:35 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 11/09/2025 10:16, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0)
> > > > wrote:
> > > > > server-side info linked to the MPTCP connect/established
> > > > > events
> > > > > can
> > > > > now
> > > > > come from the flags, in addition to the dedicated attribute.
> > > > > 
> > > > > The attribute is now deprecated -- in favour of the new flag,
> > > > > and
> > > > > will
> > > > > be removed later on.
> > > > > 
> > > > > Print this info only once.
> > > > > 
> > > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > > > ---
> > > > >  tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > > > b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > > > index
> > > > > 93fea3442216c8fef43731a99c1d5710f234b150..d4981b76693bbddca74
> > > > > 1694
> > > > > 37a5
> > > > > 40ad6294cf1d5 100644
> > > > > --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > > > +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> > > > > @@ -2,6 +2,7 @@
> > > > >  
> > > > >  #include <errno.h>
> > > > >  #include <error.h>
> > > > > +#include <stdbool.h>
> > > > >  #include <stdio.h>
> > > > >  #include <stdlib.h>
> > > > >  #include <string.h>
> > > > > @@ -113,6 +114,8 @@ static int capture_events(int fd, int
> > > > > event_group)
> > > > >  		error(1, errno, "could not join the "
> > > > > MPTCP_PM_EV_GRP_NAME " mcast group");
> > > > >  
> > > > >  	do {
> > > > > +		bool server_side = false;
> > > > > +
> > > > >  		FD_ZERO(&rfds);
> > > > >  		FD_SET(fd, &rfds);
> > > > >  		res_len = NLMSG_ALIGN(sizeof(struct
> > > > > nlmsghdr)) +
> > > > > @@ -187,18 +190,22 @@ static int capture_events(int fd, int
> > > > > event_group)
> > > > >  				else if (attrs->rta_type ==
> > > > > MPTCP_ATTR_ERROR)
> > > > >  					fprintf(stderr,
> > > > > ",error:%u",
> > > > > *(__u8 *)RTA_DATA(attrs));
> > > > >  				else if (attrs->rta_type ==
> > > > > MPTCP_ATTR_SERVER_SIDE)
> > > > > -					fprintf(stderr,
> > > > > ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
> > > > 
> > > > It is a little strange that server_side is displayed at the
> > > > end. It
> > > > changes the original display order.  It is better to display it
> > > > in
> > > > the
> > > > original position, but check whether the server_side flag is
> > > > false:
> > > 
> > > I'm not sure to understand why it is strange: the output is read
> > > by
> > > scripts, the order should not matter, right?
> > 
> > I mean the original display order of "./pm_nl_ctl events" is:
> > 
> > type:1,token:2327950928,server_side:1,family:10,saddr6:::ffff:10.0.
> > 1.1,
> > daddr6:::ffff:10.0.1.2,sport:10000,dport:40004,loc_id:0,rem_id:0
> > 
> > With this patch, the order is changed:
> > 
> > type:1,token:1072969578,family:10,saddr6:::ffff:10.0.1.1,daddr6:::f
> > fff:
> > 10.0.1.2,sport:10000,dport:42484,loc_id:0,rem_id:0,server_side:1
> > 
> > If an application still uses code like this to parse server_side,
> > an
> > error will occur.
> > 
> > sscanf(str, "type:%u,token:%u,server_side:%u",
> >        &type, &token, &server_side);
> > 
> > So it makes sense to keep the original order. But up to you.
> 
> I hope no applications are doing that: this pm_nl_ctl tool lists the

I do use this in BPF path manager selftests under development.

> arguments in the order it receives it, but this order is set by the
> kernel and can change. In other words, this order is not fixed in
> stone.
> 
> Plus this tool is for the selftests, I don't think other people are
> using it. 'ip mptcp' is probably used instead. And even they should
> not
> expect the order to be fixed.
> 
> So I don't think we need to increase the complexity here if it is not
> needed.

Sure. I have no comments then. Please add my tag for this set:

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt
