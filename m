Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B82FE1B
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSF519bo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696956353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b11GDuXrfenI5C0fgbqqvEASLpGCEaogfWbNuqB7PlM=;
	b=XSF519bo6rfbAuIMO7+ODOEgE7MgcA9MFat82aXICYT4Yw0zFchTdQ9Urt9fkyegUvsaWH
	fmfC54fICG8K+PCuStub57nG1dLF9Rs3mdwc2nKGlUP3vHJohioEzk601rbO50RbdYCx0J
	ey0+DA/w6BRtd8mbM/OrkPQMZWoAbSY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-pbsJOVnBOhSk7yfTKudcFA-1; Tue, 10 Oct 2023 12:45:52 -0400
X-MC-Unique: pbsJOVnBOhSk7yfTKudcFA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bff4bc482bso5086811fa.0
        for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 09:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696956350; x=1697561150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnYwLQ8kzLVEFsa734Nz5mzKYCDzjL5HTOUhixLQZUI=;
        b=rB37d2baGlxhV6MoxdWHDQL3gUd0qJHd9qx1vHDsmEdVbeckEpTKpEejwgsw9SzL2M
         bcq2lp+XX/HYqiJMKeQDx+T7CN8u89BXQfl4HLQn+lSQLsrbr/bSbJuBi7sLSnFcUNl0
         JsCQTr1JRHNMtV3tlh2QGVFBKrOFQCLVzI+u7+2L9pNxW0aruW/4jfud0Y2i6alCbJGz
         nsBXWxJPk0Wv1XsxJvGClzOMF3szbWlBvblIA3sxOT4utGyjUmAQnL8lUa9g4UI/kjIY
         VATHOBMf6xpKWV/41kTsjQ8aEdDpaGPL2eHu0Fyzm5NMb0MrH61jiU5zSzgW0kMenfAs
         eU4g==
X-Gm-Message-State: AOJu0Yy1Jw1sKXsaX0wZK2K5oQ16DTmCs+gD5TDZ/mBWm5rJTX48kOZX
	At/WKsg0YeuzRChG3uL9wEDy1OO19V0fncor0CdUxELxssNnZ2uvLjU+of4fHRV3LlXC/13tFHH
	IeA/V8ORrLAgHDCw=
X-Received: by 2002:a05:651c:1685:b0:2bf:f52c:3918 with SMTP id bd5-20020a05651c168500b002bff52c3918mr12325529ljb.1.1696956350576;
        Tue, 10 Oct 2023 09:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9egh/WSegb4nTtfph83aCfYCKz0A/wcdfVHdp4Q6InDufZ+EIguxovMIHN9+J1kxDd7Wd3Q==
X-Received: by 2002:a05:651c:1685:b0:2bf:f52c:3918 with SMTP id bd5-20020a05651c168500b002bff52c3918mr12325511ljb.1.1696956350192;
        Tue, 10 Oct 2023 09:45:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id ks8-20020a170906f84800b00982a92a849asm8671281ejb.91.2023.10.10.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:45:49 -0700 (PDT)
Message-ID: <cdb77e7ecec83398ff7d92f7aeb20e0158146a28.camel@redhat.com>
Subject: Re: [PATCH net] tcp: allow again tcp_disconnect() when threads are
 waiting
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>,  mptcp@lists.linux.dev, Boris Pismenny
 <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Date: Tue, 10 Oct 2023 18:45:48 +0200
In-Reply-To: <CANn89iKOZ89xhAsgXyygENOfRzXPhbFn4_PNdA3LUL0a5EYktA@mail.gmail.com>
References: <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
	 <CANn89iKOZ89xhAsgXyygENOfRzXPhbFn4_PNdA3LUL0a5EYktA@mail.gmail.com>
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

Thank you for your review!

On Tue, 2023-10-10 at 18:21 +0200, Eric Dumazet wrote:
[...]
> > @@ -1585,7 +1596,11 @@ static int peekmsg(struct sock *sk, struct msghd=
r *msg,
> >                         release_sock(sk);
> >                         lock_sock(sk);
> >                 } else {
> > -                       sk_wait_data(sk, &timeo, NULL);
> > +                       ret =3D sk_wait_data(sk, &timeo, NULL);
> > +                       if (ret < 0) {
> > +                               copied =3D ret;
>=20
>    if (!copied)
>       copied =3D ret;

I think we can infer 'copied' is zero here, as a few lines before we
have:

=09if (copied)
=09=09break;

>=20
> > @@ -3092,6 +3092,7 @@ int tcp_disconnect(struct sock *sk, int flags)
> >                 sk->sk_frag.offset =3D 0;
> >         }
> >         sk_error_report(sk);
> > +       sk->sk_disconnects++;
>=20
> Should we perform this generically, from the caller ?

Ok, I'll do that in v2.

Thanks!

Paolo

