Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FA2236E3
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860973; cv=pass; b=oPu7UbRJmQZ2qpVVfws/bY91GA69D+zAa6xxNLXPpyhcJ4/Zke3vOFpQYoLXpMo3zBY+6AYUDSVAyxUpLG/Gvdmmj7f6m/IHRkDrProqjawx1S67pWkLipb79XVTgWcFeS0d0KKa/50Zyng9osyHBKVslyBd7iDvxGNFf3RelRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860973; c=relaxed/simple;
	bh=uCclzf6ynQ9izgZvbFH+XoIiTMUPmF8eeJZOk8JcIL4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QNoMCNSBuJ4kX1oRL0WcMxkuXe/Q1SyIWgCMcIcOsPzRXZ8kINfsQ/pcIN3oH5bOaBTG65UA1/kG1RcI8fnwW6Ig132tgaCeOJ//41AcigKdQ3fd0Ia1lo1ynmOA0gZx59umvzXfR7/Ey2P1jbnz/IjTQTLKqf/srs89K0jeZhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=njFNq061 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="njFNq061"
ARC-Seal: i=1; a=rsa-sha256; t=1779860967; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JTZQNwUtOKEAkuuNGVbMSgEz9ngEhpmYC0CHN3ZBYLYY44Bl6Z5KlVq0Ri2Ut+y04fKi/W1w4WRxChqcyqqdbkqntJenjZKQ2mqZJRa/CELy0Glo5Cmuj7JuLwhiMnHuB5ZIEu3InMEGhJLHpxLrPizkjczUsk3jcVYg0Yh6X54=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779860967; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jExQdU1liV6c4s5alsnkKohBcdZlSwCBJNV0KD80y6Y=; 
	b=M9e2iB6DCPTGo8utvkBCvFeW0qP2byzCsUnvprD3BRSbDZvudwFRzUKgOaMrG3qgZxV+3fIqOWOa1I9A4p/i+s6tuJu9tvS1zNxeAr0vzquOwcMKSKge7wo+wcLAZAy773MHKVdaSRTtyuSuB+WojpSekIuvVIpRsvUNonBrIEk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779860967;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jExQdU1liV6c4s5alsnkKohBcdZlSwCBJNV0KD80y6Y=;
	b=njFNq061uvIva/d8usU/AIdwe4Acc0iCf/xPNjACBlf4a3Lpyt6Q1sugcv/5I4pc
	rylQnkwHvrwi9sVbJEwiKCHlKzpMnUnM3RnyrLgco0qZQwykbqo1g+k6RPa6u6EkGQP
	n/m9ymRPQVHho5oSL+cyotA6crTK2Lffn9EeHG0A=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1779860965012181.255172702344; Tue, 26 May 2026 22:49:25 -0700 (PDT)
Date: Wed, 27 May 2026 11:19:24 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "mptcp" <mptcp@lists.linux.dev>, "matttbe" <matttbe@kernel.org>,
	"pabeni" <pabeni@redhat.com>
Cc: "shardul.b" <shardul.b@mpiricsoftware.com>, "janak" <janak@mpiric.us>,
	"kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <19e67fb067f.1c11e928628417.8560610860929896581@mpiricsoftware.com>
In-Reply-To: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
References: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
Subject: Re:[PATCH net v3] mptcp: fix stale skb->sk reference on subflow
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

Hi all,
Gentle ping on this patch sent on 19 May 2026 =E2=80=94 I haven't seen any =
review feedback yet. If anyone has had a chance to look, I'd appreciate com=
ments; otherwise I'm happy to rebase or resend if it slipped through.
Thanks,
Kalpan Jani


