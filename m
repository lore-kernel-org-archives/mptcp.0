Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22F191
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931108; cv=none; b=N39kICCF9Qtl1hZf+MYLAkQcKKByg2C/FTJC5gwihkzcUNduZ3k0UbDO5++w2GV8tElGblpbuc799kdGUoMYRcUpFrc6wBCLte/qH+kF8laXaX7COJZ7jP1WLLLpqjUX7pv6Az34mSOcyGaKV0FijVwidGMWKFvwkAKCeJo5Uk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931108; c=relaxed/simple;
	bh=0gyVLx6juYzV5G4lhPXZzN5aT1Lp/Kvg0lAxQNK4wDw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Ti7kqjSgiZyvzp8w5MWv9tXKXExfbjS/JYVooA8JF/4/v1jcT+Jaf0+f3DM6nq6LnzfPOe2Dl9NlwoKXaL3F/kLfGf+kduBEim9/BL0HvD6jEOBTyFn5egktLK3F73+sCaH4Rkg7XinPPWCPSYotWi/xTiq1Bu1V9i5jFCz1EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sK1N2NIi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sK1N2NIi"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779931104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/fEK8woeGvHlnjD+eYq9czaEPRMkwkqZicYNaEbhis=;
	b=sK1N2NIiT9q16T4ezOLLQyQWvYx63FCG4hAySFwnDJTFbp73m7yTTRY1VHyuI3visKyphD
	/TNNhVOb0VgS+RqcfCMEOs7No2uhJaahTN0Ds9oPh3rK6TAgQ451dINMUV8AJEhwqU0PXn
	iFZquxvqfdW4LrlV0S1jGgijE57cwbQ=
Date: Thu, 28 May 2026 01:18:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <9af2ada39337fd17da0740c117307876cb01beeb@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v8 mptcp-next 7/9] mptcp: implemented OoO queue pruning
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>, "MPTCP Linux" <mptcp@lists.linux.dev>
In-Reply-To: <76116a98-e6c3-4991-b4cd-d52c354e01ca@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
 <b67f85e91abafcdc87d4b0b8e479f715489ed6f2.1779485511.git.pabeni@redhat.com>
 <9c1d28dbc379eff6cc09e9b02a6b77beafcdc4f2@linux.dev>
 <1445abca-9a84-46df-be7d-8f7b656772a1@redhat.com>
 <6d38bd40e238fa4e578a629e8db789f36fc46ebb@linux.dev>
 <76116a98-e6c3-4991-b4cd-d52c354e01ca@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 27, 2026 at 6:01 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@r=
edhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 5/27/26 7:30 AM, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> May 26, 2026 at 2:50 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pa=
beni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wr=
ote:
> >=20
>=20> >=20
>=20> > On 5/26/26 5:13 AM, gang.yan@linux.dev wrote:
> > >=20
>=20>  May 23, 2026 at 5:43 AM, "Paolo Abeni" <pabeni@redhat.com mailto:p=
abeni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > w=
rote:
> >  diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> >  index ef65e2df709f..d9bd4f4afcc0 100644
> >  --- a/net/mptcp/mib.c
> >  +++ b/net/mptcp/mib.c
> >  @@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D=
 {
> >  SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
> >  SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
> >  SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
> >  + SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
> >  };
> >=20=20
>=20>  /* mptcp_mib_alloc - allocate percpu mib counters
> >  diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> >  index c84eb853d499..18f35f7e0a2d 100644
> >  --- a/net/mptcp/mib.h
> >  +++ b/net/mptcp/mib.h
> >  @@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
> >  MPTCP_MIB_WINPROBE, /* MPTCP-level zero window probe */
> >  MPTCP_MIB_BACKLOGDROP, /* Backlog over memory limit */
> >  MPTCP_MIB_RCVPRUNED, /* Dropped due to memory constrains */
> >  + MPTCP_MIB_OFO_PRUNED, /* MPTCP-level OoO queue pruned */
> >  __MPTCP_MIB_MAX
> >  };
> >=20=20
>=20>  diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >  index 03d6f8658467..f446e22148b9 100644
> >  --- a/net/mptcp/protocol.c
> >  +++ b/net/mptcp/protocol.c
> >  @@ -373,6 +373,43 @@ static void mptcp_init_skb(struct sock *ssk, st=
ruct sk_buff *skb, int offset,
> >  skb_dst_drop(skb);
> >  }
> >=20=20
>=20>  +/* "Inspired" from the TCP version */
> >  +static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
> >  +{
> >  + struct mptcp_sock *msk =3D mptcp_sk(sk);
> >  + struct rb_node *node, *prev;
> >  + bool pruned =3D false;
> >  + u64 mem;
> >  +
> >  + if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> >  + return;
> >  +
> >  + node =3D &msk->ooo_last_skb->rbnode;
> >  +
> >  + do {
> >  + struct sk_buff *skb =3D rb_to_skb(node);
> >  +
> >  + /* Stop pruning if the incoming skb would land in OoO tail. */
> >  + if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
> >  + break;
> >  +
> >  + pruned =3D true;
> >  + prev =3D rb_prev(node);
> >  + rb_erase(node, &msk->out_of_order_queue);
> >  + mptcp_drop(sk, skb);
> >  + msk->ooo_last_skb =3D rb_to_skb(prev);
> >  +
> >  + mem =3D (unsigned int)atomic_read(&sk->sk_rmem_alloc);
> >  + if (mem < sk->sk_rcvbuf)
> >  + break;
> >=20
>=20>  Hi Paolo,
> >=20=20
>=20>  Thanks for the v8. While going through the code, I ran into a
> >  point that I'm not entirely sure about.
> >=20=20
>=20>  TCP=E2=80=98s design uses sk->sk_rcvbuf >> 3 (one eighth of the bu=
ffer)
> >  as a goal. It we use sk->sk_rcvbuf here, the loop may break after
> >  deleting just one packet, right? This may fail to free enough space
> >  for the incoming out=E2=80=91of=E2=80=91order packet, leading to rep=
eated pruning
> >  calls and potential packet drops.
> >=20
>=20> >=20
>=20> > Thank you for your review.
> > >=20
>=20> >  Yes, here there is some difference vs plain TCP and I think it's=
 for the
> > >  better.
> > >=20
>=20> >  TCP tries to make a "significant" amount of space in the receive=
r buffer
> > >  while MPTCP tries to make room for a single packet.
> > >=20
>=20> >  Both strategies make sense in their respective context: TCP invo=
kes
> > >  tcp_prune_ofo_queue() only after collapsing, and the latter is ver=
y CPU
> > >  intensive; if tcp_prune_ofo_queue() would make room for a single p=
acket,
> > >  the next incoming one could still trigger collapsing and burn a lo=
t of
> > >  CPU cycles (note that this bad chain of events could still happen =
if
> > >  sk_rcvbuf / 8 is not bigger than 2 packets).
> > >=20
>=20> >  MPTCP (intentionally, as per discussion in the last iterations h=
ere)
> > >  does not perform collapsing, and directly does pruning when over l=
imit.
> > >  Pruning is relatively cheap - computational complexity wise we cou=
ld do
> > >  it for each incoming packet with "no issues", at least compared to
> > >  collapsing.
> > >=20
>=20> >  Dropping the minimal amount of packets to fit the incoming one, =
allows
> > >  MPTCP to minimize the need for reinjections (for packets already a=
cked
> > >  at the TCP-level, which we really should avoid). I think overall t=
his
> > >  compromise is a better fit for MPTCP.
> > >=20
>=20> >  BTW did you have the chance to perform testing on top of this re=
vision?
> > >=20
>=20>=20=20
>=20>  Hi Paolo,
> >=20=20
>=20>  Yes, I've tested v8 many times =E2=80=94 hundreds of runs. And the=
 tls.c part works
> >  fine too.
> >=20=20
>=20>  I also spotted some issues with MPTCP TLS adaptation, but those ar=
e unrelated
> >  to v8. I'll reply in Geliang's thread about them soon.
> >=20
>=20Thank you for testing. I'll send a v9 to try to get sashiko comments =
on
> remaining patches, but no real changes in it. Feel free to add your
> formal Tested-by tag, if you want :)

Great, thank you.

Tested-by: Gang Yan <yangang@kylinos.cn>

>=20
>=20Thanks,
>=20
>=20Paolo
>
