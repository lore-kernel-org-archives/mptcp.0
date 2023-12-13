Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059A1DA23
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5Ll4H3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702458910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1fSkD4XquFDwx3MCLJqmcSJP2eO0nhObzDkVEmG3Xg=;
	b=V5Ll4H3tUaxNl1JRSzCdH5ksRer+I8ac34yUxqb8i1BJKMqqvYLqfLJkl6HAPm37DhcSDo
	RJ4pbqubd8zzo77IufkQiVww/SvnPYom3H6IqszYJKMS9V/qL8aU2ksNHaikNRh0Zc3Mzv
	ymdasJKDjSxi63FokTy2TDuL680LlIY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-6ylAZiLhNdWk3HQw1fEkwg-1; Wed, 13 Dec 2023 04:15:09 -0500
X-MC-Unique: 6ylAZiLhNdWk3HQw1fEkwg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1cf7d2af71so70553366b.0
        for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 01:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702458908; x=1703063708;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1fSkD4XquFDwx3MCLJqmcSJP2eO0nhObzDkVEmG3Xg=;
        b=fFxwHubUHIhlXehi4koMS2PizwASGVu/UHeKm5ZPsBBRnRhXMl2oCW/AaEKE3+HPrI
         RUSOjTU0l98ongAQC81nOP+4fcu2TAjfZVXAzBW/skvJFmPi0C3E17ap9+DXcv1YvIw7
         MqPdy0ugeWQJTztn0Ff6rUAW8EdbT6cHtApay0h5hVPj3P50KQuNwUalWG8QfK3aW4Wp
         wIBAikPZF2yWEHad75jZ40pHUZ9Sl9V1bCGuem0QvjAQ+fqz5E3UjL9ZpyB2TehpdPFX
         vvwBuwNHAQuuC+NY66qfiYDlV9yvzs32GDDxQuYLtSWYjVpRHsdu4HSMHeLPGsx+3zjN
         +5uw==
X-Gm-Message-State: AOJu0YwvRzdYE4/gCO/7PLv5TB7qhMjM3YdX38MVnXGRLf8X4nHf4s+Y
	Kulb9r1mO0ARNszBSH6HX+dRQH7ZK+CJ/avOZCVSJ/s0E8YktZQ5+ecGlAiz3oKT8GGikzFzF3d
	Yo/z2qmtfD8ERUWJSL8+EbQw=
X-Received: by 2002:a17:907:d30a:b0:a1d:65d:c1b1 with SMTP id vg10-20020a170907d30a00b00a1d065dc1b1mr7291579ejc.2.1702458907883;
        Wed, 13 Dec 2023 01:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXnSFLDd0XTz58/3AkmJERyHe9wDOTM58P7D3JsnecrWPeykh0boWIq5iNfZ7BzIyNkbpNFg==
X-Received: by 2002:a17:907:d30a:b0:a1d:65d:c1b1 with SMTP id vg10-20020a170907d30a00b00a1d065dc1b1mr7291573ejc.2.1702458907526;
        Wed, 13 Dec 2023 01:15:07 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-166.dyn.eolo.it. [146.241.250.166])
        by smtp.gmail.com with ESMTPSA id ry9-20020a1709068d8900b00a1f7470ba93sm6677879ejc.200.2023.12.13.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:15:07 -0800 (PST)
Message-ID: <f78aa221d038eb210b82d95ab6674f089ee344df.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 0/3] add MPTCP_MIB_CURRESTAB
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
Date: Wed, 13 Dec 2023 10:15:06 +0100
In-Reply-To: <cover.1702446832.git.geliang.tang@linux.dev>
References: <cover.1702446832.git.geliang.tang@linux.dev>
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

On Wed, 2023-12-13 at 13:56 +0800, Geliang Tang wrote:
> v5:
> - merge first three patches into one as Paolo suggested.
> - drop "EXPORT_SYMBOL_GPL(mptcp_set_state);" as Paolo suggested.
>=20
> v4:
> - rebased.
>=20
> v3:
> - add mptcp_set_state helper
>=20
> v2:
> - use ftrace_regs_get_argument instead of regs_get_kernel_argument to
>   fix build warnings reported kernel test robot.
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
>=20
> Geliang Tang (3):
>   mptcp: add mptcp_set_state
>   mptcp: use mptcp_set_state
>   selftests: mptcp: check CURRESTAB counters
>=20
>  net/mptcp/mib.c                               |  1 +
>  net/mptcp/mib.h                               |  8 +++
>  net/mptcp/pm_netlink.c                        |  3 +
>  net/mptcp/protocol.c                          | 56 ++++++++++++-------
>  net/mptcp/protocol.h                          |  1 +
>  net/mptcp/subflow.c                           |  2 +-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++--
>  7 files changed, 91 insertions(+), 25 deletions(-)
>=20
LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

