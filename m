Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4448280309
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100623; cv=none; b=XJloSk0Kug+Gp7cNEHDm7Xq0i6Z5wVhixYWpuT2dMGqIpkdVWss0+k3co4YxxJGrdauWJhaq8LYOKV27rL8DgRqZw/YxUhXWapR0ioqLNY2dw1YUOWyVkmLQ9CCzfLHZbNWomYG0yBKMcGuIqt4YXiMgQcGk7TABDz1SIhYHLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100623; c=relaxed/simple;
	bh=eVZ/Nn2CLpWeTgAKep9p2G+XgSgGqkQXMYmVzqAfXEI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBUTTk9mvBK3cDMFQ6ZS4isGhin2MO80hIndmbif/qF3Gcc69RCUPtpnb+IYFAhgRNy6B2ncUcF7LV2RR8mX+vedHLiQYjKfBQU45PXConCg8ot/Q6xi8XbPIqMwthqrEDdR9Y7lcsFYBy+Y2QuHuv7TsJNS/biR7Wd+WOlCGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV0G/0pt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV0G/0pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FD6C116D0;
	Tue,  3 Feb 2026 06:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770100623;
	bh=eVZ/Nn2CLpWeTgAKep9p2G+XgSgGqkQXMYmVzqAfXEI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=cV0G/0ptFteDTzr+29ygpU1kFBN+CF3uhihVY1GAbzrOJmCx+7v81wzwyC6Ninm8+
	 vvsedXoxtFwEapBWc8dssCEv+w6xNnNTWcQf9DqyWklAjaZPMNk6Xt8plcmh82L3Ld
	 gxK1ZRJC4gGI6Ubj2dI8wTjdt4kmG9yCR6Bzmp8SXBE5KSyQPxykJmS4dGJHngJw2W
	 5efZOxaX9xjDyWe2NL36NBOSspNn0PaP8fhfuwVx53yPTYXq/hLsdtHlAQfJ5pGiql
	 p22QAcU++EORcG8HZpf0ZzZuplqS64MOfH1K4M5oWx+7F7FPwKXVEQnofFZCkwfev2
	 B8nprhIXOWZuw==
Message-ID: <b0ca46ead8c060d093b8aefc4939cadc1f4c159f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: implement .splice_eof
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 03 Feb 2026 14:36:58 +0800
In-Reply-To: <5866364b-87b9-4abd-9eed-5437e6c56ffb@kernel.org>
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
	 <9e3dddfc65f24c1a11e5f0353b497f1d4f1c6f82.1770023932.git.tanggeliang@kylinos.cn>
	 <5866364b-87b9-4abd-9eed-5437e6c56ffb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2026-02-02 at 11:07 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for looking at that!
> 
> On 02/02/2026 10:21, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch implements the .splice_eof interface for MPTCP, namely
> > mptcp_splice_eof(), which sequentially calls do_tcp_splice_eof()
> > for
> > each subflow.
> 
> Can you please explain what this hook is supposed to do / used for
> please?

do_tcp_splice_eof() ensures that any remaining data in the TCP send
queue is flushed immediately when a sendfile() operation reaches end-
of-file (EOF).

> And also why the solution is to call do_tcp_splice_eof() on each
> subflow?

MPTCP operates over multiple TCP subflows. When splicing data through
an MPTCP socket, each subflow may have pending data in its send buffer
that needs to be properly finalized. So here calls do_tcp_splice_eof()
on each subflow.

> 
> Also, I'm a bit confused: why is this needed? Does it fix something
> or
> is it a new feature or an optimisation?

It is not a fix, but a new feature, to keep consistent with TCP. Since
TCP handles the splice EOF notification but MPTCP didn't.

> 
> > Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/protocol.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index c88882062c40..5635d196cb9f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -4018,6 +4018,20 @@ static int mptcp_connect(struct sock *sk,
> > struct sockaddr_unsized *uaddr,
> >  	return 0;
> >  }
> >  
> > +static void mptcp_splice_eof(struct socket *sock)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *sk = sock->sk, *ssk;
> > +
> > +	lock_sock(sk);
> > +	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> > +		ssk = mptcp_subflow_tcp_sock(subflow);
> > +
> > +		do_tcp_splice_eof(ssk);
> 
> Is it fine to call this on closed subflows? e.g. if the initial
> subflow
> has been closed. (I didn't check, maybe that's OK)

Good point. I will add this check in v2:

       if (ssk->sk_state == TCP_CLOSE)
               continue;

> 
> > +	}
> > +	release_sock(sk);
> > +}
> > +
> >  static struct proto mptcp_prot = {
> >  	.name		= "MPTCP",
> >  	.owner		= THIS_MODULE,
> > @@ -4049,6 +4063,7 @@ static struct proto mptcp_prot = {
> >  	.obj_size	= sizeof(struct mptcp_sock),
> >  	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
> >  	.no_autobind	= true,
> > +	.splice_eof	= mptcp_splice_eof,
> >  };
> >  
> >  static int mptcp_bind(struct socket *sock, struct sockaddr_unsized
> > *uaddr, int addr_len)
> > @@ -4540,6 +4555,7 @@ static const struct proto_ops
> > mptcp_stream_ops = {
> >  	.set_rcvlowat	   = mptcp_set_rcvlowat,
> >  	.read_sock	   = mptcp_read_sock,
> >  	.splice_read	   = mptcp_splice_read,
> > +	.splice_eof	   = inet_splice_eof,
> 
> Is this line required? Will it not call inet_splice_eof() by default?
> (I
> didn't check)

Yes, this is required.

sock_splice_eof() needs to call the .splice_eof interface from struct
proto_ops. To maintain consistency with regular TCP behavior, the 
.splice_eof interface of mptcp_stream_ops is set to inet_splice_eof
too. inet_splice_eof() will switch to the protocol-specific
implementation (sk->sk_prot->splice_eof), which for MPTCP is
mptcp_splice_eof().

Thanks,
-Geliang

> 
> >  };
> >  
> >  static struct inet_protosw mptcp_protosw = {
> 
> Cheers,
> Matt
