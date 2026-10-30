Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793325138;
	b=1MGpB9Mg76hr526U6fUYSMEbJxfII0EMKXYjpU8WDGukY3ZWY4OeTkqRicX32RagE6MS
	 fCRUC3jPMBuPrwK34R9hzlDgU1WygL5b4GGfwsLH96hBennD3uI0zZHKT/oka5Q4oAg7L
	 afN1i9a+aF5J6FPm8Mm+AuWNSYm0vCMjxCIs53dQt2Ba3oqIEwzu3Zq5eJ0brMfjTvkfA
	 JcrWIZfEpnBjv871oCwWAisyAwETyWwYXtLJnJJ4ad7C2Vcuzlc7z67k7fRgzxZtuLuAR
	 YDNF4H8AzNjIIbnZlIq1+ijX/uVJd2ki7pVclddRoFJRgrG2imsYnGkJZRPY45+xjFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793325138;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XCRK/t0fqsobSLMsECuVBZ4MAnsbySSHyc4alXR7pyQ=;
	b=xMATHP2EHVo1OJBaWDKD/poeT8Z4Foq3YrmxhS/tu4dtmpfGkTkGfOsz1UD8fB0UE2jV
	 vUNI67API2AFa7rqbOyFl2b9mz+VcLkK1e2gdI6AnJJACV6qN87c4whS9gsT/q1usjP3F
	 y6OGyH2uyarNALLLvA4/wVG7I/lLGuzlHNyRzgJBI9wA3n+rgHk6CcsceVBPWo03rj9Di
	 I5gyvbYqNdOUTahZh1LsZ1oYOTWFm77BgFZBAZavCn5Drri8HlqBXOOhn59a+AE/Sffq+
	 bPnJI7CJ0aERHDdp4/ESGrJMqpimcs9lOUZKahOGGrGa4rpZ9BH6tYnpUsSHnd9tzAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owVnkuhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114F606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owVnkuhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251181F000C1;
	Fri, 30 Oct 2026 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793325137;
	bh=XCRK/t0fqsobSLMsECuVBZ4MAnsbySSHyc4alXR7pyQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=owVnkuhV9Ekp1Ll5V6T5sqmal3eO0ErzcLX63tUy2P3amDQ0A/dlQUWlC6aY0Lwqa
	 jfRv8UQ/2vfCv9Pcdic2lH4IG/pZEoWMAWveYl9WpU663Lw3PtfyEcL17z9TQnnpky
	 nlf8ly7Iz4PHFvpnIuCM44DUCrzdUsHzdX/yGB1qCMQyU3l6f+aPEE4r+0xJaP076g
	 5zFfZw+x5cHJG4piELLu1fGYMO4q5QfLuf5C2GiSeFmzbkwyzQt3XlCskxEkxan12J
	 lr2asdVyBBVBhcOXpd0M0hm+FxYYbni2m/jb6BREYcEoBgEusVf0f7Cu+QT5Ed1qS+
	 n/orpTSVHOo9A==
Message-ID: <8fd964e5feefcdd389f8c85ce484ba6dbdaff4bc.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: print stats before
 socket closure
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Fri, 30 Oct 2026 09:52:14 +0800
In-Reply-To: <6995e688-db92-4291-a94d-18b03e517a73@kernel.org>
References: <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
	 <24e7da3ea0b33d5dca970449cf615a4c95ecceb8.camel@kernel.org>
	 <735a6655-b3ac-4352-8a35-0e54ac2c7ffd@kernel.org>
	 <7ad218abd5b68ac34bc34b607af3bb4c7163f60b.camel@kernel.org>
	 <6995e688-db92-4291-a94d-18b03e517a73@kernel.org>
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
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2026-10-22 at 09:58 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your patience.
> 
> On 21/09/2026 09:52, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Sorry for the delayed reply.
> > 
> > On Tue, 2026-09-08 at 19:52 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 05/09/2026 10:26, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > On Sat, 2026-08-15 at 00:28 +0200, Matthieu Baerts (NGI0)
> > > > wrote:
> > > > > In case of poll timeout, it might be too late to print the
> > > > > stats
> > > > > after
> > > > > the socket closure.
> > > > > 
> > > > > Now, in case of poll timeout, 'ss' and 'nstat' are invoked
> > > > > from
> > > > > mptcp_connect to print the stats before exiting. This should
> > > > > help
> > > > > debugging poll timeout issues.
> > > > > 
> > > > > Note: for this "workaround", system() is used for debugging
> > > > > purposes
> > > > 
> > > > This print_err_stats() implementation is basically the same as
> > > > mptcp_lib_pr_err_stats() in the shell, right?
> > > 
> > > Correct.
> > > 
> > > > I think it's better to use mptcp_lib_pr_err_stats() in the
> > > > shell to
> > > > print the information. In mptcp_connect.c, when a poll timeout
> > > > occurs,
> > > > we send a signal to the shell and don't close the socket
> > > > immediately -
> > > > we wait for the shell to finish printing the information before
> > > > closing
> > > > it. What do you think of this approach? There's a reference
> > > > implementation in the attachment, but I haven't tested it.
> > > Thank you for your review. I agree that what you suggested is
> > > better
> > > for
> > > a tool that would be used in production. But here with the
> > > selftests,
> > > I
> > > don't think we need your long patch with a higher complexity,
> > > just
> > > for
> > > the selftests. I think it is fine to have some "system()" calls
> > > with
> > > the
> > > same ss/nstat commands compared to a patch of 50+ lines to get
> > > the
> > > same
> > > result. No?
> > 
> > I agree with you - simplicity is a plus as well.
> > 
> > I tested it and it works. So LGTM!
> > 
> >     Reviewed-by: Geliang Tang <geliang@kernel.org>
> > 
> > 
> > However, we need to handle something in mptcp_connect.sh
> > afterwards.
> > Otherwise, when a timeout occurs, we'll get two duplicate outputs:
> > one
> > from mptcp_connect, which is the log added by this patch, and one
> > from
> > mptcp_connect.sh, which is an invalid log. I think in this case we
> > should ignore the latter, for example by adding the following to
> > mptcp_connect.sh:
> > 
> > do_transfer()
> > {
> >   ...
> >   mptcp_lib_pr_fail "client exit code $retc, server $rets"
> >   if [ ${rets} -ne 2 ] && [ ${retc} -ne 2 ]; then
> >     mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}"
> > "${port}"
> >   fi
> >   ...
> > }
> > 
> > What do you think? If you don't have time, I can submit this
> > follow-up
> > patch as well.
> 
> Is it really an issue to have two stats outputs? They are not
> duplicated: one is explicitly printing stats before socket closure,
> and
> the other one after.
> 
> Ignoring the 2nd output is easy, but this output can be valuable?
> Also,
> I don't think there will be a timeout issue on both the client and
> the
> server. Likely only one of them will timeout, and the additional
> check
> you suggest is not needed.
> 
> So OK like that?

OK, let's keep this patch as is. Please merge it:

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt
