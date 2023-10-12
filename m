Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967ED531
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYiNUVcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697100885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TffABJtiDsX5bnNFtMTkGIJNzRQsedPwRWktA4HZF8s=;
	b=cYiNUVclUFn2my8J2KvPOTLH4NN8ijW87/RycafMWehi7r8z99M0Z5JU6bqb5xG9MWowBk
	xSEbX2xUQdUzJX2cBmbb4psw05hyTFCbUEU5vrydJ4TSw/kD5pIwfPtpiLGqbFhTy7wZHp
	6kaEZafuWf/tAJDyiLK08ERZ9TWICdA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-UI0merWnP6O-PqxNi-uxyw-1; Thu, 12 Oct 2023 04:54:43 -0400
X-MC-Unique: UI0merWnP6O-PqxNi-uxyw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b989422300so11095466b.0
        for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 01:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100882; x=1697705682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSXUguEqVrbrPzLm2P9AbUA6GuZyBE4aTFs+odhXlwg=;
        b=rgFw9cHsbkeCnwpQioliFEaLsjHdp6fu2w3KB+mkn3yxf4geabHweto/aqjmUT/bar
         w3vnTzxVqd4YUY7Iz2XDmaAo4waqGoTLwhNOCrYp/U4PWxot45SYjn0HJ6jPIEkfA5D/
         U7O6iXkCAfmp6lShg0meIEOJ4OMES1K+HnzJmKzAPVIW4uHK1+xmvCpTUCoeHIMl1UL9
         vQ6DkVMfSIyJId6Ab86o/ZdCixzPnb8a7umBSqqWaw/exGPMRVA1IMRMjWM08igSXvAr
         vd5HM97XFdQvgs3/SaBfrjZGUwpAL6Q9I9q46ZR+3DGGA3qYokUzhhD/2cJJxP0GRo6J
         POUg==
X-Gm-Message-State: AOJu0Yz1YYNK06zPYIUY9x8qRoMojTVAJKfAO1oT+Sv8hqK6evYGDsqw
	2+CpEFpWaTdHrkdMPNyzqDYtnw2X+wPa5y1k9rJYCKTTwC1MPmvaikboLeH/Adl+SpxXca/rR1P
	2qTFsJCQCSnzfRXdUe+vRpao=
X-Received: by 2002:a17:906:100c:b0:9ae:6da8:181c with SMTP id 12-20020a170906100c00b009ae6da8181cmr18284980ejm.7.1697100882500;
        Thu, 12 Oct 2023 01:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF3JTIDvTcAQtNJKPHMm2ZwX5ev+opzDM5Kmp8zD1zUUpebSU/1ZDgJL4roqq+1SD+YDE6Yg==
X-Received: by 2002:a17:906:100c:b0:9ae:6da8:181c with SMTP id 12-20020a170906100c00b009ae6da8181cmr18284968ejm.7.1697100882114;
        Thu, 12 Oct 2023 01:54:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-181.dyn.eolo.it. [146.241.228.181])
        by smtp.gmail.com with ESMTPSA id dx12-20020a170906a84c00b009b977bea1dcsm10797462ejb.23.2023.10.12.01.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:54:41 -0700 (PDT)
Message-ID: <362f62cf2ff58f49b0aae625c4d0b583ad94964b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: more conservative check for zero
 probes.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Thu, 12 Oct 2023 10:54:40 +0200
In-Reply-To: <ba718077-7fb8-2ed7-ffc4-33b68508a1e9@kernel.org>
References: <036c68f42c3d071ce7e52ef69ffec650c3301268.1697040427.git.pabeni@redhat.com>
	 <ba718077-7fb8-2ed7-ffc4-33b68508a1e9@kernel.org>
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

