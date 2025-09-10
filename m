Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565B245028
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472265; cv=none; b=FTrVdGM4T5uB3HoHvBdqTLnVr7Py26OT3MgIwvo1sIbyb5ezx5OcOzIqD5TS8v/17t1NSsnw4/INZEsYyjGDSY1Er6vyxYWmVSLxv6JMeV/Ajzal2ururMHOG2pvN6v11l3kQaZSPVc9erk9nt1EEQsZ4ADn5/vKD4F80Mz9deg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472265; c=relaxed/simple;
	bh=mK/QbJFylY+/CgHcs5meRxUE3zi1LahTVvLu10YvZYA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dB6MQw90ZF6sfxQkmIytd8aHsiFXgOCGyEhm2mRkCyyc5eZ4+rxMh3zWvaP0GExE/xEMyRGA6yK4VD+J5OmRgn0+HmlDuvScnttoSV+SEmiKPUgOpancJk158rFrBOKq3utr6yQ67AOZHMXY/6ftFS61E0QeKNOq+kHZhVGxxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzupnRRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzupnRRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9135C4CEF4;
	Wed, 10 Sep 2025 02:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757472264;
	bh=mK/QbJFylY+/CgHcs5meRxUE3zi1LahTVvLu10YvZYA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bzupnRRG3sobAC35Yp2RGnNPkKr6qpQm8x/SS7f4lTuOVqufwA2E+IKQ3dKxHcUb6
	 v0vo9UON4BJu2WIT9hcPmbGNac5zkbSea7r5VggqdrCC73wPf+s1Cd+S60qE9Dw4fk
	 xb5FdTlM085IHP9zd87ScOetskEk51f9EUcSUsBCUix7GZTOJF0m3eFckmYD+oI6Sh
	 it3G/GKqgqYOZj2wuT+MvCkOo9b3911Mt79VjA8NvQWDRBaYDOHJVitUeuqTIbuW19
	 I6iNgShEfxyOADzZgJz2iNiBl44qsdJumuQDDiTk/uWgbu2GtJmvnPof6xscGgWmYb
	 ex519oLOzgNdQ==
Message-ID: <a55a9d1b123dae37f0478072d9eda0f6e6be7078.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/5] selftests: mptcp: connect: catch IO
 errors on listen side
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Sep 2025 10:44:19 +0800
In-Reply-To: <cf2fe151-78d8-414c-adf5-6fd62e6a1f44@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-2-dfb3b6b4a877@kernel.org>
	 <39e9e5644c96315181e19d5db1b2b44cb48fbf8a.camel@kernel.org>
	 <cf2fe151-78d8-414c-adf5-6fd62e6a1f44@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-09-06 at 15:54 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/09/2025 01:49, Geliang Tang wrote:
> > On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> > > IO errors were correctly printed to stderr, and propagated up to
> > > the
> > > main loop for the server side, but the returned value was
> > > ignored. As
> > > a
> > > consequence, the program for the listener side was no longer
> > > exiting
> > > with an error code in case of IO issues.
> > > 
> > > Because of that, some issues might not have been seen. But very
> > > likely,
> > > most issues either had an effect on the client side, or the file
> > > transfer was not the expected one, e.g. the connection got reset
> > > before
> > > the end. Still, it is better to fix this.
> > > 
> > > The main consequence of this issue is the error that was reported
> > > by
> > > the
> > > selftests: the received and sent files were different, and the
> > > MIB
> > > counters were not printed. Also, when such errors happened during
> > > the
> > > 'disconnect' tests, the program tried to continue until the
> > > timeout.
> > > 
> > > Now when an IO error is detected, the program exits directly with
> > > an
> > > error.
> > > 
> > > Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_connect.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > index
> > > 4f07ac9fa207cb08a934582b98d688d0b9512f97..c1586a7286123a509495ac3
> > > 19fd
> > > 624b98f0bfd18 100644
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > @@ -1112,6 +1112,8 @@ int main_loop_s(int listensock)
> > >  	salen = sizeof(ss);
> > >  	remotesock = accept(listensock, (struct sockaddr *)&ss,
> > > &salen);
> > >  	if (remotesock >= 0) {
> > > +		int err;
> > > +
> > >  		maybe_close(listensock);
> > >  		check_sockaddr(pf, &ss, salen);
> > >  		check_getpeername(remotesock, &ss, salen);
> > > @@ -1125,7 +1127,9 @@ int main_loop_s(int listensock)
> > >  		SOCK_TEST_TCPULP(remotesock, 0);
> > >  
> > >  		memset(&winfo, 0, sizeof(winfo));
> > > -		copyfd_io(fd, remotesock, 1, true, &winfo);
> > > +		err = copyfd_io(fd, remotesock, 1, true,
> > > &winfo);
> > > +		if (err)
> > > +			return err;
> > 
> > The file descriptor (fd) should be closed before returning.
> 
> I do agree it would be better to do so, but when you look in this
> file,
> most errors paths don't close the FD, because that's the exit path.
> 
> 'fd' will need to be closed, 'remotesock' as well, but same when it
> was
> not possible to create 'fd'. Also, I guess 'listensock' is never
> closed.
> Honestly, I don't think we need to increase the complexity, and close
> them, just for the tests. It would be different if the FD were reused
> later on, but I don't think we need to spend time on these details
> when
> this test program is about to close.

What I mean here is not to return directly, something like:

'''
int err = 0;

if (remotesock >= 0) {
    ... ...
    err = copyfd_io(fd, remotesock, 1, true, &winfo);
}

if (cfg_input)
    close(fd);

if (!err && --cfg_repeat > 0)
    goto again;

return err;
'''

WDYT?

I will send a patch to close remotesock and listensock later.

Thanks,
-Geliang

> 
> Cheers,
> Matt
