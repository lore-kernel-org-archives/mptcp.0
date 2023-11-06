Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB60FC8CB
	for <mptcp@lists.linux.dev>; Mon,  6 Nov 2023 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIl5sOzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699255317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKCb7j93O5+k3DYA1HT8hxFiN3yXykSBVbaRzKZG6V4=;
	b=SIl5sOzfVezwECVuuptN4JVB02iQ6qLo7cflZACcilbgU/5zV5CE5crypvhoHbeljOvGSo
	IC2FCGe0sV/wILBFB7mKRxeeR11FdwwEttZNlsENFmxnIOW9S8HVmQUJbIZ49UgRUQnWdB
	TW46vz4cWNb9xCUHmINsuw2J9OCIRfw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-9MRpDRS_Pg-hnEk2IPzcwA-1; Mon, 06 Nov 2023 02:21:56 -0500
X-MC-Unique: 9MRpDRS_Pg-hnEk2IPzcwA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9bfacbcabb1so46695966b.0
        for <mptcp@lists.linux.dev>; Sun, 05 Nov 2023 23:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255315; x=1699860115;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKCb7j93O5+k3DYA1HT8hxFiN3yXykSBVbaRzKZG6V4=;
        b=C2QqyLPczn1MhaNijGTJPYz6hpA3adHfo7gesqhCqaSWw3639PPykCTN3naapCcX8G
         aI8g4j9IR5MfZcIlqkvCUtw0EpKJaaSj69uHV1jwkbCGIhEshlpHV8//5D8ASACv/JXX
         H9rXSNr2/9iqvGaKNH9Uvp9kSTv37fYbyoyiUjWdswGKhIrur/0HdjwVxrL+dB6VLkhp
         X0lYUj6KhIDl9yveijF/wRz19oQOvBBnczvTwr1MBdOHWJPfG4y42Or5GUmAKz9AQk1D
         HEQltgz1FdC1auTFxjJaruXy223/x+W7hces3aF/xyZl/pR5/G7CscFa91Dv+DjaDA/Y
         D2kA==
X-Gm-Message-State: AOJu0YzBQIedGn3O/4CeborsGXtehQjvX9QnXpfoXmxYctRHk2NkFXkw
	H4G7qIu9ZUJMkhfwiURdnpmHV9aLioj9OfCNmatxMx+3Snhr/UpiPDbAyt4q/BZGGki/R1YAk8V
	n9HIZ2u2/bAaCm0c=
X-Received: by 2002:a17:907:9405:b0:9be:4cf4:d62e with SMTP id dk5-20020a170907940500b009be4cf4d62emr22188329ejc.5.1699255315010;
        Sun, 05 Nov 2023 23:21:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU1r8gmj5wdUh868MkTx5PNpvkzvIaFCpYSIZRndI//1jn2fPteHU3WC9GWE5hvhvaitsemg==
X-Received: by 2002:a17:907:9405:b0:9be:4cf4:d62e with SMTP id dk5-20020a170907940500b009be4cf4d62emr22188318ejc.5.1699255314698;
        Sun, 05 Nov 2023 23:21:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-226-133.dyn.eolo.it. [146.241.226.133])
        by smtp.gmail.com with ESMTPSA id fi3-20020a170906da0300b0099ce188be7fsm3769236ejb.3.2023.11.05.23.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 23:21:54 -0800 (PST)
Message-ID: <1831224a48dfbf54fb45fa56fce826d1d312700f.camel@redhat.com>
Subject: Re: [PATCH net-next 9/9] mptcp: refactor sndbuf auto-tuning
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,  mptcp@lists.linux.dev
Date: Mon, 06 Nov 2023 08:21:52 +0100
In-Reply-To: <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
	 <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
	 <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com>
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

On Thu, 2023-11-02 at 18:19 +0100, Eric Dumazet wrote:
> On Mon, Oct 23, 2023 at 10:45=E2=80=AFPM Mat Martineau <martineau@kernel.=
org> wrote:
> >=20
> > From: Paolo Abeni <pabeni@redhat.com>
> >=20
> > The MPTCP protocol account for the data enqueued on all the subflows
> > to the main socket send buffer, while the send buffer auto-tuning
> > algorithm set the main socket send buffer size as the max size among
> > the subflows.
> >=20
> > That causes bad performances when at least one subflow is sndbuf
> > limited, e.g. due to very high latency, as the MPTCP scheduler can't
> > even fill such buffer.
> >=20
> > Change the send-buffer auto-tuning algorithm to compute the main socket
> > send buffer size as the sum of all the subflows buffer size.
> >=20
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Mat Martineau <martineau@kernel.org
>=20
> ...
>=20
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index df208666fd19..2b43577f952e 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptc=
p_sock *msk, const struct soc
> >=20
> >  void __mptcp_set_connected(struct sock *sk)
> >  {
> > +       __mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
>=20
> ->first can be NULL here, according to syzbot.

I'm sorry for the latency on my side, I had a different kind of crash
to handle here.

Do you have a syzkaller report available? Or the call trace landing
here?

Thanks!

Paolo

