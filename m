Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4824746BF
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674755609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulGv7BR9iW9f9R9uTik0AeBIqpWv8E2K+0gzNuMQ+as=;
	b=H6wSf23F3PITEjhoiDzq3UZDm3j1CmPXpnjpdLwjwUsTZhNP0YfXJd6vXKAfHtuXV8EeIJ
	V+BYAXQNMC6v1ElIC/jk7TU8saYoiHxitcBMtsckQuzyM/+oThIPZ4F5ijr+oWz7/DJ0V3
	izG0O3FknLjavQxO/HA7okD5m4aYezE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-UAfB_6LrOu60Q1TJ810G-A-1; Thu, 26 Jan 2023 12:53:27 -0500
X-MC-Unique: UAfB_6LrOu60Q1TJ810G-A-1
Received: by mail-qv1-f71.google.com with SMTP id f16-20020ad442d0000000b005376362aa66so1465400qvr.1
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 09:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ulGv7BR9iW9f9R9uTik0AeBIqpWv8E2K+0gzNuMQ+as=;
        b=pvg7kYrFm96BIjrMpAKWR0JowavEN0+kAJHucurF3JvPZ0lOxnE/dAek7wYyI/R/vE
         gYOiQfOHzr2/l9pOkderDDgORdSqlGyOZOvBMjupTrem1hcAtFJsQ1AdEdS/qMDUarXX
         4pLr3EFfOzPQMgRPSIFm86CzjNsUjoFLzyKjcGS0PWB9r2WvYA2FsdkkvwSWn4in2lW4
         u8QOxv7HZrAHO7VdLXxd9+pf/qiXCYZRdGYkVmJRTZf0/ZjPrrEQgjM/teZcaqOi8pjM
         1ul5NuGoeSkoGmK45CSBT/t6T67Q75VockhZYbFWEWJPu/Xm159n4i6H4ONFWAECOsnE
         yMKA==
X-Gm-Message-State: AFqh2kqlG2MiKt4DxTy0aoET1o4var/JgV7xyXUpj0BTs54ZTC5/qYzm
	kHLYTvs645qHaEOj5DwL3HOmAyDa92lWK/NzObcA+IO+hr7B2a22GtuHbTC61rwv+1x1bvlOx8t
	bBvHQavBvj5pZCcE=
X-Received: by 2002:a05:622a:22a6:b0:3b6:2b4b:5688 with SMTP id ay38-20020a05622a22a600b003b62b4b5688mr55543213qtb.11.1674755606891;
        Thu, 26 Jan 2023 09:53:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv9/cb9/lNCnoWBMc/Xy6oeuNIEgZoTQ5sNJbdCAE+KAK/PUKLy60P6fBNfsTfcvUBB8ANvpA==
X-Received: by 2002:a05:622a:22a6:b0:3b6:2b4b:5688 with SMTP id ay38-20020a05622a22a600b003b62b4b5688mr55543195qtb.11.1674755606617;
        Thu, 26 Jan 2023 09:53:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a37b904000000b00705cef9b84asm1258504qkf.131.2023.01.26.09.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:53:26 -0800 (PST)
Message-ID: <d43a5e4c7238b0bd4cb886c321a2597d03d9e544.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 11/13] mptcp: refactor
 mptcp_stream_accept()
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 26 Jan 2023 18:53:24 +0100
In-Reply-To: <7abea9a1-9f31-7a52-41df-c6199671c4ec@tessares.net>
References: <cover.1673940640.git.pabeni@redhat.com>
	 <afe5ec8c5d1e4b7c72839c9ed9c153c18ff97935.1673940640.git.pabeni@redhat.com>
	 <7abea9a1-9f31-7a52-41df-c6199671c4ec@tessares.net>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
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

On Wed, 2023-01-25 at 18:47 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 17/01/2023 08:36, Paolo Abeni wrote:
> > Rewrite the mptcp socket accept op, partially open-codying
> > inet_accept(), instead of indirectly calling it.
> >=20
> > This way we can avoid acquiring the new socket lock twice
> > and we can avoid a couple of indirect calls.
>=20
> Maybe a stupid idea but could we eventually split inet_accept() to have
> a __inet_accept() version with what has to be done while holding the
> lock and reusable in MPTCP?

I thought about the above but in the end that would be a very small
helper:


        sock_rps_record_flow(sk2);
        WARN_ON(!((1 << sk2->sk_state) &
                  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
                  TCPF_CLOSE_WAIT | TCPF_CLOSE)));

        if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
                set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
        sock_graft(sk2, newsock);

        newsock->state =3D SS_CONNECTED;

with the larger part  - the WARN_ON - being likely obsoleted.=20

I can do that, if you prefer.

Thanks,

Paolo

