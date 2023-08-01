Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED6111E
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690898367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SavFeKh4vMPyH0qNjF4IbhEzkRWYRrn1rh5t3fpTUME=;
	b=PJqYxtn0fSyrDH1GOHtj496KrT/JEP4H010biTrO3aGWPgrCnDP3IiVFi8irgWjxJ33mCX
	q1HgtopyO1IoDqTI1U7rG+JdQVu4iQPgzn31Nc0DU3dL2eI+noTnFt6QSU3HInG7Pgoqia
	orTPbV70+FUd/cQjSsZEVTZJq6eX50Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-mOhejV7iMTK8TqNaTqqAlg-1; Tue, 01 Aug 2023 09:59:25 -0400
X-MC-Unique: mOhejV7iMTK8TqNaTqqAlg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d5a634b29so8715806d6.1
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 06:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898365; x=1691503165;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbhNvnw10dzzWEb8qkGUg4PmgX6XxB9v1xTZrYZB5s4=;
        b=YKR1WBWAkZTvPE3P3zD7LGxTXdXn4GOCDqTgaZvq5PHhU0zlYzvCywNRkkEQGBZhJe
         IyxvuuoPYQFMmr17LwO03GJKmmtnhurT3wnXkF4poA0t5xCBlF2uZgRp/9NU80j6KYMF
         zprdcb5XO4Prbh0Xwvg0/3bYbZmSuMAiIlTs9pLENkS1DIdU8Rz8nA5ppQyNWUZ3Iv4e
         j0q3qa4xhK2EXVX1mwpXb/TEocxo9ZnzqiNaqLnHi3bxKVXrDi0s81cimZ6MY/wNsQnM
         qf4VqKtkl4Whc6pcLaJXXUTl6XDTk9/hAk90k0YzHPGHj1WFQnXi3PV04MPcfpyCwl6w
         xXyA==
X-Gm-Message-State: ABy/qLYNZ1tZC0NIxEX3a3RSiQ1amp5a0USzz3IxA6dWAZBrvRfiHUro
	+lZaXEQjQFsPwDGyw6LurzuNYnJzDVv1oH8qLzwU1A2NduJfCAhZRrNgrBhIB+pi0cSECr2n5+B
	FtzOGYdsQ2AzTqcU=
X-Received: by 2002:ad4:5d66:0:b0:63d:313e:114c with SMTP id fn6-20020ad45d66000000b0063d313e114cmr13847223qvb.6.1690898364774;
        Tue, 01 Aug 2023 06:59:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEpZwzQCzq3bYDPrjvM1q4Qz8bAFJIVeFDoABalz6dmY/oxIk8/hZwAdqCN9QZM9djyUrQDuw==
X-Received: by 2002:ad4:5d66:0:b0:63d:313e:114c with SMTP id fn6-20020ad45d66000000b0063d313e114cmr13847212qvb.6.1690898364510;
        Tue, 01 Aug 2023 06:59:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id t8-20020a0c8d88000000b006300ff90e71sm4665403qvb.122.2023.08.01.06.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:59:24 -0700 (PDT)
Message-ID: <15dbcb31932f489673dfc6f9d2c97ce2bf497ffd.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix disconnect vs accept race
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Tue, 01 Aug 2023 15:59:21 +0200
In-Reply-To: <2894c643-f883-4f18-9e4e-36c4566c5cab@tessares.net>
References: <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
	 <2894c643-f883-4f18-9e4e-36c4566c5cab@tessares.net>
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

On Tue, 2023-08-01 at 12:34 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 01/08/2023 00:25, Paolo Abeni wrote:
> > Despite commit 0ad529d9fd2b ("mptcp: fix possible divide by zero in
> > recvmsg()"), the mptcp protocol is still prone to a race between
> > disconnect() (or shutdown) and accept.
> >=20
> > The root cause is that the mentioned commit checks the msk-level
> > flag, but mptcp_stream_accept() does acquire the msk-level lock,
> > as it can rely directly on the first subflow lock.
> >=20
> > As reported by Christoph than can lead to a race where an msk
> > socket is accepted after that mptcp_subflow_queue_clean() releases
> > the listener socket lock and just before it takes destructive
> > actions leading to the following splat:
>=20
> (...)
>=20
> > Address the issue by temporary removing the pending request socket
> > from the accept queue, so that racing accept() can't touch them.
> >=20
> > After depleting the msk - the ssk still exists, as plain TCP sockets,
> > re-insert them into the accept queue, so that later inet_csk_listen_sto=
p()
> > will complete the tcp socket disposal.
>=20
> Thank you for working on this fix and sharing this patch!
>=20
> I just have one question at the end of your patch:
>=20
> > Fixes: 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at list=
ener close")
> > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/423
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note: as a net-next follow-up it would be nice to support mptcp socket
> > migration, basically duplicating part of the inet_csk_listen_stop() log=
ic
>=20
> (As you know, I'm always worry when you talk about duplicating code :) )

I know ;)

Probably I should had written something alike "implement quite similar
code to" ... which is actually more accurate.

> > @@ -1859,6 +1852,13 @@ void mptcp_subflow_queue_clean(struct sock *list=
ener_sk, struct sock *listener_s
> > =20
> >  =09/* we are still under the listener msk socket lock */
> >  =09lock_sock_nested(listener_ssk, SINGLE_DEPTH_NESTING);
> > +
> > +=09/* restore the listener queue, to let the TCP code clean it up */
> > +=09spin_lock_bh(&queue->rskq_lock);
> > +=09WARN_ON_ONCE(queue->rskq_accept_head);
>=20
> What prevent the accept queue to be modified between the moment it has
> been "nullified" (at the beginning of this function) and here (at the end=
)?
>=20
> I see that both the locks for the queue and the socket have been
> released and re-held in between: could this accept queue be modified in
> between if we are unlucky?
>=20
> I'm sure I'm missing something :)

The tcp listener socket is unhashed before starting
mptcp_subflow_queue_clean() by tcp_set_state(TCP_CLOSE). Later lookup
can't find the listener socket at all - so not even attach more req
sockets there.

Put in another way, if the stack is able to reach the tcp listener
socket here, both mptcp and plain tcp could leak incoming request
socket at destroy time (because new req could be appended after
flushing the queue).

The WARN_ON_ONCE() should be really over-defensive.

Cheers,

Paolo

