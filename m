Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECC364046
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497925; cv=none; b=JX1Fw0xq3MBB1lf+hzoRo+gOjabYRXXBYBOW47XDeN2PUzaKqPae/B9Ci/xwulTnkIeHbw1CdVYoIRy5mfQhOwLRVT3EFrv8ZGfr7raCBTuO1GXsLgYSGo8VG/XvJHz2MmHbG+EC9o8oocYfoNZBizvUenQAKQ2X1FXZyRhvwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497925; c=relaxed/simple;
	bh=p1bkrRQJFj4l5TJxYvymvdxsj7WCN+gpR1N4ONoIlZc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=my9g5/50xms/mkWB9PB1/NN9aTwceiOa42VfaxP6OpuiIWxxFOA3UKHPvuD+oiqaNhCAAPKro8iqyrSYJDdpWEr1HKAwRRo3drY2O1lHoPNZ3HOCVfyEraYNJG1BjNWkJTCzmftHuUWh3jfYa7d8AgwYQcyPmgOsShqCQz9xStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2oiOOxH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2oiOOxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89938C2BCFD;
	Mon, 11 May 2026 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778497924;
	bh=p1bkrRQJFj4l5TJxYvymvdxsj7WCN+gpR1N4ONoIlZc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=V2oiOOxHcZbdHqZsU29govMiIuYtmyWg685GMfIZps8nlAOQdA9W9YwyQBJcYQu7q
	 ovrE56pyBNoGrRL15hoL47yr9/egYoeiCEfmIwbcI4v9/Xxnlnh6uM1nmsGO/DyMjT
	 1RgvNd+NctB4SsDXX8pxtw2uWOtRCJqEA+0BZuNlL1sH2WphRxKu4bVELYDvZUXgwx
	 XBB9rOcLwPjZ5XFjql4nCVLDaHIcr8nmd7hM7+k7g4cTLcVDBb+OETDIc1YELNnBBA
	 5Dt1vO5yDjB0MH58yk1nBQf9ztP4yVAolJdQToCDKgWncro4HKxWZmneErXK3JiPW0
	 b4+S8IyANFAIQ==
Message-ID: <aca5067c398256e04dfae42451a82d42afc7c031.camel@kernel.org>
Subject: Re: [PATCH v3 mptcp-next 00/10] mptcp: address stall under memory
 pressure
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, gang.yan@linux.dev, Matthieu Baerts
	 <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 11 May 2026 19:11:35 +0800
In-Reply-To: <c20f907e-4727-4814-86a9-38a08cd77ae1@redhat.com>
References: <cover.1777908248.git.pabeni@redhat.com>
	 <cc137cc2-718f-41e9-aabd-e65b9fbfd4ee@kernel.org>
	 <47cae42a6de0745a423098d1b15bdd71dc2937d6@linux.dev>
	 <c20f907e-4727-4814-86a9-38a08cd77ae1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Mon, 2026-05-11 at 10:29 +0200, Paolo Abeni wrote:
> On 5/9/26 9:07 AM, gang.yan@linux.dev wrote:
> > May 8, 2026 at 6:49 PM, "Matthieu Baerts"
> > <matttbe@kernel.org mailto:
> > matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel
> > .org%3E > wrote:
> > > 
> > > Hi Geliang, Gang,
> > > 
> > > On 04/05/2026 17:39, Paolo Abeni wrote:
> > > 
> > > > 
> > > > This an attempt to fix the data transfer stall reported by
> > > > Geliang and
> > > >  Gang more carefully enforcing memory constraints at the MPTCP
> > > > level.
> > > >  
> > > >  Patch 1/10 moves the bound check before entering the TCP
> > > > socket.
> > > >  Patch 2, 3, 4 and 5 are cleanups/refactors finalized to safely
> > > > re-using
> > > >  TCP helpers on MPTCP skbs.
> > > >  Patch 6 makes TCP pruning related helpers available to MPTCP
> > > > and patch 7
> > > >  makes use of them. Patch 8 addresses an edge scenario that
> > > > could still
> > > >  lead to transfer stall under memory pressure.
> > > >  Finally patch 9 and 10 improve the MPTCP-level retransmission
> > > > schema to
> > > >  make recovery from memory pressure significanly faster.
> > > >  
> > > >  Note that the diffstat is biases by the quite large patch 4/9,
> > > > which
> > > >  contains mechanical transformation of existing code; "real"
> > > > changes are
> > > >  noticiable smaller.
> > > >  
> > > >  Tested successfully vs the test cases proposed by Geliang and
> > > > Gang and
> > > >  vs the selftests.
> > > > 
> > > At the last meeting on Wednesday, Geliang mentioned he validated
> > > this
> > > series. Just to be sure, was it the v2 -- from last week -- or
> > > the v3 --
> > > from this week, while you were in EU -- that you validated?
> > > Because
> > > Paolo couldn't reproduce the issue you mentioned on the v3 on his
> > > side.
> > > 
> > Hi, Matt
> > 
> > The issue can also be reproduced on v3. I reproduced it using
> > Docker's
> > auto-debug mode with the mptcp_data.sh selftest:
> > 
> > ‘’‘
> > 	Not running all tests but:
> > 
> > -------- 8< --------
> > run_loop run_selftest_one mptcp_data.sh
> > -------- 8< --------
> > 
> > 
> > 
> > 
> > 	=== Attempt: 1 (Sat, 09 May 2026 06:55:44 +0000) ===
> > 
> > 
> > Selftest Test: ./mptcp_data.sh
> > TAP version 13
> > 1..1
> > # add_addr_accepted 4 subflows 4 
> > # id 1 flags signal 127.0.0.1 10001
> > # id 2 flags signal 127.0.0.1 10002
> > # id 3 flags signal 127.0.0.1 10003
> > # id 4 flags signal 127.0.0.1 10004
> > # TAP version 13
> > # 1..48
> > # # Starting 48 tests from 2 test cases.
> > # #  RUN           global.mptcp_v6 ...
> > # #            OK  global.mptcp_v6
> > # ok 1 global.mptcp_v6
> > # #  RUN           mptcp.shutdown_reuse ...
> > # #            OK  mptcp.shutdown_reuse
> > # ok 2 mptcp.shutdown_reuse
> > ...
> > # ok 48 mptcp.sendfile
> > # # FAILED: 41 / 48 tests passed.
> > # # Totals: pass:41 fail:7 xfail:0 xpass:0 skip:0 error:0
> > not ok 1 test: selftest_mptcp_data # FAIL
> > # time=33
> > ’‘’
> > 
> > As Geliang mentioned in the weekly meeting, we will continue
> > to debug and locate the problem based on Paolo's v3 patches.
> 
> Thanks for testing. I went over a couple more revisions. I run more
> than
> 100 iterations successfully on a local build on top of v5 (no
> failures,
> I stop due to time constraints):
> 
> https://lore.kernel.org/mptcp/f00bdac0-b544-87b8-2ef4-ca4de0f045de@gmail.com/T/#t
> 
> please have a spin as such later version.

On v5, mptcp_data.sh works fine in normal mode with the virtme docker
image, but in debug mode it's still unstable - failing after several
loop iterations.

Thanks,
-Geliang

> 
> Thanks,
> 
> Paolo
> 
