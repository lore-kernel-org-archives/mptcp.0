Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6D1DA27
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEYUIKZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697019202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLI+gNG/Ik5TmE6Ss6b86D5IYiR1FClxUP9y17ZJqCA=;
	b=KEYUIKZ2jgTWNTT2oNoCo82CbuvbCzRy2ftw2NgV3H6k3IAxdPBM0btyH7cNoAz2DpCMUm
	D6bguudy7E+JrTiBfO6DWMHDoXod7hhd5+KoIE0s7Ae1HsSDAT3bhu04fOcywatj9O3uPV
	z3R00rPyEgPRQ6j2Th6e59+Ix2uXE5k=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-2r6JUlKyNd6pHQio7yZG-A-1; Wed, 11 Oct 2023 06:13:18 -0400
X-MC-Unique: 2r6JUlKyNd6pHQio7yZG-A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bfeaf8cc4bso58597791fa.0
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 03:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697019197; x=1697623997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLI+gNG/Ik5TmE6Ss6b86D5IYiR1FClxUP9y17ZJqCA=;
        b=DvGcPt4myQS5kpam02P15/M+7IDTp0HhGWGHpMPWanl+xuenP0mgqyqJZZptvcIvIw
         Qzwv1ZKQFyR1Fy9fE93w32HDr2X0hDRQYkQGxBAHXMd3iBMRxULoUiXbpByos4jo0YZW
         9/vVoP43ZCY9U3ydItXIFkG0Ylo0xtySn3O1jDGB/C1MmJH9jCyRA2OP0UXUkvwdeJ68
         jW1hiJpIVCYpF51jf2Y+/gBTeDWITlHaZ409mEqBKJngXyYkggZ5GbJiIETLPvd7ecMI
         SI+K4q0xNdkF1KtaCz2ksT+hg9CAfipDHqXpB626jksTvllaGnlVHv9Op3117KfBFk1i
         V7hg==
X-Gm-Message-State: AOJu0YxevScK3QvM5PxPjhuIv76ly4mf149uvGh25j3If50bsIosE0TO
	8X3BOEv0hsqpA9554QTZv2ahH5A0nX+R443kEjj/DW+EefD78vOXbvFN4iQRvCjiD78jyCMO7JB
	DKntITdglrf+tCJHgl7hkP9ZHw9OFjmk=
X-Received: by 2002:a2e:9001:0:b0:2c1:7df1:14a6 with SMTP id h1-20020a2e9001000000b002c17df114a6mr18885601ljg.9.1697019197168;
        Wed, 11 Oct 2023 03:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgFBh7dpGZLMqhPmRhYZgbEoyXO+JEnPZeVd6y4j9UPTWyTctRlSWKtNno+D+4ydHwjWMyyV7Txz55onCUho=
X-Received: by 2002:a2e:9001:0:b0:2c1:7df1:14a6 with SMTP id
 h1-20020a2e9001000000b002c17df114a6mr18885577ljg.9.1697019196839; Wed, 11 Oct
 2023 03:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
 <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org> <20231010180839.0617d61d@kernel.org>
In-Reply-To: <20231010180839.0617d61d@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 11 Oct 2023 12:13:04 +0200
Message-ID: <CAKa-r6sT=WaTFqumYOEzOKWZoUi0KQ8EYpQ753+C5JjjsUb3wA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec for mptcp
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello, Jakub, thanks for looking at this!

On Wed, Oct 11, 2023 at 3:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 10 Oct 2023 21:21:44 +0200 Matthieu Baerts wrote:
> > +definitions:
> > +  -
> > +    type: enum
> > +    name: event-type
> > +    enum-name: mptcp_event_type
> > +    name-prefix: mptcp_event_
>
> I think you can use - instead of _ here.
> For consistency with other families?

right, I will convert the whole spec.

>
> > +    entries:
> > +     -
> > +      name: unspec
> > +      value: 0
>
> 90% sure enums still start at 0, only attrs and msgs now default to 1.

Just checked, value:0 is not needed for enums: I will remove it

> > +     -
> > +      name: announced
> > +      value: 6
> > +      doc:
> > +        token, rem_id, family, daddr4 | daddr6 [, dport]
> > +        A new address has been announced by the peer.
> > +     -
> > +      name: removed
> > +      value: 7
>
> Follows 6 so no need for value?

correct, will fix this too

> > +      -
> > +        name: addr6
> > +        type: binary
> > +        checks:
> > +          min-len: 16
>
> Do you not want the exact length for this?
> If YNL doesn't support something just LMK, we add stuff as needed..

ohh yes, we had NLA_POLICY_EXACT_LEN before but ynl doesn't seem to
support it. I can try to add the support and include another patch at
the beginning of the series, is that ok?

--=20
davide

