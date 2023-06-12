Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FA1B8E8
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686580024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFXIxALc9YVBEmlQEwJUDfU4/1DJzLjUWxucPZsWcuw=;
	b=HyZHIEs+JVvVWKQ+VFld6rq9ey+ruxQxJmRbq3QhTsHadMKD4cg8nEYX5dX0Fnl9MANqy6
	3TDxycCB/R7QvVnTlELqdwGP2nmiibjUTUdEG/7HPMHG4amt8sfS25S9644OyeiXViMe5V
	xhnGKTM8jDftG7YXm4TmC0BRbZhntRo=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-wBzTMaGiNguFfDwUMDWySg-1; Mon, 12 Jun 2023 10:26:57 -0400
X-MC-Unique: wBzTMaGiNguFfDwUMDWySg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-78cdfb437ccso12267241.0
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686580017; x=1689172017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gpOy9l3SU/hCqCdfWLS5/j2ZDsJnnmyKKOBx52ZIdw=;
        b=Wm4d8f6ApjCEmg9kPEkVnktl0JDld0DKMpGblIbPZUmP4CayRJl3mhZ5CsVChog1p2
         F9wjz+VXMDWZnIp4kMtyTrory750tpPNmyC6gtQN7Zpkqk+4mZGX6EdnEKi5gpEGePZz
         NLQiRAWOtUEl6EpqfnS71hz1v64c4LCdGJdLABozXU+ZNXNE3TrREMDiMaAicqCgz3TE
         EYP3+AQDsKg7dLKRVyuFv6L2hDAVsgZclXNfuSJ1IUUsp8W2Q3ME/ynNmdtXSu+uOsSh
         akS4yKAmyb+WkIdMuUMH6P0ePTtI/TUoFa06HbN3LdVJWBUgIDGaI3LLwfr0dwva3pwI
         wo3A==
X-Gm-Message-State: AC+VfDxlqqqf+jyIC1/A1uNKRL+wN3VOTzyqrfGBq3Wk5W35JUa67lK7
	nie8/1qf1but1q/1hnVRWXdI44DdP82R2ulbEqg9Ce0fn1pngCe+1IKRKvPt2SHJsYzWf2/PVbB
	lqm+ZOLaHu3HBu8Y=
X-Received: by 2002:a05:6102:83c:b0:43b:1a40:afa7 with SMTP id k28-20020a056102083c00b0043b1a40afa7mr2853886vsb.0.1686580017352;
        Mon, 12 Jun 2023 07:26:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nPEfMfIxPn1b3ZrhsSBDtyLlxJmeF0B05LF+aymHMtZYh3rEBxsiDC4e4uru5sxR8bK03FQ==
X-Received: by 2002:a05:6102:83c:b0:43b:1a40:afa7 with SMTP id k28-20020a056102083c00b0043b1a40afa7mr2853878vsb.0.1686580017095;
        Mon, 12 Jun 2023 07:26:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id a20-20020a0ca994000000b0062de1ed9d15sm1468209qvb.102.2023.06.12.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:26:56 -0700 (PDT)
Message-ID: <64d43cd38ddd96c4e077c0c36bd9cdfe67d0b821.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: convert netlink from small_ops to
 ops
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <martineau@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 12 Jun 2023 16:26:53 +0200
In-Reply-To: <ZIcjmflYHQMZ0p2H@dcaratti.users.ipa.redhat.com>
References: <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
	 <a5feec31cd5025a0357b8f60293b0879d3bb1461.camel@redhat.com>
	 <ZIcjmflYHQMZ0p2H@dcaratti.users.ipa.redhat.com>
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

On Mon, 2023-06-12 at 15:54 +0200, Davide Caratti wrote:
> On Mon, Jun 12, 2023 at 12:15:59PM +0200, Paolo Abeni wrote:
> > On Mon, 2023-06-12 at 11:39 +0200, Davide Caratti wrote:
> >=20
> > > @@ -1305,7 +1384,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff=
 *skb, struct genl_info *info)
> > >  =09struct mptcp_pm_addr_entry addr, *entry;
> > >  =09int ret;
> > > =20
> > > -=09ret =3D mptcp_pm_parse_entry(attr, info, true, &addr);
> > > +=09ret =3D mptcp_pm_parse_entry(attr, info, MPTCP_PM_CMD_ADD_ADDR, t=
rue, &addr);
> >=20
> > Can we pass to mptcp_pm_parse_entry() directly the relevant policy
> > instead of the cmd? it will avoid the need for mptcp_nl_cmd2policy()
> > and possibly for the 'duplicated' definitions above.
>=20
> this will avoid the need for mptcp_nl_cmd2policy(), but it won't probably
> eliminate the dups in the long term, when yamlification will be in place.
> (I need to confirm this by looking again at the tool, will let you know).

Whoops, I did not see the V3 when I first commented here, sorry! (well,
mid-air collision mostily ;)

I *think* let the yaml-ification introduce the code duplication would
be better, as that code is automatically generated, we can allows dups
there. Also, if the tool will change/improve, such dups *could* be
automatically-removed in the future.

Unless is causing some problem/functional issue/unneeded complexity or
complication, I would avoid adding the dups here.

Otherwise, if any of the above is true, let's add the dups and
whatever!

/P

