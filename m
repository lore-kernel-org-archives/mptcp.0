Received: from mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716203161A1
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404149; cv=none; b=k3ja7gh4HrRUnm+HgO5dx4RJy2nJkarmnxUMu96cVB/pCIV6cmnlKICqVVKo9Qi4FyeWC+mm6vw1sF6haiT+H9+1l5K9hej+Lz+FkfjF/QiUXmdPNfrmfqTVIit9AWiKr6uiPtOpKYbcG11TEf0WCIDu6TUOKxUPIwLtVZT+3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404149; c=relaxed/simple;
	bh=0El51hAb97DptRGCuonVv/eCBuhcayQJHSJILn8WIIA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFElT1Gzfa3GsWF2fXFfioCyuHZ1A3iR+orDeLR1WSB0HCpxfLRyxvEOKskzC4mfKuk1quOJ2N4YoF1GRWUvgds33R7xVvWEu78Nw0jG5zqiLB7UTiNVMYmQdWbEZxT0LEdEjQp+iOUGS/43a++bVfInK+Zxwrk5RtRtfxH5GhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cw+Qwx2v; arc=none smtp.client-ip=95.215.58.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cw+Qwx2v"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=0El51hAb97DptRGCuonVv/eCBuhcayQJHSJILn8WIIA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788404145; v=1; x=1789008945;
 b=Cw+Qwx2vqjyYwLCiejUB8vax9Fq2IylPtWAn1LroiYL8XMVcpFb9fPUHx6FxCUw1FaOoJ953
 J5CscC4BmXsZjoFfE2IOL9xUpXKaGNfgXZesVAjto6yIJVpBPucTCH+fm9kscAu0AC5UNCBzlfY
 jA6V6R7Jj+dDPfJPzdl/Fl70=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id dfaa3ad62510f3ae;
	Thu, 03 Sep 2026 02:55:45 +0000
X-Mizu-Trace-ID: dfaa3ad62510f3ae
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 10:55:36 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Message-ID: <apjhqLzekXzikx0q@fedora>
References: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
 <20260903-mptcp_nft-v2-1-66283e4b9c3b@kylinos.cn>
 <20260903011911.EC2E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903011911.EC2E61F000E9@smtp.kernel.org>

On Thu, Sep 03, 2026 at 01:19:11AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The debug rule for SYN packets lacks a counter in the nftables conversion, rendering it completely dead code and defeating its stated purpose.
> --
> 
> commit 10b242a411677a92a0a291c8ae35773ac1ef8e56
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
>     
> During the conversion, we retain the same filter and chain names previously
> used by iptables/ip6tables. Counters are not added to accept rules because
> the test does not inspect them. After conversion, the generated output
> matches the original iptables/ip6tables behavior.
> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > index e850a87429b61..a2c20483986dc 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > @@ -50,15 +48,25 @@ add_mark_rules()
> >  	local m=$2
> >  
> >  	local t
> > -	for t in ${iptables} ${ip6tables}; do
> > +	for t in ip ip6; do
> > +		ip netns exec "$ns" nft add table "$t" filter
> > +		ip netns exec "$ns" nft add chain "$t" filter OUTPUT \
> > +			'{ type filter hook output priority 0; policy accept; }'
> > +
> >  		# just to debug: check we have multiple subflows connection requests
> > -		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
> > +		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
> > +			tcp flags \& \(fin \| syn \| rst \| ack\) == syn \
> > +			meta mark "$m" accept
> 
> [Severity: Medium]
> Since this rule doesn't have a counter statement, does it become entirely
> dead code?
> 
> Because the SYN packets it matches are accepted anyway by the broader rule
> below (`meta l4proto tcp meta mark "$m" accept`), omitting the counter seems
> to eliminate the debugging capability mentioned in the comment. Should a
> counter be included here so the rule can still provide packet counts for
> manual inspection?

The --sync rule counter is not checked anywhere in the script. If someone
want do a manual inspection, they can do it manually in the script. So I
think there is no need to add counter for the debug rule.

Thanks
Hangbin
