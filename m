Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB0747A
	for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676560552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UggtD3CM5arvYYBkYdBu/YBenipknq+u8JtJ3eIK+q4=;
	b=U2xhIT5Z5buKA2lx15Dr+RWWCcOUhcXGW8P8ko9nC29a4Fv34psbaKv4rLOSkyY7Tk3vrE
	yEOna3bHCv2TTqE8oViYXSEhdSCZZqJfIWN4TCIEdXksrnDmsFi7Sk4AWEMOTKeKGxun2V
	LMtZhuobseSCB3Lz4UHVbMQeLJXET9g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-467-QeoBpHuhM0WgSyUULLwCaQ-1; Thu, 16 Feb 2023 10:15:50 -0500
X-MC-Unique: QeoBpHuhM0WgSyUULLwCaQ-1
Received: by mail-qk1-f198.google.com with SMTP id 130-20020a370588000000b0072fcbe20069so1357222qkf.22
        for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 07:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676560550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dF760nis/gJ34F7CgVFHhyNKTBECgnldHHpC0JdqEw=;
        b=h1uYNGqE8sYPelOx6XdiNR3Jh+PzJkzyfqLsq02oev7OesOtpLSrlpcEK+2h3oLOuw
         yhsQ31cbOhqdir8LkJ+qLEb2wE6ZP9jt9JMUHJf5T9ukdu7JN59qFy2JzXRId+ilP+sL
         7P8eoyg3+AXdmjuhFTw+EUeHvtBmU5jTGhOnwNm4CMNCu1g4sBsFhEY/mFjlESXAvjL9
         cf00KrK1bmn1fWgQclTbMQuVniTPGAfOUME6KBuvkis9uiW/sohUjW5W8ZVM/4nH+fX0
         KDgZROJvqVp1NgsrhfT+aEkVvsPP1UsB9pCHB91w6NW7kGOtUd0DC8I/5jqtoAUSoDtU
         L7Aw==
X-Gm-Message-State: AO0yUKVutpRjR4msY9GHJ4w2zrsvCt62DJ+/v88k1VaZeqEts6uBwOyx
	P81DH9bfXIXOyZMWourNfwlvb14YlqZJgIO81ccn8GB0SeaVsI+EO3+lTQ3jSQYfZulx5DXMnf0
	Pjo/uga2p0DTylXE=
X-Received: by 2002:a0c:9791:0:b0:56f:8e4:188b with SMTP id l17-20020a0c9791000000b0056f08e4188bmr155501qvd.2.1676560549876;
        Thu, 16 Feb 2023 07:15:49 -0800 (PST)
X-Google-Smtp-Source: AK7set/a9C/qych1j+KEv/beuDOZ7rawYAd+mwnV6JovwQbn+G6CNBtvKiZKgX2WJJNdEP3pwdmirQ==
X-Received: by 2002:a0c:9791:0:b0:56f:8e4:188b with SMTP id l17-20020a0c9791000000b0056f08e4188bmr155459qvd.2.1676560549468;
        Thu, 16 Feb 2023 07:15:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id 85-20020a370758000000b0073b7ce3735fsm1363405qkh.50.2023.02.16.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:15:48 -0800 (PST)
Message-ID: <b19d3f143c1125d68eb5d0753fb2e08c6dbf9fcf.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 1/2] mptcp: use the workqueue to destroy
 unaccepted sockets.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Thu, 16 Feb 2023 16:15:46 +0100
In-Reply-To: <c9de6cd2-7e71-9f12-850f-241493139dc8@tessares.net>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
	 <3e0bda7b-d05b-7e9c-4862-d93d120ac86c@tessares.net>
	 <02bd5e032b3ab2afb290a75c649c4df119a73dbb.camel@redhat.com>
	 <c9de6cd2-7e71-9f12-850f-241493139dc8@tessares.net>
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

