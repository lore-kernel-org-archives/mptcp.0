Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961973171
	for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEuQxchW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702403948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytemWEr4/gSOQfJoa6MiJ0J4+7/aRWtQh5KPdBI/BI0=;
	b=SEuQxchWIBbijUHQeUt4wYIoITVGlFRo7IPgU3uQwErdEJp2snKxSLOIgl5jNaEURhOYsL
	KC7kKYjhwTR4JdmaTsZAeV0f/LGCsLEiXISon6HNUrYK3EJKHdCAQjz+YCo+v3+7gLhg2/
	kOglrN80egK5mPgUMWe+VJdp82cuZmI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-neXltUMCOR64338wXF1foQ-1; Tue, 12 Dec 2023 12:59:06 -0500
X-MC-Unique: neXltUMCOR64338wXF1foQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1e27c6de0eso127457966b.1
        for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 09:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403945; x=1703008745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ML3j3zu2hO9OTqq5AfN7pTjPJXN7uKjOU8WV2iCDJRE=;
        b=Xuu82F9+fv7YFz8FzusOy6kqkx85UoDhko2GZKW+AVUi9ayp32AmG865yumlf/Js1P
         szdMdda0EmC6YdE9fs2EMRQioFnyloimUmj5N1UUoPTd1asPiXFNLWQXkdPBMf/QPigW
         +NNLWx34WbWxw+650JWy4YnvgL4N5nWhSmIgOfpjOozJ4+zkdMx2ItnGBMIsQ/tewU28
         Q+5nKU7i9yFeETKXVSl+2rjNd9+nMBpRoGluUDy3c1+fg1S2mn/9mwoCCE3eJ+rDFm2q
         gpZWUGXiNYyUVt5T9seyjMkJ1FGgn5M5rShSAZ00bj4lcKxGU1aXHjw9uBx80hz2lBV/
         DtUg==
X-Gm-Message-State: AOJu0YwjyErtngW544tXXvYVm+yjt2O/x5IeMMj6ogB8V3RckPSogWYh
	WNt/iVxcTRf1sITczKOYkpwt9p5d3SoTotFNJ0ExuAEbe2+xrpVHtf6DvL0Cq1fGSkG61NUTsAH
	CMxuKMg3HLf/jSqpW62y6H74=
X-Received: by 2002:a17:907:c207:b0:a18:96e3:ae2a with SMTP id ti7-20020a170907c20700b00a1896e3ae2amr7340768ejc.5.1702403945415;
        Tue, 12 Dec 2023 09:59:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqLCy8nmUJtfLcmyoksIRPRvtks513vhU+UAuUFx5fOB54fmgCq3t6/7Nc4XA+D/w/iDRJqQ==
X-Received: by 2002:a17:907:c207:b0:a18:96e3:ae2a with SMTP id ti7-20020a170907c20700b00a1896e3ae2amr7340758ejc.5.1702403945112;
        Tue, 12 Dec 2023 09:59:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id vh6-20020a170907d38600b00a0180de2797sm6568960ejc.74.2023.12.12.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:59:04 -0800 (PST)
Message-ID: <5fd48ec858c8a43977293f8b938de2ef796a2197.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: add mptcp_set_state helper
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
Date: Tue, 12 Dec 2023 18:59:03 +0100
In-Reply-To: <912d0df208a0fe5d146620cbc8f121b5e68e4985.1702282650.git.geliang.tang@linux.dev>
References: <cover.1702282650.git.geliang.tang@linux.dev>
	 <912d0df208a0fe5d146620cbc8f121b5e68e4985.1702282650.git.geliang.tang@linux.dev>
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

On Mon, 2023-12-11 at 16:19 +0800, Geliang Tang wrote:
> This patch adds a new function mptcp_set_state(), in it if switch from
> or to ESTABLISH state, increment or decrement the newly added counter
> MPTCP_MIB_CURRESTAB.
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
>  net/mptcp/protocol.c | 19 +++++++++++++++++++
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4fc038d29623..23727f7394b6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2885,6 +2885,25 @@ void mptcp_subflow_shutdown(struct sock *sk, struc=
t sock *ssk, int how)
>  =09release_sock(ssk);
>  }
> =20
> +void mptcp_set_state(struct sock *sk, int state)
> +{
> +=09int oldstate =3D sk->sk_state;
> +
> +=09switch (state) {
> +=09case TCP_ESTABLISHED:
> +=09=09if (oldstate !=3D TCP_ESTABLISHED)
> +=09=09=09MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
> +=09=09break;
> +
> +=09default:
> +=09=09if (oldstate =3D=3D TCP_ESTABLISHED)
> +=09=09=09MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
> +=09}
> +
> +=09inet_sk_state_store(sk, state);
> +}
> +EXPORT_SYMBOL_GPL(mptcp_set_state);

I think there is no need to export this symbol.

And possibly the patches 1-4 could be squashed together - at very least
patch 1 and 2.

Other then that LGTM!

Thanks,

Paolo

