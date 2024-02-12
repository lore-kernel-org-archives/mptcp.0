Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840F39846
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737264; cv=none; b=QJu93Gz+I1KRVL2pSgqP86rcDW1EEA+kIsqSbvz89X+9jZw2eQV+Yoa0RxiOMplWwnBSolfdN6Q/hJPq2O6JFUTA7T8Xdr/31UMqxynhQwObeEaExbitrBFNIBhc/F/4iZckvrpdsF0E7VpR+PVlSeFiQNjtxhhHOXwYTZ6U6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737264; c=relaxed/simple;
	bh=SYOn+0SQRFvkTpi09vJZHkF5iUz4Z5OF7TPtmz0IQTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKFDV96n7nyrRpgONe843p/+MO4dRs6oL0pPDgUpXVH3qZf2b5IbfvHhUdPEevy6op/JvHIn6yw7TAgBXXBd5kNGcS9JZYidVIlFhmLDpYZ4TJhw0RzMOHsJHDCzjtgLds8Lrfqrb5J663jSCcmXspxRbaVYMszLIGPkzSzDM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaCLSMcQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaCLSMcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707737261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VKGQ+8Aye5W0Zgpot921lBrORiHGSgLI/AjEsDIg6g4=;
	b=TaCLSMcQdm0D8QAdDu2zXd6IXn8EHtTcUnhota9aScbl+wt2GNADsxY66MruskwDGDHwRT
	wn9Q4j9H8Qox41TmSGActeALQ9tUSKQj51dNGnbDC/TdgINsBi4b/nlR5Yy5FxiKk9TlFN
	/bCDm+Y+ImDhDBOIWYHLrTT8iNr4mjc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-fN9Pr0rRNK6IanvRqNYbpg-1; Mon, 12 Feb 2024 06:27:40 -0500
X-MC-Unique: fN9Pr0rRNK6IanvRqNYbpg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78315f4f5c2so147828485a.0
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 03:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737260; x=1708342060;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl0wfyj8F9ITC3Ka6Lhx0V6OzucnkF23wUCb6YVP2RM=;
        b=FsuM7KBsekbB3IQbzdCCsar6zn3mkJEtaq7MS7CxVzbXN95tpuN5og+h1Oqa4Wiat+
         h4RN3enhzhFTzJlLADFpeeLlEwRmRlJA5LNYv/sZn5pc2Ayd/s/Pl1/WWPf71agW3rlb
         evIAVNeCMVQIQDHXJnIQ4d3bycgN1Lbosck0ODTlo4Z+xPSCaisSWJpFkXsSc5iNRby5
         1bmTQvKwwg5lOrPGS44vF39hv+SLkjRKT+hynhugf4k82xHs40jVefM5yajW+8BVIdP0
         i+76iQbWLc9GPdbRKlhuybESYT0wssLU2j3u+IKuB+jTJO78wsmlb7ta45VCowtgNZ8l
         bZBA==
X-Gm-Message-State: AOJu0YyqK5mUa6W5mv+/WrG1dqRB19LrONPKoQhkwox7dipBzO0Ss3OW
	XIQuEz0nQW5lpnuW5FG0UCvyZDASXTxUs+FUNjN4PX3CrLALo0MUG/g8vetsq7QPw0q7MJApGVE
	hb9X8+hrD5cKGOnQS8In0MV1YU4rt3d5LJJuquW6OQN9q9NkIk3PwlJrXGKoC
X-Received: by 2002:ac8:7dc3:0:b0:42c:410a:633a with SMTP id c3-20020ac87dc3000000b0042c410a633amr8277104qte.0.1707737260064;
        Mon, 12 Feb 2024 03:27:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhRSJSsellQpEahIlMQl9xOBiJleuT0S5wFlJNR08hjSYmWfcgt/PGaq3k2tT1/iEqPJOblg==
X-Received: by 2002:ac8:7dc3:0:b0:42c:410a:633a with SMTP id c3-20020ac87dc3000000b0042c410a633amr8277092qte.0.1707737259754;
        Mon, 12 Feb 2024 03:27:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-233-147.dyn.eolo.it. [146.241.233.147])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8744a000000b0042c659a5e25sm57820qtr.42.2024.02.12.03.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:27:39 -0800 (PST)
Message-ID: <16b50ba4548ccc1e6c4254826adf27f00f74f63f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 6/7] mptcp: implement TCP_NOTSENT_LOWAT
 support.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 12 Feb 2024 12:27:37 +0100
In-Reply-To: <8fb6b093-3d47-cec2-74a8-e2ad8215a597@kernel.org>
References: <cover.1705836321.git.pabeni@redhat.com>
	 <cfd580d15d1bbf7ba294f2f49266ae5ded02fec7.1705836321.git.pabeni@redhat.com>
	 <8fb6b093-3d47-cec2-74a8-e2ad8215a597@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-02-07 at 18:12 -0800, Mat Martineau wrote:
