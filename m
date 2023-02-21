Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094504C64
	for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676992715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMCIUZ7YHOFgxbY9yCgUzQZMyf4Amtp+AvbBw5mKJe0=;
	b=WJYmeQlt9onRjc+mYCCQBFA0YLSOEgwkAFsh2Rg4KkZ4631Ub+Q6yk97U2TmpKBS0tfjUF
	4B4o2vlhXAoLE21qTEjYeE0PBWS/EJRN3BYP/jQXwE+f2eJIu0rKT+FxGHhU22eKpCogId
	zx/NT0WuLrl5bx6ig9eQ03uavBq7qm4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-k3DZSswkMe2n6S_5iBd9lg-1; Tue, 21 Feb 2023 10:18:27 -0500
X-MC-Unique: k3DZSswkMe2n6S_5iBd9lg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-536be78056eso37440457b3.1
        for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 07:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMCIUZ7YHOFgxbY9yCgUzQZMyf4Amtp+AvbBw5mKJe0=;
        b=Gn08Nh9ixcl8Wxlod0eH1pfVnT/bvuEEWZy1uxvZHFlG/wRV/sNyPfog5MqpZ5jp/M
         KV6Tj09FQaumwS2ySeekqWY+5FwfV9eqTXoWgwgYXgpGpSnazeTvtILIq/xOkFQDerKD
         nvE3XgfsgbQFRqZThtzYaz+b8+kq1POEtIHVzACMT6/iyw5EuexowudNrkA7hvr/KCsV
         sWwI37HiMykdh7vbU14uy1pH41aSmMmg4OzAdjPTxkBOe8q6ncfU5JxBbobtGytFSVDX
         YnpqunZg2hceJx1J+PykyKKbrFrbdHJ9MC7WwtlcqvoBi8b438x4R5vhF7S0Vm2rUbxS
         3hNQ==
X-Gm-Message-State: AO0yUKViiPUjczNP0s97aH9iu7vQzz4ot1qrN9BK5cfv1cJhxqbjsKh2
	28fWxjF9jWUBlCBhbQPq9XY/o6oUq26aKErub6zAYkf66LtcPZJghi0fQt5gsrqi4XFrymV7sFo
	GXx107k42MtnX878IkgVp+d8=
X-Received: by 2002:a81:ac10:0:b0:536:4194:e6e6 with SMTP id k16-20020a81ac10000000b005364194e6e6mr3726013ywh.5.1676992698015;
        Tue, 21 Feb 2023 07:18:18 -0800 (PST)
X-Google-Smtp-Source: AK7set8WvF7K9YyL2rn2D50lVMAER5Dv9oMgmYQRyPJGcqrCPW/1MTo59aC1BXMF/sEKEB4ul2Dwhg==
X-Received: by 2002:a81:ac10:0:b0:536:4194:e6e6 with SMTP id k16-20020a81ac10000000b005364194e6e6mr3725989ywh.5.1676992697565;
        Tue, 21 Feb 2023 07:18:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id v185-20020a3793c2000000b0073b9ccb171asm480839qkd.130.2023.02.21.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:18:17 -0800 (PST)
Message-ID: <8f8b4663ae3a35c5302a291538e7d36d6e1920ca.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash-to: mptcp: refactor passive socket
 initialization
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 21 Feb 2023 16:18:14 +0100
In-Reply-To: <f2c3d45b-6bab-5747-98f2-b2cdfef5127d@tessares.net>
References: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
	 <7a23540c-0c17-6a8a-7826-2cea1e7c2ebf@tessares.net>
	 <ff85210e42fbacb69ae14d4ae972e8a95c098962.camel@redhat.com>
	 <7f6f4cf7-b643-544c-1fab-a19a4d6ea75f@tessares.net>
	 <f2c3d45b-6bab-5747-98f2-b2cdfef5127d@tessares.net>
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

On Mon, 2023-02-20 at 17:43 +0100, Matthieu Baerts wrote:
> On 20/02/2023 17:26, Matthieu Baerts wrote:
> >=20
> >=20
> > On 20/02/2023 17:09, Paolo Abeni wrote:
> > > On Mon, 2023-02-20 at 16:01 +0100, Matthieu Baerts wrote:
> > > > Hi Paolo,
> > > >=20
> > > > On 20/02/2023 15:27, Paolo Abeni wrote:
> > > > > Since the squash-to commit, msk->first is set even for unaccepted
> > > > > sockets: mptcp_mp_fail_no_response() can take action and reset
> > > > > the subflow even when msk->first is still in the accept queue,
> > > > > after that incoming reset already closed such socket.
> > > > >=20
> > > > > That in turn will end-up calling tcp_done() - via mptcp_subflow_r=
eset()
> > > > > - on already closed sockets, which is illegal.
> > > >=20
> > > > Should we not add a WARN_ON() there for our CI (and syzkaller) to c=
atch
> > > > that earlier?
> > >=20
> > > If you mean as a non upstreamable patch touching tcp_done(), that cou=
ld
> > > be useful.
> >=20
> > Yes, a non upstreamable patch, similar to:
> >=20
> >   mptcp: use kmalloc on kasan build
> >=20
> > > I think it's better not touching the upstream code enforcing such
> > > constraint (either tcp or mptcp one) because it should be an "obvious=
"
> > > one.
> >=20
> > Indeed but it is just to warn once before having real issues :)
> > But it makes sense not to upstream this.
>=20
> I just tried this patch on top of the export branch and I got a warning
> with the 2nd test of "mptcp_join.sh" :-D
>=20
> ------------------- 8< -------------------
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 33f559f491c8..d21ec9bdd453 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4639,6 +4639,8 @@ void tcp_done(struct sock *sk)
>          */
>         req =3D rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk, 1);
>=20
> +       WARN_ON_ONCE(sk->sk_state =3D=3D TCP_CLOSE);
> +
>         if (sk->sk_state =3D=3D TCP_SYN_SENT || sk->sk_state =3D=3D TCP_S=
YN_RECV)
>                 TCP_INC_STATS(sock_net(sk), TCP_MIB_ATTEMPTFAILS);
>=20
>=20
> ------------------- 8< -------------------

Could you please share the (decoded) stack trace?

Thanks!

/P

