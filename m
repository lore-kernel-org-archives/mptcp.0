Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34872C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 02:58:48 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id gp5so1312862pjb.0
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 18:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GTX6nESJwbmGtty/mh2sVu1URZM4TdObPnTgGJofFpw=;
        b=p7GJvPS+QW3/t0j3ejBX8BJdwSD3vMLNr6igsHfM6uyhiTaXcjLWqYtc1lSapIcoAE
         TXZ7YDJ+UHLg8vJRkeT8JmJ7wwD1PYwp2oEhPJ5/9JJZMiyQSprXfYXgdE8hqr31AXf3
         auT0ei20zokOWZDMG0Zm7BM4KbvxeOSknMCgnxaa2AwfYOnYQiXfcMf/GEM5YV/ThjtV
         FodyS3s4PnzXw4v3D4SPLfgIq8z50/gQCJnVRhad6U3mnI55D0YKp6RocgrphMJ/jM5W
         PESIxk+qvQeh0ilcvz0JtYsc8ZwFBy46ogKHJUO4KZ6dgPZzy4+Gd/SZfq1G40NaFdWS
         FihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GTX6nESJwbmGtty/mh2sVu1URZM4TdObPnTgGJofFpw=;
        b=TymXD24bGlE+SuSh8CVZnUo0irxa62LKDyaXDQJttDIHRABbPnduqPyPZUHMTI25KD
         ZCJIq6F91hMWAOAvIJHG63ZqVsT3+mm4jV4+zqrpZ5KmKk63y3Lw3eM7IO7fUTMdlnfQ
         8d9MhPu7LXR8UYDY0GFpzjqjAJvCYPJcgNjcRWMnVlghF2+wNjVpX/7gyKuBq185kdGB
         8eQZtyVzC6AVZbgT3eMUcHEbR+XPaz9usJ2hOK44JHgHgiSg21xE4BH9Kqy9YAfnikj2
         ARkOMJrhnaPBu4X9XSiDfSSZ+0s2JNSH2iZgQU8chhi0TWAmj26+LmLGVcmLohKwyLWl
         YKnw==
X-Gm-Message-State: AOAM532Y0KZVwubaaNarV8H2jsKQ9xWZDtKJuGZ9Xlq5itPsE/pJsUb7
	xhdMgfaFAXebOEmhTTYBMjt46cEsyac/zIDejQ3G3DSKPlI=
X-Google-Smtp-Source: ABdhPJzqr+TwH9tpWLkKOfrZTt+rhBZ9ihZqpTHrdnpa69pxYOxmbGDncRpaTNFPGw5edIKQXa9OCXl4RsWROBBiCqw=
X-Received: by 2002:a17:90b:1d03:: with SMTP id on3mr7674863pjb.82.1641437928310;
 Wed, 05 Jan 2022 18:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
In-Reply-To: <20220105155702.165123-1-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 6 Jan 2022 10:58:38 +0800
Message-ID: <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 0/8] Clarify when options can be used
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thank you so much for this new version. Good catch on patch 2. It works on
my test and all looks good to me...

Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>

... except patch 6.

I thinks we'd better to drop patch 6 ("mptcp: allow sending both ADD_ADDR
and RM_ADDR"). Since ADD_ADDR suboption is too big, we had made a lot of
efforts to let ADD_ADDR not to be sent with other subopthins. I thinks it's
better not to let ADD_ADDR sent with others by ourselves.

On the other hand, I'm not sure our code can deal with ADD_ADDR and RM_ADDR
together correctly, it's not tested.

WDYT?

Thanks,
-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B41=E6=
=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 23:57=E5=86=99=E9=81=93=EF=BC=9A
>
> This is a new version of Geliang's series called "send MP_FAIL with MP_RS=
T and
> others" (v6 + v7) but also include this time:
>
> - "mptcp: fix a DSS option writting error" (v1)
> - "selftests: mptcp: add mp_fail testcases" (v5)
>
> On top of these two new patches from Geliang already sent on the ML, this=
 new
> version:
>
> - includes one new patch 2/8 ("mptcp: fix opt size when sending DSS + MP_=
FAIL"):
>   hopefuly fixing the issue reported by Geliang (MPF+DSS ok, DSS+MPF nok)
> - has the Squash-to patch 1/8 split: the other part is in patch 4/8
>   ("mptcp: reduce branching when writing MP_FAIL option")
> - has one fix in patch 1/8 reported by Geliang
>
> Notes: I still have issues with the mptcp_join selftests and TC but this =
can be
> fixed later.
>
> Geliang Tang (4):
>   Squash to "mptcp: implement fastclose xmit path"
>   mptcp: fix a DSS option writing error
>   mptcp: print out reset infos of MP_RST
>   selftests: mptcp: add mp_fail testcases
>
> Matthieu Baerts (4):
>   mptcp: fix opt size when sending DSS + MP_FAIL
>   mptcp: reduce branching when writing MP_FAIL option
>   mptcp: clarify when options can be used
>   mptcp: allow sending both ADD_ADDR and RM_ADDR
>
>  net/mptcp/options.c                           | 105 ++++++++++++-----
>  tools/testing/selftests/net/mptcp/config      |   5 +
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
>  3 files changed, 182 insertions(+), 39 deletions(-)
>
> --
> 2.33.1
>
>
