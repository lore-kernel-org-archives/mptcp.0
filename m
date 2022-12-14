Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30379BA24
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671056037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aW8p5rry295NkbefzP1yJqPHwKJ4e7g3eAuxYhpUnzE=;
	b=SRvPKGVqdqkcbO6n8EQKvyeCEEenHQCXfg9rUDyQMUPFiWIp8qK6HVM6q+UEPLFdduuTb2
	Adrf/mb3RtkZbbTshhrR9QqdEl+E1/EvxlkVUvMYQJ8Vzubqw1SjIpbx3AdUCAzl3IPFvp
	iwnMWDEWV+G2e6DuOEJS16KRLr8yWAQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-sxot61P7Ox-_xXRcDKae6Q-1; Wed, 14 Dec 2022 17:13:55 -0500
X-MC-Unique: sxot61P7Ox-_xXRcDKae6Q-1
Received: by mail-wm1-f69.google.com with SMTP id i132-20020a1c3b8a000000b003d0f49bc21bso239975wma.6
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 14:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW8p5rry295NkbefzP1yJqPHwKJ4e7g3eAuxYhpUnzE=;
        b=Gil6S8E81avluXsD6zRIHXOOIquOqRSqH4RhvXP+XVHsKoOLxDrJFLG0bwx1lUVzNs
         Prgx0F7I9qflJ89O9C28/3+DMfGWf+1QVvroWwEWYoypCUzOi2NMQHzpHb1znphaEoPu
         Xcw1+ZDEmR1d+hPBELEr0T4mmkgU7+aRkKlWh8/FY2liWldc/cMbQVfr3DB+MUGM6QVj
         3ynQK0qBV7Ws75Kk4QsNq4fUOU9rGGiesi4Xr9Z5P2JQ2siP1BVYtNj7eQocnLkgl604
         XGGASd8RfQ6x5GTFP1zdQbKu8t04/NABxsa+1ZsZIUt9ZG54/2AZT8FPWPnxeVXewdwy
         2C4g==
X-Gm-Message-State: ANoB5pkun6RtdGEClrT72BA94uixoP07dEX26n9c2JPNo38DyDyxzBEO
	wi6Qe/j1T2GXA/+Kwe1wk5l+5kJliCcYHnBMvJKl7DHbeGa9vob9SwKqjPXqH1Lfza1wTB1gR/g
	iNGtxOCeRKPwNdyA=
X-Received: by 2002:a05:600c:5386:b0:3cf:8155:2adc with SMTP id hg6-20020a05600c538600b003cf81552adcmr19884828wmb.33.1671056034276;
        Wed, 14 Dec 2022 14:13:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf68HKsZKNnRWxk2Lze71V2S9dTijIVMH9f0Wt6PD1jdQF6OZ5wOAj/Q1v+j8/lMDCgXi1f6KA==
X-Received: by 2002:a05:600c:5386:b0:3cf:8155:2adc with SMTP id hg6-20020a05600c538600b003cf81552adcmr19884817wmb.33.1671056034014;
        Wed, 14 Dec 2022 14:13:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c430b00b003c6b70a4d69sm3502193wme.42.2022.12.14.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:13:53 -0800 (PST)
Message-ID: <401591eef86a3c47065e9873d3f25ff978f0a51d.camel@redhat.com>
Subject: Re: [PATCH 0/2] lsm: introduce and use security_mptcp_add_subflow()
From: Paolo Abeni <pabeni@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	mptcp@lists.linux.dev
Date: Wed, 14 Dec 2022 23:13:52 +0100
In-Reply-To: <cover.1671054577.git.pabeni@redhat.com>
References: <cover.1671054577.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-12-14 at 23:01 +0100, Paolo Abeni wrote:
> This series is an attempt to solve the LSM labeling breakage
> reported here:
> 
> https://lore.kernel.org/linux-security-module/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/
> 
> As per previous discussion, a new LSM hook is introduced and
> invoked by the mptcp code to let LSMs set the appropriate label
> for the newly created subflow.
> 
> I'm not sure the chosen hook name is a perfect fit, any suggestion
> more then welcome.
> The new hook requires both the mptcp socket reference and the
> subflow socket reference, even if the provided LSM implementation
> for selinux ends-up accessing only the subflow socket. Possibly
> other LSM implementation could need or use the addtional parameter.

I forgot to mention this has been tested vs the reproducer described in
the above link and vs the mptcp self-tests.

Cheers,

Paolo

