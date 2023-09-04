Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1288C13B
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693839871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcqGE561reZ/p+BmcOYrU/Wk4uiLyEG2U9GO7Lxi4Ow=;
	b=gWsS9pSJ6rdFFaVPdhp+8e56RiaQxkAti8ijSIQ3/pFFOlMKtyHACFU/AppACTLdzondvW
	z5KGTsxbO+WisH2LC6pUQDySkg8z26M/RD3TFV1+nj2Fk9qkowZQcGqmJkT5DTl59Wh2TB
	RnMcvQWcRMcn/PYE9UN5JDQtTmgOQZ0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-a1ZglubKMSKZ4R80FqykxQ-1; Mon, 04 Sep 2023 11:04:30 -0400
X-MC-Unique: a1ZglubKMSKZ4R80FqykxQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b04d5ed394so2603851fa.1
        for <mptcp@lists.linux.dev>; Mon, 04 Sep 2023 08:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693839869; x=1694444669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/CSnwcnfZnXCJAiwhIZNnxkbD4OMgH906mjlc+LftQ=;
        b=ERAZlZnFDzpQ649c94gUWGyQ9suwsScVeADqu/ZArN1qkHccPxluOSOcaevxMm8y8R
         FsYXxr5/pKuYb/7XFd1RnUSTHby3MptU/WunFiRbDf6sKB5ky0SC5AfdsODaUDCTmleS
         LGDzbz/a2LfSgoIccYDaad2HCadO9CJjpcAbfJLp0sAm5Km0ooLgCv7QocoKJ41meGoA
         Sr60nT0oUvQI0TbIC6+jZawq+wsH2QYzGw9wIQLq0YYEClKSPBg5EANsO1u4X2Ht3dJY
         Ess9H/DBWsL3P+5LyQCEa8Ixc0zBlS3hlcGCb39/a3g0ztyy6Lzjmyp93eMpLUbB2LF2
         +w/g==
X-Gm-Message-State: AOJu0YwQIrAgPjJdLTYrLmw2Nse8XnzmP6zKNjKbmv7lSNokRWIjrdX2
	YxGf0MhYhV14rIOV9J2GwajXG70YMLJxbw0tLbu5XcJaQHc7mtOJJ+Bm6DayL0aOx6u39ZmJRSk
	IFbxSMxFYhn4Cceo=
X-Received: by 2002:a2e:9cc5:0:b0:2b9:e10b:a511 with SMTP id g5-20020a2e9cc5000000b002b9e10ba511mr5134509ljj.0.1693839868888;
        Mon, 04 Sep 2023 08:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3y2ejp7UC17E4Qwn0s0e9eRLrs4Vm79PRNK0+0ne8ZmtXf+PAisjKTsM3UiLELRNy1ewQXw==
X-Received: by 2002:a2e:9cc5:0:b0:2b9:e10b:a511 with SMTP id g5-20020a2e9cc5000000b002b9e10ba511mr5134491ljj.0.1693839868394;
        Mon, 04 Sep 2023 08:04:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b0099cb0a7098dsm6355325ejb.19.2023.09.04.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:04:28 -0700 (PDT)
Message-ID: <a696b90406710bbc3a0e6f58ade4468b97726a3e.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: add a new sysctl for make after break
 timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Mon, 04 Sep 2023 17:04:26 +0200
In-Reply-To: <4a3f0eaa-f915-49dc-8948-a581a6e78542@tessares.net>
References: <85f43bff28d6d080642a968c12f68f87ee4baf5c.1693835482.git.pabeni@redhat.com>
	 <4a3f0eaa-f915-49dc-8948-a581a6e78542@tessares.net>
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

On Mon, 2023-09-04 at 16:35 +0200, Matthieu Baerts wrote:
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > index c46c22a84d23..b22d41729076 100644
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
> > @@ -27,6 +27,7 @@ struct mptcp_pernet {
> >  #endif
> > =20
> >  =09unsigned int add_addr_timeout;
> > +=09unsigned int close_timeout;
>=20
> Sometimes, it is good to add a suffix indicating the unit being used but
> I guess here in jiffies, we don't need that because the time is usually
> in jiffies, right?

I guess so. Also there is an hopefully self-documenting
proc_dointvec_jiffies() below.

[...]

> > @@ -140,6 +149,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
> >  =09=09.maxlen=09=3D MPTCP_SCHED_NAME_MAX,
> >  =09=09.mode =3D 0644,
> >  =09=09.proc_handler =3D proc_dostring,
> > +=09},
> > +=09=09{
>=20
> (nit) it looks like the indentation is not OK?

c&p error. I'll fix that in v2.

> > +=09=09.procname =3D "close_timeout",
>=20
> Do you mind documenting this new entry in
> Documentation/networking/mptcp-sysctl.rst please?

I will in v2.

> Also, here as well I guess we don't need to add a suffix "_s" or "_sec"
> for the unit because usually it is in seconds, right?

AFAICS almost all timeouts under net have no such suffix, I guess that
is fine?!?

> > +=09=09.maxlen =3D sizeof(unsigned int),
>=20
> Just an idea: would it make sense to accept -1 as special case for "no
> timeout"? (maybe not, we can always put a huge value? also I'm not sure
> we can use proc_dointvec_jiffies() with -1 and I wonder if they handle
> UINT_MAX with the conversion but that's a detail)

I'm unsure if that above is needed. A 0 timeout will fire (almost)
immediately, should be a reasonable enough approximation.
>=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 80d06cab8bc7..8022f00190ad 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2501,7 +2501,7 @@ static bool mptcp_close_tout_expired(const struct=
 sock *sk)
> >  =09=09return false;
> > =20
> >  =09return time_after32(tcp_jiffies32,
> > -=09=09  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
> > +=09    inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(s=
k));
>=20
> (nit: the indentation looks strange but maybe what you wanted?)

Just trying to fit 80 chars, probably it's better to align to the above
'('

> > @@ -2643,7 +2643,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *ms=
k, unsigned long fail_tout)
> >  =09if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
> >  =09=09return;
> > =20
> > -=09close_timeout =3D inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jif=
fies32 + jiffies + TCP_TIMEWAIT_LEN;
> > +=09close_timeout =3D inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jif=
fies32 + jiffies +
> > +=09=09=09mptcp_close_timeout(sk);
>=20
> Do we need to do something special if mptcp_close_timeout(sk) returns 0,
> AKA close the MPTCP connection immediately?

AFAIK, not needed. mod_timer() will be fine to schedule it ASAP.

Cheers,

Paolo

