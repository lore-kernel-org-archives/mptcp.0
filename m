Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B223BD
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687936371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Elbfr55q3c2N863DINYJcrnrMQxuvkkit92EcKKcfLU=;
	b=JyghQnUuz2ZPse9qo71dG/qa5tsIV5ltbPKRRG12GfV5EbAgwGU20tcGVwdkmeTCdGY8HL
	hAoK1qbmiTpMV7Q5SHT/ubBv9yMCVf2nNvJcBldpmU+NDdD5LjWbY3KloA/hTZzip8MVFH
	H7vicBSadjj6PPOSO3wCnQJ8kB6WX20=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-Ezvj8DoeM6WzumhbflqSKg-1; Wed, 28 Jun 2023 03:12:50 -0400
X-MC-Unique: Ezvj8DoeM6WzumhbflqSKg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-402fa256023so1674991cf.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 00:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687936370; x=1690528370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Elbfr55q3c2N863DINYJcrnrMQxuvkkit92EcKKcfLU=;
        b=IdH84MiNgo4nkw0gfGwnxayD8jwnToJUyzgVdXP2O+NqArcSNXx/5eACYCqYiP0U4P
         l5vdwxMNcfA8RTdiwl/5z4Dl4HBcuBe5vjzehbZDRSfKfeEmlaJeJx5T/41fpESO5M6A
         kdvgowo8NxQCuLxDJwAlEq0bj5DdxB5wGNHy2Uzi5GKgFax9/0wPgkuRlLwdwR3YKOCw
         fnE5fKN72jlbrxJbCiJRAEHzuppdodF5km/YGwR0b5ADOJt5FoGDe4S+hronuXi2Ul1W
         nRUUs3MQn8yMKHFdKfWkjxdnFv4UV5c4ohNDPMMVbNd5p5j9PcVpM6NBVtHSlugx/j+5
         ecUw==
X-Gm-Message-State: AC+VfDy8Llc/eKK30QkavaEw4S13RrmS6thO/9iKVqvA62gHBxh7S9ec
	VoV2R1eG8BjBsGO2yYaQBYFW4YfoR8cSetLUS1Pkvtk/m6D3GEDYTnPzRrW5bsozD6ZNmqfBisy
	Cm3bEzHh61yxITUV+k49gX1B10jwEPqMa7NCiQ9f6E7j7Ln2Tx4guZ6UoDSsvouO3zsiBdbZu
X-Received: by 2002:a05:622a:180e:b0:3f6:a9e9:1e96 with SMTP id t14-20020a05622a180e00b003f6a9e91e96mr44605031qtc.2.1687936369830;
        Wed, 28 Jun 2023 00:12:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yjF3pUGgQRlAUK8AefzZlTgHLayreg/hxnNz4Twf+mH05ksR1FtKzBAWrJU5PFeH6PlMHHg==
X-Received: by 2002:a05:622a:180e:b0:3f6:a9e9:1e96 with SMTP id t14-20020a05622a180e00b003f6a9e91e96mr44605008qtc.2.1687936369435;
        Wed, 28 Jun 2023 00:12:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-127.dyn.eolo.it. [146.241.226.127])
        by smtp.gmail.com with ESMTPSA id fy22-20020a05622a5a1600b003f9b6d54b17sm5541229qtb.58.2023.06.28.00.12.48
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 00:12:49 -0700 (PDT)
Message-ID: <ef68b1f1a0d79383565827c8f2440d9d0498db07.camel@redhat.com>
Subject: Re: mptcp: fix bogus socket state update: Tests Results
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 28 Jun 2023 09:12:46 +0200
In-Reply-To: <08e7a375-af0d-b512-0a64-3a8489d72a76@gmail.com>
References: <4e3c5d0b8d30cd8aa36ba591be38e5ca8958edf9.1687886219.git.pabeni@redhat.com>
	 <08e7a375-af0d-b512-0a64-3a8489d72a76@gmail.com>
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

On Tue, 2023-06-27 at 18:46 +0000, MPTCP CI wrote:
> Hi Paolo,
>=20
> Thank you for your modifications, that's great!
>=20
> Our CI did some validations and here is its report:
>=20
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 2 failed test(s): mptcp_connect_mmap selftest_mptcp_connect=
 =F0=9F=94=B4:
>   - Task: https://cirrus-ci.com/task/6484223167561728
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6484223167561728/=
summary/summary.txt

oh wow, failures here look real. Let me investigate them...

/P

