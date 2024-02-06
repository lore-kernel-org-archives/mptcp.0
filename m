Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7D77F12
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198460; cv=none; b=Fhc1iqjCyYKCULzsEWCin44JLFzktNWVpSBhDBWUYbGlpNt3AuyxI4q67FtLi7R2Pxzmvg4LjV5NElKO9N6u6vDmvfsIsH81K3kRkmN8uWLkPWGOiVk+ElmyXyXcMsuPOowgerp9zk8f2zcqH6fCiIqdxAxZNArHf4NacGhKUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198460; c=relaxed/simple;
	bh=I9ZF7wUFGbMqp7kQAkPxsTTrqnvoIi34fmFPy0xkffY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYEGkEEY8O1nd6uPB6EdEGf8loO/QktgEr6hyFmxpx1wHX7bmamJuQk45MyebaIFKg/bDJX2DsulhM+nLptnzuQIadMxoE6UHUUkIb8at00xJzlMaDgLEIkyqt+NcneXF3I+1af3rxWQkT/yCpioH8Ywupd8re+6PkMfgZyH9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkyFIJwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkyFIJwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D869FC433C7;
	Tue,  6 Feb 2024 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707198460;
	bh=I9ZF7wUFGbMqp7kQAkPxsTTrqnvoIi34fmFPy0xkffY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkyFIJwe6+a8t/4jCYgZpJzI6fpFtJ1machLOQDrPZbwFSUHOHhDa2rfTlplw8PXB
	 n/FUatDcMqfDdPoT58gWJfT/HvM9YfCUQyqN4rxw6NTJpjg9YyDZpJ15G5xRK6xlGL
	 XO8zu7jKYxqTCBsUKi84AgNe0XyiohhMbBt31T1VHXX5pHPj61Yr6V9cLa9Z79KFZm
	 uqJEel55yZxN69y9i14l2D5O1eKvCh/5M12zztw9/ULFeU5cd86unAfNMMWe+WUsvf
	 jQ1X8FzoTw8wFaBiaweCYVazFEkddYSgRd2cZ2d2ltsErJL5Fv0Abc+E+3Dd+KbnDi
	 b8nR5TJK0HukQ==
Date: Tue, 6 Feb 2024 13:47:34 +0800
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 4/4] selftests: mptcp: rm subflow with
 v4/v4mapped addr
Message-ID: <ZcHH9lD9yYtgxG0Q@t480>
References: <cover.1706759413.git.tanggeliang@kylinos.cn>
 <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
 <1cd4fa8d-4de6-8803-5a39-c5088f909c9e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd4fa8d-4de6-8803-5a39-c5088f909c9e@kernel.org>

Hi Mat,

On Mon, Feb 05, 2024 at 05:40:00PM -0800, Mat Martineau wrote:
> On Thu, 1 Feb 2024, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Now both a v4 address and a v4-mapped address are supported when
> > destroying a userspace pm subflow, this patch adds random tests for both
> > addresses.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
> > Fixes: 48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++---
> > 1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index c07386e21e0a..a3bdbc896c6f 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -3333,12 +3333,13 @@ userspace_pm_rm_sf()
> > {
> > 	local evts=$evts_ns1
> > 	local t=${3:-1}
> > -	local ip=4
> > +	local ip
> > 	local tk da dp sp
> > 	local cnt
> > 
> > 	[ "$1" == "$ns2" ] && evts=$evts_ns2
> > -	if mptcp_lib_is_v6 $2; then ip=6; fi
> > +	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
> > +	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
> > 	tk=$(mptcp_lib_evts_get_info token "$evts")
> > 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
> > 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
> > @@ -3441,7 +3442,11 @@ userspace_tests()
> > 		chk_subflows_total 2 2
> > 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
> > 		userspace_pm_rm_addr $ns1 10
> > -		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
> > +		if [ $((RANDOM%2)) -eq 0 ]; then
> > +			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
> > +		else
> > +			userspace_pm_rm_sf $ns1 10.0.2.1 $SUB_ESTABLISHED
> > +		fi
> 
> Instead of randomizing this test, does it work to add a second subflow to
> this test case?

Yes, it works.

> 
> Then the two subflows could be removed two different ways (one with the
> v4mapped and one with v4)? That should avoid adding too much test time.

I just sent a v2 for this with only patch 3 and patch 4 in it.

Thanks,
-Geliang

> 
> - Mat
> 
> 
> > 		chk_rm_nr 1 1 invert
> > 		chk_mptcp_info subflows 0 subflows 0
> > 		chk_subflows_total 1 1
> > -- 
> > 2.40.1
> > 
> > 
> > 
