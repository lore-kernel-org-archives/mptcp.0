Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AF3FCC
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241272; cv=none; b=JgCQ7dRSofP4Kts2bp4bGij5cjhDoKF/Bl7WPh+8PFCN3niHlqwp2uDTq/EUgA4MfTn0hlV4qaq4SEr/1nAATXULnMAOOrLb4wmJs6zIzP82a/TGgzTyiAQrlqTZSTqtSiVFtPVm1FZpcWDjiZTabizdjII7oTS8qFPkmayzAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241272; c=relaxed/simple;
	bh=/Skx+ZlltwFpzaqPjgI0DODH5uRCPlhWVZOVT4omYW8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=d6k5uBzNhE5jwF2/O7gIyJeKJRpOUoRNl5y20kKo0dR6PFuRCkeVJCjEeMy3Aq6ybSja88nEUUzkpZO2Te4wkWY1tLI1FC6A2/jmhBJy2+9WS7p8/4eXyT5sdLhSNNclB6gOk7RS5J2IleOA9LEXqpGAEG6c6B8+Dpid/JzqdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UT6TMKuE; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UT6TMKuE"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776241268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcNaE1Tss2xYEiElu7nOZC4mEVpRES/lI787ykX4bUk=;
	b=UT6TMKuESxRSkD/j8VQIDd2JC/kGGWyhEHsBJ3ViHUWSZT6uoifE8iF5MzTpGyn6ByqfmK
	EgLo4E04k2d60SWdo38Tu1HqjqwSj33s80JxNmK9qt0oe/wOAyjJzf1WCIQaHZd1lB9RVb
	7vUbfqmLyUmVQEmEV42rTb6766zxPG0=
Date: Wed, 15 Apr 2026 08:21:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <ef0ce8465f0b852d5e4dc5e54031a156f606b636@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v5 1/5] mptcp: replace backlog_list with
 backlog_queue
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
In-Reply-To: <d34641c0-01af-4273-83d7-5e7ed92e8da7@redhat.com>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
 <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
 <d34641c0-01af-4273-83d7-5e7ed92e8da7@redhat.com>
X-Migadu-Flow: FLOW_OUT

