Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5D7485
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 07:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689321378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slaUONSg+DlN+ayFEMZVhhuszbKRkMcTnza/85oVWyg=;
	b=WBs6qx85ahHKmsxnC3alSbADwXPi0lbe7cSu8ObMWPPT3h/FyL4sj4x5GYWO5ntWk5Vorr
	HIcByamVfLUzjUpiGODGxR3Gk0YUdGtyDL0o2xrXWp7WG/8vOFXQPSAnp0ZZTmrmajp4yt
	g6O0OUiEkitEFCBgig+IuBDrXRHbpe8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-VwUffRX_OSidxPuAWho1lw-1; Fri, 14 Jul 2023 03:56:11 -0400
X-MC-Unique: VwUffRX_OSidxPuAWho1lw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767d30ab094so41046185a.1
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 00:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321371; x=1691913371;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slaUONSg+DlN+ayFEMZVhhuszbKRkMcTnza/85oVWyg=;
        b=jwbx7AgvYWXY0a7kUIuuSqUxLmiDsgTHurc1qYSo96NNSKK0dm41VwjdG+AaRs2K8C
         GCaJn5I0sGrYP/dFvYA7Gsy2uw0n2dGPkAaCIp+F02PXaxWSjVhD0/5oN0Ubgx+J6Oxp
         hnSPVzeXh+1K7a/blRm9VifevTwzq6QxKwQFuv/5c75f3FJsOaTcPLj8kkpAx+qXp9CG
         jouUiNIYsYSxGYBEslTozl4VJ9nsmIY+mx/8guyolbhE7XbiSMWrcjTqTDRyt605/aOm
         qcgPdLRoL04cvBbywy0ly2QwFrG9JsVhhgKpAJe0a1SBc2B60yQL83G/3urgv5cfiOTv
         8FdA==
X-Gm-Message-State: ABy/qLYcVcmTPi5eoxB6RS/m3vl2Gi6wZnKVGKSaLC9Z9T9doV9UMY3O
	jxqO+j4fLhLM+UfXsg8+tdqHObW9W3TqtqlFttzXTPTWK7D5ceYIzj+3sbR5eFCOvy41sDv5CoT
	uAW6uW26yyfLnToQ=
X-Received: by 2002:a05:620a:46aa:b0:766:3190:8052 with SMTP id bq42-20020a05620a46aa00b0076631908052mr4599750qkb.0.1689321371426;
        Fri, 14 Jul 2023 00:56:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXapRXHsT2nSqUsEGRif2238r11GXN5y/Ez68arHueu7sEEY6KOYZwO2c1VhLcxcmaQwriGQ==
X-Received: by 2002:a05:620a:46aa:b0:766:3190:8052 with SMTP id bq42-20020a05620a46aa00b0076631908052mr4599732qkb.0.1689321371094;
        Fri, 14 Jul 2023 00:56:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id q26-20020a05620a039a00b00767b7375eadsm3582939qkm.39.2023.07.14.00.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:56:10 -0700 (PDT)
Message-ID: <22c30f70a632afb65b6cb2a7554e919673d48871.camel@redhat.com>
Subject: Re: [RFC bpf-next 0/8] BPF 'force to MPTCP'
From: Paolo Abeni <pabeni@redhat.com>
To: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,  Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, netdev@vger.kernel.org
Date: Fri, 14 Jul 2023 09:56:06 +0200
In-Reply-To: <ZLCELtTGksxGwaFZ@google.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
	 <ZKbzs7foUw+eeNnn@google.com>
	 <20230713054716.GA18806@localhost.localdomain>
	 <ZLAxAc1/UXcbIJBo@google.com>
	 <CAADnVQ+aPyWea4QUD9TFNpr43u052zuqOXzGaqmM8-EeMrW6rg@mail.gmail.com>
	 <ZLCELtTGksxGwaFZ@google.com>
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

On Thu, 2023-07-13 at 16:09 -0700, Stanislav Fomichev wrote:
> On 07/13, Alexei Starovoitov wrote:
> > imo all 3 options including this 4th one are too hacky.
> > I understand ld_preload limitations and desire to have it per-cgroup,
> > but messing this much with user space feels a little bit too much.
> > What side effects will it cause?
>=20
> Maybe all that is really needed is some new per-netns sysctl to automatic=
ally
> upgrade from IPPROTO_TCP to IPPROTO_MPTCP? Or is it too broad of a
> brush?

I think it would be actually too broad, see below...

> I've also CC'd netdev for visibility...
>=20
> > Meaning is this enough to just change the proto?
> > Nothing in user space later on needs to be aware the protocol is so dif=
ferent?
>=20
> IIUC, if you use IPPROTO_MPTCP, you just get regular TCP until you start
> adding extra routes (via netlink). That's why their current
> unconditional IPPROTO_TCP->IPPROTO_MPTCP rewrite via ld_preload also some=
what
> works.

FTR, it the other way around: when using IPPROTO_MPTCP you always get
MPTCP protocol handshake that downgrade gracefully to TCP if the peer
does not support it. Then multiple paths can be added/enabled by
different means, but that is another matter - a quite orthogonal one.

The transition to TCP in currently not completely for free: active
(client) MPTCP sockets fallen-back to TCP will keep some overhead vs
plain TCP ones.

Being able to control the IPPROTO_TCP->IPPROTO_MPTCP change on per
socket basis do offer some advantages e.g. constraining the change to
the sockets that are likely to complete successfully the MPTCP
handshake.=20

> > I feel the consequences are too drastic to support such thing
> > through an official/stable hook.
> > We can consider an fmod_ret unstable hook somewhere in the kernel
> > that bpf prog can attach to and tweak the ret value and/or args,
> > but the production environment won't be using it.
> > It will be a temporary gap until user space is properly converted to mp=
tcp.
>=20
> Asking every app to do s/IPPROTO_TCP/IPPROTO_MPTCP/ might be annoying
> though? (don't have a horse in this race, but have some v4->v6 migration
> vibes from this)

I can do only wild guesses, but I also expect such "transition" to be
extremely long and/or incomplete.

Cheers,

Paolo

