Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CB21361
	for <mptcp@lists.linux.dev>; Wed, 20 Dec 2023 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jj3jG2Sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703067770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPjOj5+3IbswkMBk5a3dR6rDf6VmDEAd/bulLNLFh9g=;
	b=Jj3jG2Sf3teVTPtYMu7YgNdV9OvNhArdj7H3owtg/PojXe0B0tIp+3LtAvR53jJBzBlwVe
	JcpHEzqr1oSlqFwFHakLhQAug/hDQCTimIgtz8kWm52ZHfaODE469xZkmNS7N50suuGN9l
	VAbAchdlnq5ZlbawwC2WnQwf9fcaJvk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-CiucVgUeNRyJ6gqhAfDrbg-1; Wed, 20 Dec 2023 05:22:48 -0500
X-MC-Unique: CiucVgUeNRyJ6gqhAfDrbg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a24901893abso22601466b.1
        for <mptcp@lists.linux.dev>; Wed, 20 Dec 2023 02:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703067767; x=1703672567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tenCflcvwHDUupcimFI6COHvWVks/d4mt7BRqPCBH0=;
        b=g12ESHMccpIoLj9BkBgH1WSHH/xdF9VvvP+qzRbc9Z1Jqg0RcwSJiTl3mVZXaSEM2R
         hjXeg9yf/kcuHxr5EXKUqo5Uc0DZFX+hE/gNcEq5qNHMfUuqA9WH2Tjmy9wOt0d5VDGf
         ge284KF2fBIeQ2plA3qjkIWMVs63Rkas9kxxBT7gddgBPjAo/Zdzj249wEYFu88/2vhi
         KMtS3ASBlTye5+Z07Hj+A9ysQCztTJ1HZhVCg8IT/KaCp8SVmwR2dr912reOMW+wBcuE
         DB/Cpuw7Kor5Pa635uGzRlqT031Zv25pv6jC8A+ooM31Ae5q6nBc4VyncPpBsBwLULns
         Yfvw==
X-Gm-Message-State: AOJu0YzFv98ztQ/LfIN2RsLKfYgwovWMQHjfgOL17TEeyvoSEX0ILQPZ
	Ntk/CRxmfcLrQGGHL9VCbdXrpjPZWuQk8+BEaVxPW9MQiDQqcq1TrVaKu/HBibBnm5C1M2wUfjZ
	VB+lMRKGY5Q9RU1c=
X-Received: by 2002:a17:907:72c3:b0:a23:679c:4683 with SMTP id du3-20020a17090772c300b00a23679c4683mr4746669ejc.4.1703067767638;
        Wed, 20 Dec 2023 02:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtUPRbx8MOeVOB8yA1mqeocJegsUUHrUmn8bGLwalPKHDnymDVFdMN/bgsTjAY0nQT2gkKMA==
X-Received: by 2002:a17:907:72c3:b0:a23:679c:4683 with SMTP id du3-20020a17090772c300b00a23679c4683mr4746660ejc.4.1703067767211;
        Wed, 20 Dec 2023 02:22:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906265300b00a234c5d0834sm4115922ejc.175.2023.12.20.02.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:22:46 -0800 (PST)
