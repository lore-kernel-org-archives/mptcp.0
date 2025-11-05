Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239913D891
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308840; cv=none; b=H857UEzyXCCyaTJhzOqDWfw4vvwyYAVnsbn8IEAYFVVIKjEwmrsZ9SNW1CJXv9GkhFF2ga8wEjiV3IMqYk8Rc2t1N8oprMAG5xxxIHAeONWmviOQXqMr2vWddWeSbqNNmBAt6io6/ajsSzn5PWE9zLX4UdfUCnPuKWUZLCDxoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308840; c=relaxed/simple;
	bh=24oiNoJR6Ert99MR0rh6+xqy0X2l2tVX/evTHLGiBMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnVrPeUKhLjFFUt+eC+mfSshTe+bau8kAeziii7MVq3J2AyTiWYQAIOhHit0ss+ivOrAMAdvNqetsDvrFJxQJ1CED3gA19FD6TzbXPukCLIPc2upZnefOMqBHGiTVItJfw2EXIsw8Nzy8XAXyWbgwhBk4t74cXrcZbpIq85yvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HO8tknJh; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HO8tknJh"
Date: Wed, 5 Nov 2025 10:13:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762308836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SL4njtvaPQ7uHrNGzYSWUBSyookja9hKy0sEC9BAbqE=;
	b=HO8tknJhGv9uI751QmqrWu1BG2LBKC9/44M9sOLN+4HE2yKrPPo+BHTAEsHNMj6BX7DDyN
	QiCs6TFhFp2Ry1FOixozSBqD09VX9TIEhU0jvuxkkDjeUojcKRyjpBgV+HvaUCu7yWjFBs
	MK2HQVLa5B5Kpu4s7sTOaGX0JFO6A4Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Subject: Re: [PATCH, mptcp-net] mptcp: fix address removal logic in
 mptcp_pm_nl_rm_addr
Message-ID: <aQqy3mG3hwlwRcck@thinkbook16p>
References: <20251104123416.395362-1-gang.yan@linux.dev>
 <bde9ef49-25c6-4892-8952-917ce5ff54a5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bde9ef49-25c6-4892-8952-917ce5ff54a5@kernel.org>
X-Migadu-Flow: FLOW_OUT

> On Tue, Nov 04, 2025 at 03:34:38PM +0100, Matthieu Baerts wrote:
> Hi Gang,
> 
> On 04/11/2025 13:34, Gang Yan wrote:
> > From: Gang Yan <yangang@kylinos.cn>
> > 
> > Fix inverted WARN_ON_ONCE condition that prevented normal address
> > removal counter updates. The current code only executes decrement
> > logic when the counter is already 0 (abnormal state), while
> > normal removals (counter > 0) are ignored.
> 
> Good catch!
> 
> For fixes, we need a Fixes tag:
> 
> Fixes: 636113918508 ("mptcp: pm: remove '_nl' from
> mptcp_pm_nl_rm_addr_received")
> 
> Apart from that, it looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> How did you find out about this? I'm surprised out test suite didn't
> spot it. By chance, do you have a test that can be used to reproduce
> this issue?

I've been looking into the work_pending-related issue described in
#ISSUE 440 and have designed several potentially affected scenarios
based on mptcp_join tests. Except for the case where endpoints are
deleted one by one and then re-added via ADD_ADDR (which fails), all
other related tests have passed. (I'll share some conclusions in the
corresponding discussion later.)

By tracing the relevant code, I found that the value of
'add_addr_accepted' here does not decrease, which subsequently blocks
further ADD_ADDR operations. We can verify the value of
'add_addr_accepted' in 'delete re-add signal' test, which can be found
in mptcp_join.sh, using either 'ss' or 'mptcp_diag'. The reason this
test didn't fail previously is that when the 'add_addr_accepted_limit'
was set to 3, the test's add_addr operations never reached the limit,
so no overflow occurred.

I lean toward using 'ss' to obtain the token and then retrieving the
'add_addr_accepted' value via 'mptcp_diag', because when the value is
zero, ss does not display it. Moreover, using 'mptcp_diag' minimizes
potential inconsistencies caused by different versions of iproute2,
making maintenance easier. WDYT?

Thanks,
Gang
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
