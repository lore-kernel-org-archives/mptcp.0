Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E62FA0C6
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736521; cv=none; b=bC4NHlz9+0f/Tl+ajVH1Hcq6GIhrQkjwGRCa0BafulVPHBIEgMQ9DEKVWCpOKY1CWQzYANF5zo7jWFYgwtUdpQq9S2c4uG5NHsM8tSHhM5WUpwuJOO6S/U7Wb1Gcz+xxVOLA4xh4whcVXKb+GW40UEm7kER6dcYGhIM8S4kdW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736521; c=relaxed/simple;
	bh=hsZwqTFeJz2g9lzDoXRrDPkpsxLhsmA9bGRCfMIBE7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJVwpXMYPGROEYRSvVPz9rgTWaeDGlsCtoqZXyp0i4BAex8SD3EEMh3Eh/wjCycn2DIwEzbPljI7mFmg09brnIA2ArQoadQkAkWUjIjIvdBqt8rTjA9WfXMYWTrmDm4eB0u1VtGP7K3wEFculsQQulE/X3t9g7nWSV/iOKaYUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b0nVwRIn; arc=none smtp.client-ip=91.218.175.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b0nVwRIn"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=hsZwqTFeJz2g9lzDoXRrDPkpsxLhsmA9bGRCfMIBE7g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790736517; v=1; x=1791341317;
 b=b0nVwRIntDBm1odY6bAn1U2duT+HTVE8fQkuW0GsQuxV5Ei2fYvLVrprjckshVC/MQCY3jga
 2qBBp+oDr+X1EOfKPZ/gOYFbusTacEerf+s9jw7ZgLzj8yaEmRhy1jPhY5ShM5UZVuFsAGyTpuY
 HdHxK+CBTivXz4J/3mJ0GkrY=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 8804b216241e0b16;
	Wed, 30 Sep 2026 02:48:27 +0000
X-Mizu-Trace-ID: 8804b216241e0b16
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 10:48:18 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
	martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, quanyeyang@proton.me
Subject: Re: [PATCH net-next 5/5] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <arx4cn3ZPDtuUNBM@fedora>
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-5-67af4ab37406@kernel.org>
 <179058242453.3145.1450534124183352369@kernel.org>
 <deb5e3b3-d1d7-4d1e-8bb6-95050769d656@kernel.org>
 <4278a970-2957-4387-8f20-604ae4ae97e9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4278a970-2957-4387-8f20-604ae4ae97e9@kernel.org>

On Mon, Sep 28, 2026 at 11:17:59PM +0200, Matthieu Baerts wrote:
> On 28/09/2026 13:24, Matthieu Baerts wrote:
> >>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>> index 18ce7136a2b0e..b16e24418e737 100755
> >>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>
> >> [ ... ]
> >>
> >>> @@ -4402,12 +4372,10 @@ endpoint_tests()
> >>>  
> >>>  		# To make sure RM_ADDR are sent over a different subflow, but
> >>>  		# allow the rest to quickly and cleanly close the subflow
> >>> -		local ipt=1
> >>> -		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
> >>> -			-p tcp -m tcp --tcp-option 30 \
> >>> -			-m bpf --bytecode \
> >>> -			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
> >>> -			-j DROP || ipt=0
> >>> +		local nft=1
> >>> +		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
> >>> +			ip saddr 10.0.1.2 meta l4proto tcp \
> >>> +			tcp option mptcp subtype remove-addr drop || nft=0
> >>
> >> [Severity: Medium]
> >> Can this rule ever match an RM_ADDR packet on an established connection?
> >>
> >> nft_exthdr_tcp_eval() stops at the first TCP option whose kind matches
> >> (30 for MPTCP). The subtype check therefore only ever sees the first
> >> MPTCP suboption:
> >>
> >> net/netfilter/nft_exthdr.c:nft_exthdr_tcp_eval() {
> >>     ...
> >> 	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
> >> 		optl = optlen(opt, i);
> >>
> >> 		if (priv->type != opt[i])
> >> 			continue;
> >> 		...
> >> 		return;
> >> 	}
> >>     ...
> >> }
> > 
> > Indeed, the RM_ADDR will be added in a second MPTCP option. It looks
> > like Netfilter doesn't handle that case. But that seems to be an issue
> > on the Netfilter side, rather than with the command that should work. I
> > will follow up with Netfilter devs. If a fix cannot be added on their
> > side, I will change the nft command to look at a specific offset.
> > 
> > Note that the command here is just to check there is no RM_ADDR sent on
> > the wrong side: it shouldn't catch any packets here anyway.
> 
> After a discussion with Netfilter devs, it looks like a fix will not be
> easy to have. Yet, I wonder if it wouldn't be better to apply this patch
> like that (it doesn't break things), and have an explicit follow-up/fix
> to document this issue somehow.
> 
> @Hangbin: do you plan to look at a fix for that? I guess a raw payload
> looking at the same fields as what the previous cBPF rule was doing
> would be enough.

Yes, I will add this on my todo list and fix it after holiday.

> 
> Don't hesitate to fix the "low" priority comments as well.
> 
> https://lore.kernel.org/all/20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org/T/#u

Sure, I will.

Thanks
Hangbin
