Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601486A33B
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309170; cv=none; b=MhhF+vPZiOJ1K+jopNByKkc8YMn/EUKdPCKmKB4vuBSxOV7bLyP4qTXCRgxE630Odgq0rj7AI8rusEoGMLe5t8CRcvZm2UrYxolhrB6WcxfFzmnhIx6xB8PQW2vSGuRZ+nlzLFYXdDxqQIYb3b0mIFw2fpNI0uYoFPO3sIO/7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309170; c=relaxed/simple;
	bh=p9WHywZI24Fildn2GPLGf6ir94XJ/iOpoZgFxFMM7R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh0HC2D6W6LOWQVbXaLQcgdplmSd9ebpaKgkGVvS/pxt8/aB/x8WzpJ0oqa0CtLxL5IkPz3wRxrQSEb8b71gr/j0L3XYRQAsNJM9mLfwSHQ9UJLemIE7PHGjC+L7C98MvgbblMgfbbGFlgQfN5U6IqRu7hXc82Kur569AmCA6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wl8lRYwD; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wl8lRYwD"
Date: Wed, 5 Nov 2025 10:19:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762309166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdn7v38w0+gSQZKgM3IZaxpEy/2Ezk8c4VWoDM8z5aA=;
	b=wl8lRYwDYyx8xX5Tlc6SV8Lhj6g+6lWV3uYbytqEjfLOm378U3qvFMOVtijkhCD+DI0EFU
	vzSOPFdeF+UjkKXkllMTS7PVlODVDGffmz11SwV+tSak4wia/TOSKrIr/aZlyDFOFrnnKH
	2K+wM2mQc3/0AMns9Z41rYKhkLT+WJE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Subject: Re: [PATCH, mptcp-net] mptcp: fix address removal logic in
 mptcp_pm_nl_rm_addr
Message-ID: <aQq0I6O0SC9dHhU2@thinkbook16p>
References: <20251104123416.395362-1-gang.yan@linux.dev>
 <bde9ef49-25c6-4892-8952-917ce5ff54a5@kernel.org>
 <aQqy3mG3hwlwRcck@thinkbook16p>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQqy3mG3hwlwRcck@thinkbook16p>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 05, 2025 at 10:13:56AM +0800, GangYan wrote:
> > On Tue, Nov 04, 2025 at 03:34:38PM +0100, Matthieu Baerts wrote:
> > Hi Gang,
> > 
> > On 04/11/2025 13:34, Gang Yan wrote:
> > > From: Gang Yan <yangang@kylinos.cn>
> > > 
> > > Fix inverted WARN_ON_ONCE condition that prevented normal address
> > > removal counter updates. The current code only executes decrement
> > > logic when the counter is already 0 (abnormal state), while
> > > normal removals (counter > 0) are ignored.
> > 
> > Good catch!
> > 
> > For fixes, we need a Fixes tag:
> > 
> > Fixes: 636113918508 ("mptcp: pm: remove '_nl' from
> > mptcp_pm_nl_rm_addr_received")
> > 
> > Apart from that, it looks good to me:
> > 
> > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > 
> > How did you find out about this? I'm surprised out test suite didn't
> > spot it. By chance, do you have a test that can be used to reproduce
> > this issue?
> 
> I've been looking into the work_pending-related issue described in
> #ISSUE 440 and have designed several potentially affected scenarios
Sorry for the wrong number of issue, it should be #ISSUE 549.
> based on mptcp_join tests. Except for the case where endpoints are
> deleted one by one and then re-added via ADD_ADDR (which fails), all
> other related tests have passed. (I'll share some conclusions in the
> corresponding discussion later.)
> 
> By tracing the relevant code, I found that the value of
> 'add_addr_accepted' here does not decrease, which subsequently blocks
> further ADD_ADDR operations. We can verify the value of
> 'add_addr_accepted' in 'delete re-add signal' test, which can be found
> in mptcp_join.sh, using either 'ss' or 'mptcp_diag'. The reason this
> test didn't fail previously is that when the 'add_addr_accepted_limit'
> was set to 3, the test's add_addr operations never reached the limit,
> so no overflow occurred.
> 
> I lean toward using 'ss' to obtain the token and then retrieving the
> 'add_addr_accepted' value via 'mptcp_diag', because when the value is
> zero, ss does not display it. Moreover, using 'mptcp_diag' minimizes
> potential inconsistencies caused by different versions of iproute2,
> making maintenance easier. WDYT?
> 
> Thanks,
> Gang
> > 
> > Cheers,
> > Matt
> > -- 
> > Sponsored by the NGI0 Core fund.
> > 
