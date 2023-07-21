Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC831E51A
	for <mptcp@lists.linux.dev>; Fri, 21 Jul 2023 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689954088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8cgnl5BAX44p2YbFmpGnsfzQxS2FDmgpUkh24z043k=;
	b=JgtdmBQpdaF6JMl8agPfnTq6SYv3zm59dFnzi5xmheJFRV6KRiMpoVukCU07uMdvrmpWGX
	t9pvn1+TJ916Bop6vqfy6wYwU9MaINTMt3HNEU7b0cNvNDH3fhWUgbBSo5Q92cUUQJDZfq
	j9IGw44QmZsVYkzdlrjsSX5HU3Psgck=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-69Wf5RpgP-mrH34fux5mNQ-1; Fri, 21 Jul 2023 11:41:27 -0400
X-MC-Unique: 69Wf5RpgP-mrH34fux5mNQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a3eaa4450bso403474b6e.0
        for <mptcp@lists.linux.dev>; Fri, 21 Jul 2023 08:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954087; x=1690558887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8cgnl5BAX44p2YbFmpGnsfzQxS2FDmgpUkh24z043k=;
        b=ccXlKhjxQMxlq9x2E0eXGgbTRnGU+T9i6KxmGvHFpVtLSn2tawwAo5qj54DnFtvMHg
         z5euNUV3u0LCzJ8CRTqZ2IZ0gUHBh+wk9ms0JME4wMG/KDNsz6LrsCUeStD38BwQJn9i
         ob/ABzPjTC/9Jlns7uojNQ/eSKhb4j32kWBYmT6sGMWi2T50AQ4rh9+xBRJLDQ5qZDCB
         XHjzjMnwlsloq3dnTjSEk/2rEVArJBECZfS9ZJz+KGBgznz8GIgTy8DkfMg1zIFF4cj7
         VVOrloG/MZo+d+V+bstxqB3C8K/44KrbnUbsbx+QRCG1HSfh3fMeX5J0mf/ZcUptb4fl
         PcOw==
X-Gm-Message-State: ABy/qLalTcPCV20PZ90ReSRC9QMZ6Pz0vSc0Lm29ytZW4lCQPKL8drAd
	h0zfz8WgxN+wXJcwYqQQEmuM16bzey/9e1SXhTxSDoyE7FhhfHp1W4R1JAoD0aCszg+2+N34lyx
	Lk90geS2Wi+tc1IE=
X-Received: by 2002:a05:6808:2012:b0:3a1:ebb8:396a with SMTP id q18-20020a056808201200b003a1ebb8396amr2484120oiw.2.1689954086949;
        Fri, 21 Jul 2023 08:41:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlELh3LCVyIjDSYzfP7YYMppfn4Cr5NBb0oDNk/2JsSb+PQUSljGKaDODwDyZDUwYHXmKS7ufA==
X-Received: by 2002:a05:6808:2012:b0:3a1:ebb8:396a with SMTP id q18-20020a056808201200b003a1ebb8396amr2484106oiw.2.1689954086595;
        Fri, 21 Jul 2023 08:41:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id l6-20020a0ce506000000b005ef442226bbsm1362996qvm.8.2023.07.21.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:41:26 -0700 (PDT)
Message-ID: <48a05546fd31eb31c98fe48d3cd12e0f0c36bff3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/5] Documentation: netlink: add a YAML spec
 for mptcp
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Fri, 21 Jul 2023 17:41:23 +0200
In-Reply-To: <c52da63f110661ca9394bb57ee171cb949eebea5.1689932012.git.dcaratti@redhat.com>
References: <cover.1689932012.git.dcaratti@redhat.com>
	 <c52da63f110661ca9394bb57ee171cb949eebea5.1689932012.git.dcaratti@redhat.com>
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

On Fri, 2023-07-21 at 11:53 +0200, Davide Caratti wrote:
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  Documentation/netlink/specs/mptcp.yaml | 397 +++++++++++++++++++++++++
>  1 file changed, 397 insertions(+)
>  create mode 100644 Documentation/netlink/specs/mptcp.yaml
>=20
> diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netli=
nk/specs/mptcp.yaml
> new file mode 100644
> index 000000000000..b08ced3618a7
> --- /dev/null
> +++ b/Documentation/netlink/specs/mptcp.yaml
> @@ -0,0 +1,397 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-C=
lause)
> +
> +name: mptcp_pm
> +protocol: genetlink-legacy
> +doc: Multipath TCP.
> +
> +c-family-name: mptcp_pm_name
> +c-version-name: mptcp_pm_ver
> +max-by-define: true
> +kernel-policy: per-op
> +
> +definitions:
> +  -
> +    type: enum
> +    name: event-type
> +    enum-name: mptcp_event_type
> +    name-prefix: mptcp_event_
> +    entries:
> +     -
> +      name: unspec
> +     -
> +      name: created
> +      value: 1

Do we need the 'value' element here and in all the later entries? Why
is not sufficient set it on 'unspec'?=C2=A0Is that due to the later 'holes'
in the assigned values? Could it be sufficient set the first value
after the "hole"? In this case only sub_priority -> '13',
listener_created -> '15'.

[...]
> +attribute-sets:
> +  -
> +    name: address
> +    name-prefix: mptcp_pm_addr_attr_
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0


Which value get the 'unspec' entry by default? Can we avoid setting
'value' here ? A few other similar case below.

Cheers,

Paolo

