Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8573F44D5
	for <mptcp@lists.linux.dev>; Wed, 10 Jun 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088308; cv=pass; b=OTOqZBb/MdRsFGJb5E3DgJLCdMims90rJTnmGyq+KVl26iCiIivNtqhBywaORP1ql0KL1ImqdyT7ezyfN4LQ8QKaBjQIlsuZ3iZVZgWKLLoOfvx3WtmtJxI3tHvSkHGLnB4xtUNEAP7MWjxHPlHSLLzK18Ukut7TZx+q3+xm8F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088308; c=relaxed/simple;
	bh=uVaxFJdG1kCDJ3OqeCdnNRnFULaPvW9s4OkV6xDx2Q4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=o7ZXa0ECECMNm9sYYIkqIVTkyEBJ1W7610IQ7/0Lhko4RMheVzF4/8SctMy7syVyQjG3K41Qn6uBByrHTzc1qMEJXPz80tzwyFXwq+pNuFbyWQ+llBvnBhsejIXgqJA4ffiGn0RpD22bQZk9nQXiuoRuEYbTfeGNCFI0UVY7Jeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=Uy7MOVC9 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="Uy7MOVC9"
ARC-Seal: i=1; a=rsa-sha256; t=1781088303; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=awrj2MF+C+BTnCAeCzflFoVaF3ZaendaUiGk6ipurZ1+bbZ9PC5/6HsT4UOI4vWaJPULbruauYrVJhoE+76awRS8QDp5tk4zMkArbdHh7u8sppCsqFwJJOfFX1M85YiTfuTqrBVfknaEMUYCHBGNas/OSw5/+HjoVWOVNyYbIUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781088303; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rGDB/b2P831QF0MbxOFhVfdILXmV3832HkrHtnOjnzs=; 
	b=dYDwZlO+WNnwk2yTd75FBhmHc/qsTaYosnR+7nasAuE+iXmV07Pd9uCtMtrM66dzYA5yfaAcKVo7qbbDefFh1UYch6CrYcNhnF/Z2LytjYfpDBo9MY0UNjarcd1kVoKw98yufQFQdDCmuEeCKpDMdS1aOixck20AzrND7fyUkPA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781088303;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rGDB/b2P831QF0MbxOFhVfdILXmV3832HkrHtnOjnzs=;
	b=Uy7MOVC9zZATvbXUNixuut3nDOovSAPS/ukP49SJCKMRAxaNKXr2IKh2HB+Lnmfr
	+MtcQLy9p5LNVWfyuz5HK6sMkJ4SSYWRb0RQOALLm0i9TWLt5iS45g1k4DExwWCHjKu
	QdhNKXDNS4WBOjuZ6w3ZgInEs9cgpNN5az08QuUI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1781088300646182.96556861411705; Wed, 10 Jun 2026 03:45:00 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:15:00 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>
Message-ID: <19eb122ae56.ad64411452675.6793404312191298092@mpiricsoftware.com>
In-Reply-To: <dc26df7b-5a00-4c55-bf5f-a402e079b7ef@kernel.org>
References: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com> <dc26df7b-5a00-4c55-bf5f-a402e079b7ef@kernel.org>
Subject: Re: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow
 close
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt, Paolo,

Thanks both for the review and for catching the inaccurate commit message. =
I've just sent v4:

https://lore.kernel.org/all/20260601083010.924938-1-kalpan.jani@mpiricsoftw=
are.com/

Changes since v3:
- Rewrote the commit message: the old backlog traversal in mptcp_close_ssk(=
) ran before __mptcp_close_ssk() took the ssk lock, holding neither the ssk=
 lock nor mptcp_data_lock(). The race is a concurrent softirq RX path (subf=
low_data_ready() -> mptcp_data_ready() -> __mptcp_add_backlog(), under mptc=
p_data_lock()) adding to the backlog mid-traversal, not anything tied to a =
release_sock(ssk).
- Added the missing Fixes tag (ee458a3f314e).

The diff is otherwise unchanged from v3. I kept your Suggested-by, Paolo; h=
appy to add an Acked-by too if you'd rather it be explicit.

Cheers,
Kalpan Jani

