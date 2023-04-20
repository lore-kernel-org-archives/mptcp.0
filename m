Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863E8C04
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682008858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuBhdxS9fVYpjOQGIY1wzmGfmFfidO6VAHnRtrtmz7c=;
	b=AEsK/eRyZTZ0IOnIl6mPQDz3P4YvviFD+TtO7CTQgMSAcSWf+8SucmiH/sG0X5Xvl9sEXX
	JLOk/DcoSClLKTn2dsShkJNW/AA31XT6a55FtRSIu9fbR4OIOFWvnuRbYrQob0IBE/NPea
	SSxA3akzv8cHshizTmSPIM0mT+zmWng=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-9h9uggJ4OniPlRI41Rqrrg-1; Thu, 20 Apr 2023 12:40:57 -0400
X-MC-Unique: 9h9uggJ4OniPlRI41Rqrrg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74e23e33f80so11602485a.0
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 09:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682008856; x=1684600856;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YuBhdxS9fVYpjOQGIY1wzmGfmFfidO6VAHnRtrtmz7c=;
        b=TtpLjmD6QoQWODEsDqsirQHKUtzhbLB6VnorekhH5oETcAg7QdG4vEJaqe+dxeKM/k
         gnqGfXGRDqbKlPgv7JT8kxy32HNhB0fdmBe+FuLFno1sek8vuXdqMWY+nmEyWZh0nDWn
         IZpCYzljVuoE4GR7Qeoqh2bRFasn3V22fJAytBItbO6IuenGVKVsVGfdqHbsiXaX9snQ
         O9qaxyGQEeYuswFN4er3jBWiSEmR7Z35DOtPIpJXsyULo4QqmBG5r8pRLVc3SFxMm5Ea
         anJXPjLd7etYjAgimejkNYfPz8xC8HBytoxWReX870APxfvpJy3g97fnXKhvwrRhJJAz
         miZg==
X-Gm-Message-State: AAQBX9fVKj7FTLIqL9l1HOiw9Kn1UMrd+lrF6UWuPTE0F12WWiU4FX+E
	UiAkfbObFGn7OrSTWY9VbXWGtv4xpxDrYQHYiLLEqgegCHmPPiXhsscqUhGz9wPCct/2LwB7alW
	xW9ZyW/S1RudIdohhegeQJtM=
X-Received: by 2002:a05:6214:529e:b0:5f7:d2da:c69e with SMTP id kj30-20020a056214529e00b005f7d2dac69emr2753917qvb.4.1682008856509;
        Thu, 20 Apr 2023 09:40:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350a6NpLnTfM2BdwDMfZLW6DLaH4OWRj+1PEIVM9xfE0I8+TSrGuxhzFIpJ6NIl86vNkrfafarw==
X-Received: by 2002:a05:6214:529e:b0:5f7:d2da:c69e with SMTP id kj30-20020a056214529e00b005f7d2dac69emr2753878qvb.4.1682008856151;
        Thu, 20 Apr 2023 09:40:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-117.dyn.eolo.it. [146.241.230.117])
        by smtp.gmail.com with ESMTPSA id a4-20020a0ce384000000b005ef658e65b8sm492949qvl.121.2023.04.20.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:40:55 -0700 (PDT)
Message-ID: <f63b8cadb98db9fe7eee556207082f6c607874a5.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/2] Squash to "security: SELinux/LSM label
 with MPTCP and accept "
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 20 Apr 2023 18:40:53 +0200
In-Reply-To: <20230420161957.664328-1-matthieu.baerts@tessares.net>
References: <20230420161957.664328-1-matthieu.baerts@tessares.net>
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

On Thu, 2023-04-20 at 18:19 +0200, Matthieu Baerts wrote:
> These two patches address the comments from Paul Moore on the series I
> sent yesterday containing Paolo's patches.
>=20
> Note that I used 'MPTCP socket' instead of 'main MPTCP socket' as
> suggested: there is only one MPTCP socket owning subflows (TCP) sockets,
> no main MPTCP ones.
>=20
> These patches will likely be applied on lsm/next after the next merge
> window:
>=20
>   As far as potential merge issues with netdev/net-next and lsm/next, I
>   think we'll be okay.  I have a general policy[1] of not accepting new
>   patchsets, unless critical bugfixes, past rc5/rc6 so this would be
>   merged into lsm/next *after* the current merge window closes and
>   presumably after the netdev/net-next branch finds its way into Linus'
>   tree.
>=20
> Link: https://lore.kernel.org/mptcp/20230419-upstream-lsm-next-20230419-m=
ptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net/
>=20
> Matthieu Baerts (2):
>   Squash to "security, lsm: Introduce security_mptcp_add_subflow()"
>   Squash to "selinux: Implement mptcp_add_subflow hook"
>=20
>  .topmsg                  | 15 +++++++++++----
>  security/security.c      |  4 +++-
>  .topmsg                  | 13 +++++++++----
>  security/selinux/hooks.c |  2 +-
>  4 files changed, 24 insertions(+), 10 deletions(-)
>=20

LGTM, thanks Matttbe!!!

/P

p.s. no formal tags, it would feel strange acking patches I co-devel.
Feel free to add your co-devel tag instead.

