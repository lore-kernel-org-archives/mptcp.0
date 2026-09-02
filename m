Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF3374E5A
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335265; cv=none; b=gqr4/Vmt6T5mLhV+ivSrBtm2QsyEjsL48+Xw4u1stgCk53ePyjXr6bYzHWTIxQeFu7vlOEgfIm47HLqO1AFUm+e7iZ2Ilf7GHPzXJo9YG6zlxaOSJ0oiOAiLeh5RlIftoIWsblsgBvV0T0Xdx1RUUOUQOvF+LVesUE0OvJhMWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335265; c=relaxed/simple;
	bh=5T0DDY/LO7po3l5L3kH5jryIHusgdlLonq8DYkyJU0E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC6MzSTVU3SHVek4GAUfgvaWt0e4DDylSZap0Zk66bydbOU9V/YGVaRN7DxYm//ZNviAxWx4C0H5ZvttOKzSRtoV7URoB/Tjyt9xLPeLRZRAAn5F41cm1ncYrAyiPp6IZRVkVTaDL+cnQoqYtBIO/prfgfPcnER1VF1W+3qEOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CkYnsW7f; arc=none smtp.client-ip=95.215.58.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CkYnsW7f"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=5T0DDY/LO7po3l5L3kH5jryIHusgdlLonq8DYkyJU0E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788335261; v=1; x=1788940061;
 b=CkYnsW7f5TbjWgzcsB6L7S8wnN6OCo37WKSFlwuzUaJr8n+mqNRPmlZLE2KvYNUQziyyw/8i
 VZKCQa46b9PBjNqCLIKUgBtXVmcGLts99TW/PVgd+0LfIZsg0FIAMKwKms8JZ2CPHhmkMCWJjQ7
 m9JcDzzSWTsTgodswvfSDNyY=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id cb1a297f78c77415;
	Wed, 02 Sep 2026 07:47:41 +0000
X-Mizu-Trace-ID: cb1a297f78c77415
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 15:47:37 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Message-ID: <apfUmU4cEE0uxrSs@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-1-559caa16f410@kylinos.cn>
 <20260902070232.4F4851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902070232.4F4851F000E9@smtp.kernel.org>

On Wed, Sep 02, 2026 at 07:02:31AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Replacing iptables TCP flag matching with nftables exact matching (`tcp flags rst` and `tcp flags syn`) fails to match packets with multiple flags set, causing spurious test failures.
> - [Medium] An empty `$drop` variable causes a Bash syntax error during numeric evaluation, which evaluates to false and silently masks test failures.
> - [Low] Typo in string interpolation for the error message (`IPv{$af}` instead of `IPv${af}`).
> --
> 
> commit af165781f3fb777bc40bc4de19c7d79cd01f51cc
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
> 
> This patch converts the mptcp_sockopt.sh selftest to use nftables instead of
> iptables. It replaces per-address-family iptables mark rules with an inet
> table containing drop counting rules for IPv4 and IPv6.
> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > index e850a87429b61..4d0af2bf94840 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> 
> [ ... ]
> 
> > @@ -49,17 +47,23 @@ add_mark_rules()
> >  	local ns=$1
> >  	local m=$2
> >  
> > -	local t
> > -	for t in ${iptables} ${ip6tables}; do
> > -		# just to debug: check we have multiple subflows connection requests
> > -		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
> > -
> > -		# RST packets might be handled by a internal dummy socket
> > -		ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --mark 0 -j ACCEPT
> 
> [ ... ]
> 
> > +	# just to debug: check we have multiple subflows connection requests
> > +	ip netns exec "$ns" nft add rule inet msock_table output \
> > +		 meta mark "$m" tcp flags syn accept
> > +	# RST packets might be handled by a internal dummy socket
> > +	ip netns exec "$ns" nft add rule inet msock_table output \
> > +		meta mark 0 tcp flags rst accept
> 
> [Severity: Medium]
> In add_mark_rules(), the original iptables rules --tcp-flags RST RST and
> --syn used bitmasks to allow additional flags like ACK for RST or ECN for
> SYN. The new nftables rules tcp flags rst and tcp flags syn enforce an
> exact match on the entire TCP flags byte.
> 
> Will these exact matches reject packets with multiple flags set, such as
> RST+ACK or SYN+ECN, causing them to fall through to the drop rule and fail the
> test?

Thanks, I just find a tool iptables-translate and I will recheck each
translation.

> 
> [ ... ]
> 
> > @@ -105,33 +109,23 @@ cleanup()
> >  
> >  mptcp_lib_check_mptcp
> >  mptcp_lib_check_kallsyms
> > -mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
> > +mptcp_lib_check_tools ip nft
> >  
> >  check_mark()
> >  {
> >  	local ns=$1
> >  	local af=$2
> >  
> > -	local tables=${iptables}
> > +	drop=$(ip netns exec "$ns" nft list table inet msock_table | \
> > +		grep "ipv$af.*packets.*drop" | awk '{print $(NF-3)}')
> >  
> > -	if [ $af -eq 6 ];then
> > -		tables=${ip6tables}
> > +	if [ "$drop" -ne 0 ]; then
> 
> [Severity: Medium]
> If the command extraction for drop fails, or if grep finds no matches,
> the $drop variable will be empty.
> 
> When bash evaluates [ "$drop" -ne 0 ] with an empty string, it triggers a
> syntax error. This error evaluates to false and skips the failure block.
> 
> Does this risk silently masking test failures if the extraction logic ever
> fails to produce a number?

OK, I will add a regex to check if drop is number or not.

> 
> > +		mptcp_lib_pr_fail "got $drop pkt drops in ns $ns IPv{$af} tables," \
> 
> [Severity: Low]
> Is the string interpolation IPv{$af} a typo?
> 
> Bash interpolates the $af variable but leaves the literal braces, printing
> IPv{4} instead of IPv4. Should this be IPv${af} or IPv$af instead?
> 
> > +				  "not 0 - not all expected packets marked"
> > +		ret=${KSFT_FAIL}
> > +		return 1
> >  	fi

Thanks, I will fix this.

Hangbin
