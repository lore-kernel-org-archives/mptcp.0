Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8A1C69D
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 01:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788742951; cv=none; b=MLWPMBh0o7SfNwAEbgDTRuj3qs27QQEU7ppzUfzhVL255jV9RY+AY0sTYt8RD0u5rt4W5Av+EUnUT8L7AEG104baFg9JW9/swWD+pQApRn3xR8JJf/mRoNOHooBDSjtnYIV9wam1BjIp0c4rZ+Fr8hMgcbqhR81tg7JD5/WKxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788742951; c=relaxed/simple;
	bh=SfV6QDgVf6DvOknCQkN/9eze+UvnQkSqmdMzg0CJCCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i38bMG2hzAHM8dxHgdJYe1nUn/O71GCRAcvZP3qupyWSqozpj3DvcIrn6lZ0T2LabbY6++0wS2ZBhUrq9TWb46Hw9D4oHVhxCnOmQ/9SAN/bEy8uPfGOfTeU4jAH8fD2Hb+GF/Ms+UfUE7dfduysmeWCM90uKpf4jsvw5Nmcl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XKCDDU4r; arc=none smtp.client-ip=95.215.58.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XKCDDU4r"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=SfV6QDgVf6DvOknCQkN/9eze+UvnQkSqmdMzg0CJCCY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788742945; v=1; x=1789347745;
 b=XKCDDU4r50HqKaEEyUSUq+Y79JgoXnKyNS9FcG8nUBojcoV6FJHwOyVASejfu6VtHe6kA3Jr
 y16Kl+oawU/rSOWyweXtL2ZCwx1wtCvY9pIpgFsUXQe9vOK8cr/mY+kE2yu4lCSE/k7Mb9Alecf
 w418eHIRARnCUqGjO1Jj/ln0=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 4e247f08395d6353;
	Mon, 07 Sep 2026 01:02:15 +0000
X-Mizu-Trace-ID: 4e247f08395d6353
X-Migadu-Flow: FLOW_OUT
Date: Mon, 7 Sep 2026 09:02:10 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <ap4NEvXYLC1U8hqO@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
 <apjU-uM8dvxnVcaP@fedora>
 <6c9dd599-e9d2-470f-bc7f-2af2e9d003b6@kernel.org>
 <app68h1_rYkPBpvn@fedora>
 <aa5678f7-7089-4049-9120-6604372667ac@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5678f7-7089-4049-9120-6604372667ac@kernel.org>


Hi Matthieu,
On Fri, Sep 04, 2026 at 06:40:02PM +0200, Matthieu Baerts wrote:
> > 
> > Yes, if not in purpose, I feel flush the whole table is dangerous.
> > Some rules may still in using in later testing.
> 
> Indeed. But in our case, each subtest uses a dedicated netns. Plus only
> some tests add Netfilter rules. At the end, it is clearer to delete a
> specific rule, but I think that makes sense only if the nft_handle var
> is set locally, and used a few lines below.
> 
> If a global nft_handle var is used, that doesn't seem clear, and I think
> it would be clearer/easier to:
> 
> - either delete a specific rule (but I don't think that's supported)
> 
> - get the handle from the test and use it to delete the rule
> 
> - or flush the table.
> 
> So up to you, but probably best to avoid using nft_handle as global var.

Thanks, endpoint_tests is the only test that could delete iptables rules.
I use the nft_handle mainly because the iptables also delete rules with
specific match (iptables -D OUTPUT -s .. -p tcp -j REJECT) other than flush
the table directly.

endpoint_tests
  - reset_with_tcp_filter
    - iptables -D
    - iptables -I
    - iptables -D
  - reset_with_events
    - iptables -I
    - iptables -D
  - reset_with_tcp_filter
    - iptables -D

While from the logic it should be safe to flush the tables. I can avoid the
nft_handle in v4 (after v3 review). Just one question, why we use
iptables -I here? Is there any intend? If not I will use "add" instead of
"insert" in nft rules.

> > However, I cannot perform a reset on the b4 branch, and git rebase also failed.
> > These steps have blocked me a little. I have to manually recreate the b4 branch,
> > or perhaps avoid using b4 when working on mptcp changes.
> 
> You need to use `|git rebase --onto` instead, e.g.
> 
>   git fetch origin  # adapt here and below if needed

For export branch, I think git fetch is not enough? I have to reset
to latest net/net-next merge commit and pull on that.

>   git rebase --onto origin/export "$(b4 prep --show-info base-commit)"

Yes, it works! New git usage learned :)

> 
> Can you check if it works for you, please? (so I can update the wiki
> page if needed)
> 
> The alternative is to use `for-review`, with a continuous history, see:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/wiki/Git-Branches

I will try this tree next time

Thanks
Hangbin
