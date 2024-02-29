Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA017B3D1
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208529; cv=none; b=hoPboIbqI62ItxcD0biKYmto5B2f9S/VRIPvXk60PIPnofDYZy5vc9PerOGP2JItaGoUJmAv1lanKPB2DgzqQanXW2UTI04WUdmNeQEvrl1T3ODgLVvh96B8e/FiirGORZMOHPTeLj6kuHYgffGrsblpEAuQ5yRDfScyAszqr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208529; c=relaxed/simple;
	bh=aHgp3qdfGuzRKXWjfnihxcBJohpdwGsD/p9uwR9y1J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEjFRdMu6021G06717WYQphCnRaxlv/ZWRxSyoquw+gjgLI8GmAUO/h/ihkzjygsYzCP+MpN5gzL4lIT3q03lxlrBKOgfFRg9tpGoC/8icZZAgWX8u+ReEPggeg+EYltl0Mrs1sUw07HLfWbAOuhGmZ1oLl7tZDuU/ZqOtO7wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ud6Bws/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ud6Bws/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49440C433F1;
	Thu, 29 Feb 2024 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709208529;
	bh=aHgp3qdfGuzRKXWjfnihxcBJohpdwGsD/p9uwR9y1J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ud6Bws/rhdo2EDs7ksioq3peKQq21TlN9yEzNwHMDPLHVpL/zP1iYyU4giFH/ei4A
	 LrQpVRa1w84T113GOoqMmsLGJsORP4bXrLebU+H2qr+QX/dlANzayE/cii4oxcKKaX
	 HFy6UtXJDyRoCl7B44NW+iJuFD9ML2ER+yvt467afG+ZySp1J8vRiierodz+N0wCVg
	 Qpw2hR5cqTw//9R1gSJ5ASvuSR7pYpVuA2vg7KY5nQ1Wi0TILIXdIAJYQYk4lkQwl2
	 YsI8gyTAIy+a+gCMlhOINKbhCZjXG5CPTGELhHcgA9B4cZ7gJvRTADPTsavJ9cD2ZK
	 nmEObjLgD98zw==
Date: Thu, 29 Feb 2024 20:08:45 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 5/8] selftests: mptcp: sockopt: unify
 ipv4/ipv6 as v4/v6
Message-ID: <ZeBzzVL+fwawzVB6@t480>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <80749c1dfc741ca14090559c5a2364b253c03a5a.1709200070.git.tanggeliang@kylinos.cn>
 <e8ffd789-f03d-4b99-b0aa-619cc7cce14d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ffd789-f03d-4b99-b0aa-619cc7cce14d@kernel.org>

Hi Matt,

On Thu, Feb 29, 2024 at 12:31:21PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/02/2024 10:51, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > ipv4/ipv6 and v4/v6 are mixed in the output of mptcp_sockopt.sh, this patch
> > unifies them as v4/v6.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > index 6ed4aa32222f..ae59136b5bb4 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > @@ -130,10 +130,10 @@ do_transfer()
> >  	local local_addr ip
> >  	if mptcp_lib_is_v6 "${connect_addr}"; then
> >  		local_addr="::"
> > -		ip=ipv6
> > +		ip=v6
> >  	else
> >  		local_addr="0.0.0.0"
> > -		ip=ipv4
> > +		ip=v4
> 
> Mmh, this will change the test name (used in "mptcp_lib_result_*") and
> this will break the tracking using the test name [1] while the test is
> still doing the same thing.
> 
> Maybe this patch is not worth it then, fine to see 'ipv6'. Or only

Do you mean drop this patch? I agree, let's drop it.

> display a different string in what is printed per test, what you were
> doing in patch 5/9 from the v6, but I don't know where this patch is:
> did you accidentally drop it?

5/9 from the v6 is merged into "v7 7/8".

Thanks,
-Geliang

> 
> [1] e.g.
> https://netdev.bots.linux.dev/flakes.html?br-cnt=88&tn-needle=mptcp or
> on LKFT or our CI
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
