Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B4947B
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686232676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T54weQVHg9Xl2a4QxT75TosaRRnwDaRZTjZUQQLOkPw=;
	b=QHPbpbSGBtlivoEUpwSx+2bjr9GJm0mVKSbjen/PghSyEXmgR8LAZ3TuDoWC3HKB770NiJ
	4A//OrIQkY4hbWeT0DZWeipWpjN2KV8Q/1LAX61eUowxRzsp+ZlaJLegcvVOkOhbih/8Cf
	DuhydhZ822itW85/FHJ+kdT8IeISLbE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-EIOsFav8NxaE27Ne6HIaAw-1; Thu, 08 Jun 2023 09:57:55 -0400
X-MC-Unique: EIOsFav8NxaE27Ne6HIaAw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62b67ff6943so1529816d6.0
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 06:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232675; x=1688824675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g42i/zU9qA1c+YWptB82V5/SsHIjXPKWidObbvv1lmA=;
        b=UEuGrPETS80yxPEmUpixCBvy9CV5d5MTzTndGo2aVWjjeKcslFJPqFIT19rmeAqXID
         lZCx51zPAeodBu/ftZONAe6nUUwGTsh4qR0Ao75z/ZoiXpDPQNgKOfeCethKx5GqH7Wz
         bgkc0Bh/ybaBFAGZZVOwpAcpJMPIXPFi6dPqBSQgv5ZCJ0xS/GSO3wMx5AhkbtdBCdgk
         RhIVg/tPBVTZco1rsNI2gQ+lsId0zZ3uMJPxirsO3sMwg5RVgc09bK55OUNTIwXZDaeM
         U6A6emrs5fUju7fmnNtG2G21v6+Mn9R6wifR8s8x4fLn9vNfSxHz0RHqsdU6CysEMu5/
         UGow==
X-Gm-Message-State: AC+VfDySd5YftuVMO6yzGSWDFL5HakNcYnBDZdh+iquUPtVOS8OCB5zC
	hxXZqGPf5fSqGcEC4ayDA8Bl2DWgJu0fFazDoZC2RIz3tKPWa/T8t+tSZi01qTvHldo+IFL8GMc
	qfWCWUdDSGzZXE00=
X-Received: by 2002:a05:6214:2a84:b0:625:8eef:1e71 with SMTP id jr4-20020a0562142a8400b006258eef1e71mr9635433qvb.0.1686232674832;
        Thu, 08 Jun 2023 06:57:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bVJN/VdumR9tSUvby4B1H71TO9IHWdUvCd72/2KL56rdsiFNJK/08VDIyt5j+OKO/UzePvg==
X-Received: by 2002:a05:6214:2a84:b0:625:8eef:1e71 with SMTP id jr4-20020a0562142a8400b006258eef1e71mr9635397qvb.0.1686232674542;
        Thu, 08 Jun 2023 06:57:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-199.dyn.eolo.it. [146.241.247.199])
        by smtp.gmail.com with ESMTPSA id j9-20020a0cf509000000b0062618962ec0sm405431qvm.133.2023.06.08.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:57:54 -0700 (PDT)
Message-ID: <5bd6ced877e97ac674d1308eab0b8d2107b7ab85.camel@redhat.com>
Subject: Re: [PATCH net-next v6] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
From: Paolo Abeni <pabeni@redhat.com>
To: Breno Leitao <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrea.righi@canonical.com,
 asml.silence@gmail.com,  ast@kernel.org, axboe@kernel.dk,
 courmisch@gmail.com, davem@davemloft.net,  dccp@vger.kernel.org,
 dsahern@kernel.org, edumazet@google.com, gnault@redhat.com, 
 hbh25y@gmail.com, joannelkoong@gmail.com, kernelxing@tencent.com,
 kuba@kernel.org,  leit@fb.com, linux-kernel@vger.kernel.org,
 linux-sctp@vger.kernel.org,  linux-wpan@vger.kernel.org,
 lucien.xin@gmail.com, marcelo.leitner@gmail.com,  martin.lau@kernel.org,
 martineau@kernel.org, matthieu.baerts@tessares.net, 
 miquel.raynal@bootlin.com, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
 stefan@datenfreihafen.org, willemdebruijn.kernel@gmail.com, 
 wojciech.drewek@intel.com
Date: Thu, 08 Jun 2023 15:57:48 +0200
In-Reply-To: <ZIGUofpP4k24qfQs@gmail.com>
References: <20230606180045.827659-1-leitao@debian.org>
	 <20230607173142.86395-1-kuniyu@amazon.com> <ZIGUofpP4k24qfQs@gmail.com>
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

On Thu, 2023-06-08 at 01:43 -0700, Breno Leitao wrote:
> Hello Kuniyuki,
> On Wed, Jun 07, 2023 at 10:31:42AM -0700, Kuniyuki Iwashima wrote:
> > > +/* This is the most common ioctl prep function, where the result (4 =
bytes) is
> > > + * copied back to userspace if the ioctl() returns successfully. No =
input is
> > > + * copied from userspace as input argument.
> > > + */
> > > +static int sock_ioctl_out(struct sock *sk, unsigned int cmd, void __=
user *arg)
> > > +{
> > > +=09int ret, karg =3D 0;
> > > +
> > > +=09ret =3D sk->sk_prot->ioctl(sk, cmd, &karg);
> >=20
> > We need READ_ONCE(sk->sk_prot) as IPv4 conversion or ULP chnage could
> > occur at the same time.
>=20
> Thanks for the heads-up. I would like to pick you brain and understand
> a bit more about READ_ONCE() and what is the situation that READ_ONCE()
> will solve.

AFAICS, in this specific case READ_ONCE() should not address any "real"
bug causing visible issue.

Still the lack of it will likely cause syzkaller report for (harmless,
AFAICS) 'data races' around sk->sk_prot. We want to avoid such reports,
even if harmless, because they can end-up hiding more relevant bugs.

> Is the situation related to when sock_ioctl_out() start to execute, and
> "sk->sk_prot" changes in a different thread? If that is the case, the
> arguments (cmd and arg) will be from the "previous" instance.
>=20
> Also, grepping for "sk->sk_prot->", I see more than a bunch of calls
> that do not use READ_ONCE() barrier. Why is this case different?

Races on sk->sk_prot can happen only on inet6_stream_ops (due to ulp
and/or ADDRFORM) inet6_dgram_ops (due to ADDRFORM). AFAICS here
READ_ONCE() is  needed as we can reach here via inet6_stream_ops-
>inet6_ioctl

Cheers,

Paolo

