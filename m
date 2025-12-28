Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CB199E94
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766897031; cv=none; b=TS6eKRBGMDcARG/J+vIvWbnDZrd/N3ued7ZSZz9q+oBH3VVpzy/dkwDtLEcc7Jmg82Rg1I8N6pssotv+VfJ46kxOo11ybREm0tHeGV6uk+9fZR2F56WkmLWJV+bEmsjm5IosP0Yrd4Py7xDQkOtnvnM1vn+vhy2MY9JFfanJnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766897031; c=relaxed/simple;
	bh=SvXxhhPzCIRwmawsi0nh/HJe57LsFeUS/I6bYQAGlW0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JIvkABJrmi5Jl1C0b+F7OVYlO7yIa9NnpKBCqlRs1BwSAd1zlgvLGqOpAFM+TavVNqjbOlikJCtZI7vd5AXIaTlc1R+mvIuifgdXgqnSJcO37ZrFYELYIrHnmAsrAHvUxExAk4VWUUYdecYvDKD0jBuLfaHMBMspfYq/8j9TxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StLhDTsb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StLhDTsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A80EC113D0;
	Sun, 28 Dec 2025 04:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766897030;
	bh=SvXxhhPzCIRwmawsi0nh/HJe57LsFeUS/I6bYQAGlW0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=StLhDTsb6WEnRbXeiIO53ptbFkntWq5pCz5uGI6+f5hct8snyiZHhLBObFvmMkSuR
	 ej2uIv8Sxn46PdPpqHeNGboP6u9jljcZyEq4SUesBpHy5UmXaUO7EK+H1vkUJSifki
	 b3HWvPksYfs9jlWO0cgEy3QhZA5M2a3O8FRHh0gGuARk1WOzHWWjet9Tm0tI0rx4hN
	 yrFJrXPJ0FIriWN8NCjzkuUxwJ1nk1pPBl7QJ7tfpn7xZUjArxWB8c/5OGlMXFxpSt
	 S8dgbHHLJP70JRmP2fKBuXqf0Qa7C6Rro9l1gLQg3dk61MdDF1I0llZesixf3LXIf1
	 oLMmAJGaxF6tA==
Message-ID: <34fa8f6dc3cfe8a70cbb207e300d34719eea82b9.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 08/11] selftests: mptcp: join chk_stale_nr:
 avoid dup stats
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 12:43:47 +0800
In-Reply-To: <f7bd1668def5a8062f7deef87b88a7444e037587.camel@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
		 <20251226-mptcp-issue-603-v1-8-bb30e331b839@kernel.org>
	 <f7bd1668def5a8062f7deef87b88a7444e037587.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2025-12-28 at 10:25 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this patch.
> 
> On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> > nstat outputs are already printed when calling 'fail_test', no need
> > to
> > do it again.
> > 
> > While at it, no need to use the dump_stats variable, print the
> > extra
> > stats directly. And use 'ip -n $ns' instead of 'ip netns exec $ns',
> > shorter and clearer.
> > 
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 63a84a4d43a6..80e03168b419 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -1648,7 +1648,6 @@ chk_stale_nr()
> >  	local stale_min=$2
> >  	local stale_max=$3
> >  	local stale_delta=$4
> > -	local dump_stats
> >  	local stale_nr
> >  	local recover_nr
> >  
> > @@ -1664,16 +1663,11 @@ chk_stale_nr()
> >  		fail_test "got $stale_nr stale[s] $recover_nr
> > recover[s], " \
> >  		     " expected stale in range
> > [$stale_min..$stale_max]," \
> >  		     " stale-recover delta $stale_delta"
> > -		dump_stats=1
> > +		echo $ns stats
> > +		ip -n $ns -s link show
> >  	else
> >  		print_ok
> >  	fi
> > -
> > -	if [ "${dump_stats}" = 1 ]; then
> > -		echo $ns stats
> > -		ip netns exec $ns ip -s link show
> > -		ip netns exec $ns nstat -as | grep MPTcp
> 
> mptcp_lib_pr_nstat() is called in fail_test(), it's slightly
> different
> from the above line:
> 
>         ip netns exec "${ns}" nstat -as | grep Tcp
> 
> So, is it necessary for us to keep the above line?

Sorry, I made a mistake. The output of 'grep Tcp' includes the output
of 'grep MPTcp', so the information of dump_stats is indeed redundant.

So this patch looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> > -	fi
> >  }
> >  
> >  chk_add_nr()
