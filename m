Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2B538C
	for <mptcp@lists.linux.dev>; Fri,  3 Mar 2023 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677843552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1Ct/6nINkmWZSFMigoxMFMstImpmSCqjjI/pBizmA0=;
	b=P3RPHmBo29nab9gHqtm2cDxxNLRU7p+Sh6mOCqKoBm2rrDsxTP8dsPE9LW5gLMkr9PiTKs
	GiGIB6DefHI8co6RV+sboZkGTiCIi00SYEbcXNItS8cmv++CZozaXwds1ov417l5AhtbrJ
	bvSjgJqE8R1gSN4kmj8+5K6L1AF+jqA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-vdfs5lhXODi-LB1AHLHY2g-1; Fri, 03 Mar 2023 06:39:11 -0500
X-MC-Unique: vdfs5lhXODi-LB1AHLHY2g-1
Received: by mail-wm1-f69.google.com with SMTP id n15-20020a05600c500f00b003dd07ce79c8so891089wmr.1
        for <mptcp@lists.linux.dev>; Fri, 03 Mar 2023 03:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1Ct/6nINkmWZSFMigoxMFMstImpmSCqjjI/pBizmA0=;
        b=IEcMakJjzuNN0m1Fxm/DmnMEdtKJnTYNGxw42RPmO6TlOM94catwlz9b8XKUEbtvQv
         Fp+M2mrmgxGRUMZws5mS/sP+6VFIJ4l4+/nLL7x8Jq0ZGHQZTSnqANX8ckJGQe7Mc6LS
         Ro0uos/j5cWVpUvH1ot1sm6XbPSJpOS42gY+r1oG2IMnyhbr/sVZYNXiBT1JvMx6ti3e
         W4Dx7eej0vStDgxpQMN6DAmKiANQRpTiBycvWCQrtsCvancPen/FmOg8ruh4/Dbtb2M3
         cNEN6jDz3M9jZGG8fUp4ez5LbIJYZ52pGW+AzHih983ETfheGRrUW0FOuhTDImu0oVI6
         TWuw==
X-Gm-Message-State: AO0yUKUcGniuczjY7LlkCF5g84FXjJp4RFSAv5K0wEAoO2Q9FYoD9b7O
	/W4oxsaHIVroB2WBE8LbHWL0CLK6AnEMq/9R6Ek3VxORz0TlT5x93pk9JO8KaU4FhApVuYeLPZg
	hx1liw//TtJB7a8k=
X-Received: by 2002:a05:600c:3b07:b0:3eb:2e2a:be82 with SMTP id m7-20020a05600c3b0700b003eb2e2abe82mr1246733wms.2.1677843550671;
        Fri, 03 Mar 2023 03:39:10 -0800 (PST)
X-Google-Smtp-Source: AK7set9mwcWeiYEjlmyu4x2ILE7IqBBjOngusHgtCAMB0AGXHzaXoDMdecgdiEJ4F2mFuYU5V0UiRg==
X-Received: by 2002:a05:600c:3b07:b0:3eb:2e2a:be82 with SMTP id m7-20020a05600c3b0700b003eb2e2abe82mr1246704wms.2.1677843550405;
        Fri, 03 Mar 2023 03:39:10 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id s8-20020a7bc388000000b003eb2e685c7dsm5725689wmj.9.2023.03.03.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:39:09 -0800 (PST)
Message-ID: <28afc90c1b8b51a36ced5b6026d1a64aeb7c0b14.camel@redhat.com>
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
From: Paolo Abeni <pabeni@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naresh Kamboju
	 <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
 srw@sladewatkins.net, rwarsow@gmx.de, mptcp@lists.linux.dev, Florian
 Westphal <fw@strlen.de>, Mat Martineau
 <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
 <matthieu.baerts@tessares.net>, Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 03 Mar 2023 12:39:07 +0100
In-Reply-To: <ZAG8dla274kYfxoK@kroah.com>
References: <20230301180657.003689969@linuxfoundation.org>
	 <CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com>
	 <ZAB6pP3MNy152f+7@kroah.com>
	 <CA+G9fYsHbQyQFp+vMnmFKDSQxrmj-VKsexWq-aayxgrY+0O7KQ@mail.gmail.com>
	 <CA+G9fYsn+AhWTFA+ZJmfFsM71WGLPOFemZp_vhFMMLUcgcAXKg@mail.gmail.com>
	 <9586d0f99e27483b600d8eb3b5c6635b50905d82.camel@redhat.com>
	 <CA+G9fYuLQEfeTjx52NxbXV5914YJQ2tVd8k4SJjrAryujPjnqA@mail.gmail.com>
	 <ZAG8dla274kYfxoK@kroah.com>
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

On Fri, 2023-03-03 at 10:23 +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 03, 2023 at 02:34:05PM +0530, Naresh Kamboju wrote:
> > On Fri, 3 Mar 2023 at 13:34, Paolo Abeni <pabeni@redhat.com> wrote:
> > > I read the above as you are running self-tests from 6.2.1 on top of a=
n
> > > older (6.1) kernel. Is that correct?
> >=20
> > correct.
> >=20
> > > If so failures are expected;
>=20
> Shouldn't the test be able to know that "new features" are not present
> and properly skip the test for when that happens? =C2=A0

I was not aware that running self-tests on older kernels is a common
practice. I'm surprised that hits mptcp specifically. I think most
networking tests have the same problem.

Additionally, some self-tests check for known bugs/regressions. Running
them on older kernel will cause real trouble, and checking for bug
presence in the running kernel would be problematic at best, I think.

> Otherwise this feels
> like a problem going forward as no one will know if this feature can be
> used or not (assuming it is a new feature and not just a functional
> change.)

I don't understand this later part, could you please re-phrase?

Users should look at release notes and/or official documentation to
know the supported features, not to self-tests output ?!?

Thanks!

Paolo

p.s. for some reasons I did not receive the previous replies, I had to
fetch the conversation from the ML archives.

