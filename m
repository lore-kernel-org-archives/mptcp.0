Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7684C79
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680873954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIIxiNsNUL9Ev/E6ipax6p/gxYQ3T4JBH2hUs6E4kqY=;
	b=dwOjmBedJH5aMejlsM2ppt7q5+NrDZ+OowlN6KztXlVNEzszv7jH8MLp+NJFgIcxw39kzG
	x0eVMX3LqbOkiMup3yG6MKC9y7vFgRd0nvhf6fhVqmSf32gwfBwMa5R53dhsIQ7MEGaaDv
	GgN2zhoQMb+AMC6ViMbjMZXTa3VQXH0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-YIt6nwEBNsiy1qmdJUSM5Q-1; Fri, 07 Apr 2023 09:25:45 -0400
X-MC-Unique: YIt6nwEBNsiy1qmdJUSM5Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74610f3f19fso50059385a.0
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 06:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873945; x=1683465945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIIxiNsNUL9Ev/E6ipax6p/gxYQ3T4JBH2hUs6E4kqY=;
        b=YJkmMayEYSz1YbyqvDIZBxPVioSdWxTHxui/UZtsJooXzH9/1oXqcnd8tlRUrK44iJ
         hrq3H3FCP5F4IiNpwTXZd7/mQ/lBOKceT1WNWip2mbyO1S3Vahxx5xxiO0kbrDiO0JQZ
         vmqltGOyXlaI4EOj0BWDLEIn3cPq8OswWEGxzwwmkTDijpxTcdxzxP5JopXQBp4qsoBT
         +GvRbwoIgouE/49/PqV9VOAw/2TsFWLGQ515uNlAa/q+VLHC7mQgqQfSecWhBZKieRg8
         +B+qtHriuzErk3+j1AXkRmLYcvs3X6zSe2+1QDszL22/GZFFEFsjWM1bvQpEF20kRISb
         V2CA==
X-Gm-Message-State: AAQBX9cGvwzAIJf4Pt3FWxf5pslG4eaPuupfK1U7WQ8DfkzSreXSmgdN
	FBEF8hkgX8cGY/KxINYfbC+JtEfKJvWc2yq7ACY0IWktDJhxBTwAHull45qBQalvl2nGxlUG2D6
	cH1bYU2DNIG2+j4geYTeDSsY=
X-Received: by 2002:a05:6214:c2f:b0:5e0:84a9:2927 with SMTP id a15-20020a0562140c2f00b005e084a92927mr4077990qvd.4.1680873945042;
        Fri, 07 Apr 2023 06:25:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350asrNu8OmA98rFZnJVCo9SwSj9y4HcnsyK5y2yjZhziQJ83i0RXLjbDthPDewVOfdzMqGnTig==
X-Received: by 2002:a05:6214:c2f:b0:5e0:84a9:2927 with SMTP id a15-20020a0562140c2f00b005e084a92927mr4077950qvd.4.1680873944707;
        Fri, 07 Apr 2023 06:25:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id g8-20020a0cd7c8000000b005dd8b934571sm1365414qvj.9.2023.04.07.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:25:44 -0700 (PDT)
Message-ID: <1861e413e6befae96bddaa8b7ec25b52b1073c3c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: misc. small cleanups
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Abaci Robot <abaci@linux.alibaba.com>, Mat Martineau
 <martineau@kernel.org>,  Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Date: Fri, 07 Apr 2023 15:25:36 +0200
In-Reply-To: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
References: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
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

On Wed, 2023-03-29 at 15:17 +0200, Matthieu Baerts wrote:
> Here is a series of small unrelated cleanups, nothing very important nor
> big.
>=20
> I don't know if the modification of the MAINTAINERS file should go in
> -net instead.
>=20
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Matthieu Baerts (3):
>       MAINTAINERS: add git trees for MPTCP
>       mptcp: remove unused 'remaining' variable
>       selftests: mptcp: remove duplicated entries in usage
>=20
>  MAINTAINERS                                       | 2 ++
>  net/mptcp/options.c                               | 7 ++-----
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++----
>  3 files changed, 8 insertions(+), 9 deletions(-)
> ---
> base-commit: b2c5489c86ee1881dae3bc431ff6f284eb74f7ef
> change-id: 20230329-mptcp-misc-cleanups-90754eb81610

LGTM, nice cleanups!

For the series:

Acked-by: Paolo Abeni <pabeni@redhat.com>

