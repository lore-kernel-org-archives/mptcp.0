Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4F1448D5
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235793; cv=none; b=dPJkoxTsosOTQSJdgfn6358DYSHWzVc/yEhDYB7eIuF59kAjSqZVoShVOfZhzeN5fFNQZ3qKffFrmoEPE7f40MCkEwacEFXyaC4OBllE4DX8+fEeSwAc7Ocf0Wg/Jm+jRYlogRAdlEmtadv4iYLKd4WQtELkAHsBFFv+vkI+Xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235793; c=relaxed/simple;
	bh=xI+MLW9DZOspBoOS//wTIHDJNIvpRskqP78eo0nsNjE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jW4huxLr/m+wO87sLNw6BRHIBUeama+LDRXNlLi+lMGE6a4/j3QQQ/XLHaSwoAaxE9LJU8B0uupS+y2PjyL9OGQ50uW3rC5aSWL5nYy39SHwpjimPfdNdKn/kMrAewougc+XLKhL7yULA75E8AUCq+Oz62RDXctBZgyc4uVyhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uhzwwpk4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uhzwwpk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF53C4CEF7;
	Tue,  4 Nov 2025 05:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762235792;
	bh=xI+MLW9DZOspBoOS//wTIHDJNIvpRskqP78eo0nsNjE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Uhzwwpk4bxB2eIxjChYHRsNUi1yvhkO68DKquaiw3N7I5uiAxFRRFVVbW033WjUsw
	 +gJygYc4cp77GbcHvP9X6Pee5a3yqk7kAh6IJLcyTQtYdv5mNR5KMOj/kK5PCgKkSU
	 BEhcucrJV0vHp03lBIkG4kGuPTFwdTV2J8xUgo2dww8z5R9qfw8+E0zuRIzQUxEl4X
	 yirsbDUlnbScq6zhzhTPfeR5LLOfv18E8ZzH96Qiz83WPPxriHBdS5vRUmaL5Kmocv
	 Y8SmVDVbYW/txMXTeFFCwDfOIaD8FKE3zH4qqPMmMRHQXa0tn9dMWYfwRxArb84k6e
	 WKrL6SKcXX2eA==
Message-ID: <00d092b8b3dd3bb81a8201727c789be882a1e894.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 6/6] selftests: mptcp: connect: trunc: read
 all recv data
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Tue, 04 Nov 2025 13:56:28 +0800
In-Reply-To: <2e71345d-fe2a-4ae7-ba28-26e5d4fab726@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
	 <20251102-slft-join-inst-v2-6-b4f3ba15a7c4@kernel.org>
	 <d94c0f0850c8985324956cfdfef900bde3f2b377.camel@kernel.org>
	 <2e71345d-fe2a-4ae7-ba28-26e5d4fab726@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2025-11-03 at 13:12 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 03/11/2025 08:13, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
> > > MPTCP Join "fastclose server" selftest is sometimes failing
> > > because
> > > the
> > > client output file doesn't have the expected size, e.g. 296B
> > > instead
> > > of
> > > 1024B.
> > 
> > Thanks for this fix. After repeatedly running the fastclose tests,
> > patches 5 and 6 have indeed eliminated the flaky failures.
> 
> Thank you for the tests.
> 
> > > When looking at a packet trace when this happens, the server sent
> > > the
> > > expected 1024B in two parts -- 100B, then 924B -- then the
> > > MP_FASTCLOSE.
> > > It is then strange to see the client only receiving 296B, which
> > > would
> > > mean it only got a part of the second packet. The problem is then
> > > not
> > > on
> > > the networking side, but rather on the data reception side.
> > > 
> > > When mptcp_connect is launched with '-f -1', it means the
> > > connection
> > > might stop before having sent everything, because a reset has
> > > been
> > > received. When this happens, the program was directly stopped.
> > > But it
> > > is
> > > also possible there are still some data to read, simply because
> > > the
> > > previous 'read' step was done with a buffer smaller than the
> > > pending
> > > data, see do_rnd_read(). In this case, it is important to read
> > > what's
> > > left in the kernel buffers before stopping without error like
> > > before.
> > > 
> > > SIGPIPE is now ignored, not to quit the app before having read
> > > everything.
> > > 
> > > Fixes: 6bf41020b72b ("selftests: mptcp: update and extend
> > > fastclose
> > > test-cases")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > v2:
> > >  - Also catch EPIPE, and ignore SIGPIPE
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_connect.c | 18
> > > +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > index c030b08a7195..404a77bf366a 100644
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > @@ -710,8 +710,14 @@ static int copyfd_io_poll(int infd, int
> > > peerfd,
> > > int outfd,
> > >  
> > >  				bw = do_rnd_write(peerfd, winfo-
> > > >buf
> > > + winfo->off, winfo->len);
> > >  				if (bw < 0) {
> > > -					if (cfg_rcv_trunc)
> > > -						return 0;
> > > +					/* expected reset,
> > > continue
> > > to read */
> > > +					if (cfg_rcv_trunc &&
> > > +					    (errno == ECONNRESET
> > > ||
> > > +					     errno == EPIPE)) {
> > > +						fds.events &=
> > > ~POLLOUT;
> > > +						continue;
> > > +					}
> > 
> > We're adjusting the behavior of the falseclose tests here and need
> > to
> > ensure it doesn't affect other tests. I'm considering adding a new
> > config like cfg_rcv_ign to encapsulate these changes within an if
> > (cfg_rcv_ign) block, and only enable this new config in the
> > falseclose
> > tests.
> > 
> > WDYT?
> 
> I don't think we need an extra option. For the moment, when one side
> truncates the output ("-f XXX", which will cause a fastclose), the
> other
> side will be launched with "-f -1". In this case, "cfg_rcv_trunc"
> will
> be set, and we only change the behaviour for that.
> 
> It looks like this "-f" option is only use for the fastclose tests,
> and
> both peers have a "-f". So we can keep this as it is, no?

Yes, you're right. Let's keep this patch as is.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt

