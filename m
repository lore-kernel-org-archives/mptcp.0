Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848201772E
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686156153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7+tmusYsCU5i3xkkXrUrWDK9TthOFpgdXvImrr8SL8=;
	b=QUp0jgye0PjTn3chY7tdIVJS7w6DHcYQRjjd/XhBsfcCzrMs8z7GGdOBbSGSJ5t4/+1zCe
	wyWc9EFsE+A1Q+NRLbFZXnNrsNizB6K8TGnf7tMAhYI03HBeshw8ihK90lJ7BPmW2EVSYZ
	qO9nr46agfeAgxLuzXMCdyzsFwPlql8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-kvf2aLCsPWqjZj2PK75ygA-1; Wed, 07 Jun 2023 12:42:32 -0400
X-MC-Unique: kvf2aLCsPWqjZj2PK75ygA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f73936c258so7398595e9.1
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 09:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686156151; x=1688748151;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTgc+83rjr+T3qNrzRFHnC1zpyHSdT7KGqQAzSyow2E=;
        b=Ycs5eSnBrIVq//5V01pK5CLCuxIutXinQRrdCstkUEBWX3Bqxol2NXTeHo5t0APYKO
         BBKHrktABdQExIElHkBUvpa2lbFjAtw3vZZ1S8ObEsbHypnAqHBf0HvvEZBjLGRo1CCM
         DkT9hzyzPcKgkxPFJR6bPA1mrGGGapeddbJS6aObB7QTkRbGV/u3BNg6S8Uyr2DOIfcU
         Xqa9cEy6+QTo81BOHtxh6OlKjT6gyv791C26js65cwKfOD6rGd7mYllrCbufoUPcctiq
         OMRLWvTzKVTLT+pRCP/VWGNRccp1z01Evh9H7VmaQUAJ1Pjo4IzuMgmlm8vHAJH7vf7C
         MBQg==
X-Gm-Message-State: AC+VfDw4VeWHzhw4SHhbQp+Y3JQyw6EuPb7OnNYKlJuH/h1S01a/RXPn
	X33pBXYcVxqbSZuVXprfgd7fvo6BQ7mF2Nm40IYF2eZll61efOXyorCRFeRnTG6tpf9lkfut8aQ
	pv67tVzmCs6CjeL/FDBnY1Vg=
X-Received: by 2002:a05:600c:3d94:b0:3f7:3579:2843 with SMTP id bi20-20020a05600c3d9400b003f735792843mr2399521wmb.4.1686156150825;
        Wed, 07 Jun 2023 09:42:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IuqZP2YIHepEQ3Jg+oTVZ3b1iyaGn09Kp7hSH5b2T8lVZtP94FCft+ou6JQiqDRf4Tc5Q9Q==
X-Received: by 2002:a05:600c:3d94:b0:3f7:3579:2843 with SMTP id bi20-20020a05600c3d9400b003f735792843mr2399503wmb.4.1686156150447;
        Wed, 07 Jun 2023 09:42:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-199.dyn.eolo.it. [146.241.247.199])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bcd0a000000b003f195d540d9sm2689660wmj.14.2023.06.07.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 09:42:30 -0700 (PDT)
Message-ID: <5c2b2f84e801f196ab6ff4cca201cfdb35d55e26.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v7 03/19] Squash to "mptcp: add sched in
 mptcp_sock"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 07 Jun 2023 18:42:29 +0200
In-Reply-To: <bfc6063cc04fd19a96e9427b7b6e34ea3d3afedb.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
	 <bfc6063cc04fd19a96e9427b7b6e34ea3d3afedb.1686127032.git.geliang.tang@suse.com>
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

Hi,

On Wed, 2023-06-07 at 16:38 +0800, Geliang Tang wrote:
> Add sched_data pointer into mptcp_sock too.
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.c |  5 +++--
>  net/mptcp/protocol.h |  4 +++-
>  net/mptcp/sched.c    | 13 ++++++++++++-
>  3 files changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c52f0eb8c261..f3e1a0c359e6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2817,7 +2817,8 @@ static int mptcp_init_sock(struct sock *sk)
>  =09=09return -ENOMEM;
> =20
>  =09ret =3D mptcp_init_sched(mptcp_sk(sk),
> -=09=09=09       mptcp_sched_find(mptcp_get_scheduler(net)));
> +=09=09=09       mptcp_sched_find(mptcp_get_scheduler(net)),
> +=09=09=09       GFP_KERNEL);
>  =09if (ret)
>  =09=09return ret;
> =20
> @@ -3217,7 +3218,7 @@ struct sock *mptcp_sk_clone_init(const struct sock =
*sk,
>  =09msk->snd_una =3D msk->write_seq;
>  =09msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
>  =09msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
> -=09mptcp_init_sched(msk, mptcp_sk(sk)->sched);
> +=09mptcp_init_sched(msk, mptcp_sk(sk)->sched, GFP_ATOMIC);
> =20
>  =09/* passive msk is created after the first/MPC subflow */
>  =09msk->subflow_id =3D 2;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 35dd3683f735..949f46d4c710 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -314,6 +314,7 @@ struct mptcp_sock {
>  =09=09=09=09   */
>  =09struct sock=09*first;
>  =09struct mptcp_pm_data=09pm;
> +=09struct mptcp_sched_data *sched_data;
>  =09struct mptcp_sched_ops=09*sched;
>  =09struct {
>  =09=09u32=09space;=09/* bytes copied in last measurement window */
> @@ -660,7 +661,8 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *=
name);
>  int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
>  void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
>  int mptcp_init_sched(struct mptcp_sock *msk,
> -=09=09     struct mptcp_sched_ops *sched);
> +=09=09     struct mptcp_sched_ops *sched,
> +=09=09     gfp_t gfp);
>  void mptcp_release_sched(struct mptcp_sock *msk);
>  void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
>  =09=09=09=09 bool scheduled);
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index c7c167e48d72..a053a9504dfd 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -56,7 +56,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched)
>  }
> =20
>  int mptcp_init_sched(struct mptcp_sock *msk,
> -=09=09     struct mptcp_sched_ops *sched)
> +=09=09     struct mptcp_sched_ops *sched,
> +=09=09     gfp_t gfp)
>  {
>  =09if (!sched)
>  =09=09goto out;
> @@ -64,6 +65,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
>  =09if (!bpf_try_module_get(sched, sched->owner))
>  =09=09return -EBUSY;
> =20
> +=09msk->sched_data =3D kzalloc(sizeof(struct mptcp_sched_data), gfp);
> +=09if (!msk->sched_data) {
> +=09=09bpf_module_put(sched, sched->owner);
> +=09=09return -ENOMEM;
> +=09}
> +
>  =09msk->sched =3D sched;
>  =09if (msk->sched->init)
>  =09=09msk->sched->init(msk);
> @@ -81,6 +88,10 @@ void mptcp_release_sched(struct mptcp_sock *msk)
>  =09if (!sched)
>  =09=09return;
> =20
> +=09if (msk->sched_data) {
> +=09=09kfree(msk->sched_data);
> +=09=09msk->sched_data =3D NULL;
> +=09}
>  =09msk->sched =3D NULL;
>  =09if (sched->release)
>  =09=09sched->release(msk);

First thing first, I'm sorry for the late feedback. I really was not
able to cope with your speed!

I think we should avoid adding more dynamic allocations to the fast
path. mptcp_sk_clone_init() is in the fast path.

If the such struct is really needed, should be added as new field to
mptcp_sock, I think.

Cheers,

Paolo

