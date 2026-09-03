Received: from mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC532B130
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401750; cv=none; b=t6Z9+kVzBkzwtKXfZHGxR7Ay6XyFRf/YmUMI7a2EGGy8R7DmmNE/1Ezgs0LPUU73mbW3bexmGMxSY7KUABjrO+N1Llf36sW0J5VF/2de3OK+l1AqC12mtckRSbp2tCeRqNn2j499G+sREdaF9R/hQUrXiWxTlmV3X//HZBCA6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401750; c=relaxed/simple;
	bh=G34xxgRBmUeCrrkke6/zmw55SL1tojQfi33A55TotFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkXWrVbT+/n24ubzFBCa3mdWj+/5fk68HUqR6DC/w6JfLMTAViRdR8ZO5UFrh8vPh6/1eprKv3Y5+GKYPaIwBZsfyN+u56ILfar0va3Nd/DxZ6EX8oAXTrD1ET/kBNAU4dDQdm7KjVf6+agwqmGwTZgfrRmrPW+P29Vo8teUWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NnryLoMH; arc=none smtp.client-ip=95.215.58.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NnryLoMH"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=G34xxgRBmUeCrrkke6/zmw55SL1tojQfi33A55TotFk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788401744; v=1; x=1789006544;
 b=NnryLoMHCH5MB5L+wdVaBc2gzN6ossRcMyqJJS575vokGkFaIwu8MObJJiYzWBuIoHJqMmB+
 11c7UWAyKM9cyZD75bcITWH3lKfjo1vM/kF2GkCCqpz0eYZCiBETcaFJXZJebyk7wA2Rvi5VN2s
 CEIE7/L5uO4OPLwaI8cn/4J8=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 22d32196a450c1c8;
	Thu, 03 Sep 2026 02:15:44 +0000
X-Mizu-Trace-ID: 22d32196a450c1c8
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 10:15:31 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Message-ID: <apjYQ3bCkpT2Rb-X@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-1-559caa16f410@kylinos.cn>
 <5b5452db-f03c-4825-b9ae-91ca28bbcf03@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5452db-f03c-4825-b9ae-91ca28bbcf03@kernel.org>

On Wed, Sep 02, 2026 at 11:17:48AM +0200, Matthieu Baerts wrote:
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
> 
> Would it not be cleaner to use 'nft -j' and 'jq' to get all the
> (non-zero) drop counters?

We can get with this rule:

nft -j list table filter | jq -r '.nftables[] | select(has("rule")) |
				.rule | select (.chain=="OUTPUT" and any(.expr[]; has("drop"))) |
				.expr[] | select(has("counter")) |
				.counter.packets'

Thanks
Hangbin
