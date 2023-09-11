Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974FF23CE
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694413053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwQHhIyQeGgSRO7ljEPB0yGFpgec7QXg0fT1JEUfNO0=;
	b=jRJXXjYM7qglHbZoXpqJkhlxLGDHxrgk8jghhVgEN5a0aLnYfi/2igfXVVpWrFLovSD//O
	JFuhNfVCVZH4Co1y3y2a9I4wJVtUeNGLsTF27w6Jvh9eHDbXouSvOgnVbq1cS2gkYGHxgj
	u7Kh9iSZRM5bzfVXuk6wVUayvAQ91rs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-XOtTFU6dNpiw_y8GuGK0Vg-1; Mon, 11 Sep 2023 02:17:31 -0400
X-MC-Unique: XOtTFU6dNpiw_y8GuGK0Vg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso101675166b.1
        for <mptcp@lists.linux.dev>; Sun, 10 Sep 2023 23:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694413050; x=1695017850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WeEeE/ACdDOmhayDmquTmXw6o8aqD5lTSwqty4z6Qik=;
        b=L93kKVTdKfMmRHU655D92fSLqz6MOhSfAwwmp8oIRyCImvHXdPt+rM14MOVIzIdFHW
         MkYXjcHnld3Fx0a5w2DKC1LX9rQsTt/PdlY7a/ibcsQKDzc0cWtjXZ5ZHY+oNv3EscO+
         c+r/bgBgV4E3QleW5ouLSf4YY85dnYRhwSNL3AjoFqvalPeWal8IjHT5zJiA9RZyXwWz
         otgSqAD2rc+6ae72PtSe7Sxl16/recvLvr5S6wc4lMQFP0dqLTQpMyRSJOedFgOp/LnI
         9ijVLxEB0hEZhiVrPfXKslXplDeZsk0dAgWGsGpxgNLWxb+Cds+StrZE3P7jxs86w3KP
         XimA==
X-Gm-Message-State: AOJu0YzZcirvmq1E9FG290TH26PWLj00awn+VRtL4CU+gHWpeb1gnU3T
	LkypFcFV62ln5cOjA+QQU2VHayljAVLvOaFmxhgtvo25rN0NiP9N0MyviR8J2HAXxiRNMIWj+ce
	AGariSdT+KMQWrryzt3D8Q24=
X-Received: by 2002:a05:6402:35d5:b0:523:220e:a6ca with SMTP id z21-20020a05640235d500b00523220ea6camr6957410edc.3.1694413050450;
        Sun, 10 Sep 2023 23:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRMwkqQqmmFzw5hceAdxqxdOT7KuMc5mqmUhxf3IzBJp+zcfvDn9wZ0kOV1UNKrHv86CXEjw==
X-Received: by 2002:a05:6402:35d5:b0:523:220e:a6ca with SMTP id z21-20020a05640235d500b00523220ea6camr6957396edc.3.1694413050033;
        Sun, 10 Sep 2023 23:17:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-166.dyn.eolo.it. [146.241.243.166])
        by smtp.gmail.com with ESMTPSA id j18-20020a50ed12000000b0052996528b81sm4131047eds.45.2023.09.10.23.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 23:17:29 -0700 (PDT)
Message-ID: <5c4d5eefdae7992aae4a321349ec58aadbc672d9.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: add a new sysctl for make after
 break timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 11 Sep 2023 08:17:28 +0200
In-Reply-To: <b7703287-9e04-4c9a-93a6-b50c2020c5ab@tessares.net>
References: <dfadc0c4a9bf4649c01e09d675f4de59eb409f5d.1693841118.git.pabeni@redhat.com>
	 <b7703287-9e04-4c9a-93a6-b50c2020c5ab@tessares.net>
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

On Mon, 2023-09-04 at 17:58 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 04/09/2023 17:48, Paolo Abeni wrote:
> > The MPTCP protocol allows sockets with no alive subflows to stay
> > in ESTABLISHED status for and user-defined timeout, to allow for
> > later subflows creation.
> >=20
> > Currently such timeout is constant - TCP_TIMEWAIT_LEN. Let the
> > user-space configure them via a newly added sysctl, to better cope
> > with busy servers and simplify (make them faster) the relevant
> > pktdrill tests.
> >=20
> > Note that the new know does not apply to orphaned MPTCP socket
> > waiting for the data_fin handshake completion: they always wait
> > TCP_TIMEWAIT_LEN.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - add the doc for the new knob (Matttbe)
> >  - fix a couple of bad/strange indentation (Matttbe)
>=20
> Thank you for the update!
>=20
> > ---
> >  Documentation/networking/mptcp-sysctl.rst | 11 +++++++++++
> >  net/mptcp/ctrl.c                          | 16 ++++++++++++++++
> >  net/mptcp/protocol.c                      |  5 +++--
> >  net/mptcp/protocol.h                      |  1 +
> >  4 files changed, 31 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/=
networking/mptcp-sysctl.rst
> > index 15f1919d640c..f569129ea881 100644
> > --- a/Documentation/networking/mptcp-sysctl.rst
> > +++ b/Documentation/networking/mptcp-sysctl.rst
> > @@ -25,6 +25,17 @@ add_addr_timeout - INTEGER (seconds)
> > =20
> >  =09Default: 120
> > =20
> > +close_timeout - INTEGER (seconds)
> > +=09Set the make-after-break timeout: in absence of any close or
> > +        shutdown syscall, MPTCP sockets will maintain the status
> > +        unchanged for such time, after the last subflow removal, befor=
e
> > +        moving to TCP_CLOSE.
>=20
> You are using spaces for these 3 lines, the rest is OK using tabs. Did
> you switch to EMACS? :-D
>=20
> I can do the modification when applying the patch (if I don't forget :) )

I'll fix that in v3.

> > +
> > +=09The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
> > +=09sysctl.
> > +
> > +=09Default: 60
> > +
> >  checksum_enabled - BOOLEAN
> >  =09Control whether DSS checksum can be enabled.
> > =20
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > index c46c22a84d23..36e389326073 100644
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
>=20
> (...)
>=20
> > @@ -141,6 +150,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
> >  =09=09.mode =3D 0644,
> >  =09=09.proc_handler =3D proc_dostring,
> >  =09},
> > +=09{
> > +=09=09.procname =3D "close_timeout",
> > +=09=09.maxlen =3D sizeof(unsigned int),
>=20
> (just to be sure not to miss the idea which is probably not interesting)
> No need to accept negatives values and use -1 as a special case not to
> close "subflow-less" MPTCP connections?

I would prefer not adding special values. I think a large enough close
timeout could be really indistinguishable from "infinity" here.

Cheers,

Paolo

