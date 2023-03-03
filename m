Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DC46AA
	for <mptcp@lists.linux.dev>; Fri,  3 Mar 2023 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677847268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FepeFCltrr6Y6adbFfF6ozHOJLVN2784TOOqblo8G3c=;
	b=Lcf1uUZz8KkgL9RDOAl7ULD6gXigtr4zdbUlbqNl1Ym8ViPdv7HVN3TtPmlvhniiFAeXvk
	5CPcFT/v7O7KZkaEO7yl4VsIlb13bBe71xI90b4OgVGvhaszlE5lTWmeGTFLsJ4vDluzzf
	X7KquPU5cFaDZuGVi7xqXzbQfm/qQZs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-BiMtxCRAOPuGqXHFOnBf1Q-1; Fri, 03 Mar 2023 07:41:06 -0500
X-MC-Unique: BiMtxCRAOPuGqXHFOnBf1Q-1
Received: by mail-qt1-f197.google.com with SMTP id c11-20020ac85a8b000000b003bfdd43ac76so1407168qtc.5
        for <mptcp@lists.linux.dev>; Fri, 03 Mar 2023 04:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677847266;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FepeFCltrr6Y6adbFfF6ozHOJLVN2784TOOqblo8G3c=;
        b=KZogF8iQNNeVRqNahZXb929/8A+gKhqpm3+SgUkNyyI6KuuxL6SrXGJAlOfipNYHOS
         iryZ/jcrVccw0SRnaCAV8Wy4oeh7fV2AkHzPkzprEozgQmFhq5M6Q4NrhxrTPvhxqIL1
         dzhlRlgQXQoQDjQ0BixyUiMbPjQTYaxQ1a2Ujfoin289cX/5HQRUk/kk/RXhQUUqavDZ
         Nu/Z0rVit+sCcrNr9JXX7bDgX1pjQuJ+FL0KuKpRDZtAMS6Q6sRvFybwqUfhqdXkqLCc
         GMnyq2ahsWzxX9q1TXWEQgAPrbkCASKOSeZBwVW4JwuaPjAYihbTFP8j4aE9LTe7GUGf
         w4gw==
X-Gm-Message-State: AO0yUKX0QXvNdJFl8UhD5fC8GmlNGCyiO8bQOH/co5cwNmsLulPei+bn
	irVyQYEz5hvD9F6RvTAdr82zxil4TpEcTyurygLVT1YHm0mSI1DTfOn/7a4Eu23C8uHKgWz6TuI
	h4+BecSr9g3MdTP8=
X-Received: by 2002:a0c:dd94:0:b0:572:54c1:c14e with SMTP id v20-20020a0cdd94000000b0057254c1c14emr1924528qvk.5.1677847266313;
        Fri, 03 Mar 2023 04:41:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/FBxS/cUG+PDkuwIhgP84j9mKZaexu2RFQNHEszy7xrIX+bUBvWrgOvHDO1VJWm6twPe6o2g==
X-Received: by 2002:a0c:dd94:0:b0:572:54c1:c14e with SMTP id v20-20020a0cdd94000000b0057254c1c14emr1924493qvk.5.1677847266015;
        Fri, 03 Mar 2023 04:41:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id r145-20020a37a897000000b0073b69922cfesm1639351qke.85.2023.03.03.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:41:05 -0800 (PST)
Message-ID: <d593e9434dba16a869ec48fcdfe8a3fe540c8a82.camel@redhat.com>
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
From: Paolo Abeni <pabeni@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net,  shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org,  pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de,  mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
 <matthieu.baerts@tessares.net>, Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 03 Mar 2023 13:41:00 +0100
In-Reply-To: <ZAHdrhY2P+sBI+xX@kroah.com>
References: <20230301180657.003689969@linuxfoundation.org>
	 <CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com>
	 <ZAB6pP3MNy152f+7@kroah.com>
	 <CA+G9fYsHbQyQFp+vMnmFKDSQxrmj-VKsexWq-aayxgrY+0O7KQ@mail.gmail.com>
	 <CA+G9fYsn+AhWTFA+ZJmfFsM71WGLPOFemZp_vhFMMLUcgcAXKg@mail.gmail.com>
	 <9586d0f99e27483b600d8eb3b5c6635b50905d82.camel@redhat.com>
	 <CA+G9fYuLQEfeTjx52NxbXV5914YJQ2tVd8k4SJjrAryujPjnqA@mail.gmail.com>
	 <ZAG8dla274kYfxoK@kroah.com>
	 <28afc90c1b8b51a36ced5b6026d1a64aeb7c0b14.camel@redhat.com>
	 <ZAHdrhY2P+sBI+xX@kroah.com>
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

On Fri, 2023-03-03 at 12:44 +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 03, 2023 at 12:39:07PM +0100, Paolo Abeni wrote:
> > Additionally, some self-tests check for known bugs/regressions. Running
> > them on older kernel will cause real trouble, and checking for bug
> > presence in the running kernel would be problematic at best, I think.
>=20
> No, not at all, why wouldn't you want to test for know bugs and
> regressions and fail?  That's a great thing to do, and so you will know
> to backport those bugfixes to those older kernels if you have to use
> them.

I'm sorry, I likely was not clear at all. What I mean is that the self-
test for a bug may trigger e.g. memory corruption on the bugged kernel
(or more specifically to networking, the infamous, recurring
"unregister_netdevice: waiting for ...") which in turn could cause
random failures later.

If that specific case runs on older (unpatched) kernel will screw the
overall tests results. The same could happen in less-detectable way for
old bugs non explicitly checked by any test, but still triggered by the
test-suite. As a consequence I expect that the results observed running
newer self-tests on older kernel are unreliable.=20

Cheers,

Paolo

