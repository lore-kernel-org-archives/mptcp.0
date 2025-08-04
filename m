Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59752E36F4
	for <mptcp@lists.linux.dev>; Mon,  4 Aug 2025 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288064; cv=none; b=ejOVHXn3gfgKQ1vRXZ4rKh3Bav9vPPMc6MFhAIBSj9gZUgE/uhG/Zl0fwYoJXLAaNZ06qBQu6KaOqChfcYDiUQ182vC7iwEQYsh/6E4elnVX72vKv2hNlJ0PF02oALOb2rBEia4iNOt/FPOk7bqjZcGdjqcr3kkNMXPk4RAEtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288064; c=relaxed/simple;
	bh=o7WfVbbAwoH02lbkOeJPGFGXIrpfkWcmSFf/Q8SGRBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhByRioJkImJN4D+m5GH9YcEghzOgZBMy07Z9XvTC+DRXtDWAGCVzQ02VQlZD04yzCoYI4sqr2XF/kIfZNaX9OWm8EnPHoGZO6WgD71Co+RgEmBYrikcCl17JxpidM8xLcXm1kOCkCx9xvK+LP5MHR0xB5h359UyIZsmZ3Nw7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtxlqzM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtxlqzM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F81C4CEE7;
	Mon,  4 Aug 2025 06:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754288064;
	bh=o7WfVbbAwoH02lbkOeJPGFGXIrpfkWcmSFf/Q8SGRBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XtxlqzM5s8YmpK0UHwG49K+GSg1KDFird5m5cT9cUcR4vgGPaNjEhbfRPkMxiLyju
	 ew/MqEmWtG/Z/yJaJhf7EbEFwAuvLbgKd+uNLO3qAkneVaBj37MOL84aqYmx4utQwF
	 aV6lIFsuLfs0d3UzLf3XUfDZW1AM+bp/n8EHlGX/HwcPpE+K1R4njg4OXWgdNVhyW+
	 tALdPEvv1YvEJNgiZRkdCarqv3ivKrl0DIB3XzR9VKslUrB3mtnCUXOUEP4hDjQnnV
	 f/f8S7/cXPoLptA8tsc7QKSbz/BGWAR4eHsKB6ruhv8lc/Yc8tylGA4U9E8X5KWRZa
	 kBKbGvuaojQJg==
Message-ID: <5bb6d1597f1b95fa3e47235092ae8b64209d8bce.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: TCP_MD5SIG support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 04 Aug 2025 14:14:10 +0800
In-Reply-To: <2370b313-4d83-458a-bfe9-9b0e556e9926@kernel.org>
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
	 <CADg4-L_VUj4xXLWiUAVF0pGvguwTHPbrh4ixFanaqkWJqOfvkg@mail.gmail.com>
	 <0567166cba36ca9d7d0181984ae703eea7068712.camel@kernel.org>
	 <2370b313-4d83-458a-bfe9-9b0e556e9926@kernel.org>
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

On Sun, 2025-08-03 at 09:47 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 03/08/2025 08:10, Geliang Tang wrote:
> > Hi Christoph,
> > 
> > On Sat, 2025-08-02 at 16:27 -0700, Christoph Paasch wrote:
> > > On Sat, Aug 2, 2025 at 5:01 AM Geliang Tang <geliang@kernel.org>
> > > wrote:
> > > > 
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > v4:
> > > >  - drop CONFIG_TCP_MD5SIG check.
> > > >  - drop sk_state check.
> > > >  - use WARN_ON_ONCE for __mptcp_try_fallback().
> > > > 
> > > > v3:
> > > >  - limit the use of these options for listened and closed
> > > > state.
> > > >  - check the return value of __mptcp_try_fallback().
> > > > 
> > > > v2:
> > > >  - trigger fallback to TCP.
> > > >  - check CONFIG_TCP_MD5SIG.
> > > >  - update MD5 comment.
> > > >  - drop selftests, packetdrill tests will be added later.
> > > > 
> > > > This series introduces support for TCP_MD5SIG socket options in
> > > > MPTCP along
> > > > with code improvements:
> > > > 
> > > > Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve
> > > > code
> > > > consistency
> > > > Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT
> > > > (first
> > > > subflow only)
> > > > 
> > > > Closes:
> > > > https://github.com/multipath-tcp/mptcp_net-next/issues/575
> > > > 
> > > > Geliang Tang (2):
> > > >   mptcp: Handle TCP_MAXSEG getsockopt in common case
> > > >   mptcp: setsockopt support for TCP_MD5SIG
> > > > 
> > > >  net/mptcp/sockopt.c | 18 +++++++++++++-----
> > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > 
> > > When I run these 2 patches, I get a reset from the server :
> > > 
> > > 23:24:48.285068 enP22p3s0f0np0 Out IP 10.221.81.117.35206 >
> > > 10.221.81.118.1234: Flags [S], seq 314447609, win 64240, options
> > > [nop,nop,md5 shared secret not supplied with -M, can't check -
> > > bab9b1ba60e4d55efb3d475ee4222311,mss
> > > 1460,nop,nop,sackOK,nop,wscale
> > > 0], length 0
> > > 23:24:48.285172 enP22p3s0f0np0 In  IP 10.221.81.118.1234 >
> > > 10.221.81.117.35206: Flags [R.], seq 0, ack 314447610, win 0,
> > > options
> > > [nop,nop,md5 shared secret not supplied with -M, can't check -
> > > c3bb41109aead9863e97f9cc4e12e7d2], length 0
> > > 
> > 
> > Yes, indeed, I got this reset too. This patch can fix it:
> > 
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 69e773059844..b22daf8c4526 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -165,7 +165,8 @@ static int subflow_check_req(struct
> > request_sock
> > *req,
> >  	/* no MPTCP if MD5SIG is enabled on this socket or we may
> > run
> > out of
> >  	 * TCP option space.
> >  	 */
> > -	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
> > {
> > +	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)
> > &&
> > +	    !__mptcp_check_fallback(mptcp_sk(listener->conn))) {
> 
> If __mptcp_check_fallback() is true, does it mean we will accept
> SYN+MPC+MD5?
> 
> Should we not have something like that?
> 
>   if (__mptcp_check_fallback())
>       return 0;

Yes, this is much better, I'll update it in v5.

> 
> Please provide packetdrill tests: for the client and server side. For
> the server side, with and without MPTCP in the injected SYN.

Adding MD5SIG tests to packetdrill is not easy, as packetdrill
currently does not accept struct tcp_md5sig as a parameter for
setsockopt calls. This makes it difficult to express the following
operation in packetdrill:

setsockopt(sockfd, IPPROTO_TCP, TCP_MD5SIG, &md5sig, sizeof(md5sig))

Integer parameters for setsockopt, on the other hand, are
straightforward to represent. For example:

+0.0  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0

Do I need to extend packetdrill to support struct tcp_md5sig? I'm
uncertain and would like your advice.

Thanks,
-Geliang

> 
> (+ adapt the one causing issues)
> 
> Cheers,
> Matt
