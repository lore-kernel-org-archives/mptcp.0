Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F615AA
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686321606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhWLk4u+qi4RHWSAAW7X1vOtxXYi9sm7ob8fZ/HJDxo=;
	b=WfIxo6gQjI77vh7JaMjO2Ab+fzv4qcyWLh3BelXFBHy1KRSrBICp7sNrzOnYX1QR4qMFTv
	S4bDJCUTw7iyohY/rmH4IlVLAP7cHUteYcWAAMuTwqfYHc7tQXDUPf6S6ZXD89WRAb2Sid
	uKYqUdeiXRcYKUOeLcVWuu5zjSc8C3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-2xHNwyvnNYuCvfM2XtunSg-1; Fri, 09 Jun 2023 10:40:04 -0400
X-MC-Unique: 2xHNwyvnNYuCvfM2XtunSg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7ecda6eefso3379155e9.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 07:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321602; x=1688913602;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xaw9L4wBlSa4mZ59mHHtd3vX6V6A8A7UOmTuz6iZ3QM=;
        b=j6u0hG9CtWTUhMNIFdBdA6fNY12B6CrPvvP0UEfWHptEW95/4YzcimWxSjV/ujLnbA
         WFCxDbBGgu61CexFAeSlQzncQDJMrKRJuT2tZts8hv/kgDbz2qxS0VspLh7TjB7tIJf4
         Q6ep7yKkkmxQdzJrYw6QcsZN24fFrcKp+6/3e6JYSO5/QCxYpDCMAmLDQKuS7RumrJTI
         4Sz/DwvDix41w3IUNz4opgKDTJCxy33WNue4rn58IlRtKIdfJF7v9uP18zdINxvMeh4k
         xmb7r6wBc0vGoq3/Pe0TI9fI6LJO/7QCEpdsBj6mBUxSvDSyq4h58GpvORHQpms1MzbB
         ZX8w==
X-Gm-Message-State: AC+VfDz47nu1sxlowL1YY5l0teCKbhAJOgZvAlL4Wup61RMC17rpu1rR
	k9uWWz5plw/78eBHPxqQBf3Y9UQS0vl4nT1d+Ieg86C5F67ht4K2PayQW7zemdtOV+qavA+O7Ga
	olDkdAheAYZ/gJ1KOSSTFz2U=
X-Received: by 2002:a05:600c:198c:b0:3f7:f2df:4e3e with SMTP id t12-20020a05600c198c00b003f7f2df4e3emr1515486wmq.3.1686321602745;
        Fri, 09 Jun 2023 07:40:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44V5j3UZfEZQRQACfnqWKRqFCGrmmyWhnNK0FVChPcHHx7bsxos8N7YJ4x1pi4XZ9RuOdLXg==
X-Received: by 2002:a05:600c:198c:b0:3f7:f2df:4e3e with SMTP id t12-20020a05600c198c00b003f7f2df4e3emr1515477wmq.3.1686321602446;
        Fri, 09 Jun 2023 07:40:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003f8044b3448sm2522999wmj.9.2023.06.09.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:40:02 -0700 (PDT)
Message-ID: <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 09 Jun 2023 16:40:01 +0200
In-Reply-To: <20230609133236.GA30403@localhost>
References: <cover.1686202841.git.geliang.tang@suse.com>
	 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
	 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
	 <20230609133236.GA30403@localhost>
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

On Fri, 2023-06-09 at 21:32 +0800, Geliang Tang wrote:
> On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
>=20
> > May I guess you get a similar error if you do:
> >=20
> > =09subflow =3D mptcp_subflow_ctx(ssk)
> >=20
> > ? (just out of sheer ignorance and curiosity)
>=20
> Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk' is
> considered unsafe in BPF context. So here we pass 'send_info[SSK_MODE_ACT=
IVE].ssk'
> into bpf_mptcp_subflow_ctx() to find the related subflow. Then we access =
this
> subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. This can make =
BPF happy.
>=20
> >=20
> > > +=09 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > > +=09 */
> > > +=09subflow =3D mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACTIVE].ssk=
, data);
> > > +=09ssk =3D mptcp_subflow_tcp_sock(subflow);
> >=20
> > What if you store the 'subflow' pointer in 'send_info'? Will the
> > verifier splat with that? and what if we store the corresponding
> > context index 'i' instead?
>=20
> Storing the 'subflow' or index 'i' don't work too.

Uhmm... I'm very surprised about 'i'. Specifically what I mean is:

struct subflow_send_info {
=09unsigned int subflow_id;
=09__u64 linger_time;
};

// ...
=09for (i =3D 0; i < SSK_MODE_MAX; ++i) {
=09=09send_info[i].ssk =3D MPTCP_SUBFLOWS_MAX;
=09=09send_info[i].linger_time =3D -1;
=09}
// ...

=09=09if (linger_time < send_info[subflow->backup].linger_time) {
=09=09=09send_info[subflow->backup].subflow_id =3D i;
=09=09=09send_info[subflow->backup].linger_time =3D linger_time;
=09=09}

// ...
=09if (send_info[SSK_MODE_ACTIVE].subflow_id =3D=3D MPTCP_SUBFLOWS_MAX)
=09=09send_info[SSK_MODE_ACTIVE].subflow_id =3D send_info[SSK_MODE_BACKUP].=
subflow_id;

=09if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
=09=09subflow =3D data->context[send_info[SSK_MODE_ACTIVE].subflow_id];

The last assignment should be equivalent to the already used 'subflow =3D
data->contexts[i];'. What kind of errors do you see here?!? Could you
please report them verbatim?

>=20
> > that we avoid the 'mptcp_subflow_tcp_sock()'
> > call entirely.
>=20
> No need to avoid "mptcp_subflow_tcp_sock", we need to access both
> 'subflow' and 'ssk' below.

Yup, typo on my side above. I'm trying to avoid
bpf_mptcp_subflow_ctx().


Cheers,

Paolo

