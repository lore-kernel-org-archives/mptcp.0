Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82C2F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644505700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILoEvL2fZmxE6OcW5aDtfzpFHEdaeSt/nwvvNpEMAyY=;
	b=VjB7dM6kgdh4JNDED1D0GlA7S7LlAvAdqj5pxjXAaNlQwb9DYqGHhFQHICtHkb8cO7kOzJ
	9YOfqXIoAUM1D+x/a5jaeBSwGbsEfiz+vT6G2QDvW9xQjDDUVfnSpR/k/C+kKrrGQ1LIv9
	tfr5fx0Zko3cigoAvedRZPGuOrHqSpk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-RvBBhebJOiy4Onmzd0KzOQ-1; Thu, 10 Feb 2022 10:08:19 -0500
X-MC-Unique: RvBBhebJOiy4Onmzd0KzOQ-1
Received: by mail-wr1-f72.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso2625797wrv.17
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 07:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ILoEvL2fZmxE6OcW5aDtfzpFHEdaeSt/nwvvNpEMAyY=;
        b=CNT7Tsngg7Ok396BbTosX87ah/YsWQbQVvGHVG3Z5Ju2s7xsp038ZTRl3IN70YF+Q3
         CkjI2AiGSwIB25TBSW/kVq4QNFCut2rUybhpid6fXh0e+x4nkYqF6VeWJZArqAObztHv
         Y6PKgvsRVPY8w4jt1aReVHXu02I3/ilrXMrfoErLU+o7xwCBm3fAQvWkVsksXQ1Dpm0w
         /+ywbUjXxGBkqrbO4Duom27yracr4MXIA/pU6Iq7LZ7zeCBwaGrV1dm+cX8vqfze033m
         /jjyh9zEBz0loj5SW01Q0ep5hWEenQSCcmEJYlTwzT29sj6VOn9FXKEU3KRoxdwf4LSy
         wL+Q==
X-Gm-Message-State: AOAM533HXeelO9wIyYkMKVDVt9U56YqDTEn1/6l9Pb3YZp35snmI+PHj
	CyTCoFyA8Ff14sCvpVJniYOccLlB0En1S4LDFH88nKuD4QW40gc4s3WkZEc6teh+vLX/Yq3EDrj
	dAuPJvM4kw+Vxub4=
X-Received: by 2002:a5d:6443:: with SMTP id d3mr6418173wrw.33.1644505697874;
        Thu, 10 Feb 2022 07:08:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbO3GrrlipGX64bai+BBSQwfWTADfeI0PUXAsiwtpBrbQccjEb3xVL9Xg0MC+AHvYyPYXeiA==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr6418158wrw.33.1644505697631;
        Thu, 10 Feb 2022 07:08:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id o14sm973940wms.4.2022.02.10.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 07:08:17 -0800 (PST)
Message-ID: <2747570e9a46ee5b3d18ed9f44e73e4043be333d.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: strict local address ID selection.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 10 Feb 2022 16:08:16 +0100
In-Reply-To: <60ef8629-d9d4-3bc2-00cb-d8c286d934aa@tessares.net>
References: <75e02d63aa8b03b873ad94f5b4d901776f9a81ea.1644487551.git.pabeni@redhat.com>
	 <47e854cf68fdc2a1e0b2c9e79813d4212393faac.camel@redhat.com>
	 <60ef8629-d9d4-3bc2-00cb-d8c286d934aa@tessares.net>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2022-02-10 at 13:03 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 10/02/2022 11:36, Paolo Abeni wrote:
> > On Thu, 2022-02-10 at 11:07 +0100, Paolo Abeni wrote:
> > > The address ID selection for MPJ subflows created in response
> > > to incoming ADD_ADDR option is currently unreliable: it happens
> > > at MPJ socket creation time, when the local address could be
> > > unknown.
> > > 
> > > Additionally, if the no local endpoint is available for the local
> > > address, a new dummy endpoint is created, confusing the user-land.
> > > 
> > > This change refactor the code to move the address ID seleciton inside
> > > the rebuild_header() helper, when the local address eventually
> > > selected by the route lookup is finally known. If the address used
> > > is not mapped by any endpoint - and thus can't be advertised/removed
> > > pick the id 0 instead of allocate a new endpoint.
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > Note: send v2 to address the build issue, to help the discussion
> > 
> > It looks like I was too hasty and this is badly broken. Please ignore,
> > I'll try to cook something better later.
> 
> Funny, the CI doesn't agree with you :)

Well, sometimes I don't agree even with myself ;)

The root cause of the breakage I mentioned above is actually pebkac: I
was testing an older kernel :(((

It looks like the self-tests are happy even here - when checking the
correct kernel - so in the end this patch should be valid - execept for
the intentional RFC breakage.

/P

