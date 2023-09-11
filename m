Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AD23CE
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 06:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694412824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GVeRtJytrM8IXsvkIoHn/WlK0VorwM3OpJUeCX6AIs=;
	b=IF6bR8p9XekLH7dMGo2WQcZLReS6iZZNDU5laICizU6G5fPTvytcXUJ3yUF+w31Bx7rMVw
	tHVXfsmOwBZttHLltr36oNZrPmvUSInkC4k7ZiWNwe5DQNxKYhVAqFyRz27SS5JgZEUuNX
	lBw/WLU+U6ya/yTvz5LB0Mrt+pCKPag=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223--s6ym4jxO-qaPOcfiBY29A-1; Mon, 11 Sep 2023 02:13:43 -0400
X-MC-Unique: -s6ym4jxO-qaPOcfiBY29A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1be1e2b63so38063466b.0
        for <mptcp@lists.linux.dev>; Sun, 10 Sep 2023 23:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694412822; x=1695017622;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GVeRtJytrM8IXsvkIoHn/WlK0VorwM3OpJUeCX6AIs=;
        b=UEMRW+gwjVmbsA7Gg50DP9Y+ji0pkGGQ4wgMOmgsLvcVYKQXvPDK8bYX7iFAVaoFvG
         zw0ENNrWdetkWDFlheuIgLFonksAj22Pac0yK6T3TgPKsxIKGxs3KoM490pLmUnKvtqI
         pbALnRl+y3WeZZ4BS/ZYn7JQObxik3kImhwdxb0dAK1+K2hqAbVm0Ll4szStBEg17luH
         gdrFNk4so0iV7NCgzT3Y+rlIqw7fdp/sHNHGCbR3TKqC4DM/A0CmUReOfTNKMhFTv+q+
         8n1UPTV9w1fT9mVgfHRH5Vu7bY6R52K+n3DE9dlTe1iMoDG5fcrF6i1qxZotpznYKBP5
         C1ww==
X-Gm-Message-State: AOJu0YxBDmxom9s0cSQNYAb94QpteuvljGjsMjUmvGyp0FfpP/aNbbTq
	ZgpKjG2XUVtGl4rvfj1/fuoIH8xDIbY5MlaV3bOkAzA+mJKSerlpcl217Uv+FJZobduwUZADUn7
	prndLI2qiEeHjwMhLcqNHjTw=
X-Received: by 2002:a17:906:2088:b0:9a5:ce62:6e1a with SMTP id 8-20020a170906208800b009a5ce626e1amr6940068ejq.1.1694412822076;
        Sun, 10 Sep 2023 23:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe3LxcYRU5mvbJFlduStFIvjhDkjOgzWYKBL+m+jkj3vOCEgqGFDJAD+6CUWbFcuh2s1vmbg==
X-Received: by 2002:a17:906:2088:b0:9a5:ce62:6e1a with SMTP id 8-20020a170906208800b009a5ce626e1amr6940060ejq.1.1694412821739;
        Sun, 10 Sep 2023 23:13:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-166.dyn.eolo.it. [146.241.243.166])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709064a1400b00991faf3810esm4861541eju.146.2023.09.10.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 23:13:41 -0700 (PDT)
Message-ID: <982b3b51305db17ed5a8371c7cb3abb41c05ab97.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v5 2/2] mptcp: fix dangling connection hang-up
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 11 Sep 2023 08:13:40 +0200
In-Reply-To: <4f8e9b17-e19a-44a3-adac-38771b5fac51@tessares.net>
References: <cover.1693988314.git.pabeni@redhat.com>
	 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
	 <4f8e9b17-e19a-44a3-adac-38771b5fac51@tessares.net>
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

On Sat, 2023-09-09 at 17:50 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 06/09/2023 10:30, Paolo Abeni wrote:
> > According to RFC 8684 section 3.3:
> >=20
> >   A connection is not closed unless [...] or an implementation-specific
> >   connection-level send timeout.
> >=20
> > Currently the MPTCP protocol does not implement such timeout, and
> > connection timing-out at the TCP-level never move to close state.
> >=20
> > Introduces a catch-up condition at subflow close time to move the
> > MPTCP socket to close, too.
> >=20
> > That additionally allow removing similar existing inside the worker.
> >=20
> > Finally, allow some additional timeout for plain ESTABLISHED mptcp
> > sockets, as the protocol allows creating new subflows even at that
> > point and making the connection functional again.
> >=20
> > The issues is actually present since the beginning, but it basically
> > impossible to solve without a long chain of functional pre-requisites
> > topped by the blamed commit below.
>=20
> Would it not be better to put another "Fixes" tag and mention that
> bbd49d114d57 is required for the backports?
>=20
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
> > Fixes: bbd49d114d57 ("mptcp: consolidate transition to TCP_CLOSE in mpt=
cp_do_fastclose()")
>=20
> My fear is that this patch will not be automatically selected to be
> backported below 6.5.
>=20
> Instead, I suggest to use:
>=20
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
>=20
> The issue was certainly there before but hard to backport without that
> one anyway.

Can we keep both tags? I would like to track the dep on bbd49d114d57
explicitly.

Cheers,

Paolo

