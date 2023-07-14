Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6916AB3
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689325234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSuu1f509ovjq68vsfz/AJWEwkzHqYHqR4ePD/jYMT8=;
	b=UQGifevyls8N5kXthvhGW4oEcxWCArTq+hL19Bx87QymiO4d1TPVh1rmsshIgvOaSE0dJk
	h8pAUpBcG64bJRKknxE4uT0jXywwNv/Fa0Fxs0J9OP0EdHtjAFrY3LWPf8m23DSJMA5/7d
	V69Ux5rhJqBP3vWX9T5HsaGdr1JKi3w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-v2n_Fh7mNyuCxa56-2t5MA-1; Fri, 14 Jul 2023 05:00:33 -0400
X-MC-Unique: v2n_Fh7mNyuCxa56-2t5MA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765ad67e690so36075185a.1
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 02:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689325233; x=1689930033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REyEqKAyoAnFuHsVMQkekCXlj2z45t113iL6N8O+4EU=;
        b=R5jmlEK3bF7/6qNMap4gD9mY6SJqqiOAAZ3wq1zyq2WtlQlV7BO4vsnaqkSj6nZSS/
         z3B0h6mdR/Yk5QFJE6ko/7qgDnnm4iK3KxUF5M5BHzVNbSDfVOCmYkMybwdP/TYKTDZd
         WWd9DhYHQgojGock8EpWFn7K6yGSeDx5TOt6g/V5EgMacX/kwYm57BJxEpAg300E5Dkc
         ycfPoEh9DzZtj4w58KQE5yTzR0drju/egvsovAywCIeRAitCLHFK/5AXvkjOgNPRwEA8
         +x44Esxrji9pzVLB0Tjnbs3pAyomSnhURibygLVbTT1iVYN6gtNiIjLdKGzFRCXq2BDx
         hcKw==
X-Gm-Message-State: ABy/qLZGbnc4lB+6Ph7fYT/gyKlisR+Kds/a/lfarfRF7Csl9J9FoSaN
	cs0CXhiR07VqpwnMM1xCKnHI7dIjvOqsuhQJhJ86IhpeM1sPTp6Oey3ZX5R31O5BaHLvPEwn8kE
	I0jVfHF4ORhFVhVc=
X-Received: by 2002:a05:6214:407:b0:635:dfe1:c1f2 with SMTP id z7-20020a056214040700b00635dfe1c1f2mr3992547qvx.0.1689325233141;
        Fri, 14 Jul 2023 02:00:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlETEVvFqUzqCnVL4kJZHFQ3TbHtCO9iqJ8bzyhVloruyw1WBiuAeCnNjOS4roymcU9PvGJj2g==
X-Received: by 2002:a05:6214:407:b0:635:dfe1:c1f2 with SMTP id z7-20020a056214040700b00635dfe1c1f2mr3992531qvx.0.1689325232800;
        Fri, 14 Jul 2023 02:00:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a12f200b00767f6391ccesm1245271qkl.135.2023.07.14.02.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:00:32 -0700 (PDT)
Message-ID: <64bae0d4237dcf2f804ec718142398493dfbe78a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 14/14] mptcp: get rid of msk->subflow
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 Jul 2023 11:00:30 +0200
In-Reply-To: <e062c54d-acff-d89a-1a99-9c0bc9ab9a3c@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com>
	 <f994b6d9cf322414f649676bf283326658fc428d.1688993570.git.pabeni@redhat.com>
	 <e062c54d-acff-d89a-1a99-9c0bc9ab9a3c@kernel.org>
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

