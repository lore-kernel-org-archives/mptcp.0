Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD6498A2
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwlwsCLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702918460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ow/CBU6TdgejPtzvZ7Xz1uoKmK9S8/MdQCWKi9j900=;
	b=UwlwsCLYCVGOz1L/cCIuhZ7JW6bSXHMYNgBMJLhxjwXzwqKaItKSZPGARm8GpVLFou4Z7N
	wNfF+NmHUk9u45eew5WTqGI9/gi9E5ZOhhEb6UZyj8/SuEJnlMIZ4SEGz0KeqzGgcIbJ9L
	PE5xuUv9qfvXvDa+s9MsbTnLH8UjqBE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-jFAXTtTcNIWlrOzP32vIrw-1; Mon, 18 Dec 2023 11:54:19 -0500
X-MC-Unique: jFAXTtTcNIWlrOzP32vIrw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cc794df910so1076831fa.1
        for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 08:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702918457; x=1703523257;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tp6e6o/ABkQ82EX5xmW1+gZ0UfWYfoqdf4xRfYbmzeQ=;
        b=lRlkTRswuelKQQheqeQxnDrVPcpB1ax0gOMBQa8l93h5ht6RVme6N870PM2tUdzi5h
         JJnFmqRjRnvyq2VXXEYHLsIl4Gx77IjjSlyJtz+8fOUCzVsQbiGAgYjiVbuEik3zt1Q2
         rVJFh587M1Gc9LVdKdyrBrrUlwHLbP1wDxQiVuuaxSvNn3YmgxXJOg5/7czhQRQOH/re
         qsMfLFsDSOix1vUZ15EqwtxMItlqb5hIRJ02R/T2DUqXJXvMzv5PyQ26tfLbXlk47bTL
         yAFem/FS3Y/ZUeTOFP7WJc1cvsnZXBA/iH7vzoByzIeQb2gWhKWM0prGtmH0KHbL0BT5
         03fA==
X-Gm-Message-State: AOJu0YyqOYtDyTYWIqT8chr6B6elMZwBiXtg1gRvN/4YX3T28e7K7XAn
	6dPtOum7ZjjH7rMs8NTZma72WVVujf4vv3beqhONUC/WnvpHfm480UviLXeOdrY89ViWT4T7ICR
	IMfV0kDdKzw08VC4=
X-Received: by 2002:a05:651c:211e:b0:2c9:e7cb:fe8e with SMTP id a30-20020a05651c211e00b002c9e7cbfe8emr18318124ljq.2.1702918457531;
        Mon, 18 Dec 2023 08:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbR9JBxBrY//rOPWprnxz2Vz9rxNiOtgEG1YXNBrDCH/GW6JOQKZgag4Wam0vTu4snsLSahQ==
X-Received: by 2002:a05:651c:211e:b0:2c9:e7cb:fe8e with SMTP id a30-20020a05651c211e00b002c9e7cbfe8emr18318112ljq.2.1702918457161;
        Mon, 18 Dec 2023 08:54:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-3.dyn.eolo.it. [146.241.253.3])
        by smtp.gmail.com with ESMTPSA id dh6-20020a0564021d2600b0055338547cc1sm1610499edb.70.2023.12.18.08.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:54:16 -0800 (PST)
Message-ID: <4c1e2e407e2b6721b4ca0aad73746c8ea13f2753.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/5] mptcp: move inet_sk_state_store under
 lock
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
Date: Mon, 18 Dec 2023 17:54:15 +0100
In-Reply-To: <84b7f01dcee92c4c1ae00523baa5f98f0cb64671.1702889134.git.geliang.tang@linux.dev>
References: <cover.1702889134.git.geliang.tang@linux.dev>
	 <84b7f01dcee92c4c1ae00523baa5f98f0cb64671.1702889134.git.geliang.tang@linux.dev>
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

On Mon, 2023-12-18 at 16:47 +0800, Geliang Tang wrote:
> This patch moves inet_sk_state_store() under the socket lock in
> mptcp_pm_nl_create_listen_socket(). This is a pre-req patch for
> using mptcp_set_state() instead of inet_sk_state_store().
>=20
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
>  net/mptcp/pm_netlink.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index bf4d96f6f99a..0e6da322c8f2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1030,9 +1030,10 @@ static int mptcp_pm_nl_create_listen_socket(struct=
 sock *sk,
> =20
>  =09lock_sock(newsk);
>  =09ssk =3D __mptcp_nmpc_sk(mptcp_sk(newsk));
> -=09release_sock(newsk);
> -=09if (IS_ERR(ssk))
> +=09if (IS_ERR(ssk)) {
> +=09=09release_sock(newsk);
>  =09=09return PTR_ERR(ssk);
> +=09}
> =20
>  =09mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -1045,10 +1046,14 @@ static int mptcp_pm_nl_create_listen_socket(struc=
t sock *sk,
>  =09else if (ssk->sk_family =3D=3D AF_INET6)
>  =09=09err =3D inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
>  #endif
> -=09if (err)
> +=09if (err) {
> +=09=09release_sock(newsk);
>  =09=09return err;
> +=09}
> =20
>  =09inet_sk_state_store(newsk, TCP_LISTEN);

If you move 'inet_sk_state_store(newsk, TCP_LISTEN);' just before the
'__mptcp_nmpc_sk()' call, the overall patch should be significantly
smaller.

Cheers,

Paolo