On Thu, 2023-02-16 at 16:07 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 16/02/2023 15:58, Paolo Abeni wrote:
> > On Wed, 2023-02-15 at 18:53 +0100, Matthieu Baerts wrote:
> > > Hi Paolo,
> > >=20
> > > On 09/02/2023 19:48, Paolo Abeni wrote:
> > > > Christoph reported a UaF at token lookup time:
> > > >=20
> > > > BUG: KASAN: use-after-free in __token_bucket_busy+0x253/0x260
> > > > Read of size 4 at addr ffff88810698d5b0 by task syz-executor653/319=
8
> > > >=20
> > > > CPU: 1 PID: 3198 Comm: syz-executor653 Not tainted 6.2.0-rc59af4eaa=
31c1f6c00c8f1e448ed99a45c66340dd5 #6
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.1=
3.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  dump_stack_lvl+0x6e/0x91
> > > >  print_report+0x16a/0x46f
> > > >  kasan_report+0xad/0x130
> > > >  __token_bucket_busy+0x253/0x260
> > > >  mptcp_token_new_connect+0x13d/0x490
> > > >  mptcp_connect+0x4ed/0x860
> > > >  __inet_stream_connect+0x80e/0xd90
> > > >  tcp_sendmsg_fastopen+0x3ce/0x710
> > > >  mptcp_sendmsg+0xff1/0x1a20
> > > >  inet_sendmsg+0x11d/0x140
> > > >  __sys_sendto+0x405/0x490
> > > >  __x64_sys_sendto+0xdc/0x1b0
> > > >  do_syscall_64+0x3b/0x90
> > > >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > >=20
> > > > We need to properly clean-up all the paired MPTCP-level
> > > > resources and be sure to release the msk last, even when
> > > > the unaccepted subflow is destroyed by the TCP internals
> > > > via inet_child_forget().
> > > >=20
> > > > We can re-use the existing MPTCP_WORK_CLOSE_SUBFLOW infra,
> > > > explicitly checking that for the critical scenario: the
> > > > closed subflow is the MPC one, the msk is not accepted and
> > > > eventually going through full cleanup.
> > > >=20
> > > > With such change, __mptcp_destroy_sock() is always called
> > > > on msk sockets, even on accepted ones. We don't need anymore
> > > > to transiently drop one sk reference at msk clone time.
> > >=20
> > > Thank you for the patch, I just have one question below if you don't =
mind :)
> > >=20
> > > (...)
> > >=20
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index 546df81c162f..d7588535bf6d 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -2444,9 +2444,10 @@ static unsigned int mptcp_sync_mss(struct so=
ck *sk, u32 pmtu)
> > > >  =09return 0;
> > > >  }
> > > > =20
> > > > -static void __mptcp_close_subflow(struct mptcp_sock *msk)
> > > > +static void __mptcp_close_subflow(struct sock *sk)
> > > >  {
> > > >  =09struct mptcp_subflow_context *subflow, *tmp;
> > > > +=09struct mptcp_sock *msk =3D mptcp_sk(sk);
> > > > =20
> > > >  =09might_sleep();
> > > > =20
> > > > @@ -2460,7 +2461,15 @@ static void __mptcp_close_subflow(struct mpt=
cp_sock *msk)
> > > >  =09=09if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
> > > >  =09=09=09continue;
> > > > =20
> > > > -=09=09mptcp_close_ssk((struct sock *)msk, ssk, subflow);
> > > > +=09=09mptcp_close_ssk(sk, ssk, subflow);
> > > > +=09}
> > > > +
> > > > +=09/* if the MPC subflow has been closed before the msk is accepte=
d,
> > > > +=09 * msk will never be accept-ed, close it now
> > > > +=09 */
> > > > +=09if (!msk->first && msk->in_accept_queue) {
> > > > +=09=09sock_set_flag(sk, SOCK_DEAD);
> > > > +=09=09sk->sk_state =3D TCP_CLOSE;
> > >=20
> > > Would it make sense to call inet_sk_state_store() here, mainly for th=
e
> > > tracing?
> >=20
> > Right you are, this si the msk, it's state is read lockless by the
> > subflows.
>=20
> Sorry, I'm not sure I understood your reply. Just to be sure, we should
> then replace this single line:
>=20
>   sk->sk_state =3D TCP_CLOSE;
>=20
> by:
>=20
>   inet_sk_state_store(sk, TCP_CLOSE);
>=20
> and nothing else.

Exactly.

What I was trying to say above is that we need such change because the
msk (=3D=3D sk above) status is accessed (read) by the subflows without
holding the msk socket lock (using inet_sk_state_load()). Hence  we
must use inet_sk_state_store() to write it.

>=20
> (and we should not use tcp_set_state() here because that's the msk)
>=20
> > Do you prefer a v3 or editing that in while applying the patch?
>=20
> If the suggested modification is correct, I can do the modification (+
> the Fixes tags) when applying the patches.

Thanks!

Paolo

