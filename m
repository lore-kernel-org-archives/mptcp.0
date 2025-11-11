Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC9225761
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849028; cv=none; b=lKtQCWz804zRwlLFNKIHfFUURr46fvVU13WqqSUwWQy/nmO9/CTV1uZx9XPNYJ/dqqdJLcb/LqB+YCo70TRGSBd1hUx4nWhncy8hTGpi2GOKtHAwfrgUJXmGifYGnXE3seWHPVL6rPrTB6azqU44J0Dq+zDaJcot4I9bGxXQydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849028; c=relaxed/simple;
	bh=5kPzaTU0qRfCwaUlv9RHVFK3+zR9Czm5SA2eEP4KHaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKfhpY0nI8TXHNPRCr9BU590+qQlqm6t76+dGpaCEdSErq8KPLR5wdoQLzktxKC4wVlPcDA//0vlhcqnTEjBCFrVcjqVKSXv3YyYvDXv0r8cvMLEtCs9rcyaQS4eSBL6XKd4vZf6sZZ3W92L4CicAS8RS7yzORuEaG/jKCXdhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPGBYGtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPGBYGtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B78C116D0;
	Tue, 11 Nov 2025 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762849026;
	bh=5kPzaTU0qRfCwaUlv9RHVFK3+zR9Czm5SA2eEP4KHaU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lPGBYGtEWew5zaDpt12rQNs/27mCQ/OMqONDf+gmpJZnNVjRNbeDAO/RgR07RGHsE
	 lf5Y5Gf0tiv+xvizLnzYqi/3PwnW2XJpq0QzBZAe5igjXdpjUrt7KOIRHk/Y8R/MIS
	 Lmo52ivKSXe9cUtDNT1pGyXNAYR4wn2drkqId9mTwhd4QIEwaa/AsCzSULl0VYm62o
	 3wxH7wEh2RBe0nKDG/lt1UHXjuKRmmo8J/Ovmn5CYBO8aDZt30aqcf9R4e95uRwDg/
	 Z//labxwwouK4w0ntinvz0uFw3/YLgKDr+Lu2n4U1oYBYUwlamGivaPJiCfD3q7snu
	 CJ/DrjNFf/wTg==
Message-ID: <a8768ce5597666aca5effeb794303245d8edc67c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] selftests: mptcp: join: properly kill
 background tasks
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Tue, 11 Nov 2025 16:17:03 +0800
In-Reply-To: <894506e8-df54-4fb7-8337-c5fdc99ecb73@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
	 <20251108-slft-timeout-stats-v1-1-c2234d277318@kernel.org>
	 <d5ef4083df02cc56e51170ec906eeaea78443c84.camel@kernel.org>
	 <894506e8-df54-4fb7-8337-c5fdc99ecb73@kernel.org>
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

On Tue, 2025-11-11 at 07:53 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the reviews.
> 
> 11 Nov 2025 03:46:06 Geliang Tang <geliang@kernel.org>:
> 
> > Hi Matt,
> > 
> > This for this fix.
> > 
> > On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
> > > The 'run_tests' function is executed in the background, but
> > > killing
> > > its
> > > associated PID would not kill the children tasks running in the
> > > background.
> > > 
> > > To properly kill all background tasks, 'kill -- -PID' could be
> > > used,
> > > but
> > > this requires kill from procps-ng. Instead, all children tasks
> > > are
> > > listed using 'ps', and 'kill' is called with all PIDs of this
> > > group.
> 
> (...)
> 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > index ce6c92826be7..91ec75ddcb96 100644
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > @@ -359,6 +359,27 @@ mptcp_lib_kill_wait() {
> > >     wait "${1}" 2>/dev/null
> > >  }
> > >  
> > > +# $1: PID
> > > +mptcp_lib_pid_list_children() {
> > > +   local curr="${1}"
> > > +   # evoke 'ps' only once
> > > +   local pids="${2:-"$(ps o pid,ppid)"}"
> > > +
> > > +   echo "${curr}"
> > > +
> > > +   local pid
> > > +   for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print
> > > \$1 }"); do
> > > +       mptcp_lib_pid_list_children "${pid}" "${pids}"
> > 
> > To be honest, I don't understand why this
> > mptcp_lib_pid_list_children
> > function is calling itself here. Is this recursion?
> 
> Yes it is a recursion: children processes can have children ones.
> 
> mptcp_lib_pid_list_children() will print the PID it is called with,
> and call
> itself with all children (can be none).
> 
> In our case with mptcp_join.sh, it means getting the run_tests job
> plus
> the other background tasks: mptcp_connect (x2), the timeout, and
> eventually the task modifying the endpoints.

Thanks for your explanation, this patch looks good to me.

I'll reply my RB tag in the cover letter.

And for patch 6 of "selftests: mptcp: join: fix some flaky tests"
sending to -net too.

-Geliang

> 
> Cheers,
> Matt

