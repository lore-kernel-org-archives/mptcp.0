Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC123B7
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674758233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dc1twQJHaR9z+5m1hB22m0ydKDAzi/I3stugcfPET9w=;
	b=NVk5coVXLb4cLPOpFNtAPgP7Q4soABik1+K8HYEs/8jZpnm+JL5Kph5fnoBssNa6bCxYIp
	ppizc66ndOMZjQndViaL/VzFIhDjND1PKLxQsLCKns5O+7hk8WZvhcXqulprGA88Dldm/Q
	TZawxOoLba3gyXGI5GlcUD4408mPDng=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-65FhxE3NO1CGbXREbIcyeA-1; Thu, 26 Jan 2023 13:37:12 -0500
X-MC-Unique: 65FhxE3NO1CGbXREbIcyeA-1
Received: by mail-il1-f200.google.com with SMTP id i7-20020a056e021b0700b003033a763270so1718819ilv.19
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 10:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dc1twQJHaR9z+5m1hB22m0ydKDAzi/I3stugcfPET9w=;
        b=3++YRSSuLQmo8FibNASUk1FeW91d2TWbNQi5QDD2BsNjbXGF22C6rn79j0sdQTTkKL
         Ywz32+CItbhcz5vbULKhVBQrYf/QGGfMzz8jm3brTvZTZ/OS+6bqL3jLW89zUT7x+9vi
         uHQ8NAxBOjaRB+vT3Km1oymBGbAXPkR0Wtpijf8Dw4ysYAf7fhn0KBI6PULKGeIbGsSZ
         lsEQ1hQgDkFniAQ7yphFn8sNOwxdywPzbuDs0Uab3edA1d3Nq5suxb17Kb5p4vWYucgH
         gIhJ6tEv70Z79SrJkEEJ4qPvhPUMKAQsGRawTvJQElHhU9BrbDGNR0FGYX4phgROcDsq
         fT3A==
X-Gm-Message-State: AFqh2krA8H9cKDpIDdKVrKdG6kQOqs0b+cYho06NoRXBfDa8usHGAPOC
	69VtW6FJRqKi73quAtLW0RuwwhsxSGg91JeA9cnxmW6FxBDHYOmytY1vCRApgfMXcP32+gOpmNO
	M9q2ziEje0lWoP7A=
X-Received: by 2002:a05:6602:1253:b0:6e3:19f:b3c3 with SMTP id o19-20020a056602125300b006e3019fb3c3mr27482453iou.0.1674758231628;
        Thu, 26 Jan 2023 10:37:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuflg1szc16cIfvrWQaz+Bj6WyMRXYRPKLaCejk4aJqQ2MTm2NkiVjv0cCMyEhnfqWu7KG2lQ==
X-Received: by 2002:ac8:4d83:0:b0:3ac:1bd5:b7ad with SMTP id a3-20020ac84d83000000b003ac1bd5b7admr76691462qtw.33.1674758220690;
        Thu, 26 Jan 2023 10:37:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id 202-20020a3707d3000000b007091068cff1sm1391266qkh.28.2023.01.26.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 10:37:00 -0800 (PST)
Message-ID: <c3711eb7d970034cb4291378ac4b060333c18a92.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 11/13] mptcp: refactor
 mptcp_stream_accept()
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 26 Jan 2023 19:36:58 +0100
In-Reply-To: <b21f2991-c404-0efb-69fb-f9c6343d8ce2@tessares.net>
References: <cover.1673940640.git.pabeni@redhat.com>
	 <afe5ec8c5d1e4b7c72839c9ed9c153c18ff97935.1673940640.git.pabeni@redhat.com>
	 <7abea9a1-9f31-7a52-41df-c6199671c4ec@tessares.net>
	 <d43a5e4c7238b0bd4cb886c321a2597d03d9e544.camel@redhat.com>
	 <b21f2991-c404-0efb-69fb-f9c6343d8ce2@tessares.net>
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

On Thu, 2023-01-26 at 19:27 +0100, Matthieu Baerts wrote:
> On 26/01/2023 18:53, Paolo Abeni wrote:
> > On Wed, 2023-01-25 at 18:47 +0100, Matthieu Baerts wrote:
> > > On 17/01/2023 08:36, Paolo Abeni wrote:
> > > > Rewrite the mptcp socket accept op, partially open-codying
> > > > inet_accept(), instead of indirectly calling it.
> > > >=20
> > > > This way we can avoid acquiring the new socket lock twice
> > > > and we can avoid a couple of indirect calls.
> > >=20
> > > Maybe a stupid idea but could we eventually split inet_accept() to ha=
ve
> > > a __inet_accept() version with what has to be done while holding the
> > > lock and reusable in MPTCP?
> >=20
> > I thought about the above but in the end that would be a very small
> > helper:
> >=20
> >=20
> >         sock_rps_record_flow(sk2);
> >         WARN_ON(!((1 << sk2->sk_state) &
> >                   (TCPF_ESTABLISHED | TCPF_SYN_RECV |
> >                   TCPF_CLOSE_WAIT | TCPF_CLOSE)));
> >=20
> >         if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
> >                 set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
> >         sock_graft(sk2, newsock);
> >=20
> >         newsock->state =3D SS_CONNECTED;
> >=20
> > with the larger part  - the WARN_ON - being likely obsoleted.=20
> >=20
> > I can do that, if you prefer.
>=20
> I would prefer but please tell me if you think we should not.
>=20
> I'm maybe a bit too paranoiac because we had some nasty bugs in the past
> with mptcp.org due to modifications on TCP side. (But I know the
> situation is different here: MPTCP is upstream, people might now think
> about it when changing the core and a great net maintainer is super
> aware of MPTCP :-D )
>=20
> If the chunk is "duplicated", it would be nice to at least add a comment
> in the code :)

Ok I can send out a v3 with the bunch of additional comments discussed
in the other patches and the new helper (will add one more patch).

Cheers,

Paolo

