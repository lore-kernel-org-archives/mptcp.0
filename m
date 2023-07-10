Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964D13AC3
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689007918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q505X3ztpT6pKXaZLfv14lLYsEyYXWpUNED5Q9ukcyk=;
	b=D+djafRAUCfyTgqXYXbP181QSRIVbJ6dBOWzAZ12sPT210pNMSr92nQ9bcFtFFriNq7tml
	Q/A6zaI+Q+DmuNdY8Tv7LJq2XmuKcQ7iEqPPW44zFBoc7IO1p1CB2S8LuZZvPlMU6ACsRq
	1PuEBNFXksLL5rZFccfTM9V2oowhS8o=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-jBEE09cGPxeSsFaQ2-dBJQ-1; Mon, 10 Jul 2023 12:51:57 -0400
X-MC-Unique: jBEE09cGPxeSsFaQ2-dBJQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-47e27f0e91eso150775e0c.1
        for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 09:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689007916; x=1691599916;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q505X3ztpT6pKXaZLfv14lLYsEyYXWpUNED5Q9ukcyk=;
        b=KKWueKrcGtdD+/L/ugFjG1Yrq3K9+WxzpTLHNPtJ4d2uE9VVbLBEgHgjj/aIiieEgq
         2iQ8dJ2CCbFs+udNGkARSge6mCeK3uoqa63UE0lTNxN1hP7uWM7aHfpaWFSrcx+IKyGB
         kqx8fEkuimHIUzvVaifnz/G99y2DKhO5VoQcw8rZQMXWUIMRacEscWJxDUTr0y0BbeE8
         okcCKOWIrqZMdD2PEeWUdLBu6lb6iTZNqnX9z82h4oYrcJGu0GgT53G88cWr3S5S8umz
         GiyCij8FLpbBDHNogZhhmg+rx0EsnenrSyojJlM4v+RG0JZzUw+wiiCFaLr8QWKiApRq
         gHtA==
X-Gm-Message-State: ABy/qLaGyzgHPuyHTaQUrDhpkjh4Z5S7gjXgtP+AbAhkgsKC4oqlpDgs
	HXfQWmt81su8cwV/F+7yhje/CwW+RbT1Pk4XrYa8xnw7U44D97xbBKsXzm4qrCoVsU/EpKkAky7
	zpvZGCNe3G3o3j+aEDlFNLhI=
X-Received: by 2002:a05:6102:1590:b0:443:94f2:234f with SMTP id g16-20020a056102159000b0044394f2234fmr5267135vsv.1.1689007916327;
        Mon, 10 Jul 2023 09:51:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE6ODjbghm69LqOALkujjXQoQxSKjMLMwt2KEMt08V7pEtVt8A+KVtqPq9BPGHy/SRVG+rMzA==
X-Received: by 2002:a05:6102:1590:b0:443:94f2:234f with SMTP id g16-20020a056102159000b0044394f2234fmr5267124vsv.1.1689007916031;
        Mon, 10 Jul 2023 09:51:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a0c9d0c000000b00635ef3a34ebsm21253qvf.48.2023.07.10.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:51:55 -0700 (PDT)
Message-ID: <9de27c12da208e32efc43e2b36840d941cd1575f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/6] mptcp: sockopt: uniform code to get/set
 values
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 10 Jul 2023 18:51:53 +0200
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
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

On Fri, 2023-07-07 at 18:00 +0200, Matthieu Baerts wrote:
> Here is the implementation of an idea I suggested a few months ago: it
> is a factoring of the sockopt code trying to uniform it, mainly to rely
> on {ip,ipv6,tcp}_[gs]etsockopt() instead of copying what is done there
> to get and set values.
>=20
> That's a first step. More might come if we are OK with the approach,
> e.g.
>=20
> - For SOL_TCP socket options we cannot store info in the MPTCP socket so
>   we still need to "manually" store it somewhere in the msk. Maybe we
>   could store info in the different subflows (and create a first one if
>   there is no subflow) and retrieve info from there?
>=20
> - For SOL_SOCKET socket options, it looks like it should be feasible to
>   do something similar to what I did here but I'm probably missing
>   something. This could clean quite a lot of code, e.g. the last commit
>   from:
>=20
>     https://github.com/matttbe/mptcp_net-next/commits/b4/mptcp-unify-sock=
opt-issue-353
>=20
> - To sync the socket options when a new subflow has been created, for
>   the moment, we copy info from the msk to the subflow but maybe it
>    would be fine to call some getsockopt() / setsockopt() to do the
>   sync? If we take this approach, we might want to save a list of
>   setsockopt() that have been done in the past on this socket and only
>   re-do these ones? That should help with the maintenance of these
>   socket options and ease the support of new ones.

I would highly discourage this latest approach. We will have to limit
the list length, breaking the sync at some point. And there are few
quite gray area, e.g. how errors should be handled? I also fear the
"final" state of the subflow could be different from the
expected/correct one for non trivial socktopt.=20


Cheers,

Paolo