From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <mptcp@lists.linux.dev>
Cc: <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail=
.com>, <shardulsb08@gmail.com>
Date: Sun, 31 May 2026 11:41:51 +0530
Subject: Re: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow c=
lose

 > Hi Kalpan,
 >=20
 > On 19/05/2026 19:22, Kalpan Jani wrote:
 > > The backlog list is updated by mptcp_data_ready() under
 > > mptcp_data_lock(), but the cleanup of references to a closing subflow
 > > in mptcp_close_ssk() was done after release_sock(ssk) without holding
 > > that lock.
 >=20
 > Is it possible the commit message needs to be updated?
 >=20
 > AI assisted review is reporting this:
 >=20
 > The commit message states the cleanup "was done after release_sock(ssk)"
 > Is this description of the old code accurate?
 >=20
 > Looking at the pre-patch code, the backlog traversal in mptcp_close_ssk
 > ran before __mptcp_close_ssk() was called. __mptcp_close_ssk() is where
 > lock_sock_nested(ssk) happens. The traversal was never preceded by
 > lock_sock(ssk) nor followed by release_sock(ssk) - it simply ran with
 > neither ssk lock nor mptcp_data_lock held.
 >=20
 > The phrase "after release_sock(ssk)" does not match the actual old code
 > structure. The correct statement would be: "was done without holding the
 > ssk lock or mptcp_data_lock, before __mptcp_close_ssk() acquired the ssk
 > lock."
 >=20
 > > Once release_sock(ssk) returns, the RX path can acquire the ssk lock,
 > > call mptcp_data_ready(), and enqueue a new skb under mptcp_data_lock()
 > > before the close path reaches its list_for_each traversal. That skb is
 > > missed by cleanup, leaving skb->sk pointing to the freed ssk.
 >=20
 > AI assisted review is reporting this:
 >=20
 > The race scenario is real, but is the ordering description accurate?
 >=20
 > In the old code, the list_for_each traversal happened before
 > lock_sock(ssk) (inside mptcp_close_ssk(), before calling
 > __mptcp_close_ssk()). There was no prior release_sock(ssk) to trigger
 > the race.
 >=20
 > The actual race is: the traversal runs without mptcp_data_lock, so
 > concurrent softirq processing on another CPU can call subflow_data_ready
 > -> mptcp_data_ready -> __mptcp_add_backlog (under mptcp_data_lock) while
 > the traversal is in progress. The traversal can miss newly-added entries
 > or worse, encounter list corruption. The bug is real, but the mechanism
 > description is inaccurate.
 >=20
 > > Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
 > > subflow->closing is set to 1 and while the ssk lock is still held,
 > > serialized under mptcp_data_lock(). The cleanup runs only on the push
 > > path (MPTCP_CF_PUSH), where backlog references accumulate; on other
 > > teardown paths the caller already handles cleanup.
 > >=20
 > > With both locks held simultaneously, any concurrent mptcp_data_ready()
 > > either completes its enqueue before the purge runs and gets caught, or
 > > observes closing=3D1 while the ssk lock is still held and bails withou=
t
 > > enqueuing. After mptcp_data_unlock(), no new skbs can be enqueued.
 > > The cleanup is exhaustive.
 > >=20
 > > Remove the unprotected traversal from mptcp_close_ssk() entirely.
 > >=20
 > > Tested with the MPTCP kernel selftests on the patched kernel:
 > > - tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
 > > - tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass
 >=20
 > Do not forget about the Fixes tag.
 >=20
 > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
 > > Reported-by: syzkaller <syzkaller@googlegroups.com>
 > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
 > > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > > ---
 > > v3: follow Paolo's suggestion exactly =E2=80=94 use mptcp_cleanup_ssk_=
backlog() helper under MPTCP_CF_PUSH condition only; remove inline loop dup=
lication and second call from !dispose_it path.
 > > v2: moved cleanup into __mptcp_close_ssk() but duplicated logic and ad=
ded redundant second call; incorrect approach.
 > > v1: incorrect race analysis around subflow->closing flag.
 > >=20
 > >  net/mptcp/protocol.c | 33 +++++++++++++++++++--------------
 > >  1 file changed, 19 insertions(+), 14 deletions(-)
 > >=20
 > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
 > > index 718e910ff..149f816fe 100644
 > > --- a/net/mptcp/protocol.c
 > > +++ b/net/mptcp/protocol.c
 > > @@ -2527,6 +2527,22 @@ static void __mptcp_subflow_disconnect(struct s=
ock *ssk,
 > >      }
 > >  }
 > > =20
 > > +static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *s=
sk)
 > > +{
 > > +    struct mptcp_sock *msk =3D mptcp_sk(sk);
 > > +    struct sk_buff *skb;
 > > +
 > > +    mptcp_data_lock(sk);
 > > +    list_for_each_entry(skb, &msk->backlog_list, list) {
 > > +        if (skb->sk !=3D ssk)
 > > +            continue;
 > > +
 > > +        atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
 > > +        skb->sk =3D NULL;
 > > +    }
 > > +    mptcp_data_unlock(sk);
 > > +}
 > > +
 > >  /* subflow sockets can be either outgoing (connect) or incoming
 > >   * (accept).
 > >   *
 > > @@ -2550,6 +2566,9 @@ static void __mptcp_close_ssk(struct sock *sk, s=
truct sock *ssk,
 > >      lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 > >      subflow->closing =3D 1;
 > > =20
 > > +    if (flags & MPTCP_CF_PUSH)
 > > +        mptcp_cleanup_ssk_backlog(sk, ssk);
 > > +
 > >      /* Borrow the fwd allocated page left-over; fwd memory for the su=
bflow
 > >       * could be negative at this point, but will be reach zero soon -=
 when
 > >       * the data allocated using such fragment will be freed.
 > > @@ -2641,9 +2660,6 @@ static void __mptcp_close_ssk(struct sock *sk, s=
truct sock *ssk,
 > >  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 > >               struct mptcp_subflow_context *subflow)
 > >  {
 > > -    struct mptcp_sock *msk =3D mptcp_sk(sk);
 > > -    struct sk_buff *skb;
 > > -
 > >      /* The first subflow can already be closed or disconnected */
 > >      if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0=
)
 > >          return;
 > > @@ -2653,17 +2669,6 @@ void mptcp_close_ssk(struct sock *sk, struct so=
ck *ssk,
 > >      if (sk->sk_state =3D=3D TCP_ESTABLISHED)
 > >          mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KE=
RNEL);
 > > =20
 > > -    /* Remove any reference from the backlog to this ssk; backlog skb=
s consume
 > > -     * space in the msk receive queue, no need to touch sk->sk_rmem_a=
lloc
 > > -     */
 > > -    list_for_each_entry(skb, &msk->backlog_list, list) {
 > > -        if (skb->sk !=3D ssk)
 > > -            continue;
 > > -
 > > -        atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
 > > -        skb->sk =3D NULL;
 > > -    }
 > > -
 > >      /* subflow aborted before reaching the fully_established status
 > >       * attempt the creation of the next subflow
 > >       */
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20

