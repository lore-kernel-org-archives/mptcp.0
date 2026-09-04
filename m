Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969F44238C
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514395; cv=none; b=ojRyS4gtFK2T52NxWpehTpvCRU5HK4obh2tQPOUyy/URKurWYZ53WKCmKu9xKZaq3TLJfcmntPOAUG7GSo8JuENLhDI4NMkhLATxEEw38ifvGGOPBYmyflTw6gWhni08KqeCD/BUQyNLBjQowwaRMtQRsLBi8y1FQLCOhHwAL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514395; c=relaxed/simple;
	bh=9ZvD/FschNKJZxanPexYeygKVAqpXY2hL4PqGsRH00A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4E+XOMEVNcBGpRFlJX1epaO7g6BHynoYzZJ1f1jXM90JDMGbDqgBgPH7RJ6R0EvJMbPzN+E8FJATh8lLU7+G/8wgQuaDmGYUPIw03e0wYZ+OnaDKl2e0rv321R0LMvngP0Jxt39ycoR8vQoLvOUwh4R49Nh26vkXjE8B+QQoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhqX9dgU; arc=none smtp.client-ip=95.215.58.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhqX9dgU"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=9ZvD/FschNKJZxanPexYeygKVAqpXY2hL4PqGsRH00A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788514390; v=1; x=1789119190;
 b=nhqX9dgUIVKin3UnbjXg0VreHnSDgadq7uQ/cxBdKS7A3MQs1UBFfGNm5tykczeL9oGYYalB
 udyhXGOz7K5IWLeHPewe+zNo1sKasmhRFSIrcaDeQudpc9gxKeytyHrgfMClGAGtN94MRTgY7Wm
 GegSJOKGwifiErvatkr88cdc=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 843e076f61d57e67;
	Fri, 04 Sep 2026 09:33:10 +0000
X-Mizu-Trace-ID: 843e076f61d57e67
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 17:33:03 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <apqQT8TAR4gRvl1F@fedora>
References: <20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn>
 <20260904-mptcp_nft-v3-2-4abedaf00bf9@kylinos.cn>
 <20260904074206.C41951F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904074206.C41951F00A3D@smtp.kernel.org>

On Fri, Sep 04, 2026 at 07:42:06AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing 'add' keyword in nftables configuration script causes syntax error, silently skipping tests.
> --
> 
> commit 45eaf6e2e654e036380de79d25fbc989c2055da7
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> selftests: mptcp: convert iptables to nftables for mptcp_join.sh
> 
> This commit replaces the iptables/ip6tables setup with nftables in the
> mptcp_join.sh selftest. It introduces a new init_nftables function to setup
> the nft tables using a heredoc rather than configuring them inline.
> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 18ce7136a2b0e..835cb92cab1a4 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> 
> [ ... ]
> 
> > @@ -184,6 +147,28 @@ init_shapers()
> >  	done
> >  }
> >  
> > +init_nftables()
> > +{
> > +	nft_handle=""
> > +
> > +	local netns table
> > +	for netns in "$ns1" "$ns2"; do
> > +		for table in ip ip6; do
> > +			ip netns exec "$netns" nft -f - <<-EOF
> > +				add table $table filter
> > +				add chain $table filter INPUT \
> > +					{ type filter hook input priority filter; policy accept; }
> > +				add chain $table filter OUTPUT \
> > +					{ type filter hook output priority filter; policy accept; }
> > +
> > +				table $table mangle
> > +				chain $table mangle OUTPUT \
>                                 ^^^^
> 
> [Severity: Medium]
> Are these table and chain declarations missing the "add" keyword?
> 

Ah, copy‑and‑paste error. But the test passed when I run it.

After investigating, I found the interesting usage for nft. Both

nft -f - <<-EOF
add table ...
add chain ..
EOF

and

nft -f - <<-EOF
table ...
chain ..
EOF

Works!

Anyway, I will sync the writing in next version (if have) to not miss-leading
others.

Thanks
Hangbin
