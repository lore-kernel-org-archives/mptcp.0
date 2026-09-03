Received: from mta1.migadu.com (out-144.mta1.migadu.com [95.215.58.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74043F7877
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417343; cv=none; b=ZBdhvsewJ5NREspveWJj6o3wLqMg6DnZ6Gu3vt6Hqz1aI8Tr0WMZ0Yv0DpWmQWLBV9EPomd4Z+YqYVxAX+w32lf+yjXo48pfLmW+j76AX/TmNy9YyBOQHdZmZb19H4m/E5IWKzoMnwSds+jcSiXqbOBJeeJa/LG1k9XJCHcZCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417343; c=relaxed/simple;
	bh=GDHRmYGSxLU9y5qum6loaHbdBOmUI0ZNpWY0pzQOCAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXUvO4W6AMiZH/jLQzqMIEBfNojxfzRUJqCYmzgErWDNc1aReSe58PnvbH9y24SyVYfezSG2lBHs2rsRjNwhQsY8C2mE1JqN/nszIGDCYAAp4erlqQrEupRU5XszCOALhbxOILIfGJ3m6XbpkDQ18tb4rsmBmaxJ+0RLg9cC9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F4BmjkAU; arc=none smtp.client-ip=95.215.58.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F4BmjkAU"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=GDHRmYGSxLU9y5qum6loaHbdBOmUI0ZNpWY0pzQOCAw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788417336; v=1; x=1789022136;
 b=F4BmjkAUq4HpX6giNmEC2l8TzTUXTQbGw3uVPD8/GktqX5VUFUjWhwqnACVAF7QRAIaPOfZ5
 w7RtMYtaBbF/rS0UWUjlxDUajVh4lteD4jG4T6nM61AJJSEsGD0vXWVhWxRAIR+v0rfow+V/FlQ
 F8uKeu0EyXaIPzMKgJn5O4cQ=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d24e603535efbe3a;
	Thu, 03 Sep 2026 06:35:36 +0000
X-Mizu-Trace-ID: d24e603535efbe3a
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 14:35:26 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <apkVLlKisTGIS_n_@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
 <apjU-uM8dvxnVcaP@fedora>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apjU-uM8dvxnVcaP@fedora>

Hi Matthieu,

Here is some update.
On Thu, Sep 03, 2026 at 10:02:52AM +0800, Hangbin Liu wrote:
> > 
> > >  init_partial()
> > >  {
> > >  	capout=$(mktemp)
> > > @@ -147,6 +110,14 @@ init_partial()
> > >  		if $checksum; then
> > >  			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
> > >  		fi
> > > +
> > > +		ip netns exec "$netns" nft add table inet mjoin_table
> > > +		ip netns exec "$netns" nft add chain inet mjoin_table input \
> > > +			'{ type filter hook input priority filter; policy accept; }'
> > > +		ip netns exec "$netns" nft add chain inet mjoin_table output \
> > > +			'{ type filter hook output priority filter; policy accept; }'
> > > +		ip netns exec "$netns" nft add chain inet mjoin_table mangle \
> > > +			'{ type filter hook output priority mangle; policy accept; }'
> > 
> > I hope having this done by default for all subtests will not have a big
> > impact at the end when using a debug kernel. Do you mind checking the
> > impact, please? Just not to add a few seconds for each of the 130+
> > subtest if it is only needed in some of them.
> 
> It shouldn't, I will test the running time before/after the change.

With debug kernel + 4 cpu on my laptop, the time for iptables version is

real    35m44.460s
user    0m22.455s
sys     25m17.923s

The time for nft version is

real    43m37.393s
user    0m29.183s
sys     32m15.354s

I will find a way to only add the table when needed.

> > Also, maybe clearer to use 'nft -j' with 'jq' to get that (if possible)?
> 
> I check the output of `nft -j` (paste an example at the end of mail),
> which looks not each to get the rule handle easily.

I have find a way to get the handle via jq.

nft -e -j add rule ip filter OUTPUT meta l4proto tcp accept | \
	jq '.nftables[] | select(has("add")) | .add.rule.handle'

I will use it in the next version.

Thanks
Hangbin
