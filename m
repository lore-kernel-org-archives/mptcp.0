Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA517A
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 12:45:54 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so5509617pjr.1
        for <mptcp@lists.linux.dev>; Wed, 18 May 2022 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wMBWkCffbBwysChLpTvWBp9qoFOKgowkBCTbVVltEvc=;
        b=Tgo/QWUS67DuIrrV7tAltNApvOhIatkqkxvsSUL5cgee/8bSFEVskiqtezbpCcOIvQ
         3BVcC6NG1dGHaShAupmErhkcq5mE1cmJbnoTDHHx5LkRYIzVRhGRMvgZmsA8Y8bs6RfO
         zgWUHlaYMR21iG2oAZVM8tXAZGCSilGtKRDSBToa3N1LO+9Aw7AX6RZrRbIDBjVpPCC6
         29wGcZlvtJn4nYn6uV2zUgh9I+GSBetyZCcb75v1RdQAW0l29IRg8R1oxNsj50qczIOx
         a38cym4NODlIiEbiM2Z6kolcegymkZLsCxD7fE5tjXax6TvCJOxOJBPEeS5u1QutZsPf
         DwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wMBWkCffbBwysChLpTvWBp9qoFOKgowkBCTbVVltEvc=;
        b=YVYGXZJJlOyILT1rFmASNTHArJBeupDh1uQW1KLF2MUX81NVcAIORIGcZ+G9GLZf5G
         fQYNLORoN8BzAcRFpl3Bvxa34BXTzbPHAS5Wz9cOiULqtKUclrv2dbHPS0Qyj4HbFG0H
         wjnmXvgMlUT44lgx2WNdgI3G3Hvd/fAwvdd3QatprovmUlwrMh57nNJvURrj3Z66LqtZ
         0LV0PQQz/d49gtnkM5d03WKO5HEMPPAZPMiLhdCcBL69cZ177rkFAHUj9q7b2P9XcmcD
         I0tkMYEFnqOZUfuZVaBakKcM9mS3UwaQDmmkEIA4BoJ4B+Jh+JCDmiSLaBZyMhhGuPQT
         qUvQ==
X-Gm-Message-State: AOAM532giw/7i3i46PJZ2yE2wnLd1Mrk4CjY4qqF9CpRGI/G2Ra9EPhz
	IU72TahyUEHQjPpgn+DhduGBxTCcD4SI6ja89mOwDLDAgwc=
X-Google-Smtp-Source: ABdhPJxoioopodj5CYQ+VjOH/KtaPnv/DPN35CrRlNdT5BSBeegG6t4ZB+jBoPV8QYU1LtattcGa8Is+6sp9dGPxj1k=
X-Received: by 2002:a17:902:8c8f:b0:15e:ab1c:591b with SMTP id
 t15-20020a1709028c8f00b0015eab1c591bmr27554255plo.171.1652877953485; Wed, 18
 May 2022 05:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1652853898.git.geliang.tang@suse.com> <b5db3ac6-acc9-a551-de50-816a79754e2a@tessares.net>
In-Reply-To: <b5db3ac6-acc9-a551-de50-816a79754e2a@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 18 May 2022 20:45:56 +0800
Message-ID: <CA+WQbwvtDfeFrMQRoubHohFJrxZ6ikFz6gVtHnHGfBav2ma+GQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 00/17] for bpf-next
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B45=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=B8=89 18:59=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> Thank you for this series.
>
> On 18/05/2022 08:10, Geliang Tang wrote:
> > - The first 10 patches is for bpf-next v5.
> > - Rebased the "BPF packet scheduler" series on export branch.
> > - base-commit: df896c77f02a ("DO-NOT-MERGE: git markup: features
> > net-next-next"), export/20220517T155019
>
> Does this correspond to what I should get if I apply all the Squash-to
> patch you sent yesterday?
> Or are there differences on top of that?

This series addresses all BPF maintainers=E2=80=98 comments for v4. It make=
s
the squash-to patches I sent yesterday superseded. I found it's hard
to send them as squash-to patches because there are too many
differences. So I sent this new series. I think it's much easier for
Mat to review and upstream.

>
> On my side, it is easier to apply squash-to patch and re-apply an
> updated series which is already in our tree.
> Of course if the conflicts are complex, you can send your version on a
> public Git repo for me to compare.

I suggest we skip merging this version into our export branch. I guess
BPF maintainers will give some comments for this v5 too. When this
series is accepted at last, then I'll split them as squash-to patches,
and send to you for merging into our export branch.

Thanks,
-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