On Wed, 2023-07-12 at 14:59 -0700, Mat Martineau wrote:
> On Mon, 10 Jul 2023, Paolo Abeni wrote:
>=20
> > Such field is now unused just as a flag to control the first subflow
> > deletion at close() time. Introduce a new bit flag for that and finally
> > drop the mentioned field.
> >=20
> > As an intended side effect, now the first subflow sock is not freed
> > before close() even for passive sockets. The msk has no open/active
> > subflows if the first one is closed and the subflow list is singular,
> > update accordingly the state check in mptcp_stream_accept().
> >=20
> > Among other benefits, the subflow removal, reduces the amount of memory
> > used on the client side for each mptcp connection, allows passive socke=
ts
> > to go through successful accept()/disconnect()/connect() and makes retu=
rn
> > error code consistent for failing both passive and active sockets.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Side notes:
> > - syzkaller will be likely happy about the new code path to possibly
> >  exploit
> > - we could possibly avoid allocating the 'socket' struct at
> >  __mptcp_subflow_connect() time, but that will require more invasive
> >  helpers creation in inet core.
> > ---
> > net/mptcp/protocol.c | 22 +++++-----------------
> > net/mptcp/protocol.h | 13 ++++++-------
> > 2 files changed, 11 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1c12c7911c43..0518a37e62c7 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -91,7 +91,6 @@ static int __mptcp_socket_create(struct mptcp_sock *m=
sk)
> > =09=09return err;
> >=20
> > =09WRITE_ONCE(msk->first, ssock->sk);
> > -=09WRITE_ONCE(msk->subflow, ssock);
> > =09subflow =3D mptcp_subflow_ctx(ssock->sk);
> > =09list_add(&subflow->node, &msk->conn_list);
> > =09sock_hold(ssock->sk);
> > @@ -101,6 +100,7 @@ static int __mptcp_socket_create(struct mptcp_sock =
*msk)
> > =09/* This is the first subflow, always with id 0 */
> > =09subflow->local_id_valid =3D 1;
> > =09mptcp_sock_graft(msk->first, sk->sk_socket);
> > +=09iput(SOCK_INODE(ssock));
> >=20
> > =09return 0;
> > }
> > @@ -2263,14 +2263,6 @@ struct sock *mptcp_subflow_get_retrans(struct mp=
tcp_sock *msk)
> > =09return min_stale_count > 1 ? backup : NULL;
> > }
> >=20
> > -static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
> > -{
> > -=09if (msk->subflow) {
> > -=09=09iput(SOCK_INODE(msk->subflow));
> > -=09=09WRITE_ONCE(msk->subflow, NULL);
> > -=09}
> > -}
> > -
> > bool __mptcp_retransmit_pending_data(struct sock *sk)
> > {
> > =09struct mptcp_data_frag *cur, *rtx_head;
> > @@ -2349,7 +2341,7 @@ static void __mptcp_close_ssk(struct sock *sk, st=
ruct sock *ssk,
> > =09=09goto out_release;
> > =09}
> >=20
> > -=09dispose_it =3D !msk->subflow || ssk !=3D msk->subflow->sk;
> > +=09dispose_it =3D msk->free_first || ssk !=3D msk->first;
> > =09if (dispose_it)
> > =09=09list_del(&subflow->node);
> >=20
> > @@ -2370,7 +2362,6 @@ static void __mptcp_close_ssk(struct sock *sk, st=
ruct sock *ssk,
> > =09=09 * disconnect should never fail
> > =09=09 */
> > =09=09WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> > -=09=09msk->subflow->state =3D SS_UNCONNECTED;
> > =09=09mptcp_subflow_ctx_reset(subflow);
> > =09=09release_sock(ssk);
> >=20
> > @@ -3147,7 +3138,6 @@ struct sock *mptcp_sk_clone_init(const struct soc=
k *sk,
> > =09msk =3D mptcp_sk(nsk);
> > =09msk->local_key =3D subflow_req->local_key;
> > =09msk->token =3D subflow_req->token;
> > -=09WRITE_ONCE(msk->subflow, NULL);
> > =09msk->in_accept_queue =3D 1;
> > =09WRITE_ONCE(msk->fully_established, false);
> > =09if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> > @@ -3285,10 +3275,8 @@ static void mptcp_destroy(struct sock *sk)
> > {
> > =09struct mptcp_sock *msk =3D mptcp_sk(sk);
> >=20
> > -=09/* clears msk->subflow, allowing the following to close
> > -=09 * even the initial subflow
> > -=09 */
> > -=09mptcp_dispose_initial_subflow(msk);
> > +=09/* allow the following to close even the initial subflow */
> > +=09msk->free_first =3D 1;
> > =09mptcp_destroy_common(msk, 0);
> > =09sk_sockets_allocated_dec(sk);
> > }
> > @@ -3828,7 +3816,7 @@ static int mptcp_stream_accept(struct socket *soc=
k, struct socket *newsock,
> > =09=09    unlikely(inet_sk_state_load(msk->first) =3D=3D TCP_CLOSE)) {
> > =09=09=09__mptcp_close_ssk(newsk, msk->first,
> > =09=09=09=09=09  mptcp_subflow_ctx(msk->first), 0);
> > -=09=09=09if (unlikely(list_empty(&msk->conn_list)))
> > +=09=09=09if (unlikely(list_is_singular(&msk->conn_list)))
>=20
> There are other checks for an empty conn_list in the PM code. Do we need =
a=20
> new helper to check for "no open/active subflows", if list_empty() is no=
=20
> longer the correct thing?

Addendum: I audited the code and all the other places use list_empty()
as an optimization to avoid acquiring additional locks: this is the
only place we need to update.

Note that the generic helper will be less trivial:

bool mptcp_no_open_subflow(struct mptcp_sock *msk)
{
=09if (!msk->first)
=09=09return false;

=09if (inet_sk_state_load(msk->first) !=3D TCP_CLOSE)
=09=09return false;

=09return list_is_singular(&msk->conn_list);
}

but here we already did the first 2 checks. I'll postpone the helper
creation to some other use-case.

Cheers,

Paolo


