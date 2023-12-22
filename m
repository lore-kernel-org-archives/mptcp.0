Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD4D51E
	for <mptcp@lists.linux.dev>; Fri, 22 Dec 2023 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYDk53Kp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703236612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zL4otOkEkgrJYshDXVfG3llGb9GLE+6bxmM+6mJ2DY=;
	b=IYDk53KpQQ3kKNTWJAWTUlpinbWDH0VZejflzXtTZOruxR0syC95g1bEW1UAJe1DxRA4my
	5lk2bevWI04b3Lssf9liB4+hTGGarop/Rc2B4ti0L2f8WqIS5tmVJJvhOT1Re+4f6FUwUl
	alxPZoY7IOEAanynzqZEiWsw2huzUcw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-Gy4UQFkUPtCr8vLCXLDiRA-1; Fri, 22 Dec 2023 04:16:50 -0500
X-MC-Unique: Gy4UQFkUPtCr8vLCXLDiRA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54cc7651e4eso266552a12.0
        for <mptcp@lists.linux.dev>; Fri, 22 Dec 2023 01:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703236609; x=1703841409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCZ/+y2+HvgdWczNDQ9cwZ6Mr4uqljyBKqweGi4DBkk=;
        b=cR/5D2yUfnWpCE+mbmWcPnbQzZNfAq1pMzi/69JlMls0v1ZnSkp1UGJ8gss6evPxy9
         P856k/fgN4HYU304ObSlmFa3lPNwPLqffxQxTKMzOUhHpNcpLJytI6eNF7M+0Ag5yRP4
         oaNniatvk6WU91DjUZ5Kw9PDnFEAEoliOLHNG6ZcFsBja1z4nUsgjNOC8yOEtAVeGL8j
         QJr6i9H73/biOGRdNgHyRqQAcSzI1tMvuQDbdfSh+mRdDiyOaFcrbq/oYvjmxdodaQVP
         BWNYlljUzhRkZIxMp3q5H30fUx3xhpZk+DfO2JVk8mY0mwLQLS/NV5AAek18MslL19rB
         SzgQ==
X-Gm-Message-State: AOJu0Yxgr4YrraaHCcYGvgiu5/p3PdOz7dauTgKNFFbPpOUUQ7JH9pec
	VsCCMbxUlhZ4I/JqJZ/tcJHOkEJrnciGwsdWJz3PFPqQPDoORwkFYJ8FhjdimfnLIazBBhpjpTV
	1+SmO+nZVYe2/dTkLzD+V/farStrcT9dsc0jV22x/3cgpxHUUi0dz7YufWntWncx3K77fWEM++8
	yiZwEH
X-Received: by 2002:a50:d74f:0:b0:553:2037:92e2 with SMTP id i15-20020a50d74f000000b00553203792e2mr1089093edj.0.1703236608984;
        Fri, 22 Dec 2023 01:16:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1C5drXcaejOGC4MvdmYM4xmu+RKLtZR3Ak2M0Kl93ohnW+b/b6ICa85Bxe/q+AdMBPsCAhQ==
X-Received: by 2002:a50:d74f:0:b0:553:2037:92e2 with SMTP id i15-20020a50d74f000000b00553203792e2mr1089074edj.0.1703236608585;
        Fri, 22 Dec 2023 01:16:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7de95000000b0055289f60e3bsm2324786edv.79.2023.12.22.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:16:47 -0800 (PST)
Message-ID: <2763a165e2dce31e8e8d1f0268aaa69c9127a29d.camel@redhat.com>
Subject: Re: [PATCH mptcp-net-next] mptcp: cleanup state propagation.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Matthieu
	Baerts <matttbe@kernel.org>
Date: Fri, 22 Dec 2023 10:16:46 +0100
In-Reply-To: <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
References: <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
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

On Wed, 2023-11-22 at 17:21 +0100, Paolo Abeni wrote:
> When propagating the first subflow state via the release_cb, the
> msk must actually take to 2 separate actions: state sync-up and
> send buffer sync-up. Relaying on the specific flags instead of
> bounding both in __mptcp_sync_state(), allows cleaning up a bit
> the code.
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 3 +--
>  net/mptcp/subflow.c  | 5 ++---
>  2 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 199b2e09f1ac..4fc038d29623 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3404,9 +3404,8 @@ static void mptcp_release_cb(struct sock *sk)
>  =09if (unlikely(msk->cb_flags)) {
>  =09=09/* be sure to sync the msk state before taking actions
>  =09=09 * depending on sk_state (MPTCP_ERROR_REPORT)
> -=09=09 * On sk release avoid actions depending on the first subflow
>  =09=09 */
> -=09=09if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags) && msk-=
>first)
> +=09=09if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags))
>  =09=09=09__mptcp_sync_state(sk, msk->pending_state);
>  =09=09if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
>  =09=09=09__mptcp_error_report(sk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6d7684c35e93..64302a1ac306 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -421,9 +421,6 @@ static bool subflow_use_different_dport(struct mptcp_=
sock *msk, const struct soc
> =20
>  void __mptcp_sync_state(struct sock *sk, int state)
>  {
> -=09struct mptcp_sock *msk =3D mptcp_sk(sk);
> -
> -=09__mptcp_propagate_sndbuf(sk, msk->first);
>  =09if (sk->sk_state =3D=3D TCP_SYN_SENT) {
>  =09=09inet_sk_state_store(sk, state);
>  =09=09sk->sk_state_change(sk);
> @@ -436,10 +433,12 @@ static void mptcp_propagate_state(struct sock *sk, =
struct sock *ssk)
> =20
>  =09mptcp_data_lock(sk);
>  =09if (!sock_owned_by_user(sk)) {
> +=09=09__mptcp_propagate_sndbuf(sk, msk->first);
>  =09=09__mptcp_sync_state(sk, ssk->sk_state);
>  =09} else {
>  =09=09msk->pending_state =3D ssk->sk_state;
>  =09=09__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
> +=09=09__set_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags);
>  =09}
>  =09mptcp_data_unlock(sk);
>  }

Could you please drop this patch? And not sent it upstream...

I'm working on a series of pre-req for
https://github.com/multipath-tcp/mptcp_net-next/issues/464
and - among many other things - it basically will require reverting
this patch :(

Thanks!

Paolo