From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail=
.com>, <shardulsb08@gmail.com>
Date: Tue, 19 May 2026 14:52:43 +0530
Subject: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow close

 > The backlog list is updated by mptcp_data_ready() under
 > mptcp_data_lock(), but the cleanup of references to a closing subflow
 > in mptcp_close_ssk() was done after release_sock(ssk) without holding
 > that lock.
 >=20
 > Once release_sock(ssk) returns, the RX path can acquire the ssk lock,
 > call mptcp_data_ready(), and enqueue a new skb under mptcp_data_lock()
 > before the close path reaches its list_for_each traversal. That skb is
 > missed by cleanup, leaving skb->sk pointing to the freed ssk.
 >=20
 > Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
 > subflow->closing is set to 1 and while the ssk lock is still held,
 > serialized under mptcp_data_lock(). The cleanup runs only on the push
 > path (MPTCP_CF_PUSH), where backlog references accumulate; on other
 > teardown paths the caller already handles cleanup.
 >=20
 > With both locks held simultaneously, any concurrent mptcp_data_ready()
 > either completes its enqueue before the purge runs and gets caught, or
 > observes closing=3D1 while the ssk lock is still held and bails without
 > enqueuing. After mptcp_data_unlock(), no new skbs can be enqueued.
 > The cleanup is exhaustive.
 >=20
 > Remove the unprotected traversal from mptcp_close_ssk() entirely.
 >=20
 > Tested with the MPTCP kernel selftests on the patched kernel:
 > - tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
 > - tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass
 >=20
 > Suggested-by: Paolo Abeni <pabeni@redhat.com>
 > Reported-by: syzkaller <syzkaller@googlegroups.com>
 > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
 > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > ---
 > v3: follow Paolo's suggestion exactly =E2=80=94 use mptcp_cleanup_ssk_ba=
cklog() helper under MPTCP_CF_PUSH condition only; remove inline loop dupli=
cation and second call from !dispose_it path.
 > v2: moved cleanup into __mptcp_close_ssk() but duplicated logic and adde=
d redundant second call; incorrect approach.
 > v1: incorrect race analysis around subflow->closing flag.
 >=20
 >  net/mptcp/protocol.c | 33 +++++++++++++++++++--------------
 >  1 file changed, 19 insertions(+), 14 deletions(-)
 >=20
 > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
 > index 718e910ff..149f816fe 100644
 > --- a/net/mptcp/protocol.c
 > +++ b/net/mptcp/protocol.c
 > @@ -2527,6 +2527,22 @@ static void __mptcp_subflow_disconnect(struct soc=
k *ssk,
 >      }
 >  }
 > =20
 > +static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk=
)
 > +{
 > +    struct mptcp_sock *msk =3D mptcp_sk(sk);
 > +    struct sk_buff *skb;
 > +
 > +    mptcp_data_lock(sk);
 > +    list_for_each_entry(skb, &msk->backlog_list, list) {
 > +        if (skb->sk !=3D ssk)
 > +            continue;
 > +
 > +        atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
 > +        skb->sk =3D NULL;
 > +    }
 > +    mptcp_data_unlock(sk);
 > +}
 > +
 >  /* subflow sockets can be either outgoing (connect) or incoming
 >   * (accept).
 >   *
 > @@ -2550,6 +2566,9 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
 >      lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 >      subflow->closing =3D 1;
 > =20
 > +    if (flags & MPTCP_CF_PUSH)
 > +        mptcp_cleanup_ssk_backlog(sk, ssk);
 > +
 >      /* Borrow the fwd allocated page left-over; fwd memory for the subf=
low
 >       * could be negative at this point, but will be reach zero soon - w=
hen
 >       * the data allocated using such fragment will be freed.
 > @@ -2641,9 +2660,6 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
 >  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 >               struct mptcp_subflow_context *subflow)
 >  {
 > -    struct mptcp_sock *msk =3D mptcp_sk(sk);
 > -    struct sk_buff *skb;
 > -
 >      /* The first subflow can already be closed or disconnected */
 >      if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 >          return;
 > @@ -2653,17 +2669,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock=
 *ssk,
 >      if (sk->sk_state =3D=3D TCP_ESTABLISHED)
 >          mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERN=
EL);
 > =20
 > -    /* Remove any reference from the backlog to this ssk; backlog skbs =
consume
 > -     * space in the msk receive queue, no need to touch sk->sk_rmem_all=
oc
 > -     */
 > -    list_for_each_entry(skb, &msk->backlog_list, list) {
 > -        if (skb->sk !=3D ssk)
 > -            continue;
 > -
 > -        atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
 > -        skb->sk =3D NULL;
 > -    }
 > -
 >      /* subflow aborted before reaching the fully_established status
 >       * attempt the creation of the next subflow
 >       */
 > --=20
 > 2.43.0
 >=20
 >=20

