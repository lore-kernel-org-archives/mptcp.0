Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F1FBFA
	for <mptcp@lists.linux.dev>; Mon,  6 Nov 2023 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VC+g7o+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so9048a12.1
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699258748; x=1699863548; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/i/NbnNcOp2PQfn3YFUM6ZJmzO+qOkgPk5i2DQ8FBI=;
        b=0VC+g7o+7BEpdbzDG9vhckWZ11SjX+/AqkuZLMRuv1rKsW8cMMaxddbIkjVnOtGtRo
         3wnwxR+ZV652eOEvjtJwaYvLeARlndP0Lv1WQRl5yJpT+qibsBrJQeyfzLMf2Pn6U+3U
         CKHMgGCMEoyafHoFb8QcVv9bS8Son2bgaokFNecMJOUMKwIKvMVnDRWeUe6nS7d20x9+
         Dvb0e23uFgSeqNnoR/vLaVzYzrIAuz6goq9nbvnebmQgMnNMXE0KDcvPt9JJiM7R9oTo
         ZbeALT+wfFn4lTXAjKI2pnpOt91YrEWD5EdTvwPf5+wembqjyq2vEJ5SxR34c1O/H1LE
         D1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699258748; x=1699863548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/i/NbnNcOp2PQfn3YFUM6ZJmzO+qOkgPk5i2DQ8FBI=;
        b=AnjUoPNq0AfTZn4VjpVSO+w3aJzPW0+wRYjMPZMfEDz5DrwRRAjVDvjJTdMR808fp0
         Jw1l2PhLWqlCrR5hHK6X4imtWD0KMlO9zpKGaLjlgy7/X29le6/P5JimVzl59bHx130V
         T157SsK4qCAtHR36m7SKZG1gimYJAeiPrnT1hsR6Ap/d/xoYxpfFxn0DwhcnF31DdOCZ
         2pu8B8HefnDfLGy4020mJURB3JBrGTzphHeG2G8j5ReQ/dwVP65vZjIlZPsEQfoAS/yI
         CqmjqKdgApi3yeheD9finHcjJwbtAzFBIKlsO/Uu0mytGj+FFTEkqvjuvmuLXQkDS3BU
         /2Sg==
X-Gm-Message-State: AOJu0YwbTDErfTxlWECtlf3fD18LlUIi+HguOiZoafgYFeCsSeyThM8Z
	tfxWE8shgkyjjN/vdIKqtR9cXdZCxfErUqc9hq0lLg==
X-Google-Smtp-Source: AGHT+IGkyW04CpK4IDAOlc5Y0p8Zck32aKz9RbNbK1LqNDmTh5FITG274bDLPYFvC7Q84CRzdKp3MwnQ02D4rzCnsGU=
X-Received: by 2002:a05:6402:388e:b0:544:4636:db0b with SMTP id
 fd14-20020a056402388e00b005444636db0bmr101681edb.1.1699258747532; Mon, 06 Nov
 2023 00:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
 <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
 <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com> <1831224a48dfbf54fb45fa56fce826d1d312700f.camel@redhat.com>
In-Reply-To: <1831224a48dfbf54fb45fa56fce826d1d312700f.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Nov 2023 09:18:54 +0100
Message-ID: <CANn89iJ=38aXWA9K18bsMDO22SLi+XyjARTPSdvOMzycOLGPeQ@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] mptcp: refactor sndbuf auto-tuning
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 8:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On Thu, 2023-11-02 at 18:19 +0100, Eric Dumazet wrote:
> > On Mon, Oct 23, 2023 at 10:45=E2=80=AFPM Mat Martineau <martineau@kerne=
l.org> wrote:
> > >
> > > From: Paolo Abeni <pabeni@redhat.com>
> > >
> > > The MPTCP protocol account for the data enqueued on all the subflows
> > > to the main socket send buffer, while the send buffer auto-tuning
> > > algorithm set the main socket send buffer size as the max size among
> > > the subflows.
> > >
> > > That causes bad performances when at least one subflow is sndbuf
> > > limited, e.g. due to very high latency, as the MPTCP scheduler can't
> > > even fill such buffer.
> > >
> > > Change the send-buffer auto-tuning algorithm to compute the main sock=
et
> > > send buffer size as the sum of all the subflows buffer size.
> > >
> > > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Mat Martineau <martineau@kernel.org
> >
> > ...
> >
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index df208666fd19..2b43577f952e 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mp=
tcp_sock *msk, const struct soc
> > >
> > >  void __mptcp_set_connected(struct sock *sk)
> > >  {
> > > +       __mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
> >
> > ->first can be NULL here, according to syzbot.
>
> I'm sorry for the latency on my side, I had a different kind of crash
> to handle here.
>
> Do you have a syzkaller report available? Or the call trace landing
> here?

Sure, let me release the report.
