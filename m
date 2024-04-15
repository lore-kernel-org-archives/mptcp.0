Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317E3BBD7
	for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175368; cv=none; b=jb/kG6SpfY4DH3ShuQkPdsCuHW4j3sd72t1xPOXAqp9qxoRPywfXGJ3FeSahrEa+JCGzF41KCxvO/MvQLte+xR810bstLJ9Kpg47XVD5kt+KxlVvzx4BQjLiUBP7DKcj+LkyMtThm/WzBTRA6mxDjq33pCVyqzeatDM6g8K/S6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175368; c=relaxed/simple;
	bh=+PeaM/1i9BQR4RDkr+OgVOsxijRj+RyX6g4UATPd61o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XILjI1u+XZ7fauz5NB6gn/HDdYMSRphHKvjL77bJpwhxr0a5sTvzJosPlPptQ/b+8Yd2yne+UuXc4sFU+7tqQcf2hhOZaMlUH1pB572PHT5a3o34UaU7HYXaY7NWqN3s75Y6KfwM03zoPSWksjt9osIS6BV89oOYpziS6qAYsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIXn7p1d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIXn7p1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713175365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yx610o6xDUOJTs1TPYJrEj8QP1woMv25DXdbFdYO0i0=;
	b=aIXn7p1d+gUjz3bnAjOZ/11OXLrRHZEdj/jBkdX31J+kucxJK9hbgz7NTAadjWHdF8J+0p
	f+ilWuBBg7WyxYhQ+G/IWMDa22zUflQedHfEjgAp6uhyAKknOW6jf/jMEnBSPnpIbDfUko
	FafRPygy4+avRh98zRVH2SFCXqIT4lM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-zFlTKRfKNhqVe_-q4chxag-1; Mon, 15 Apr 2024 06:02:44 -0400
X-MC-Unique: zFlTKRfKNhqVe_-q4chxag-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417be20a1feso1978925e9.0
        for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 03:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175362; x=1713780162;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Txsc6t1gLU2HIgqV4KIy/t8eScFCGw03oXL3L88kU=;
        b=cFA0xqFV0JLRYsk2HNm2ghgRiaD1uiFHtVhARci2S00884WgTeeZy1QG3Y09pkDhnT
         6D+ErCE/X6PgpXjqKsmq10CI91FyBvc48I0xvNBsuYTlQUp1sOeXl+qOFBq/9Axq/q0V
         bQfYDU/J8jgrk1nVGximxG90jJ/YnpkILGuszOtLlfGZMVeek8xr60QIp7LSzownRMNU
         oL114iN3Lgm0NDxtDexoT6MG4xILBh6k5fv/ksMyAkRDvynjPnxfAGst4tQG7LPBkIev
         s8PRnMD+6BZzInrD8xwsDccR2Z3iwckntST07GO5QeaNG3DnrXZRpePcOoYapNufk7ho
         vs2g==
X-Gm-Message-State: AOJu0YxXMRoRyO/ryLQCYC+Ql0WU88N/lRY2WIkInUKSR1RPcL9sCnB0
	/WoIat7Eft1AUmYpv54+vKnvD16KSQWEnugovOiBELX20tJ9m3AFkfxlP1C4OBB6rVKV3AfSHOH
	+j4N/WLJnAG7GtwMoLJhajkT8D6R2iqRLc+20s5b4wHk3R8z/JWZ/qW52KE7R
X-Received: by 2002:a05:600c:35c4:b0:418:2719:6b14 with SMTP id r4-20020a05600c35c400b0041827196b14mr4045874wmq.3.1713175362628;
        Mon, 15 Apr 2024 03:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAl15YzPdw+SatI/Cr3iW59JJUhcfnugOrcwqNBkckh/ki3h79qutISfShFEKS3StCZn4tuw==
X-Received: by 2002:a05:600c:35c4:b0:418:2719:6b14 with SMTP id r4-20020a05600c35c400b0041827196b14mr4045852wmq.3.1713175362237;
        Mon, 15 Apr 2024 03:02:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-238.dyn.eolo.it. [146.241.228.238])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b0041627ab1554sm18774032wmq.22.2024.04.15.03.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:02:41 -0700 (PDT)
