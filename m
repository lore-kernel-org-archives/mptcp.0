Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE638BE55
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694427160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuaq79Se97v+aJmzE5zOOTjoP8DucXGlUvDDbDJVMxQ=;
	b=M9s7NXusr3oKy5NLdTVk3Gyq/wqwmpO883WkvMfiGJHt4k8OYtejsq8EfnbshF/b5V2VuW
	vnYP26KTUKUmkSGFXGo86PLiFo12UcNmd0Y+vrf/SquQuGr1F078z6SbN0U5tiFKDhDoy2
	ybHrSGzij0iU61xr1Krvy6bz3eyaLnI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-MVobtxP9OvWsoTPE_mUDbw-1; Mon, 11 Sep 2023 06:12:39 -0400
X-MC-Unique: MVobtxP9OvWsoTPE_mUDbw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9aa1e8d983aso34283466b.0
        for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 03:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694427158; x=1695031958;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuaq79Se97v+aJmzE5zOOTjoP8DucXGlUvDDbDJVMxQ=;
        b=NQJORksINuZ6PktHiNn6cnRysgctViYnObFy7+Hxncd2eoVMlO6Q2TwG/zve0NbdIh
         f6jvclD+HAgjP99pVjSn3FWIB8/WIAkxda+vHG2pVDfKA1BwbrrcCD6W55o2626xiSKc
         nbhtj16qw7LhUg4af96PsP9qRtIpk7g93DKlUaB37wQDLLysYKwGC4hM2HqMCOnfwYrg
         M3q9VhMO5hCf5OaLDWpwGxJObF2N6M1dZM+FwXiYHWQdftHgGPIHJnVQrA0cl3QxuD4F
         X7ExK4JBt1/TIU/mWNGT2I+jCreG4jXm6xjwI4HZ4NdWJTGeUYqLWa93DArgoh47T5zp
         UTGA==
X-Gm-Message-State: AOJu0YyGd46D8q0w6qFj3SysjH3iIi6sRYMmPFXX78XM4gpTxpI5jcgI
	//Se3AZXc9uHIuQFcLf54lwDcOBxNpQNKf133OK4jma4YofDzDaaf6hw6fUFBlcW+0JdBhJsGCF
	NJogpUyk+STnIzptVDDApz2w=
X-Received: by 2002:a17:906:295:b0:9a1:eb67:c0d3 with SMTP id 21-20020a170906029500b009a1eb67c0d3mr7084270ejf.4.1694427158170;
        Mon, 11 Sep 2023 03:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxcZe4gljP2cWArrd5+lDOjWlj4wuO9hPJU/Rkey4DUHDKOQV0BxqQG/xkzfNHKctdT7M6yQ==
X-Received: by 2002:a17:906:295:b0:9a1:eb67:c0d3 with SMTP id 21-20020a170906029500b009a1eb67c0d3mr7084260ejf.4.1694427157828;
        Mon, 11 Sep 2023 03:12:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-166.dyn.eolo.it. [146.241.243.166])
        by smtp.gmail.com with ESMTPSA id ke25-20020a17090798f900b0099cf91fe297sm5159240ejc.13.2023.09.11.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:12:37 -0700 (PDT)
Message-ID: <5734fb79e301d6e91ada91e3b70009f51c0fcce8.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v5 2/2] mptcp: fix dangling connection hang-up
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 11 Sep 2023 12:12:36 +0200
In-Reply-To: <869db5c2-c1e1-46e6-8b97-ce33dfc9f7e1@tessares.net>
References: <cover.1693988314.git.pabeni@redhat.com>
	 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
	 <4f8e9b17-e19a-44a3-adac-38771b5fac51@tessares.net>
	 <982b3b51305db17ed5a8371c7cb3abb41c05ab97.camel@redhat.com>
	 <869db5c2-c1e1-46e6-8b97-ce33dfc9f7e1@tessares.net>
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

On Mon, 2023-09-11 at 10:42 +0200, Matthieu Baerts wrote:
> On 11/09/2023 08:13, Paolo Abeni wrote:
> > Can we keep both tags? I would like to track the dep on bbd49d114d57
> > explicitly.
>=20
> I don't know: if we put multiple "Fixes" tags, how is it interpreted?
> Does it mean: we backport this patch to kernel versions having all (or
> at least?) the commits mentioned in the Fixes tags?
>=20
> As long as it is not confusing for the stable team :)

I also don't know how multiple tags are handled by the stable team. But
I really want=20

bbd49d114d57 ("mptcp: consolidate transition to TCP_CLOSE in
mptcp_do_fastclose()")

being explicitly there in the commit message, otherwise I fear backport
will cause more bugs then the one they are supposed to fix.

Cheers,

Paolo

