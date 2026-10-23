Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717551;
	b=0Raf6I9nUr2yuFfeKC72qWMBwJJzRbBaskWotWSMq+VBvQI6GrXPERtfXjHtJPLpYuwL
	 lqKOA4G9aHyJfaCrcNemeV60g/VUxwMxeQCT5EBoSAuX8XbarkPQF61lyVqEUEx8b1vXm
	 4Y4khsZL01p4r+roD6pgfwKIhogmR9neGGLjFICihFgkkh9QTtoqPKJEL/8pxE2MFGnOu
	 jb4RyR4o2gGBUKGu4pyIIEKExEH9nDqK7ojDn5C9u3T+LA3AbrZoL99jkvdNxNOrHIGtH
	 diTiwgjRNXFGVns+loihRW51gBZcGVrhXwwX3r5JRQs1CMl/BqEzXQVjim42YmkchSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717551;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7gITHsLJGrhoXPvLv0qeEFZR2Pz9tkRqEq+0nKRC7vE=;
	b=CPIFZ2vcclSw7R3tpWSqIWv9iJcEdZefe4jKFdxSomEs4U954sFpfC5vCSthWMTC+fGD
	 +2jy9kr0zG/7UXmDbGRnTt00A+PBCi6IFYCd7nhXuJNOmku61tXueq4/c9jp7nuA9+qa7
	 +zqIlM+wT1z+mhNqIUEb/baiIOaVxoDquwzEgC6C10JTfGk7/tPEZUFJH/xInNeCpj6Yb
	 dlyzWqyC1VX9S7bp0lHisl+1Me9LPLHtsk5pDn2rm6Cf5HXbJzA9C9+b6xpAMLzWBhPXp
	 o0QDShsBYK0VLMypC5ekibpCpPCFqrRmVWu858UHccxiEnr35hLM5rJFtiR/59e/onQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4KthTlr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9D606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4KthTlr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD5B1F01825;
	Fri, 23 Oct 2026 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717551;
	bh=7gITHsLJGrhoXPvLv0qeEFZR2Pz9tkRqEq+0nKRC7vE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=j4KthTlryd5vAdIhCx/hfNF8oLJ3+VC9BoOMhzWL5IJeN+Cmd+t7gwCmmdf7KM6KF
	 WCnPXuA5zef7KKDPQ1C5tLqltq2W2gclnCVVJ6N7yO5yqb/MvIzh+dy+Y5sYwjUNAH
	 nO9ZhXRG0BDdX926YRKmHB+4iJJLiYyMrjZihTer5ge8aR2WFcaR0c7VjvBrCe3e1Z
	 E6EWZ9kkrZoucD7L1VwMSwYyWfJG4ewJXu2FWzqOT66DaNQ51Umc6o7NhNqebEIDkl
	 9+QZ54s77BJDA8hwj2RT/sZaLyZvE/8DpZCNoeedp0dGMgGrxkxJcGwOH/7/aA59pD
	 lfa5AD7IxxeZQ==
Message-ID: <758fc944eb96407a0d761ff84679ee5066cf836e.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2] selftests: mptcp: sockopt: pass total
 bytes to do_getsockopts
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, quanyeyang@proton.me, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 23 Oct 2026 09:05:47 +0800
In-Reply-To: <d16ffc4a-d8af-4b8d-b112-ce83736b9c3b@kernel.org>
References: <20261016-fix-mptcp-issue-638-v2-1-cc32774a8b0c@proton.me>
	 <d16ffc4a-d8af-4b8d-b112-ce83736b9c3b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt, Quanye,

On Thu, 2026-10-22 at 13:06 +0200, Matthieu Baerts wrote:
> Hi Quanye,
> 
> On 17/10/2026 07:33, Quanye Yang via B4 Relay wrote:
> > From: Quanye Yang <quanyeyang@proton.me>
> > 
> > connect_one_server() reads the echoed payload in a loop because
> > read()
> > on a stream socket can return a partial chunk. After the loop, it
> > still
> > passed the last read() return value to do_getsockopts() instead of
> > the
> > accumulated byte count.
> > 
> > do_getsockopts() checks MPTCP_INFO first. The client samples
> > mptcpi_write_seq before write(), and write() has already advanced
> > msk->write_seq by the full length, so a partial last read() makes
> > the write_seq assert fail. Pass the total instead.
> 
> Thank you for the patch, it looks good to me.
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I just applied it in our tree, but for net-next because I don't think
> I
> saw the issue in our and the netdev CI. So I added this in the commit
> message:
> 
> This issue has been reported by Sashiko and not seen in CI
> environments.
> Yet, it could be visible, especially when the test is launched
> manually.

Sorry for the late reply - I just saw this patch. Glad the issue has
been fixed. But actually, I had already fixed this issue earlier: my
patch titled "selftests: mptcp: sockopt: use exact length in
connect_one_server" [1] is still waiting for review on the MPTCP
mailing list. But it's no big deal - I should have replied with an
Acked-by for this patch.

Anyway, I'm wondering - does it look like my pending series "selftests:
consolidate TCP_INQ testing into sockopt" [2] is still useful after
all? Should I rebase it and send a v15?

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/6ec4570fb7b73f92905ef38beb414a4a7709e0a4.1785380422.git.tanggeliang@kylinos.cn/
[2]
https://patchwork.kernel.org/project/mptcp/cover/cover.1785380422.git.tanggeliang@kylinos.cn/

> 
> New patches for t/upstream:
> - e4ab26e68fc2: selftests: mptcp: sockopt: pass total bytes to
> do_getsockopts
> - Results: 7ea69c5a1764..54143bb812b1 (export)
> 
> Tests are now in progress:
> 
> - export:
> https://github.com/multipath-tcp/mptcp_net-next/commit/fae0397e047620f27866048567a39eb2bae6746c/checks
> 
> Cheers,
> Matt
