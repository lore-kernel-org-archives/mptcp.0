Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F779F0
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689322533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReEauez+22x8Co+Kw43lYsnHZeLL2uBQKwKh4x67xSk=;
	b=jSiqsG9JJ7OQ/tlnoQhIG957y32nb9ijd7jVfXZQBo77ORmxVMpVplyKUvLLqHiDBt+PB8
	ZUDH8UXZy9h4xSs8N7ScMjiGzktLXTI4bBgwP1ZZwNl0f5PIqN+lYHO+asUfbRGB3QEzBy
	R/vUqOzqgaRY42biv2GYAB9Xkvy/vYY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-N_8FZWASMD2Si5NRNZUjeA-1; Fri, 14 Jul 2023 04:15:32 -0400
X-MC-Unique: N_8FZWASMD2Si5NRNZUjeA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-401df9d2dc4so3832621cf.0
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 01:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322532; x=1691914532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiIZXuTC8UEt0F4l9XCO2WLHmRkfPzv7+IWhs4SbzJo=;
        b=gZjs/nC4wSmdxyMP3rpkTMhVsLvgNE6iu8ovrfnMo8WawWMofape10rU5GpWNXKfgO
         2ssYDeUFTnpJDXN7hteBpsrdIM91OzyraHQYCHuoRdDi0v0/rRCbv9ZY5r7627tmi379
         iC/TRtLkAheafuZSKbAlMo9dr3R6SfJGeGpTHEvLG68aFFH8e5KHK7gaHbrVPwKi5gA8
         Hbet5Gs56uaz9s7SMz+8sbKIc51OSJni9XEc+Mph23cOcWeF3DLcJmrUgjEO5ReJ0SYc
         hGa5A36XS3kV/BCu8OmiLopUY+OUsgYCF8xllrnx7XjMso2/S79DuA/wbZEUAMt99iQ7
         f3og==
X-Gm-Message-State: ABy/qLZq/ZYvuJDrwG0tK5DHwVHrydFrLFxPLolYofITHPagaMRnAOG7
	34W6n0nE3eDYwFC5wgptU9q0sl/M8iS79K54BTysplPuI+mZT18QKHb9Rw+lsBmGEzQwR/3PJZN
	P1+dFZ3JaUBIcKFg=
X-Received: by 2002:a05:622a:1888:b0:400:8036:6f05 with SMTP id v8-20020a05622a188800b0040080366f05mr5264703qtc.2.1689322531787;
        Fri, 14 Jul 2023 01:15:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEiv/bMbbujwW+aImRb079PVQiMk4acpnyM7v/KUSoFCEswpVutLQkaovl8W3/hr2SpqJy2Ig==
X-Received: by 2002:a05:622a:1888:b0:400:8036:6f05 with SMTP id v8-20020a05622a188800b0040080366f05mr5264689qtc.2.1689322531497;
        Fri, 14 Jul 2023 01:15:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id d25-20020ac85459000000b004009f6e7e7csm3764702qtq.31.2023.07.14.01.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:15:31 -0700 (PDT)
Message-ID: <55e3409dd8ce16914f44d2d5d9eaf2bdb83f3315.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 03/14] mptcp: avoid additional
 __inet_stream_connect() call
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 Jul 2023 10:15:28 +0200
In-Reply-To: <6f46d6b1-2aa9-e56f-f473-0300c08e2788@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com>
	 <3f427fdc84212cde2d5ad09a46925a43a4a0fae7.1688993569.git.pabeni@redhat.com>
	 <6f46d6b1-2aa9-e56f-f473-0300c08e2788@kernel.org>
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

On Wed, 2023-07-12 at 14:49 -0700, Mat Martineau wrote:
> On Mon, 10 Jul 2023, Paolo Abeni wrote:
>=20
> > The mptcp protocol maintains an additional socket just to easily
> > invoke a few stream operations on the first subflow. One of them is
> > __inet_stream_connect().
> >=20
>=20
> Hi Paolo -
>=20
> Thanks for the series! It will be good to get rid of the confusing subflo=
w=20
> pointer.
>=20
> > We are going to remove the first subflow socket soon, so avoid
> > the addictional indirection via at connect time, calling directly
>        ^^^^^^^^^^^
>=20
> "additional" is misspelled this way in many of the series commit messages=
.

Oops, I guess that the "many" above burns my usual "is a typo" excuse;)

> > @@ -3629,22 +3629,24 @@ static int mptcp_connect(struct sock *sk, struc=
t sockaddr *uaddr, int addr_len)
> > =09struct mptcp_sock *msk =3D mptcp_sk(sk);
> > =09struct socket *ssock;
> > =09int err =3D -EINVAL;
> > +=09struct sock *ssk;
> >=20
> > =09ssock =3D __mptcp_nmpc_socket(msk);
> > =09if (IS_ERR(ssock))
> > =09=09return PTR_ERR(ssock);
> >=20
> > =09inet_sk_state_store(sk, TCP_SYN_SENT);
> > -=09subflow =3D mptcp_subflow_ctx(ssock->sk);
> > +=09ssk =3D msk->first;
> > +=09subflow =3D mptcp_subflow_ctx(ssk);
> > #ifdef CONFIG_TCP_MD5SIG
> > =09/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> > =09 * TCP option space.
> > =09 */
> > -=09if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
> > +=09if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
> > =09=09mptcp_subflow_early_fallback(msk, subflow);
> > #endif
> > -=09if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
> > -=09=09MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT=
);
> > +=09if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
> > +=09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
> > =09=09mptcp_subflow_early_fallback(msk, subflow);
> > =09}
> > =09if (likely(!__mptcp_check_fallback(msk)))
> > @@ -3653,21 +3655,37 @@ static int mptcp_connect(struct sock *sk, struc=
t sockaddr *uaddr, int addr_len)
> > =09/* if reaching here via the fastopen/sendmsg path, the caller alread=
y
> > =09 * acquired the subflow socket lock, too.
> > =09 */
> > -=09if (msk->fastopening)
> > -=09=09err =3D __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK=
, 1);
> > -=09else
> > -=09=09err =3D inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
> > -=09inet_sk(sk)->defer_connect =3D inet_sk(ssock->sk)->defer_connect;
> > +=09if (!msk->fastopening)
> > +=09=09lock_sock(ssk);
> > +
> > +=09if (ssk->sk_state !=3D TCP_CLOSE)
> > +=09=09goto out;
> > +
> > +=09if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
> > +=09=09err =3D ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
> > +=09=09if (err)
> > +=09=09=09goto out;
> > +=09}
> > +
> > +=09err =3D ssk->sk_prot->connect(ssk, uaddr, addr_len);
> > +=09if (err < 0)
> > +=09=09goto out;
> > +
> > +=09inet_sk(sk)->defer_connect =3D inet_sk(ssk)->defer_connect;
>=20
> The above code doesn't do everything __inet_stream_connect() does. Is tha=
t=20
> code omitted here because the caller of this function handles the timeout=
s=20
> and msk-level socket states already?

Yes. The main point is that we had an inet_stream_connect() call in the
existing/prior code because we did not have access to a more
specific/constrained helper. Maintaining the struct socket state for
the ssock will be useless soon - we are going to drop such struct. So
the above should be all we really need.


Cheers,

Paolo

