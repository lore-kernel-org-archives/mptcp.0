Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012154;
	b=r6KPcevN12EdrDGibvC6OUtvZZMziVFI3tosCTgLVamgK0Eq5LobRS5lAFQ2dMwUvW0d
	 QHycsSEwlyT4LmqsHPeT4XtywqwIoaSppN60yjeOOgmWD46lOjq8kkmlbsoj+Bh26bL2/
	 nF0WxTcAVHN/Jd+2Bhk+pAVBfZEYveXuPhOegBn6TXrIQB+q5+YwVooOmJiyBq1ZGvJgT
	 ZqTDpBuFBSIQaYSJvPzqKkeFPpZ2Fa/PbL760Dh8jQBq1t4MlTAg08NSjAjELcZFp3VYA
	 qR7w4stShSo82aQinhjQ+fy8rS8kh29J55xQOIbMmCoQb/p7jOJOz+NLq350jgWkqmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012154;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eLA7PIRs/g+oR3+s8bFZHOewrWnop8L/Vi7wz4jXt24=;
	b=qeungsuTe6x7q2noIbka4lvc/u0bWl652GEk8EhFhP5x2Nr0JE5YaKNBmQy/91RL1wdK
	 XA0CClNM1ZxGxRoJjlTIUpjZKratgJN6kxS3mJ+OohAlekfGd6Yxzl+FdS570xfCTQlix
	 CFz4GAFWKaWv6j3NOQHuK++C1UJqxeTkGFu4M0bT/clWOWiWHMyxw3kQ1QqbY0mh1agWc
	 UabmXQL1S/xKXs3w5RUJYmEvQxMcIk+JbSoFjzx8ZU3Gwb7XwU6eM7C/Sq1A90NqciwVY
	 3FOqyWsyQtRYRWXZ1/DLPuPrTEivPkzhXqJ85oB9o9uAGJps5povN7C5FCOQapEec+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fw/PHz29";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5D606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fw/PHz29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3731F01825;
	Mon, 26 Oct 2026 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012153;
	bh=eLA7PIRs/g+oR3+s8bFZHOewrWnop8L/Vi7wz4jXt24=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=fw/PHz29D1+bWMQrDQQ6/cd+QC6qKOVc7iMBogX78JlK9GX/CdFjWKS4lyw+lPnqy
	 gdTJpiY43ZUmPWPCkkC/yX2N12bcJqjXo4IzGSxR4jgTfvEMk825GakVzt/6orWMz/
	 4UPbmdogDzzdHknhMoCUKvBK0F+f7yMr54/EOQdxCG02xq8/cr0JqETiAgk5AtWOq0
	 V7jofRvpMrNAkFfr/um/JM3tswn/jjaGnDo9NynjuTG8g+H1v9OesdJm4mX+yZ4DAb
	 9PyGd/xBnlAOeHHba2dyKm4GgpDfpPTkiURufoZoPvwWsU182Mm8ytdgLh5NnX2CTU
	 HjdsB9X9alyJA==
Message-ID: <699a31e9224d6fc32d57e066ac3a70f19ad61122.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2] selftests: mptcp: sockopt: pass total
 bytes to do_getsockopts
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, quanyeyang@proton.me, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Mon, 26 Oct 2026 18:55:47 +0800
In-Reply-To: <6b4005d8-850f-438d-a692-ebda1608d13d@kernel.org>
References: <20261016-fix-mptcp-issue-638-v2-1-cc32774a8b0c@proton.me>
	 <d16ffc4a-d8af-4b8d-b112-ce83736b9c3b@kernel.org>
	 <758fc944eb96407a0d761ff84679ee5066cf836e.camel@kernel.org>
	 <6b4005d8-850f-438d-a692-ebda1608d13d@kernel.org>
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

Hi Matt,

On Fri, 2026-10-23 at 11:28 +0200, Matthieu Baerts wrote:
> On 23/10/2026 03:05, Geliang Tang wrote:
> > Hi Matt, Quanye,
> > 
> > On Thu, 2026-10-22 at 13:06 +0200, Matthieu Baerts wrote:
> > > Hi Quanye,
> > > 
> > > On 17/10/2026 07:33, Quanye Yang via B4 Relay wrote:
> > > > From: Quanye Yang <quanyeyang@proton.me>
> > > > 
> > > > connect_one_server() reads the echoed payload in a loop because
> > > > read()
> > > > on a stream socket can return a partial chunk. After the loop,
> > > > it
> > > > still
> > > > passed the last read() return value to do_getsockopts() instead
> > > > of
> > > > the
> > > > accumulated byte count.
> > > > 
> > > > do_getsockopts() checks MPTCP_INFO first. The client samples
> > > > mptcpi_write_seq before write(), and write() has already
> > > > advanced
> > > > msk->write_seq by the full length, so a partial last read()
> > > > makes
> > > > the write_seq assert fail. Pass the total instead.
> > > 
> > > Thank you for the patch, it looks good to me.
> > > 
> > > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > 
> > > I just applied it in our tree, but for net-next because I don't
> > > think
> > > I
> > > saw the issue in our and the netdev CI. So I added this in the
> > > commit
> > > message:
> > > 
> > > This issue has been reported by Sashiko and not seen in CI
> > > environments.
> > > Yet, it could be visible, especially when the test is launched
> > > manually.
> > 
> > Sorry for the late reply - I just saw this patch. Glad the issue
> > has
> > been fixed. But actually, I had already fixed this issue earlier:
> > my
> > patch titled "selftests: mptcp: sockopt: use exact length in
> > connect_one_server" [1] is still waiting for review on the MPTCP
> > mailing list. But it's no big deal - I should have replied with an
> > Acked-by for this patch.
> 
> My bad, I forgot about that patch when I opened a bunch of issues
> reported by Sashiko.
> 
> I will add your co-dev-by on that one.

No need - let's keep it as it is.

> 
> Do we need the other modification you did on the 'read' to silence a
> GCC
> warning? Because the current "sizeof(buf2) - total" seems correct to
> me.
> 
> > Anyway, I'm wondering - does it look like my pending series
> > "selftests:
> > consolidate TCP_INQ testing into sockopt" [2] is still useful after
> > all? Should I rebase it and send a v15?
> 
> It is still useful, but sorry, I need to go through it (and many
> others
> :( ). I will try to do that in November/December after some
> deadlines.
> No need to rebase before.

But could we hold off on the other patch, "selftests: mptcp: sockopt:
echo until EOF on partial reads"? It conflicts with patches 3 and 4 in
my series. As it's for "-next" rather than "-net", I'd suggest not
merging it yet - I'll sort out the conflict once I have some time.

Thanks,
-Geliang

> 
> Cheers,
> Matt