> On Mon, 22 Jan 2024, Paolo Abeni wrote:
>=20
> > Add support for such socket option storing the user-space provided
> > value in a new msk field, and using such data to implement the
> > _mptcp_stream_memory_free() helper, similar to the TCP one.
> >=20
> > To avoid adding more indirect calls in the fast path, instead of
> > hooking the new helper via the sk_stream_memory_free sock cb,
> > add the directly calls where needed.
> >=20
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/464
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++-----
> > net/mptcp/protocol.h | 28 +++++++++++++++++++++++++++-
> > net/mptcp/sockopt.c  | 12 ++++++++++++
> > 3 files changed, 67 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 3599205fdceb..53d6c5544900 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1761,6 +1761,25 @@ static int do_copy_data_nocache(struct sock *sk,=
 int copy,
> > =09return 0;
> > }
> >=20
> > +static u32 mptcp_send_limit(const struct sock *sk)
> > +{
> > +=09const struct mptcp_sock *msk =3D mptcp_sk(sk);
> > +=09u32 limit, not_sent;
> > +
> > +=09if (!sk_stream_memory_free(sk))
> > +=09=09return 0;
> > +
> > +=09limit =3D mptcp_notsent_lowat(sk);
> > +=09if (limit =3D=3D UINT_MAX)
> > +=09=09return UINT_MAX;
> > +
> > +=09not_sent =3D msk->write_seq - msk->snd_nxt;
> > +=09if (not_sent >=3D limit)
> > +=09=09return 0;
> > +
> > +=09return limit - not_sent;
> > +}
> > +
> > static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t le=
n)
> > {
> > =09struct mptcp_sock *msk =3D mptcp_sk(sk);
> > @@ -1805,6 +1824,12 @@ static int mptcp_sendmsg(struct sock *sk, struct=
 msghdr *msg, size_t len)
> > =09=09struct mptcp_data_frag *dfrag;
> > =09=09bool dfrag_collapsed;
> > =09=09size_t psize, offset;
> > +=09=09u32 copy_limit;
> > +
> > +=09=09/* ensure fitting the notsent_lowat() constraint */
> > +=09=09copy_limit =3D mptcp_send_limit(sk);
> > +=09=09if (!copy_limit)
> > +=09=09=09goto wait_for_memory;
> >=20
> > =09=09/* reuse tail pfrag, if possible, or carve a new one from the
> > =09=09 * page allocator
> > @@ -1812,9 +1837,6 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
> > =09=09dfrag =3D mptcp_pending_tail(sk);
> > =09=09dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag)=
;
> > =09=09if (!dfrag_collapsed) {
> > -=09=09=09if (!sk_stream_memory_free(sk))
> > -=09=09=09=09goto wait_for_memory;
> > -
> > =09=09=09if (!mptcp_page_frag_refill(sk, pfrag))
> > =09=09=09=09goto wait_for_memory;
> >=20
> > @@ -1829,6 +1851,7 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
> > =09=09offset =3D dfrag->offset + dfrag->data_len;
> > =09=09psize =3D pfrag->size - offset;
> > =09=09psize =3D min_t(size_t, psize, msg_data_left(msg));
> > +=09=09psize =3D min_t(size_t, psize, copy_limit);
>=20
>=20
> Hi Paolo -
>=20
> Any concern that this will cause us to start sending short packets if=20
> mptcp_send_limit() starts returning small (nonzero) values?
>=20
> If copy_limit is small on the first iteration of this loop, it looks like=
=20
> a small segment will be created. When that gets acked, a small amount=20
> becomes available and then we create another small segment (repeat...).

The idea is to align the mptcp behavior with the one exposed by plain
TCP.

Note that wait_for_memory/sk_stream_wait_memory() should be woken-up
only after __mptcp_stream_memory_free(sk, 1), see mptcp_write_space()
below...

> On the first pass (or on the 'wait_for_memory' path) should something lik=
e=20
> __mptcp_stream_is_writeable(sk, 1) be used to make sure a reasonable chun=
k=20
> of buffer is available before proceeding?

... so the above should be already guaranteed (and plain TCP does not
check for that in tcp_sendmsg_locked/wait_for_space.

Anyway I think you outlined a bug here: mptcp_sendmsg() waits for
mptcp_notsent_lowat/__mptcp_stream_memory_free(sk, 0) but I explicitly
avoided to set sk_prot->stream_memory_free, so sk_stream_wait_memory()
could wake the reader too early.

I'll send a v2 addressing the above.

Cheers,

Paolo

