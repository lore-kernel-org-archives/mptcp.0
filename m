Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB91F933
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684860333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zYCkb8kcoPtg1/FK93G3TJnKp4oQBoJz0eFAfFfmbo=;
	b=ZKzx9V6+qe+zv1bCLhH9hAalX5ld9LqsZTvTCrsZL0f2saMnMG98VUnTnSEvLBGmtTe+dE
	nWpDUlbiaWKhwlf09iblzHXfl592SL7hGffbNPEC6l2TggE4c1JneS2Etfosil+r3T1lj/
	FxXHFi+50WAhSnF0nCb+QjHw1yoano4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-iIFIvgbPOv-tHdl5GuBCzA-1; Tue, 23 May 2023 12:45:32 -0400
X-MC-Unique: iIFIvgbPOv-tHdl5GuBCzA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b1224f63aso856485a.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860331; x=1687452331;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqzM7aFx8Iq3DOPao9okBNB8K/IUNC4MLeA+2F53kqw=;
        b=KtscLSWHVxCoHKdE3fIlNsoNzsXS5c5fCKbKHrIJ13v4NaIMfujKy5ksrz8XYcMgKq
         3zDwsUzxj0Bm2bBQAxrtgDVNuMhAts65tL10dfuzn19wWxCWrT/CqXiYMEbwgqds7fUp
         UY480RnaMQzug2/MPHg/ZE9Xmy2vbrzuthXnAABJkjsXcPYtKmK9/XNjd6shx/3ls/Tb
         3U2NOJQqdwsqMJzFC76XKMQ7I3540AN43/KmFhPFlu9BoFTyiFdHl9qe3w1z1scVEFSY
         7+YVouuhfv95F4b8dEkWzIDwVF2avnatun55iObFcCKhnr5cyhHBv4PJRpKCmLPL/IvT
         Xgbg==
X-Gm-Message-State: AC+VfDxKqJt59jB98UBn8Gqzw2kLc5Ggti8/zUAZ2PSLvA4e9elKtOfz
	SM6wQJQNGlwfxZPDx1leL+b6nrdwjqO+pn8PYNTVPdxrR44prtlehobb0x/BwpfGPt+MMuVa9U8
	xp7a52oyhEcR4vI/EURuJq9Q=
X-Received: by 2002:a05:620a:838a:b0:75b:23a1:1de6 with SMTP id pb10-20020a05620a838a00b0075b23a11de6mr5050167qkn.3.1684860331622;
        Tue, 23 May 2023 09:45:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KgVzyW93oaRg2eMEHJ6+n5XybELiRsqN+AgaZUfW0PvMHM45l1XjaZbRUzAB2u95/Od20Aw==
X-Received: by 2002:a05:620a:838a:b0:75b:23a1:1de6 with SMTP id pb10-20020a05620a838a00b0075b23a11de6mr5050145qkn.3.1684860331233;
        Tue, 23 May 2023 09:45:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-246-0.dyn.eolo.it. [146.241.246.0])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a200200b007593af0c85fsm2632337qka.88.2023.05.23.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:45:30 -0700 (PDT)
Message-ID: <7e490b1f2ada9d3caaf29118f5bc2fb1484aa0ec.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/6] mptcp: add subflow unique id
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 23 May 2023 18:45:28 +0200
In-Reply-To: <18e20b8f-aaf1-81ae-1f88-8572bf270098@tessares.net>
References: <cover.1684763196.git.pabeni@redhat.com>
	 <82dfa3a412939eb515bba411d8aa585f987e61f6.1684763196.git.pabeni@redhat.com>
	 <18e20b8f-aaf1-81ae-1f88-8572bf270098@tessares.net>
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

On Tue, 2023-05-23 at 17:20 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 22/05/2023 15:56, Paolo Abeni wrote:
> > The user-space need to preperly account the data received/sent by
> > individual subflows. When additional subflows are created and/or
> > closed during the MPTCP socket lifetime, the information currently
> > exposed via MPTCP_TCPINFO are not enough: subflows are identifed only
> > by the sequential position inside the info dumps, and that will change
> > with the above mentioned events.
> >=20
> > To solve the above problem, this patch introduces a new subflow identif=
ier
> > that is unique inside the given mptcp socket scope.
> >=20
> > The initial subflow get the id 1 and the other subflows get incremental
> > values at join time.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - properly set subflow_id for the first passive subflow and active sub=
flows, too
> >  - drop the tcpi_fackets overload
> > ---
>=20
> (...)
>=20
> > @@ -3203,6 +3206,7 @@ struct sock *mptcp_sk_clone_init(const struct soc=
k *sk,
> >  =09msk->snd_nxt =3D msk->write_seq;
> >  =09msk->snd_una =3D msk->write_seq;
> >  =09msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
> > +=09msk->subflow_id++;
>=20
> It is a bit confusing. Just to be sure, here it would be the same to do
>=20
>   msk->subflow_id =3D 1;
>=20
> because subflow_id from the listener will be 0, right?

You are right, my code above is confusing and even incorrect. I'll
replace it with the plain assignment.

Thanks!

/P

