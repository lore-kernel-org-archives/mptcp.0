Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1F7F
	for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692711253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS70hKpJZGSclS2yOgZbY95EjmQo1CeuR3/f9L+TiR0=;
	b=WWHKPv3ClCcIjiWHuJbd0VjX4gpL3/d2Aj1HbQzAPbzM5pl6aCHsGxrDfiaNQm2Ynj9L4b
	8XtopKI9EN8e3Vd3gxck/3hDpk93NxQRY6uY3vY9qF0J6H6TiU2gbmQBRzjT1wUBJsKR9d
	v/IezUwHUqB3wP0F4TDmWeHo+07zk3U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-0Llu0OSkMXKL-lHaF3nugg-1; Tue, 22 Aug 2023 09:34:11 -0400
X-MC-Unique: 0Llu0OSkMXKL-lHaF3nugg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe1f278abcso511633e87.0
        for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 06:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692711250; x=1693316050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pS70hKpJZGSclS2yOgZbY95EjmQo1CeuR3/f9L+TiR0=;
        b=cA6YVsrLI9yXT+21tfUgeWy2zEJJGPAN685sQZuKp2zetuzTQxy6HB2Zo4Nxh7mrS3
         bw7CWN/hOTRW7tazeO4FdPK/ATa1xQb1KmefIYhdFutjC1Rrnt6qVK4LYzAjjG0tv8iJ
         NCv25i0+1X5Do6MapF0FleAZK6NtN4t83fiQgCC+nmmdfdrsKpjsiHyPpprPvakRxKPz
         YucRY94tbx/zBqgXNycKxdjHp9XDIMKaUUykgj35aVJVvRrNJUJ4QeVxBTdSp/UKJeDf
         UNlhFYnkjeQxwTSGyTfwwzZYqRiVzRs3qz+9HCayHpAhXKFm4kBvF0HdQbS9xFluSyds
         XPqQ==
X-Gm-Message-State: AOJu0YzmuPXdTJdX94KAph3isTR4cYBUDg+4JdtTUg5oN5xA92iSZkKZ
	trSOZLG55EVwqSoVuQrKl0OYlFN1ACETAozdHIZLie/fLu1MVze0TKi3a0NNWINasbi6+neTAyO
	N6WTzjKj0hDvc4bFSADCEnRw=
X-Received: by 2002:ac2:59c6:0:b0:500:7c56:ff5 with SMTP id x6-20020ac259c6000000b005007c560ff5mr4241521lfn.0.1692711249962;
        Tue, 22 Aug 2023 06:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlRxK8Vpn/EbmLMt8W7VPFSv++E9jkH02WZ3otMf3RK97XMOnG2pjpxY/y0ustQgMIi7RZ7w==
X-Received: by 2002:ac2:59c6:0:b0:500:7c56:ff5 with SMTP id x6-20020ac259c6000000b005007c560ff5mr4241505lfn.0.1692711249586;
        Tue, 22 Aug 2023 06:34:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id k11-20020a05640212cb00b005233f2635fbsm7591268edx.21.2023.08.22.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:34:09 -0700 (PDT)
Message-ID: <16df353824fe30bf32bd8fe8173e587919a35b35.camel@redhat.com>
Subject: Re: [PATCH mptcp-iproute 0/3] ss: mptcp: print new info counters
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 22 Aug 2023 15:34:08 +0200
In-Reply-To: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
References: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
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

On Mon, 2023-08-21 at 17:27 +0200, Matthieu Baerts wrote:
> Some MPTCP counters from mptcp_info structure have been added in the
> kernel but not in ss.
>=20
> Before adding the new counters in patch 3/3, patch 1/3 makes sure all
> unsigned counters are displayed as unsigned. Patch 2/3 displays all seq
> related counters as decimal instead of hexadecimal.
>=20
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Matthieu Baerts (3):
>       ss: mptcp: display info counters as unsigned
>       ss: mptcp: display seq related counters as decimal
>       ss: mptcp: print missing info counters
>=20
>  misc/ss.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> ---
> base-commit: 872148f54e35cb13aa6c9e48e52306cd469aaa53
> change-id: 20230817-mptcp-issue-415-ss-mptcp-info-6-5-9d6fa5121fb0
>=20
> Best regards,

FWIS, LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

p.s. I actually have a local version of patch 3/3 that I forgot to
upstream... ;)=20

