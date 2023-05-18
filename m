Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA323C69
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684419951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHdrfva4F4JOeIfF3k7WaE1+pl1LmSs7qpgQjhizY/E=;
	b=Ju/OQkV1fthQziTIhNasM0hHh1aZxwF2kLY7REu7w/T6XzHq7n9KCq7QyLaW8++lHZqGfT
	EbAJK7NmToU3F10yHPNth8TCYcSsRFD6A4f7zmqJj2nyxKUdL0fycGtZ9uHzs3sVr0oa8w
	QRsYR6Atp3Lo8SEyTIux2IGPrPa5Qq4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-y0J5wTR5O5-vrDkJwwmqUA-1; Thu, 18 May 2023 10:25:49 -0400
X-MC-Unique: y0J5wTR5O5-vrDkJwwmqUA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30944ad9089so84949f8f.1
        for <mptcp@lists.linux.dev>; Thu, 18 May 2023 07:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684419948; x=1687011948;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp3CZ7JzNOVS4qcXvcOTYPu4gLW8u2Qfh3hfU0O9b00=;
        b=PtmyagF4VCSmodm/2hGbS3d6QRpejWTK3zO/P4xi7FIsWi7mW7hKUS81Ls7WJmcd5a
         tLpFNdHiScVtgducxSOjnAg66IyWi9FV7S+dhUsHCZNoF+c8McBjq43ZpxQo9z+K9pjT
         EIjl0YIENjE6+e5pb1Pfsji5v4jCaDjg9edWO9fCUeGiqz2WxhO2/tnUx665+ESqAxZ9
         fb4CkdeLQkVvm6pean0Jyb9GlSG2gdibJD356kz3bnhZNMRIQIjgjTYhqI3HnvKllxvg
         MX5Twmpds9yT7RVb5STwJ9soo0aYKzZFS5P6R3NcxOw1FoAGrOdgWGhxvu7ybTG5Y30I
         TZ4A==
X-Gm-Message-State: AC+VfDx9Ug0VgzkJwfRxlIfX357mR6uWpVXvqTe74mDYlAO5shNdUEBD
	0qQZjCaE761Ef6280RQSUHiPmDP8EC9kfTU6NAncYxQE1A1DJkvpwr+AHtzuyeMOtnoaQx0wHam
	X55AL76yVRgGt4dlIKgn/q0Y=
X-Received: by 2002:adf:ec0f:0:b0:2f9:12ae:4a29 with SMTP id x15-20020adfec0f000000b002f912ae4a29mr4461955wrn.5.1684419947883;
        Thu, 18 May 2023 07:25:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DG/wqbYGF+76vdI3kK+VxlIe9p9RmT41HILGBdDS9BeJ+vklNJxyXv3o4105PG1aNcaE4yQ==
X-Received: by 2002:adf:ec0f:0:b0:2f9:12ae:4a29 with SMTP id x15-20020adfec0f000000b002f912ae4a29mr4461946wrn.5.1684419947569;
        Thu, 18 May 2023 07:25:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-175.dyn.eolo.it. [146.241.239.175])
        by smtp.gmail.com with ESMTPSA id p4-20020a7bcc84000000b003f42d3111b8sm2197533wma.30.2023.05.18.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:25:47 -0700 (PDT)
Message-ID: <1fdc3f043e6ae0ca60a6e5eadccb757088ee71e3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/4] mptcp: add subflow unique id
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 18 May 2023 16:25:45 +0200
In-Reply-To: <af3935bd-04c2-88ea-7349-3af4ade2ad3c@tessares.net>
References: <cover.1683212362.git.pabeni@redhat.com>
	 <456718f354d8db508b2db8590d9b055d49c728e9.1683212362.git.pabeni@redhat.com>
	 <af3935bd-04c2-88ea-7349-3af4ade2ad3c@tessares.net>
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

On Wed, 2023-05-17 at 16:25 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 04/05/2023 18:39, Paolo Abeni wrote:
> > The user-space need to preperly account the data received/sent by
> > individual subflows. When additional subflows are created and/or
> > closed during the MPTCP socket lifetime, the information currently
> > exposed via MPTCP_TCPINFO are not enough: subflows are identifed only
> > by the sequential position inside the info dumps, and that will change
> > with the above mentioned events.
> >=20
> > To solve the above problem, this patch introduces a new subflow identif=
ier
> > that is unique inside the given mptcp socket scope.
> >=20
> > The initial subflow get the id 1 and the other subflows get incremental
> > values at join time.
> >=20
> > The identifier is exposed to user-space overloading tcpi_fackets in
> > MPTCP_TCPINFO.
>=20
> This smart idea solves the issue with MPTCP_TCPINFO but not with
> MPTCP_SUBFLOW_ADDRS. But I guess for the second one, we can easily add a
> new field in "struct mptcp_subflow_addrs", right? If yes, we can do that
> in a new dedicated commit, that's not blocking this series I think.
>=20
> We can add:
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/388

Right, the above is not completed yet.

Possibly the right solution would be implementing a new SOCKOPT dumping
all the info alltogether.

BTW I just noticed this patch has a bug: we need to explicitly set the
subflow_id for active MPJ subflow - that will not land into
__mptcp_finish_join as they are already present into the conn_list when
mptcp_finish_join() is invoked.

>=20
> (But not the "Closes" tag then)
>=20
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  include/uapi/linux/mptcp.h | 3 +++
> >  net/mptcp/protocol.c       | 3 +++
> >  net/mptcp/protocol.h       | 5 ++++-
> >  net/mptcp/sockopt.c        | 1 +
> >  4 files changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index 32af2d278cb4..49bfbf85cb80 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -249,4 +249,7 @@ struct mptcp_subflow_addrs {
> >  #define MPTCP_TCPINFO=09=092
> >  #define MPTCP_SUBFLOW_ADDRS=093
> > =20
> > +/* MPTCP_TCPINFO overload obsoleted tcp fields with MPTCP-specific inf=
o */
> > +#define tcpi_subflow_id=09=09tcpi_fackets
>=20
> Should we eventually add a comment next to the declaration of
> "tcpi_fackets" in include/uapi/linux/tcp.h to say that this field is
> being used by MPTCP_TCPINFO? Or this is not needed because this is field
> is only overridden when using MPTCP_TCPINFO?
>=20
> I guess it will never be removed anyway. But could it be overridden by
> another field at some points later?
>=20
> Cheers,
> Matt

