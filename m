Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0C8C02
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680197073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD7GvyKowDYvkBnFwHq/6dzLj7+z3IRrcYLwDHCWrNQ=;
	b=VaB8lJaB2vhFtqaHGE8ouRBhK91H2Wyxrqbet5b/RvLex1SzB7RRd5H/QJTdeIYd+pmwvB
	0ofaSUV+opMtwXgGXSppLVF5SR3X5PkjNDnEsgmav01HHSgprB3c77OH2Gi3MavYn+997B
	YmR3L8MO5/N2CifLtQKUOktjQ4CNE/g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-VQ9Hx5TqMa6em0h_kWfc8A-1; Thu, 30 Mar 2023 13:24:32 -0400
X-MC-Unique: VQ9Hx5TqMa6em0h_kWfc8A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5aae34d87f7so13150746d6.0
        for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 10:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197072;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBweDNde1FJMyTTvOnlgTAUS9KkUxE0+bKl6ljGaiuI=;
        b=U3OQdlzDK5DVow9tnWhxMi708zeDAripxhlc57FKxENn5di09iB2PcLNQerhybDGgI
         PilfJPdv9X/g8lQ8zysXvQoZRNgVnWgTRYxuOqpP5wfIMpe55y/byacVeQkhMo4R9lBm
         pFPYtr4kdV4z1uCwZZz6mRSnUiN6TchX/ugLySZeKJTJ1gZmZyDj0m+Fu8PE2lsPPO7g
         w0R4UMN47I8O4xMdqClNpoAPeCXv1ueDHsYN6VBoD9s/IODjvDzkNm4i9GXzJc7DCU40
         OkQRMvYVBMB7rvjABpObkj+7jsL10GY7/1EE7QJPkQP1Y9MLHWiToTgfYd8/HRuHKaa0
         eq+A==
X-Gm-Message-State: AAQBX9dhSh2UOaLd/BrrrLKGQmPoaQGSM4z//c1KTgJ64RqVcfH1Qhhj
	koJ5N9wnBdJAIqJSMx1lC8kI073fboQN36Di+nPv+J1SNApsEN5ZegK3XlWuh2gbAn6MiVb+wTA
	lQL1Go6mJc0eURfU=
X-Received: by 2002:a05:6214:4007:b0:5da:b965:1efe with SMTP id kd7-20020a056214400700b005dab9651efemr4061582qvb.4.1680197072022;
        Thu, 30 Mar 2023 10:24:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdWX2Bu6+V9wHqPTCiaAIjDlnfAqb9cl0Bv3Zh+9Xt0gLqrVrntOun7MvSicsNbSFAfmLLAg==
X-Received: by 2002:a05:6214:4007:b0:5da:b965:1efe with SMTP id kd7-20020a056214400700b005dab9651efemr4061563qvb.4.1680197071788;
        Thu, 30 Mar 2023 10:24:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-125.dyn.eolo.it. [146.241.228.125])
        by smtp.gmail.com with ESMTPSA id g125-20020a37b683000000b007486cc8a3f8sm18667qkf.23.2023.03.30.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 10:24:31 -0700 (PDT)
Message-ID: <6194ed6e679f6a0a21ac6f25ea23d71e56a9dae6.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 2/2] mptcp: fix accept vs worker race
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Thu, 30 Mar 2023 19:24:29 +0200
In-Reply-To: <c181f78a-ce58-a9b3-c86b-c33c63771882@tessares.net>
References: <cover.1680110912.git.pabeni@redhat.com>
	 <93685516f6f6d543c831013f957a03a21f774fd9.1680110912.git.pabeni@redhat.com>
	 <c181f78a-ce58-a9b3-c86b-c33c63771882@tessares.net>
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

On Thu, 2023-03-30 at 19:20 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> Thank you for this patch!
>=20
> On 29/03/2023 19:32, Paolo Abeni wrote:
> > The mptcp worker and mptcp_accept() can race, as reported by Christoph:
>=20
> (...)
>=20
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index d90267da9114..d9f5dcc734b1 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
>=20
> (...)
>=20
> > @@ -1846,18 +1848,25 @@ void mptcp_subflow_queue_clean(struct sock *lis=
tener_sk, struct sock *listener_s
> >  =09release_sock(listener_ssk);
> > =20
> >  =09for (msk =3D head; msk; msk =3D next) {
> > -=09=09struct sock *sk =3D (struct sock *)msk;
> > -
> >  =09=09lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> > +=09=09sk =3D (struct sock *)msk;
>=20
> Just to be sure, you do the lock_sock_nested() on the previous 'sk' and
> then switch to the new one on purpose?

Well, no ;) I changed the above few lines too many times and ended-up
with messing them.

I'll send a v3.

Thanks!

Paolo

