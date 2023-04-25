Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052577B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:57:34 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f199696149so20169435e9.0
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682409453; x=1685001453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkpjR3PJAFUzIkuX4iLPJpbLIN82iT4K6HlQdJXhdhk=;
        b=WMglDYp2d9+t0LWOt4/XU3zsUj5IwUCZXG5hIhZalUoOn74qgkxES9bbxf/CPg7uM+
         285dossdbtjqmC5ggAKaSPN8knoxWhhVX1vX/k+TR6gvgIblfioCy4Q75iqrmKS2IOFy
         ZHrTHv0cRALfJ2K7e47GhnMTHq5huh6y/hmtV/r7GBYMMNKyj8MWLg4xUEjGzUDFBOor
         pLIVixK7eQrgiIWC7qtoaRSIXgSPsLv/d6I/gp5GQIlMhOw4GitmuCkrG6/T62Cio3XJ
         C7M6IarrguLLYV5+gXMabe62VFYSK8LD1iZCEEygXcE2ivCu9h2A73lIk7IieLfXTrMk
         bMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682409453; x=1685001453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkpjR3PJAFUzIkuX4iLPJpbLIN82iT4K6HlQdJXhdhk=;
        b=W6RrCUNT0XcECjvoavzptwWv3k4lj/J42VrgE1fksyPx8pvYb0wXp1yfZixIArMq7P
         hd+7PwcgIrAFE57K9KdircICCMMSSq+OY8hRpN+KLgs7a/Y64QoNwLyh5dYZo5mLfcJN
         5/wUcznQGsmJaKx3DD8zeZJHn76mTQq1PGaFXuo7pJY4iafb8s0+znD+kz5soOYatqZE
         Q6j3IhiZhYjJN7Mx2PDO40tex+Ma2KtUNSvHDjiHNEn2/WB1y8zAXYDcrxnTtsNHPYTR
         0Oelrz3ILPrAodQ/Q+28z1uBiJdKk1K6CytZfwGI9PAgrtvJ3MUnms6am5EdLaqy4hcP
         HZ+w==
X-Gm-Message-State: AAQBX9ctOIW114xzjM9loM18xzgqinGCMZaV5bBlAv4DT110BqGWpC4t
	PS5bIAhxiD7BUYPNOM60q47Lg83cETpeihu7Mjs=
X-Google-Smtp-Source: AKy350Z8hKCJ6P4//6WDVB6+DG67Ltld9isNBCZ8+gv2OGDF+LhPb8qkhZkRR+ixsDit5G0ovAVxkxNm/NRi+Tzammg=
X-Received: by 2002:a05:600c:230e:b0:3ee:6cdf:c357 with SMTP id
 14-20020a05600c230e00b003ee6cdfc357mr9215700wmo.20.1682409452897; Tue, 25 Apr
 2023 00:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681960259.git.geliang.tang@suse.com> <8c56e8306c829d6ca42ec34e07448fcee21b5dc4.1681960259.git.geliang.tang@suse.com>
 <2e9d011c-fd88-4ccf-e4fd-6d312cd5b527@tessares.net>
In-Reply-To: <2e9d011c-fd88-4ccf-e4fd-6d312cd5b527@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 25 Apr 2023 15:57:25 +0800
Message-ID: <CA+WQbwt0=5NCt2bPqnF8ZvK2khVumZPQmx_qtUATku-RVi6Evw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 1/5] mptcp: only remove addrs in nl_cmd_remove
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 22:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 20/04/2023 05:11, Geliang Tang wrote:
> > Only send RM_ADDRS to remove addrs in mptcp_nl_cmd_remove(), add a new
> > helper mptcp_pm_remove_addrs() to do this. Use mptcp_nl_cmd_sf_destroy(=
)
> > to delete associated subflows.
>
> If you need to send a new version, can you add a bit more explanations
> to make things clear that the NL command was not supposed to delete
> subflow but only send a RM_ADDR? I think it is important because we will
> need to have this patch backported.
>
> Maybe something like this:
>
>   mptcp: only send RM_ADDR in nl_cmd_remove
>
>   The specifications from [1] about the "REMOVE" command say:
>
>       Announce that an address has been lost to the peer
>
>   It was then only supposed to send a RM_ADDR and not trying to delete
>   associated subflows.
>
>   A new helper mptcp_pm_remove_addrs() is then introduced to do just
>   that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
>   subflows.
>
>   To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
>   command, see mptcp_nl_cmd_sf_destroy().
>
>   Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>   Link:
> https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linu=
x/mptcp.h
> [1]
>
> WDYT?

Thanks, updated this in v9.

>
> > Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
>
> Oops, I gave you the wrong sha, it should be:
>
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
