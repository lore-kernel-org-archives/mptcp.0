Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFFEA23
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687948476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypdudUQRsCoF+npXHCERhNkOw78WTE67axb3jGrh7Mw=;
	b=OnMQ6kxQPWKpJWLY9c2fOrebwUUkRVapievQJp80x26Xn70EBh0JrSAQla/SExHhl1HS9j
	0gUG7ULUlQrfAlX6iikkmW0WYq1R4XAfyKPe6eR24nuFH+TIFQO3onyYvqC72erHw4KRI+
	0Jxs3FhpTh2zXvNVSIOnuX65sLkuw8M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-asxeb95wNCeccFIrthOC2A-1; Wed, 28 Jun 2023 06:34:34 -0400
X-MC-Unique: asxeb95wNCeccFIrthOC2A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7672918d8a4so2957285a.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 03:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687948474; x=1690540474;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypdudUQRsCoF+npXHCERhNkOw78WTE67axb3jGrh7Mw=;
        b=NpT+swoumgtqsIt+4D5FqsEQS5+mxt0r9CILenyhAHDatEqmldY4I38OmsXeEE5sLm
         i5/gntSPVFICHD1y8ZDquNC/4dCbAX6tsUSAbkVk+zJQrkG2hEVElY5E1FNjg3mgIOFP
         Pelx3EnoyPVW6DVI+okQVA2gLAwDYUKsJ80yzgEF/JPzIIj7nSw/KHrYpfKussCfko1f
         4W4g2zIbLAGZPavlxvMNazQOfso8iyG9ze0aWDFcwltiT+IpsAvqNIQn7wOUKZQ8f/yb
         nEGAvye78yTS0I70zFkrm6CPXxIkEKml1FbZMJyJ77tsJoKZ3wWPspt3N8D1WSmL8jEB
         8ong==
X-Gm-Message-State: AC+VfDxrHl7EAiBnhdpd/9F+YClAB2TopkEiUV6QwjUPpufSpVj8jLe8
	EBuTE5k0CTO0ZYDglu9QyB9I7QMcS9P9t3sN4zaRqktsLg1kyPJAnnn8xRaTasMcC9eqA2R4W53
	i/TuoLuDiJyzGYZUtLAlfZO5lKf5GB+sFmnYqv2qzn+ggho6YinI+NG5JqQ+4MWQczajehUxv
X-Received: by 2002:a05:620a:c45:b0:75b:23a1:69e4 with SMTP id u5-20020a05620a0c4500b0075b23a169e4mr38455205qki.4.1687948473784;
        Wed, 28 Jun 2023 03:34:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kGh6KsMON30yWreW3M5A2caA4nIooG3/HbSTY5JQQr/GJuPCt4s5xv5RY0PgtN/IAdJAEVw==
X-Received: by 2002:a05:620a:c45:b0:75b:23a1:69e4 with SMTP id u5-20020a05620a0c4500b0075b23a169e4mr38455190qki.4.1687948473416;
        Wed, 28 Jun 2023 03:34:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-127.dyn.eolo.it. [146.241.226.127])
        by smtp.gmail.com with ESMTPSA id g7-20020ad457a7000000b00634daee6ecbsm5319556qvx.113.2023.06.28.03.34.32
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:34:32 -0700 (PDT)
Message-ID: <240bdc99624be53c70b6ef86b626102f3f1dede0.camel@redhat.com>
Subject: Re: mptcp: fix bogus socket state update: Tests Results
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 28 Jun 2023 12:34:30 +0200
In-Reply-To: <ef68b1f1a0d79383565827c8f2440d9d0498db07.camel@redhat.com>
References: <4e3c5d0b8d30cd8aa36ba591be38e5ca8958edf9.1687886219.git.pabeni@redhat.com>
	 <08e7a375-af0d-b512-0a64-3a8489d72a76@gmail.com>
	 <ef68b1f1a0d79383565827c8f2440d9d0498db07.camel@redhat.com>
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

On Wed, 2023-06-28 at 09:12 +0200, Paolo Abeni wrote:
> On Tue, 2023-06-27 at 18:46 +0000, MPTCP CI wrote:
> > Hi Paolo,
> >=20
> > Thank you for your modifications, that's great!
> >=20
> > Our CI did some validations and here is its report:
> >=20
> > - KVM Validation: normal (except selftest_mptcp_join):
> >   - Unstable: 2 failed test(s): mptcp_connect_mmap selftest_mptcp_conne=
ct =F0=9F=94=B4:
> >   - Task: https://cirrus-ci.com/task/6484223167561728
> >   - Summary: https://api.cirrus-ci.com/v1/artifact/task/648422316756172=
8/summary/summary.txt
>=20
> oh wow, failures here look real. Let me investigate them...

Well, after some more digging I concluded this supposed 'fix' is
actually useless and buggy. Just discard it.

Sorry for the noise,

Paolo

