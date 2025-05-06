Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE582FC0FC
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746499252; cv=none; b=aBbj80XtJKJzEjrYVZYkDm+45EJ2VyrW1rqTQTMFv/X8DYaTPjosfWcDqD5gPi7HFIoINseIz3UUg6Q98GHMninTDJ8rRQCNSqCT4BSnl6hx2zp5DJstFJP4CrywWETaREgizaud4PaYycIgmHJynNbRfO5qSrYFEnQ5XZqTYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746499252; c=relaxed/simple;
	bh=ZPtMO1JG0EZNeOAhbgCeLebHybYQkWOe9T+RMZTegQo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLKwNqS9EaRtXz4+9BDjgdWjsNYR/axkksm6ZTE/n+9ub8si0FlMy/kk8OPsDs2Xm/+1OsKevV5mGe0F282CXzMAQMzn9ljt/AxaqtuOOhJAvhlgbMgRWPF48ohSifigGxsKboegnlikUsBIBuJ+64Hhy65HETplnskS8x1R7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvHA135f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvHA135f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1112AC4CEE9;
	Tue,  6 May 2025 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746499251;
	bh=ZPtMO1JG0EZNeOAhbgCeLebHybYQkWOe9T+RMZTegQo=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=EvHA135f+AhCP2xOuABnxUiMR2fzOSS393eDcC94NroSqDTQuaAegSBkK7FM06VlL
	 3VuGnyVBvPx0GN2uVN5cQ+UjITkM1nDZQAD4id9cbnnHMykJ3j28UHXUkEuMnsWrKp
	 pIWW2D978GLrAu114hW57e3pb7P4zTVyRb6UxuJMoOKsUhQEmWGd5CVzrqYujDNqQD
	 SfCpBfGghzBavZDW5VspdiKzUOpcJZ2TwinpWmtz5aZUMadV4bMT6P6r3aJ3FQVN1G
	 trvit2MaiMBH4cvgrdnBicTpc5gSVGqiQSGnhlYKaPiUn8vmPztluo93Eg2fIoF5MK
	 2eqZYQkFnCacg==
Message-ID: <f74bf2eaf7cedcdf7684e836b54d1828c88eebf6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] sock: add sock_krfree_s helper
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 06 May 2025 10:40:48 +0800
In-Reply-To: <51744839-e4a2-4bb0-8f54-5f6ad3db6925@kernel.org>
References: 
	<ffe72ff201ea72938b136eb37ea3e0777ae890f4.1746004135.git.geliang@kernel.org>
	 <51744839-e4a2-4bb0-8f54-5f6ad3db6925@kernel.org>
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

On Wed, 2025-04-30 at 11:46 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/04/2025 11:09, Geliang Tang wrote:
> > This patch adds the rcu version of sock_kfree_s() helper, named
> > sock_krfree_s(), to free the memory using kfree_rcu_mightsleep()
> > and adjust the socket's option memory buffer.
> > 
> > This new helper is first used in MPTCP.
> > 
> > Signed-off-by: Geliang Tang <geliang@kernel.org>
> > ---
> >  include/net/sock.h       |  1 +
> >  net/core/sock.c          | 14 +++++++++++---
> >  net/mptcp/pm_userspace.c |  3 +--
> >  3 files changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index e223102337c7..94f72f5c8754 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1836,6 +1836,7 @@ void *sock_kmemdup(struct sock *sk, const
> > void *src,
> >  		   int size, gfp_t priority);
> >  void sock_kfree_s(struct sock *sk, void *mem, int size);
> >  void sock_kzfree_s(struct sock *sk, void *mem, int size);
> > +void sock_krfree_s(struct sock *sk, void *mem, int size);
> >  void sk_send_sigurg(struct sock *sk);
> >  
> >  static inline void sock_replace_proto(struct sock *sk, struct
> > proto *proto)
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index b64df2463300..f9ee0b44ab2a 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2862,12 +2862,14 @@ EXPORT_SYMBOL(sock_kmemdup);
> >   * condition entirely.
> >   */
> >  static inline void __sock_kfree_s(struct sock *sk, void *mem, int
> > size,
> > -				  const bool nullify)
> > +				  const bool nullify, const bool
> > rcu)
> >  {
> >  	if (WARN_ON_ONCE(!mem))
> >  		return;
> >  	if (nullify)
> >  		kfree_sensitive(mem);
> > +	else if (rcu)
> > +		kfree_rcu_mightsleep(mem);
> 
> I'm not sure about that: in some cases, kfree_rcu() might be called.
> kfree_rcu_mightsleep() is more an exception to me, I think. Also, it
> looks like there are many other places where the free and
> atomic_sub()
> is done "manually", that's not specific to MPTCP.
> 
> I don't know what Mat thinks about that, but I don't think this is
> needed (or it should replace some code in different places in the
> kernel).

Indeed, thanks for your reminder. I didn't notice that there are many
other places that use free() and atomic_sub() too. I will reconsider
whether to drop this patch or replace some code in different places.

Thanks,
-Geliang

> 
> Cheers,
> Matt