April 15, 2026 at 3:17 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 4/1/26 10:12 PM, Paolo Abeni wrote:
>=20
>=20>=20
>=20> On 4/1/26 10:54 AM, Gang Yan wrote:
> >=20
>=20> >=20
>=20> > @@ -2210,12 +2260,12 @@ static bool mptcp_can_spool_backlog(struc=
t sock *sk, struct list_head *skbs)
> > >  mem_cgroup_from_sk(sk));
> > >=20=20
>=20> >  /* Don't spool the backlog if the rcvbuf is full. */
> > >  - if (list_empty(&msk->backlog_list) ||
> > >  + if (RB_EMPTY_ROOT(&msk->backlog_queue) ||
> > >  sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> > >  return false;
> > >=20=20
>=20> >  INIT_LIST_HEAD(skbs);
> > >  - list_splice_init(&msk->backlog_list, skbs);
> > >  + mptcp_backlog_queue_to_list(msk, skbs);
> > >=20
>=20>=20=20
>=20>  This is under a spinlock with BH disabled, and N is potentially qu=
ite
> >  high. This code is problematic as it could cause stall and delay BH =
for
> >  a significant amount of time.
> >=20=20
>=20>  Note that there are more chunks later and in later patches with si=
milar
> >  problem.
> >=20=20
>=20>  I don't have a good solution on top of my head, I'll try to go bac=
k to
> >  the design table.
> >=20
>=20I had some time to have a better look at the whole problem and how it
> manifest itself in the included self-tests - comprising the initial one
> using sendfile().
>=20
>=20AFAICS the stall in the self-tests in patch 5/5 is caused by the sysc=
tl
> setting taking effect on the server side _after_ that the 3whs
> negotiated the initial window; the rcvbuf suddenly shrinks from ~128K t=
o
> 4K and almost every incoming packet is dropped.
>=20
>=20The test itself is really an extreme condition; we should accept any
> implementation able to complete the transfer - even at very low speed.
>=20
>=20The initial test-case, the one using sendfile(), operates in a
> significantly different way: it generates 1-bytes len DSS preventing
> coalescing (I've not understood yet why coalescing does not happen),
> which cause an extremely bad skb->truesize/skb->len ratio, which in tur=
n
> causes the initial window being way too "optimistic", extreme rcvbuf
> squeeze at runtime and a behavior similar to the previous one.
>=20
>=20In both cases simply dropping incoming packets early/in
> mptcp_incoming_options() when the rcvbuf is full does not solve the
> issue: if the rcvbuf is used (mostly) by the OoO queue, retransmissions
> always hit the same rcvbuf condition and are also dropped.
>=20
>=20The root cause of both scenario is that some very unlikely condition
> calls to retract the announced rcv wnd, but mptcp can't do that.
>=20
>=20Currently I start to think that we need a strategy similar to plain T=
CP
> to deal with such scenario: when rcvbuf is full we need to condense and
> eventually prune the OoO queue (see tcp_prune_queue(),
> tcp_collapse_ofo_queue(), tcp_collapse()).
>=20
>=20The above has some serious downsides, i.e. it could lead to large sli=
ce
> of almost duplicate complex code, as is diff to abstract the MPTCP vs
> TCP differences (CB, seq numbers, drop reasons). Still under investigat=
ion.
>=20
>=20/P
>
Hi, Paolo
Thanks a lot for your detailed and insightful analysis of this problem!

I fully agree with your points: MPTCP should allow the transfer to comple=
te
even under extremely slow or harsh conditions, just as you mentioned.

Regarding the TCP-style mechanisms like 'tcp_prune_queue' for handling fu=
ll
rcvbuf conditions =E2=80=94 I have actually attempted similar implementat=
ions before.
As you pointed out, this approach is indeed highly complex for MPTCP. The=
re
are far too many aspects that require careful modification and considerat=
ion,
making it extremely challenging to implement correctly.

I=E2=80=99ve also made some progress on this issue recently. I implemente=
d a solution
based on the backlog list structure: when a transfer stall is detected, I
traverse the backlog_list, and only move the skbs where 'map_seq =3D=3D a=
ck_seq' into
the rcv_queue to unblock the transfer.

This approach effectively prevents unbounded growth of rmem_alloc, and ha=
s nearly
no impact on performance. The core logic is roughly as follows:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..c733dd2aa85f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2189,6 +2189,18 @@ static void mptcp_rcv_space_adjust(struct mptcp_so=
ck *msk, int copied)
        msk->rcvq_space.time =3D mstamp;
 }

+static bool mptcp_stop_spool_backlog(struct sock *sk)
+{
+       return sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
+              !skb_queue_empty(&sk->sk_receive_queue);
+}
+
+static bool mptcp_recv_stall(struct sock *sk)
+{
+       return sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
+              skb_queue_empty(&sk->sk_receive_queue);
+}
+
 static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u=
32 *delta)
 {
        struct sk_buff *skb =3D list_first_entry(skbs, struct sk_buff, li=
st);
@@ -2198,7 +2210,7 @@ static bool __mptcp_move_skbs(struct sock *sk, stru=
ct list_head *skbs, u32 *delt
        *delta =3D 0;
        while (1) {
                /* If the msk recvbuf is full stop, don't drop */
-               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+               if (mptcp_stop_spool_backlog(sk))
                        break;

                prefetch(skb->next);
@@ -2228,12 +2240,32 @@ static bool mptcp_can_spool_backlog(struct sock *=
sk, struct list_head *skbs)
        DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket =
&&
                               mem_cgroup_from_sk(sk));

-       /* Don't spool the backlog if the rcvbuf is full. */
+       /* Don't spool the backlog if the rcvbuf is full when rcv_queue i=
s
+        * not empty.=20
+=20       */
        if (list_empty(&msk->backlog_list) ||
-           sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+           mptcp_stop_spool_backlog(sk))
                return false;

        INIT_LIST_HEAD(skbs);
+
+       /* If the rcvbuf is full and the rcv_queue is empty, the transmis=
sion
+        * will stall. To prevent this, move the ack_seq skb from the
+        * backlog_list to the receive queue.
+        */
+       if (mptcp_recv_stall(sk)) {
+               struct sk_buff *iter, *tmp;
+
+               list_for_each_entry_safe(iter, tmp, &msk->backlog_list, l=
ist) {
+                       if (MPTCP_SKB_CB(iter)->map_seq =3D=3D msk->ack_s=
eq) {
+                               list_del(&iter->list);
+                               list_add(&iter->list, skbs);
+                               break;
+                       }
+               }
+               return !list_empty(skbs);
+       }
+
        list_splice_init(&msk->backlog_list, skbs);
        return true;
 }

I would really appreciate it if you could share your thoughts on this app=
roach when
you have time.

Cheers,=20
Gang
