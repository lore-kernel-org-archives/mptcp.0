Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9681747A
	for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676559512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8LwyK0FZshjpSF4cfnQuxOaRRvsSOP7H7XBizKNq0M=;
	b=I4qqrnvYTm+cKOb0jZjmfej2YbzNXQFyE6RFeTrUaGwdbfknGGOe0xQ6wofXyjXK1wGDAx
	+HNDFL8a0jZUx5IEvjFimo6X0kGWrQW6u/tHwK9Ge98lrV99M99XjfBsrHlss3dP4GXMvF
	nt0dvd5iomr0cHHgZV/85MUmKIXykJQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-3HCww3p7MsWjO4OViv3EMg-1; Thu, 16 Feb 2023 09:58:31 -0500
X-MC-Unique: 3HCww3p7MsWjO4OViv3EMg-1
Received: by mail-qt1-f199.google.com with SMTP id cd3-20020a05622a418300b003b9bd2a2284so1337368qtb.4
        for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 06:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676559510;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhPxowSs3vABjqWAaT7xtbSwwXfcpjOfuz/6sg1Dpk0=;
        b=5F3pZ3OuyyCGlVcmRpjmswntXiOVKzhzeUAgM86B2Gg0civHAkpHWVcUA5QPRuFnwH
         eYf4dEV54K7OsK50UnnMuLhUtqqLf2PY4+/+2s2rnIt2mcLlTsenj3n+LFn9h458BGyQ
         Tt0EyqwJGZq2MfngDvLp00YvUgVeePavxsGhtfMFmRqp9DgwI/huwt2omCMWiCNNDqGn
         CJwph/NKywgBAnH89w0SjhL0vuTn5N8OgI/BtgzZEYz8hg5yAjS9oPYA0zPfNu8rrk6W
         7yclXAGsKcv/FI2Bk2oNuy7YzWKhcavLgRG3dXqni6PTvhZeN4N0AgIBaly5QeTqN30O
         KFGg==
X-Gm-Message-State: AO0yUKV0k2ENVs4CiKEVMPcjTUNbUgC0s7RA/oGqlBMXpSlW+mefw5SG
	a0yGd4mk/r8QP8Fn5/Ux/d4jmjv2zUYe9hcQOpLSpo5Qbs57Sr+T9AEmTfODHOUl6jmylQ1piE1
	fSyd6GoFLaBjC2UdEB4uI
X-Received: by 2002:a05:622a:290:b0:3bb:75c7:9326 with SMTP id z16-20020a05622a029000b003bb75c79326mr11692855qtw.0.1676559510333;
        Thu, 16 Feb 2023 06:58:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8fPP5bsUBoQNcX0qo4QfifvQDF59cDjJ628FKXK1rE3NYV0Pg3s2vBvYr7laMa9u1dE/XSzQ==
X-Received: by 2002:a05:622a:290:b0:3bb:75c7:9326 with SMTP id z16-20020a05622a029000b003bb75c79326mr11692830qtw.0.1676559510038;
        Thu, 16 Feb 2023 06:58:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id x1-20020ac81201000000b003b9b41a32b7sm1317102qti.81.2023.02.16.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:58:29 -0800 (PST)
Message-ID: <02bd5e032b3ab2afb290a75c649c4df119a73dbb.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 1/2] mptcp: use the workqueue to destroy
 unaccepted sockets.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Thu, 16 Feb 2023 15:58:27 +0100
In-Reply-To: <3e0bda7b-d05b-7e9c-4862-d93d120ac86c@tessares.net>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
	 <3e0bda7b-d05b-7e9c-4862-d93d120ac86c@tessares.net>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
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

On Wed, 2023-02-15 at 18:53 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 09/02/2023 19:48, Paolo Abeni wrote:
> > Christoph reported a UaF at token lookup time:
> >=20
> > BUG: KASAN: use-after-free in __token_bucket_busy+0x253/0x260
> > Read of size 4 at addr ffff88810698d5b0 by task syz-executor653/3198
> >=20
> > CPU: 1 PID: 3198 Comm: syz-executor653 Not tainted 6.2.0-rc59af4eaa31c1=
f6c00c8f1e448ed99a45c66340dd5 #6
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-=
0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x6e/0x91
> >  print_report+0x16a/0x46f
> >  kasan_report+0xad/0x130
> >  __token_bucket_busy+0x253/0x260
> >  mptcp_token_new_connect+0x13d/0x490
> >  mptcp_connect+0x4ed/0x860
> >  __inet_stream_connect+0x80e/0xd90
> >  tcp_sendmsg_fastopen+0x3ce/0x710
> >  mptcp_sendmsg+0xff1/0x1a20
> >  inet_sendmsg+0x11d/0x140
> >  __sys_sendto+0x405/0x490
> >  __x64_sys_sendto+0xdc/0x1b0
> >  do_syscall_64+0x3b/0x90
> >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >=20
> > We need to properly clean-up all the paired MPTCP-level
> > resources and be sure to release the msk last, even when
> > the unaccepted subflow is destroyed by the TCP internals
> > via inet_child_forget().
> >=20
> > We can re-use the existing MPTCP_WORK_CLOSE_SUBFLOW infra,
> > explicitly checking that for the critical scenario: the
> > closed subflow is the MPC one, the msk is not accepted and
> > eventually going through full cleanup.
> >=20
> > With such change, __mptcp_destroy_sock() is always called
> > on msk sockets, even on accepted ones. We don't need anymore
> > to transiently drop one sk reference at msk clone time.
>=20
> Thank you for the patch, I just have one question below if you don't mind=
 :)
>=20
> (...)
>=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 546df81c162f..d7588535bf6d 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2444,9 +2444,10 @@ static unsigned int mptcp_sync_mss(struct sock *=
sk, u32 pmtu)
> >  =09return 0;
> >  }
> > =20
> > -static void __mptcp_close_subflow(struct mptcp_sock *msk)
> > +static void __mptcp_close_subflow(struct sock *sk)
> >  {
> >  =09struct mptcp_subflow_context *subflow, *tmp;
> > +=09struct mptcp_sock *msk =3D mptcp_sk(sk);
> > =20
> >  =09might_sleep();
> > =20
> > @@ -2460,7 +2461,15 @@ static void __mptcp_close_subflow(struct mptcp_s=
ock *msk)
> >  =09=09if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
> >  =09=09=09continue;
> > =20
> > -=09=09mptcp_close_ssk((struct sock *)msk, ssk, subflow);
> > +=09=09mptcp_close_ssk(sk, ssk, subflow);
> > +=09}
> > +
> > +=09/* if the MPC subflow has been closed before the msk is accepted,
> > +=09 * msk will never be accept-ed, close it now
> > +=09 */
> > +=09if (!msk->first && msk->in_accept_queue) {
> > +=09=09sock_set_flag(sk, SOCK_DEAD);
> > +=09=09sk->sk_state =3D TCP_CLOSE;
>=20
> Would it make sense to call inet_sk_state_store() here, mainly for the
> tracing?

Right you are, this si the msk, it's state is read lockless by the
subflows.

Do you prefer a v3 or editing that in while applying the patch?

Thanks,

Paolo

