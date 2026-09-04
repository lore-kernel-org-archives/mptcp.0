Received: from mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333DB31197C
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508930; cv=none; b=tcaGEDVSh5jZzCEvx/Ax5jwQs1rmuef1VgESPfMazwmGMn1xThgYNNvs5p5446waQDOaRcPM9pGZfLRcFwUubW07IBVpT916MXxhE4faIOvb6oLoSiSAS7oKtUufLR2eE3dCgx/GeHnTSaEMEIn1t8FRMyBx4YlFA6Xo3+pnOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508930; c=relaxed/simple;
	bh=LR62VJEKk07W/pgXn6Dgk5a9R3BtoeQgt9lU9tB5xMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGnMU6djXKDomsGL71U6haYfBcb1V04rv6Nb9Pfq/N8KhB025bIECOmkJYcH/m/eao7F5cUFCMW80zDGLBDFxyaCJOaZcwNhCkty1f+wlJrZJRIZ5t8PEaWcDuwnjyA4y58dWfvVGTcTXzLRrKdTjkeUAfiuW91Crll/LtVlXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=el0Xi/lx; arc=none smtp.client-ip=91.218.175.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="el0Xi/lx"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=LR62VJEKk07W/pgXn6Dgk5a9R3BtoeQgt9lU9tB5xMU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788508922; v=1; x=1789113722;
 b=el0Xi/lx0j+2WhwSartjsYoYY90Q/Rx+HnRdsJ7fceoBh1FkTjsbdLhCF+dfhBfst3GhwysX
 CMw8WSsVHBTeRSxIaop4yFeqOgpVukjl4YKDOfxg8ml8jRRXWIlu2FgAC4fraARSedeZxY8VVa3
 wkuF6/TiwRW2pnpQMbJS+rQM=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c25acbcfaf354676;
	Fri, 04 Sep 2026 08:02:02 +0000
X-Mizu-Trace-ID: c25acbcfaf354676
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 16:01:54 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <app68h1_rYkPBpvn@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
 <apjU-uM8dvxnVcaP@fedora>
 <6c9dd599-e9d2-470f-bc7f-2af2e9d003b6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c9dd599-e9d2-470f-bc7f-2af2e9d003b6@kernel.org>

On Thu, Sep 03, 2026 at 11:28:28AM +0200, Matthieu Baerts wrote:
> Hi Hangbin,
> 
> On 03/09/2026 04:02, Hangbin Liu wrote:
> > Hi Matthieu,
> > 
> > Sorry, My mbsync has some delays and I post v2 too quick before catching
> > your feedback.
> 
> No problem.
> 
> Just in case, maybe korgalore can help?
> 
> https://people.kernel.org/monsieuricon/tracking-kernel-development-with-korgalore

Thanks, learned a new tool.

> >> If you don't need this one (or any set in helpers), don't set it/them,
> >> and don't use a global variable. Or reset it in init_partial, but prefer
> >> using local variable with a limited scope.
> > 
> > Yes, we don't need the handle in other place, which I will remove them.
> > But for endpoint_tests(), after adding rules in reset_with_tcp_filter,
> > we need to remove the rule outside. I will reset it after each test.
> 
> Perhaps you could flush the whole table instead? But if it makes more
> sense to assign this variable, fine by me.

Yes, if not in purpose, I feel flush the whole table is dangerous.
Some rules may still in using in later testing.

> > Thanks for the notes. I used to rely on `b4 auto-to-cc` too much...
> 
> Most of the time, that's fine. It's just for some subsubtrees where
> (urgent & simple) fixes can go to the parent tree (netdev here)
> directly, but the rest can go only to the subsubtree ML.
> 
> BTW, if you are on top of our export(-net) (or for-review(-net)) branch,
> there is a .b4-config: you just need to use 'b4 send' then :)

Thanks. I am working on top of the export branch. I ran into a small issue
while using b4. The export branch is not fast‑forwardable. I used
`git reset --hard` to fall back to the top merge commit, then ran
`git pull` to fetch the latest changes.

However, I cannot perform a reset on the b4 branch, and git rebase also failed.
These steps have blocked me a little. I have to manually recreate the b4 branch,
or perhaps avoid using b4 when working on mptcp changes.

> 
> > An example of `nft -j` output:
> 
> Thanks for the output!

I have post the new version, which use jq to get the handle now.

Thanks
Hangbin
