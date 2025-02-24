Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A52566D6
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393726; cv=none; b=PuoZvzt4H/JWwmKjbd4N5/nG9gPbyBwLXJlCmjf/TuSWRhxRRASyXMsP2DnY4eel5tXIflLjdefHF7guYm13xYb2kQ1k4U+IdJp2rbfwHXE5MrMqmBC0AMd/aMOaAEyZlTeHFVz7pyJp8Nf7g41kRM35xNRfGCpXLJvqznENQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393726; c=relaxed/simple;
	bh=BswoIa2CEjiPwVoiLWCceNxnjLsje5paS+wRhqcTiOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1KeNa7oM2oUqtGdddKfh9xaQ7ECjbEvK3O4DY2wt55mLejyp3jTjZkhXAg/hxtPrzecr1dctwJ5Vh+2QnnHmuA/aZbma8bbP0IXAVJmmbeuLMB17o4YJ2TrE+cjyC64bMuM+9Wk6ybDog/HUPju3M9Yhrna1Do7SmWNEEtTGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xsh6IoCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsh6IoCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E337DC4CEE6;
	Mon, 24 Feb 2025 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740393725;
	bh=BswoIa2CEjiPwVoiLWCceNxnjLsje5paS+wRhqcTiOs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Xsh6IoCE0sYt9h3ZUD+NRMbBBSlW3grsDeSc6VS5ZhfdkdX/lnz2htNM0di9gFHXJ
	 aGe5NB47s2syN5FmS93WvNiSgfYVe4es52+TJ7+gdW99NtMU0s3jT94Cbridl1KJE2
	 YsYwquyS5sKqDG4DMyFqaaN51xFS9Ge9tpLQ+MeGxM/haxTcfQtjCWpwu2bOpTFIa3
	 xunUnilHm+oHK++K+cxnFFpLPZNPTbVZXwAHyd3ATknwIPfF7WfnqNdGS7IbNRVznx
	 P7pgJV0jfrD8jfp29FaGq8CeW9X82+QtIKqVbc92Hsae+QpLvvWq0aHTDImcavlHch
	 rVuGsyNuFLu5w==
Message-ID: <bdcc04eab97f31bab5c9d09b2a5458a827774662.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1 5/6] sock: add sock_kmemdup helper
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 24 Feb 2025 18:42:01 +0800
In-Reply-To: <f40a2f15-7735-4131-8087-e5e1f1382f69@kernel.org>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
	 <0a3f7a31983f0587ace333f349f3e630c49d075d.1740384564.git.tanggeliang@kylinos.cn>
	 <f40a2f15-7735-4131-8087-e5e1f1382f69@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
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

Thanks for the review.

On Mon, 2025-02-24 at 09:54 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/02/2025 09:13, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds the sock version of kmemdup() helper, named
> > sock_kmemdup(),
> > to duplicate a memory block using the socket's option memory
> > buffer.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  include/net/sock.h |  1 +
> >  net/core/sock.c    | 23 +++++++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index edbb870e3f86..ffd757e7e329 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1793,6 +1793,7 @@ static inline struct sk_buff
> > *sock_alloc_send_skb(struct sock *sk,
> >  }
> >  
> >  void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
> > +void *sock_kmemdup(struct sock *sk, const void *src, int size,
> > gfp_t priority);
> >  void sock_kfree_s(struct sock *sk, void *mem, int size);
> >  void sock_kzfree_s(struct sock *sk, void *mem, int size);
> >  void sk_send_sigurg(struct sock *sk);
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 0d385bf27b38..d09bd697c120 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2805,6 +2805,29 @@ void *sock_kmalloc(struct sock *sk, int
> > size, gfp_t priority)
> >  }
> >  EXPORT_SYMBOL(sock_kmalloc);
> >  
> > +/*
> > + * Duplicate a memory block using the socket's option memory
> > buffer.
> > + */
> > +void *sock_kmemdup(struct sock *sk, const void *src, int size,
> > gfp_t priority)
> > +{
> > + int optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
> > +
> > + if ((unsigned int)size <= optmem_max &&
> > +     atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {
> > + void *mem;
> > + /* First do the add, to avoid the race if kmalloc
> > + * might sleep.
> > + */
> > + atomic_add(size, &sk->sk_omem_alloc);
> > + mem = kmemdup(src, size, priority);

I made some updates to this patch here.

      mem = src ? kmemdup(src, size, priority) :
                  kmalloc(size, priority);

> > + if (mem)
> > + return mem;
> > + atomic_sub(size, &sk->sk_omem_alloc);

Then sock_kmalloc() can be implemented through sock_kmemdup(), which
can reduce the duplication of code between them.

void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
{
      return sock_kmemdup(sk, NULL, size, priority);
}

> 
> I'm not really convinced by this helper: it is a duplication of
> sock_kmalloc(), and it is only used once in MPTCP code.

I found that this new helper can also be used in
mptcp_copy_ip_options() too.

> 
> Calling sock_kmalloc() + memset, and using this new helper in
> different
> places in the net code might help. But still, I don't know if this

And there are three other places in the net code where it can be used:

	ipv6_dup_options()
	sctp_v4_copy_ip_options()
	tcp_ao_copy_key()

That way, this helper can be used in five places.

> would
> be accepted, it is only saving one line (plus memcpy() will be used
> when
> it is not needed, same for the previous patch at the end).

What do you think of this new version?

> 
> If you still want to propose that, I suggest sending a dedicated
> series
> to netdev, not to block MPTCP (only) patches. WDYT?

Please remove the last two patches from this set if others are ready to
apply.

Thanks,
-Geliang

> 
> Cheers,
> Matt