On Wed, 2023-10-11 at 15:06 -0700, Mat Martineau wrote:
> On Wed, 11 Oct 2023, Paolo Abeni wrote:
>=20
> > Christoph reported that the MPTCP protocol can find the subflow-level
> > write queue unexpectedly not empty while crafting a zero-window probe,
> > hitting a warning:
> >=20
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 188 at net/mptcp/protocol.c:1312 mptcp_sendmsg_fra=
g+0xc06/0xe70
> > Modules linked in:
> > CPU: 0 PID: 188 Comm: kworker/0:2 Not tainted 6.6.0-rc2-g1176aa719d7a #=
47
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el=
7 04/01/2014
> > Workqueue: events mptcp_worker
> > RIP: 0010:mptcp_sendmsg_frag+0xc06/0xe70 net/mptcp/protocol.c:1312
> > RAX: 47d0530de347ff6a RBX: 47d0530de347ff6b RCX: ffff8881015d3c00
> > RDX: ffff8881015d3c00 RSI: 47d0530de347ff6b RDI: 47d0530de347ff6b
> > RBP: 47d0530de347ff6b R08: ffffffff8243c6a8 R09: ffffffff82042d9c
> > R10: 0000000000000002 R11: ffffffff82056850 R12: ffff88812a13d580
> > R13: 0000000000000001 R14: ffff88812b375e50 R15: ffff88812bbf3200
> > FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000695118 CR3: 0000000115dfc001 CR4: 0000000000170ef0
> > Call Trace:
> > <TASK>
> > __subflow_push_pending+0xa4/0x420 net/mptcp/protocol.c:1545
> > __mptcp_push_pending+0x128/0x3b0 net/mptcp/protocol.c:1614
> > mptcp_release_cb+0x218/0x5b0 net/mptcp/protocol.c:3391
> > release_sock+0xf6/0x100 net/core/sock.c:3521
> > mptcp_worker+0x6e8/0x8f0 net/mptcp/protocol.c:2746
> > process_scheduled_works+0x341/0x690 kernel/workqueue.c:2630
> > worker_thread+0x3a7/0x610 kernel/workqueue.c:2784
> > kthread+0x143/0x180 kernel/kthread.c:388
> > ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:147
> > ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
> > </TASK>
> >=20
> > The root cause of the issue is that expectations are wrong: e.g. due
> > to MPTCP-level re-injection we can hit the critical condition.
> >=20
> > Explicitly avoid the zero-window probe when the subflow write queue
> > is not empty and drop the related warning.
> >=20
> > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/444
> > Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c | 7 +------
> > 1 file changed, 1 insertion(+), 6 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 30e0c29ae0a4..88404a9837d7 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1297,7 +1297,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
> > =09if (copy =3D=3D 0) {
> > =09=09u64 snd_una =3D READ_ONCE(msk->snd_una);
> >=20
> > -=09=09if (snd_una !=3D msk->snd_nxt) {
> > +=09=09if (snd_una !=3D msk->snd_nxt || tcp_write_queue_tail(ssk)) {
> > =09=09=09tcp_remove_empty_skb(ssk);
> > =09=09=09return 0;
> > =09=09}
> > @@ -1305,11 +1305,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, s=
truct sock *ssk,
> > =09=09zero_window_probe =3D true;
> > =09=09data_seq =3D snd_una - 1;
> > =09=09copy =3D 1;
> > -
> > -=09=09/* all mptcp-level data is acked, no skbs should be present into=
 the
> > -=09=09 * ssk write queue
> > -=09=09 */
> > -=09=09WARN_ON_ONCE(reuse_skb);
>=20
> Hi Paolo -
>=20
> At this point, both reuse_skb and zero_window_probe are 'true' if that=20
> warning was printing.
>=20
> There's a WARN_ON_ONCE(zero_window_probe) later in this function that wil=
l=20
> also fire under these conditions. Looks like that one needs to be removed=
=20
> too.

I intentionally left the other warning in place, mainly for irrational
reasons - it makes me feel safer, even if it's impossible to
trigger/useless.

I'll post v2 with such warn removed, thanks!

Paolo

