Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277747365
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itKp9xlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696959673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv35QJZetS2K7uo9ft/T0V3hanLhfr2MmPiIw/JxWXE=;
	b=itKp9xlVehzKmh3HcahThSTqoMqu4ZMGhfIdckSBzJ5elNHXBeKObyJWbeNK41vxzNobZH
	V6vV1Jz3wNqkIApfUP6jbE8e0NWS9s3TPRRmJFrBubgDD7BDyYMCv+jiSk2js3IZxGMGs5
	QBRV+cyIkA5NAPzLA8krDpfKqgCMD4s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-2J8RMgFOMpyDtEzIR_iuxw-1; Tue, 10 Oct 2023 13:41:02 -0400
X-MC-Unique: 2J8RMgFOMpyDtEzIR_iuxw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae5101b152so108452466b.1
        for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 10:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959661; x=1697564461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yv35QJZetS2K7uo9ft/T0V3hanLhfr2MmPiIw/JxWXE=;
        b=qys+qHL1Z611n375XxaiOfPtjRXubXXl/+d068UNdo2vhU5UJVK6udP0xIKY1xe10f
         gbJOWEo3X8E5qwWvTW7XpaGE4Bt4WLYVaoV3ijLT5H8gjHd4PBTFYj4fVlV0pttzyKzV
         j4vzynENIWVAnq1E9uitMCpzjaCOoc9PAUW8/tdDdzRcU2uM5MV+Qs+GzgPyNgjcq9IY
         dyuQb5oLrOs+pfVE7R6wUWG8/8vJZfxlNNuw2/jeUq7sUYruS3oATrfucXMOGKAhh5Fb
         bOrHv8+TIB78ZTSf4YB2f3jIIiMz/6iQ7UEKvMvok+GWxolFwXAW7Duo4U36dXR1Q0xR
         lE+A==
X-Gm-Message-State: AOJu0YzV6k7qltziCaoNK4i/zQ8lCdAKirHRz/YPfT/nMye1kT+l3+PQ
	+XoQ2df8boN+MpndMrUpUokgmAM26pPo5Psg7JTUc4QQcFF6qvks/+kJJjmr4X50WmWe1hCDdDz
	qONth6c2eS01Nb9M=
X-Received: by 2002:a17:906:20da:b0:9ad:e1e2:3595 with SMTP id c26-20020a17090620da00b009ade1e23595mr14846682ejc.7.1696959661254;
        Tue, 10 Oct 2023 10:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3JDCHMsapRZEz0siGbGB9Rn9s1ONofLSNYtQxI6ShAdrhZuPLiX0Hp6kOVCRCquQqM3e29A==
X-Received: by 2002:a17:906:20da:b0:9ad:e1e2:3595 with SMTP id c26-20020a17090620da00b009ade1e23595mr14846671ejc.7.1696959660938;
        Tue, 10 Oct 2023 10:41:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906230900b009928b4e3b9fsm8739316eja.114.2023.10.10.10.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:41:00 -0700 (PDT)
Message-ID: <6ad14b4726342f2a37e0f8e95e3d681c6659242b.camel@redhat.com>
Subject: Re: [PATCH net] tcp: allow again tcp_disconnect() when threads are
 waiting
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>,  mptcp@lists.linux.dev, Boris Pismenny
 <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Date: Tue, 10 Oct 2023 19:40:59 +0200
In-Reply-To: <cdb77e7ecec83398ff7d92f7aeb20e0158146a28.camel@redhat.com>
References: <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
	 <CANn89iKOZ89xhAsgXyygENOfRzXPhbFn4_PNdA3LUL0a5EYktA@mail.gmail.com>
	 <cdb77e7ecec83398ff7d92f7aeb20e0158146a28.camel@redhat.com>
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

On Tue, 2023-10-10 at 18:45 +0200, Paolo Abeni wrote:
> > On Tue, 2023-10-10 at 18:21 +0200, Eric Dumazet wrote:
> > [...]
> >=20
> > > > > > @@ -3092,6 +3092,7 @@ int tcp_disconnect(struct sock *sk, int f=
lags)
> > > > > >                 sk->sk_frag.offset =3D 0;
> > > > > >         }
> > > > > >         sk_error_report(sk);
> > > > > > +       sk->sk_disconnects++;
> > > >=20
> > > > Should we perform this generically, from the caller ?
> >=20
> > Ok, I'll do that in v2.

I have to touch both calls site in __inet_stream_connect(), and the
patch will still touch both mptcp and tcp disconnect - reverting the
bits from 4faeee0cf8a5. The patch will not be smaller, but the
resulting fix will centralized in single place. I guess it's still
worthy.

Cheers,

Paolo