Message-ID: <533e8e80c4db4ecd34a2c49dd3de3e76810afe22.camel@redhat.com>
Subject: Re: [PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in
 skb_steal_sock().
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>, Kuniyuki Iwashima
 <kuniyu@amazon.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, edumazet@google.com, 
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  kuni1840@gmail.com, martin.lau@linux.dev,
 netdev@vger.kernel.org,  mptcp@lists.linux.dev
Date: Wed, 20 Dec 2023 11:22:45 +0100
In-Reply-To: <7d00ad25-abaa-191d-8e80-32674377b053@kernel.org>
References: <CANn89i+8e8VJ8cJX6vwLFhtj=BmT233nNr=F9H3nFs8BZgTbsQ@mail.gmail.com>
	 <20231215023707.41864-1-kuniyu@amazon.com>
	 <7d00ad25-abaa-191d-8e80-32674377b053@kernel.org>
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

On Tue, 2023-12-19 at 08:45 -0800, Mat Martineau wrote:
> On Fri, 15 Dec 2023, Kuniyuki Iwashima wrote:
>=20
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Thu, 14 Dec 2023 17:31:15 +0100
> > > On Thu, Dec 14, 2023 at 4:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >=20
> > > > We will support arbitrary SYN Cookie with BPF.
> > > >=20
> > > > If BPF prog validates ACK and kfunc allocates a reqsk, it will
> > > > be carried to TCP stack as skb->sk with req->syncookie 1.  Also,
> > > > the reqsk has its listener as req->rsk_listener with no refcnt
> > > > taken.
> > > >=20
> > > > When the TCP stack looks up a socket from the skb, we steal
> > > > inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock() so that
> > > > the skb will be processed in cookie_v[46]_check() with the
> > > > listener.
> > > >=20
> > > > Note that we do not clear skb->sk and skb->destructor so that we
> > > > can carry the reqsk to cookie_v[46]_check().
> > > >=20
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  include/net/request_sock.h | 15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/net/request_sock.h b/include/net/request_sock.=
h
> > > > index 26c630c40abb..8839133d6f6b 100644
> > > > --- a/include/net/request_sock.h
> > > > +++ b/include/net/request_sock.h
> > > > @@ -101,10 +101,21 @@ static inline struct sock *skb_steal_sock(str=
uct sk_buff *skb,
> > > >         }
> > > >=20
> > > >         *prefetched =3D skb_sk_is_prefetched(skb);
> > > > -       if (*prefetched)
> > > > +       if (*prefetched) {
> > > > +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> > > > +               if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV && inet_re=
qsk(sk)->syncookie) {
> > > > +                       struct request_sock *req =3D inet_reqsk(sk)=
;
> > > > +
> > > > +                       *refcounted =3D false;
> > > > +                       sk =3D req->rsk_listener;
> > > > +                       req->rsk_listener =3D NULL;
> > >=20
> > > I am not sure about interactions with MPTCP.
> > >=20
> > > I would be nice to have their feedback.
> >=20
> > Matthieu, Mat, Paolo, could you double check if the change
> > above is sane ?
> > https://lore.kernel.org/bpf/20231214155424.67136-4-kuniyu@amazon.com/
>=20
> Hi Kuniyuki -
>=20
> Yes, we will take a look. Haven't had time to look in detail yet but I=20
> wanted to let you know we saw your message and will follow up.

I'm sorry for the late reply.

AFAICS, from mptcp perspective, the main differences from built-in
cookie validation are:

- cookie allocation via mptcp_subflow_reqsk_alloc() and cookie
'finalization' via cookie_tcp_reqsk_init() /
mptcp_subflow_init_cookie_req(req, sk, skb) could refer 2 different
listeners - within the same REUSEPORT group.

- incoming pure syn packets will not land into the TCP stack, so
af_ops->route_req will not happen.

I think both the above are problematic form mptcp.=C2=A0

Potentially we can have both mptcp-enabled and plain tcp socket with
the same reuseport group.=20

Currently the mptcp code assumes the listener is mptcp
cookie_tcp_reqsk_init(), the req is mptcp, too. I think we could fix
this at the mptcp level, but no patch ready at the moment.

Even the missing call to route_req() is problematic, as we use that to
fetch required information from the initial syn for MP_JOIN subflows -
yep, unfortunately mptcp needs to track of some state across MPJ syn
and MPJ 3rd ack reception.

Fixing this last item looks more difficult. I think it would be safer
and simpler to avoid mptcp support for generic syncookie and ev enable
it later - after we address things on the mptcp side.

@Eric, were you looking to something else and/or more specific?

Thanks!

Paolo


