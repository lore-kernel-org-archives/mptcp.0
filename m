Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942223C6A
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684419436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awqFsFrKS36DwghnBliUmnAKb2VyumzXlkdRexGI9Yg=;
	b=C5eOk5HaxZTKFH12wwTpKyj4ZRXo9s5J75GZZegxDCwmb9GJxpZ/SH9twcBErxjIYlVrlT
	NSMyxVpPG8d5orolLqxcp2FMIIzCR8ibtBuecketgmjxdnQQ2G9ifaltCjg6xOeQpMOmyh
	RrQ66ecwhnxn5365p1ZflcL3Zi4h/ts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-xRVApyvFMiiPdtJFnAldNQ-1; Thu, 18 May 2023 10:17:15 -0400
X-MC-Unique: xRVApyvFMiiPdtJFnAldNQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f08900caadso3475625e9.0
        for <mptcp@lists.linux.dev>; Thu, 18 May 2023 07:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684419434; x=1687011434;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+erPCXND9ULDQDrNT2Hwz9DjBv1DXKDnOQ+3OmNgt8=;
        b=auR+VVHD3sn2ASCTIdvqFfeoGZnnMZeuk5O/rqoA13Tb2hWAfyVItyUOkVpdffDKcw
         ZnjBYSp6DQVs85Co+/BBWfX7thBLdkz6Ov+N3aLiKFif56ywDW7UUaeMk7lWL1/nwJ7V
         wMeCRP+2euKudKZU+jEzKzBCnzVxv53MvdZqCiIRJGaAAlGAcoat2gEumU3iyArOCj8q
         4BuIdxnpzGAaUxZZ1Lh7l2plcMN8/uJwhAeaqI0Y2gnMe2BXapxJlzssa2R/OY9DMF2s
         q+UEsGAW+UIx9YiqQLYa2B2JK0l6sDFuiubRg1HULh4QnAZwDLIrN0H26zHW+3ipMKUM
         /LNQ==
X-Gm-Message-State: AC+VfDwm17C1+mvFLn0stm+N/bJ3mEFffJnxQFC2bkyEMr/YONxYMGaI
	KD0uRIat+yxtWV75F9vFgqj11h3IF5yw9g4hTFgc9/Xaco1OdMcBNuiveoD5RDnKutGH2urNYZg
	+gnOVjgWI3tpsswo=
X-Received: by 2002:adf:e984:0:b0:309:3a72:3cea with SMTP id h4-20020adfe984000000b003093a723ceamr4051479wrm.0.1684419434203;
        Thu, 18 May 2023 07:17:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6chnlvDRi8M8ZCI8GBL8EQ5P6m8P0adQFAVS0De1pR20uFxa/3WnxJpnM9LRRfX3REmtclZw==
X-Received: by 2002:adf:e984:0:b0:309:3a72:3cea with SMTP id h4-20020adfe984000000b003093a723ceamr4051464wrm.0.1684419433785;
        Thu, 18 May 2023 07:17:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-175.dyn.eolo.it. [146.241.239.175])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6509000000b003062d815fa6sm2321632wru.85.2023.05.18.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:17:13 -0700 (PDT)
Message-ID: <b414faa5313b041cf68b4a0d98eb4b2ee16f93ee.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/4] mptcp: track some aggregate data
 counters.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 18 May 2023 16:17:12 +0200
In-Reply-To: <9962f754-1d08-4982-e55e-63e25a7c365b@tessares.net>
References: <cover.1683212362.git.pabeni@redhat.com>
	 <df47acfb7e35b28e3eb4f591f182c383bc2076d7.1683212362.git.pabeni@redhat.com>
	 <9962f754-1d08-4982-e55e-63e25a7c365b@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
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

On Wed, 2023-05-17 at 16:26 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 04/05/2023 18:40, Paolo Abeni wrote:
> > Currently there are no data transfer counters accounting for all
> > the subflows used by a given MPTCP socket. The user-space can compute
> > such figures aggregating the subflow info, but that is inaccurate
> > if any subflow is closed before the MPTCP socket itself.
> >=20
> > Add the new counters in the MPTCP socket itself and expose them
> > via the existing diag and sockopt. While touching mptcp_diag_fill_info(=
),
> > acquire the relevant locks before fetching the msk data, to ensure
> > better data consistency
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> (...)
>=20
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index d2aa02e28917..2265387a5db2 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -888,7 +888,9 @@ static int mptcp_getsockopt_first_sf_only(struct mp=
tcp_sock *msk, int level, int
> > =20
> >  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *i=
nfo)
> >  {
> > +=09struct sock *sk =3D (struct sock *)msk;
> >  =09u32 flags =3D 0;
> > +=09bool slow;
> > =20
> >  =09memset(info, 0, sizeof(*info));
> > =20
> > @@ -914,11 +916,21 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk,=
 struct mptcp_info *info)
> >  =09if (READ_ONCE(msk->can_ack))
> >  =09=09flags |=3D MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
> >  =09info->mptcpi_flags =3D flags;
> > -=09info->mptcpi_token =3D READ_ONCE(msk->token);
> > -=09info->mptcpi_write_seq =3D READ_ONCE(msk->write_seq);
> > -=09info->mptcpi_snd_una =3D READ_ONCE(msk->snd_una);
> > -=09info->mptcpi_rcv_nxt =3D READ_ONCE(msk->ack_seq);
> > -=09info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
> > +=09mptcp_data_lock(sk);
> > +=09info->mptcpi_snd_una =3D msk->snd_una;
> > +=09info->mptcpi_rcv_nxt =3D msk->ack_seq;
> > +=09info->mptcpi_bytes_acked =3D msk->bytes_acked;
> > +=09mptcp_data_unlock(sk);
>=20
> Do you know if this could have a "bad" impact on the performances?

It depends ;)

If you do something alike:

for CPU in $(seq $(nproc)); do while ss -M; do :; done & done

it will impact mptcp socket performances ;)

For a more reasonable usage, nothing measurable is expected: once every
a few minutes? hours? much longer interval? an additional process will
compete for the mptcp data and socket lock. It's not expected to matter
much.

The fact we need to acquire independently the data lock and socket lock
is a bit not nice - for the user-space requesting the dump. It can
possibly be avoided implementing some helper to upgrade the mptcp data
lock to the (fast) socket lock, but at this point I think it would be a
bit overkill.

> I mean mptcp_diag_fill_info() is also used on when dumping all the
> connections via Netlink. I guess the lock_sock_fast() should be fine
> because it is also used in tcp_get_info() but what about the data lock?
> Also OK because that's a spin lock and we only copy fields?

The main impact we have on the data path is the dirtying of the msk
socket spin lock cacheline, which will possibly cause a cache miss on
the next data path lock operation, if the dumping happens on a
different core. Not relevant until we get many of them per socket per
seconds.

Cheers,

Paolo

