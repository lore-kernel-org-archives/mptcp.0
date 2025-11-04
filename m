Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5D2FDC53
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241355; cv=none; b=EvjuNM9dRSdkx88xvEQipHaYub2/Jj+5vpJDeJmF6e16iTrC841MomUQjBXwhxrKDCzbRKhiUqL9MYfF/nuZ1AwMxcZvWs+tQ9IStjScHGygyWnRUSs/em5sKaMiFFwX0H5y30RD+HS+bCXLLZFa/4RMLkogR41x/8dXvITmRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241355; c=relaxed/simple;
	bh=5op/CBb0f/9Bq9ei7hEEdQZmNnrfK2bxgaod7+399Hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQ2AIZiBpoq+x/TPNFyCV08VP4a4TC8yWlDRyUpRIr5qz0tuZ54vp0aAh/p7fm/RAtoO/ZIgoZMFIkHWc9dnALZAcOUsn+IYrh4E4xG5vPeD5j0S4Ofsc90EbUTOaMBKLGtB6rXBzN+iQbKEN4yiE05EsJQ8gRjRQYlnoSLcm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcjstwa9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcjstwa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61858C4CEF8;
	Tue,  4 Nov 2025 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762241355;
	bh=5op/CBb0f/9Bq9ei7hEEdQZmNnrfK2bxgaod7+399Hc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bcjstwa95GkwJwXUFioSb7UAF+/8fPcVca/pthyim5PEATymF6OHwAc+SnDwKrg1v
	 4MdUlcUbkvtFNZX7wL1NKH9+DnpoEuKVetgfwNoeP+/CdqIHhbhoi3L7CX++Xaq0Ei
	 fTfgY2jYPPtAhdBfEuUI5UWo/Ay5gAhmgU0PMU+/MfMTpeyz66XkQOUUzZLzt6zvjQ
	 IUYymF8FFWUiHoGMcvZvl/Y4FI+Ha1n91hcpyRv69rnu/hgr+GuxxJK/vUoHaIur5o
	 8TF2UTW8SeJ/VIMm5aVbwz80cw7Neu0BvH5QC/BzgaRVR3MSSeA1MXXOSgq4PiIETt
	 eGDxy/mO47Avg==
Message-ID: <c707d12083543db56fa5b2f361837d1c29931c58.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/6] selftests: mptcp: join: rm: set backup
 flag
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Tue, 04 Nov 2025 15:29:10 +0800
In-Reply-To: <21daa38d-d335-4d62-b247-472629ee54dc@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
	 <20251102-slft-join-inst-v2-2-b4f3ba15a7c4@kernel.org>
	 <1d91f6b378b430088d81c2a5a1d33c678fc81cac.camel@kernel.org>
	 <21daa38d-d335-4d62-b247-472629ee54dc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2025-11-04 at 07:57 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review.
> 
> 4 Nov 2025 07:06:34 Geliang Tang <geliang@kernel.org>:
> 
> > Hi Matt,
> > 
> > Thanks for this fix. It works indeed.
> > 
> > On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
> > > Some of these 'remove' tests rarely fail because a subflow has
> > > been
> > 
> > In my testing, only the "flush addresses" test case fails
> > intermittently. I'm wondering which other test cases have failed in
> > your environment?
> 
> I took the unstable ones from the Netdev and MPTCP CIs:
> 
> https://netdev.bots.linux.dev/contest.html?pass=0&executor=vmksft-mptcp-dbg&ld-cases=1
> 
> https://ci-results.mptcp.dev/flakes.html
> 
> > I'm thinking we shouldn't add the "backup" flag to every test in
> > remove_tests, but only to the specific ones that are actually
> > failing.
> > 
> > Similarly for patches 3 and 4, we don't need to add
> > "test_linkfail=128"
> > to every test. We should only apply it to the specific ones that
> > are
> > actually failing.
> 
> If my analysis is correct, it means the simple fixes I did (backup
> and
> longer file size) can be applied to multiple tests. Then probably
> better
> to avoid these other tests to fail for the same reasons even if it is
> very
> rare, and very hard to reproduce, no? Each false positive takes a lot
> of
> resources (mainly time) to debug.

I'll leave it to you to decide. However, I still believe it's better to
apply these fixes to the tests one by one, in case we see failures in
the future.

I'll respond with my Reviewed-by tag in the cover letter.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> 

