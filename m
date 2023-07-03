Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0A100A3
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688397500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4DbfGHfvCJwuQnD3yVlhAPmsD+z3p05txtPx+a5g8k=;
	b=J7et+9JrWMOwz2fT3sol64kzGX+DKMzefKxiCJkGSaVSfUj/rYXW9txN77/zZyajJhyl+a
	G8vKzqrd8vBA8pqrkGR7jDJLBIrXKzxGWwz5T/ZJVxRg5Ko0iXW8eP0edCPqB7XlMsaUA3
	qebgfIzyTi1Og1wGDaEDiKFY1PlaN80=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-bW5TvbDZO1aq6K94xz3Big-1; Mon, 03 Jul 2023 11:18:19 -0400
X-MC-Unique: bW5TvbDZO1aq6K94xz3Big-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-401df9d2dc4so10643361cf.0
        for <mptcp@lists.linux.dev>; Mon, 03 Jul 2023 08:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397497; x=1690989497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4DbfGHfvCJwuQnD3yVlhAPmsD+z3p05txtPx+a5g8k=;
        b=VV9nkkP3/RleICifwung9ejT0QUq40oSmaexuW6cIH+yhTP44Zue+0iKLV5Db1Tkjh
         1z7roTrA7cgi+cQ8dHHOaB8dh1iDhPImCJ72LDGCtzvLCYGQA15EvyjuXCZebw/XENpM
         /XUidzFFOI8PUCHDN0Z0xuKjHhZ7U7UPkKojOHdLxq3y35dRufwjDxUtt7tnuJnm0dXV
         ZsSRZ11AnP2foQoFx6rj7+yWKDFtVgMMOpyrO2ebZi6RE/+qoI+opoj+yBAIzOyefOoz
         E96ewnAwkD9HwrPOkc+SjF4uGdkQ4KAHLN/aMOLtXPrHoNRe2UPW1OzOg460OZxWKd/D
         PFTA==
X-Gm-Message-State: AC+VfDz1RXeAL0ZYVATH61GWH4yTOti5d/vYtdcjNGWUlXWi76ZGvK74
	+3Wn/02NDIVZ8OVS1BNl45CXNVV2tWB8UBte21sD0ZiAnyKuE1t32wrZahh5g82Ff6sJh6clMHs
	+JiXVAEn5zPHsrSBkOLcoz6Y=
X-Received: by 2002:a05:622a:1981:b0:400:84a9:a09c with SMTP id u1-20020a05622a198100b0040084a9a09cmr13615516qtc.6.1688397497724;
        Mon, 03 Jul 2023 08:18:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZoupYz9V8B+6TNYEOcY+R5XTXKqyroP3OBHpNpmiZHfVa6IklOo1QOa4XOYPobpdLQxOCBg==
X-Received: by 2002:a05:622a:1981:b0:400:84a9:a09c with SMTP id u1-20020a05622a198100b0040084a9a09cmr13615494qtc.6.1688397497410;
        Mon, 03 Jul 2023 08:18:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id j11-20020ac85f8b000000b003fdec95e9c8sm5602222qta.83.2023.07.03.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:18:17 -0700 (PDT)
Message-ID: <dde10ed6f356d1593d43b64f582e8bc740ff3e9b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] BPF 'force to MPTCP'
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 03 Jul 2023 17:18:15 +0200
In-Reply-To: <cover.1688004307.git.geliang.tang@suse.com>
References: <cover.1688004307.git.geliang.tang@suse.com>
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

Hi Geliang,

On Thu, 2023-06-29 at 10:12 +0800, Geliang Tang wrote:
> This series depends on the two netns patches, should be inserted before
> the BPF scheduler series:
>   selftests/bpf: use random netns name for mptcp
>   selftests/bpf: add two mptcp netns helpers
>   bpf: Add bpf_mptcpify helper
>   selftests/bpf: Test bpf_mptcpify helper
>   selftests/bpf: Add mptcpify selftest
>   mptcp: refactor push_pending logic
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79

Again sorry for the possibly late feedback.

Before investing more time on this topic, are there any issues with the
current tools available (mainly: 'mptcpize') that need to be addressed?

Otherwise we would possibly better off not adding more code to the
kernel for such goal.

/P

