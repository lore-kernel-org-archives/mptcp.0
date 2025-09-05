Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30C25C81B
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060214; cv=none; b=c3Un+tj+UaAzBreFvYek++Dn4cRkhT14pxwVSdiU77CbYYIuz3qPp8mVdOJPhoRK/j4WmpIfLu5+vRsG7g9xoFcQUPdR5FvmBshlwlrd3AEdmx9w9JkI3mMFAfTpk1KMCA7JwA6ddEv12IBaSOXZMcB9pWqxshfTDrmXgOMwQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060214; c=relaxed/simple;
	bh=OzjZmLZ3izH1TnIaKIDaRjoyigMivTbT17SJOiQ1VUk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESaKxU0awa2BgdtEjr0YLx3iKk1ktAGFGmJzFNhwCdch+f5ivIrcuDQa3KrZy3JiSXT6uMdyP8BRRApCmAyaGsISzEP9ppePylhBkqjYO/zzwn0TNGcvttG3whTtb84KmJWctGc/MY1puj5w7QyM8bqAuYcoPbW/6XfBVaseggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPTHFkvT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPTHFkvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24351C4CEF1;
	Fri,  5 Sep 2025 08:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757060213;
	bh=OzjZmLZ3izH1TnIaKIDaRjoyigMivTbT17SJOiQ1VUk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MPTHFkvTlf+0K09Dg0QUJWHWIoZUpe1hqucbMMOrlBDo1pkc8BTv49q94QgGrCVd8
	 xOnACH+CUw7d8AoMcdIAjN43wNEa70k9sjsRE2zlABreeGmoU45uL9qPV2YUxtaSdp
	 9Qb4Kmy0mTkTec08Jw1CTeJA0Li10CrVzVntR32BaRF44iGcVj0gJQTSATO4M52WsD
	 PTLGiLbTyrFX21rswPm02fipTVPHj6LJXX3dOGVrvJEomYxPENJPBzeTMFzZf6Xdhl
	 ta6ptRmmVHgGAeCyxeyt7zKqfTJXKm+dpTeAw1N9/Hcq752jWcrrPtF7n2B8A9lckY
	 e/TW50ztYvYXg==
Message-ID: <21ee1ae6c2d86739387e3e9709fbd630d5e5bdc5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/3] selftests: mptcp: join: tolerate more
 ADD_ADDR
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Fri, 05 Sep 2025 16:16:48 +0800
In-Reply-To: <cde1771d-2383-42cb-97e3-92d53e42b381@kernel.org>
References: 
	<20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
	 <20250904-sft-mptcp-join-add_addr-no-retrans-v2-2-a019e6678628@kernel.org>
	 <cde1771d-2383-42cb-97e3-92d53e42b381@kernel.org>
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

Thanks for this new version, and thanks for the explanation in v1.

On Thu, 2025-09-04 at 16:54 +0200, Matthieu Baerts wrote:
> On 04/09/2025 13:38, Matthieu Baerts (NGI0) wrote:
> > ADD_ADDR can be retransmitted, and with, the parent commit, these
> > retransmissions can be sent quicker: from 2 minutes to less than
> > one
> > second.
> > 
> > To avoid false positives where retransmitted ADD_ADDR causes higher
> > counters than expected, it is required to be more tolerant. Errors
> > are
> > now only reported when fewer ADD_ADDRs have been sent/received,
> > except
> > if no ADD_ADDR are expected.
> > 
> > Before the parent commit, the tolerance was present for each tests
> > where
> > the ADD_ADDR could be retransmitted in a reasonable time (1 sec).
> > Now
> > that all tests can have retransmitted ADD_ADDR, it is normal to
> > apply
> > the same tolerance for all tests.
> > 
> > An alternative could be to disable the ADD_ADDR retransmissions by
> > default, but that's changing the default kernel behaviour. Plus,
> > ADD_ADDR retransmissions can be required for some tests. To avoid
> > adding
> > exceptions to many tests, it seems better to increase the
> > tolerance.
> > 
> > Later, we could add a new MIB counter to identify the ADD_ADDR
> > retransmissions, and remove the tolerance when this counter is
> > available.
> > 
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++------
> > ------
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index
> > 2f046167a0b6cc6fb5531a033d8d95c9ea399cf9..be49712f91155a1f14f6cc217
> > 76764d65a897c27 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -358,6 +358,7 @@ reset_with_add_addr_timeout()
> >  		tables="${ip6tables}"
> >  	fi
> >  
> > +	# set a maximum, to avoid too long timeout with
> > exponential backoff
> >  	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> >  
> >  	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
> > @@ -1669,7 +1670,6 @@ chk_add_nr()
> >  	local tx=""
> >  	local rx=""
> >  	local count
> > -	local timeout
> >  
> >  	if [[ $ns_invert = "invert" ]]; then
> >  		ns_tx=$ns2
> > @@ -1678,15 +1678,13 @@ chk_add_nr()
> >  		rx=" server"
> >  	fi
> >  
> > -	timeout=$(ip netns exec ${ns_tx} sysctl -n
> > net.mptcp.add_addr_timeout)
> > -
> >  	print_check "add addr rx${rx}"
> >  	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
> >  	if [ -z "$count" ]; then
> >  		print_skip
> > -	# if the test configured a short timeout tolerate greater
> > then expected
> > -	# add addrs options, due to retransmissions
> > -	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ]
> > || [ "$count" -lt "$add_nr" ]; }; then
> > +	# Tolerate more ADD_ADDR then expected (if any), due to
> > retransmissions
> > +	elif [ "$count" -lt "$add_nr" ] ||
> > +	     { [ "$count" != "$add_nr" ] && [ "$add_nr" != 0 ]; };
> > then
> 
> Arf, it should be:
> 
>   "$add_nr" == 0

It should indeed be "$add_nr" == 0.

nit:

Is it possible to keep the same order as before when checking
"$timeout", just replace [ "$timeout" -gt 1 ] with [ "$add_nr" == 0 ]?

That is:

elif [ "$count" != "$add_nr" ] && { [ "$add_nr" == 0 ] || [ "$count" -
lt "$add_nr" ]; }; then

Although they are actually the same, I usually try to keep it
consistent with the original code.

> >  		fail_test "got $count ADD_ADDR[s] expected
> > $add_nr"
> >  	else
> >  		print_ok
> > @@ -1774,18 +1772,15 @@ chk_add_tx_nr()
> >  {
> >  	local add_tx_nr=$1
> >  	local echo_tx_nr=$2
> > -	local timeout
> >  	local count
> >  
> > -	timeout=$(ip netns exec $ns1 sysctl -n
> > net.mptcp.add_addr_timeout)
> > -
> >  	print_check "add addr tx"
> >  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
> >  	if [ -z "$count" ]; then
> >  		print_skip
> > -	# if the test configured a short timeout tolerate greater
> > then expected
> > -	# add addrs options, due to retransmissions
> > -	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1
> > ] || [ "$count" -lt "$add_tx_nr" ]; }; then
> > +	# Tolerate more ADD_ADDR then expected (if any), due to
> > retransmissions
> > +	elif [ "$count" -lt "$add_tx_nr" ] ||
> > +	     { [ "$count" != "$add_tx_nr" ] && [ "$add_tx_nr" != 0
> > ]; }; then
> 
> Same here:
> 
>   "$add_tx_nr" == 0
> 
> If there is nothing else, I can fix that when applying the patches.

No need to send a v3, please fix it when applying it.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> >  		fail_test "got $count ADD_ADDR[s] TX, expected
> > $add_tx_nr"
> >  	else
> >  		print_ok
> > 
> 
> Cheers,
> Matt
