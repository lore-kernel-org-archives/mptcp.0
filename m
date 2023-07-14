Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAF6D3F
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689324156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l634xzaHUpk0quf74dlb6bpWxmn2ZdmlecFLsrybRVk=;
	b=Z1F3LWgbwrsoTzIAljZv8+lDCSgmeHz4+6D4TKo1DRFMvus4R6ZXq6akDF0Q/o2JMC7Zj7
	lR7IlMwreOKEbBJCyhcj+zI6WmDqLIxSNX1ZJaxR32HoH7rgDQsVJjbZXevdavuj1Zhseb
	Wios3DXuVnT50Em7ooqgSQ0KtRkj9Yw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-qaXE8h8KOHCyszlFmk8jcw-1; Fri, 14 Jul 2023 04:42:35 -0400
X-MC-Unique: qaXE8h8KOHCyszlFmk8jcw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-401df9d2dc4so3903321cf.0
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 01:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689324155; x=1691916155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbIh0Bd34/R0siOsZ7qQ2uSHv4nGNMCyK2AKpix+HWo=;
        b=Te73LCRR1eDAvu2NLQFSH2JptFGcrkkBE9BqKSZyc8Tqh3jIodu/s4oafXawmaCm2t
         AQ3AieQxgOOBmeBA6AEi63nD8odnn73wG5noYWWLzjPYyi+wFFIUbnU8AHRXOanj35sG
         i1PJstv1ezOejk103A0XVcXIBbdI41xSkPXmKuHxbRrVZLhmy8eXfYJTWPi20e0pFI3S
         6Y6tITk2rv+KrPNgKGuy/R3lXLXccgHMG12DsqiZvaJxuQbIX9qSO8I96Y4kpCdWfzSN
         bC7xbE0fwIh8M7flJ4CWfWuQH9sI1SM3cYdfzxjZQtqxu/gs/Bl2ycL6GdVIxbbNx5C7
         nb4w==
X-Gm-Message-State: ABy/qLZk4qjs+y6s/2NoR3VlwjDywOexG25Nbs1gdsqp+g7sOllJg2pL
	8UqxmmHkYI0sYOkflnRcqsKeb4uPRWsnB/zsPcjFcDsLDbMKAiOubjzjosKWsJ0rlGqCFpfaa4a
	LUjuACgsHrMjsRXQ=
X-Received: by 2002:a05:622a:1a23:b0:403:864b:7ab8 with SMTP id f35-20020a05622a1a2300b00403864b7ab8mr4915782qtb.1.1689324155060;
        Fri, 14 Jul 2023 01:42:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCuIVTKDbhiw0ylJElwklxYNjDDNqbhzjkuTT1T8BZenJSLQQ+Z6PNJivBJW13LYXiZpRFww==
X-Received: by 2002:a05:622a:1a23:b0:403:864b:7ab8 with SMTP id f35-20020a05622a1a2300b00403864b7ab8mr4915776qtb.1.1689324154801;
        Fri, 14 Jul 2023 01:42:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id c6-20020ac87d86000000b0040378535dccsm3778572qtd.43.2023.07.14.01.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:42:34 -0700 (PDT)
Message-ID: <a8bee177c8955e3bb7c856336cf2f5b27f7df93a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 10/14] mptcp: avoid unneeded indirection in
 mptcp_stream_accept()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 Jul 2023 10:42:32 +0200
In-Reply-To: <059ab23a-f925-a1c7-2a1d-a4e03714d66e@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com>
	 <7e485259a201fdac1807c56746bd437d4335edd1.1688993569.git.pabeni@redhat.com>
	 <059ab23a-f925-a1c7-2a1d-a4e03714d66e@kernel.org>
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

On Wed, 2023-07-12 at 14:55 -0700, Mat Martineau wrote:
> On Mon, 10 Jul 2023, Paolo Abeni wrote:
>=20
> > We are going to remove the first subflow socket soon, so avoid
> > the addictional indirection at accept() time. Instead access
> > directly the first subflow sock.
> >=20
> > No functional changes intended.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c | 17 +++++------------
> > 1 file changed, 5 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4e5c9770d8d6..00cfed1d0ebd 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3220,17 +3220,12 @@ static struct sock *mptcp_accept(struct sock *s=
k, int flags, int *err,
> > =09=09=09=09 bool kern)
> > {
> > =09struct mptcp_sock *msk =3D mptcp_sk(sk);
> > -=09struct socket *listener;
> > -=09struct sock *newsk;
> > +=09struct sock *ssk, *newsk;
> >=20
> > -=09listener =3D READ_ONCE(msk->subflow);
> > -=09if (WARN_ON_ONCE(!listener)) {
> > -=09=09*err =3D -EINVAL;
> > -=09=09return NULL;
> > -=09}
> > +=09ssk =3D READ_ONCE(msk->first);
>=20
> There's a check for NULL msk->first in mptcp_stream_accept() below, but=
=20
> the analogous NULL check in this function has been removed. Should this=
=20
> be checking? (not sure if we have test coverage for out-of-sequence=20
> accept() calls)

The existing check above was really a pedantic one. The caller
(mptcp_stream_accept) already checked the same field under the same
lock scope, so only random memory corruption could change it. Note that
mptcp_accept() can be invoked only by mptcp_stream_accept().

I'll a note in the commit message to explain why we can drop the check.

Thanks,

Paolo