Message-ID: <0b2ec0614ff984b0d32c78cbec19a044c5d24cbd.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure snd_una is properly initialized
 on connect
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Date: Mon, 15 Apr 2024 12:02:40 +0200
In-Reply-To: <7aa81bc3-7ec1-6e93-bc81-e60911ef5eed@kernel.org>
References: <2b6d11d0210f683cc0de8bb47a923d568cfa8f47.1712942966.git.pabeni@redhat.com>
	 <7aa81bc3-7ec1-6e93-bc81-e60911ef5eed@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
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

On Fri, 2024-04-12 at 14:05 -0700, Mat Martineau wrote:
> On Fri, 12 Apr 2024, Paolo Abeni wrote:
>=20
> > Christoph reported a splat hinting at a corrupted snd_una:
> >=20
> > WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+=
0x4b3/0x620 net/mptcp/protocol.c:1005
> > Modules linked in:
> > CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #5=
9
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el=
7 04/01/2014
> > Workqueue: events mptcp_worker
> > RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
> > Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
> > =098e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
> > =09<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
> > RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
> > RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
> > R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
> > FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
> > Call Trace:
> > <TASK>
> > __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
> > mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
> > __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
> > mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
> > process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
> > process_scheduled_works kernel/workqueue.c:3335 [inline]
> > worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
> > kthread+0x121/0x170 kernel/kthread.c:388
> > ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
> > ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > </TASK>
> >=20
> > When fallback to TCP happens early on client socket, and the mptcp
> > worker (dumbly) tries mptcp-level re-injection, the snd_una is
> > not yet initialized, and the worker tries to use it to clean-up
> > the send buffer.
> >=20
> > Address the issue always initializing snd_una for active sockets
> > at connect time.
> >=20
> > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > @Christoph: could you please test this vs the above issue reproducer?
> > The repro doesn't work for me.
> > ---
> > net/mptcp/protocol.c | 13 ++++++++++++-
> > 1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 3e1b15d76442..68247075069b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1002,8 +1002,12 @@ static void __mptcp_clean_una(struct sock *sk)
> >=20
> > =09=09if (unlikely(dfrag =3D=3D msk->first_pending)) {
> > =09=09=09/* in recovery mode can see ack after the current snd head */
> > -=09=09=09if (WARN_ON_ONCE(!msk->recovery))
> > +=09=09=09if (WARN_ON_ONCE(!msk->recovery)) {
> > +=09=09=09=09pr_err("snd_una %llx dfrag end seq %llx frag len %d bytes =
sent %lld acked %lld",
> > +=09=09=09=09=09msk->snd_una, dfrag->data_seq + dfrag->data_len, dfrag-=
>data_len,
> > +=09=09=09=09=09msk->bytes_sent, msk->bytes_acked);
> > =09=09=09=09break;
> > +=09=09=09}
> >=20
> > =09=09=09WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> > =09=09}
> > @@ -3730,6 +3734,13 @@ static int mptcp_connect(struct sock *sk, struct=
 sockaddr *uaddr, int addr_len)
> > =09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
> > =09=09mptcp_subflow_early_fallback(msk, subflow);
> > =09}
> > +
> > +=09/* after the connect, the worker (and re-injections) can trigger
> > +=09 * at any time, and that will need snd_una properly initialized
> > +=09 */
> > +=09mptcp_data_lock(sk);
> > +=09WRITE_ONCE(msk->snd_una, subflow->idsn);
> > +=09mptcp_data_unlock(sk);
>=20
> Hi Paolo -
>=20
> msk->write_seq, msk->snd_nxt, and msk->snd_una are initialized as a group=
=20
> in mptcp_sk_clone_init() (on the accept() side).
>=20
> Does it make sense to also initialize them together on the connect() side=
?=20

Could make sense for consistency, but it should not solve any
additional issues.

> Looks like msk->write_seq and msk->snd_nxt are initialized together in=20
> __mptcp_sync_state() and I think setting msk->snd_una would fit better=20
> there. The attempt to re-inject means that a transmit happened, so=20
> msk->write_seq and msk->snd_nxt must have been initialized in=20
> __mptcp_sync_state().

I think you are right. Moving the initialization there should be
cleaner and equally safer. Let me do some more testing,

Thanks!

Paolo

