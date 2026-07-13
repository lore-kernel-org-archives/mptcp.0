Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E9305690
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954435; cv=none; b=imcKvyf+fTnXBmmzz6h4zWxfJMuDd/aXMOKKwT90KTsGQLrCvDTH37r2f3b4HJvxJN9vW0ru5AtwPVzYFVNI5uf6vRUY6BMdgZktSyzxgKmio3Z3bWiOe4RDEIq1mept1s0NQ4i8p4rUmdJVKjNHLUhYNpWCC5m/JyL6r8SMefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954435; c=relaxed/simple;
	bh=MXvpFMo8JhJ5Px6QERH2XwHdSoCz/NautskeJkNZy4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mfGcmlH5EC/2jMloSzeLerNoRHzDDonTVbLrL8+WNBarRbL6tu1CVlv7NAARuM015oI+2ZESOgHkC6JraelrEWEVG26MB9z6EXX5EQWg7cBekeG1pqpwvS4lR+ifV4dWXCgwWbvgd3MYKFwWITHBFFZnUK9u0d+diin1zJSWq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=od/tTi6G; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od/tTi6G"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-738a5cc517eso2284739137.2
        for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783954432; x=1784559232; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DT5L4uGMBGrMHY24CzCQV3kOlvYe2QlztaxuGj7uNHg=;
        b=od/tTi6GMEXVm5UTfjnpunnZM4l/0ik1a98ImDhvJrnJ31Fn46+yfXCdkqfhYgPLP/
         nLZH1M/cywr1pAoJjeYOZcNEvpDLMoBjU1SscBgg4loWVLBCC8yXd2C6AzwJdxMlidsl
         q8ajp8EEu+oNIcE7o1haWQZKnEaUKb1k674s9ZGgxoXeLEQOZuAX6I1g4Y1elvsiYAEC
         teRePwJSfBmPBEglTRhdQItEedtsU/dpLYT+fEDzYGoakTiLTVF5XVsTxint2b5VS8jc
         +RbTTGkjI3/UGCSWF+RnUlqQuPDTtBzSHw0l2rSsGdp5UrEdG6+uauYi+wJ4hh8Qw21w
         IqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783954432; x=1784559232;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DT5L4uGMBGrMHY24CzCQV3kOlvYe2QlztaxuGj7uNHg=;
        b=hvDKeZtPz5EXlzkz7vIpxEZv1eLixO+lYqPKGlHL5byPiVTNL9y9MtNL6fVEYfdu+/
         mS9m0NqZi80PdH/HnfI8dhyUk3Fyh4rBSQkOOgLDTAc072qVUcJDisLiJSiExvF6GvX/
         G4Tib9g/ThydvjImTP+GOoB+FeP86v+LHIdugLPMegLHGIbwiiJGbTfUkVG/isLr+5TP
         hDwD2S0XmtzaNkBKTYird0yyApzZ8ietEZqE05M3rQumqN3RDSSLq+dnjn0CCuIIRSU0
         Al40esYeOPvXzEtNpyy3DMuRCZcyaQzWwoJJgY8MvJr/UjmvxzE2+kWgOH7P5qZ6p/DR
         zE+g==
X-Gm-Message-State: AOJu0YyPneRgXN4H0NKaP1SA0HiBy9o0vEBhK+M6bHMC5feHdL/9xL8n
	wpXv0/JHylWlziXnMcSphAgNndlA2BNK2gbLwXWNCRgURhSf3ZHC6zvOuokt
X-Gm-Gg: AfdE7cnsJ0x7Nrjrm0JaVPjnSZx4CrShPsAAxGAgCySMVYhH9Yv95s/ayDl3L8W16hZ
	ykEES2Vq/4gZ+3J7XRqyh/q0DQ+GOG1LLTC2uMAYjwovGR5zQWQSK7yW74FN0UIlBkvkNRtdNTc
	VDUkKE14AbxegvYBi1IiVitQ/nInY01Ap0Hu7+qDI9QvhMPLiY3wEyZlgEJjbdJtou/JQqbA/JI
	nI9kctHJ8JoxGr3Gp5526fvO8GtkTbhDZgs9rlQQj0RJ1Jy6pmJ3YKF144Ad6+gJVnS6A/GC6HS
	DpbzZTMM6yEb70jzXDonzyWuWGicDSq+z2zCvH+sEwdtgcfmAXyDoPF05EXF3hB4220rbhlboUn
	ZFyMiGG2acKhd6Y+v4z3ZGO9FyATlIrkT7nYKsbSh2t/mh2vlefSc+YESswMDrl0m2mwAXDw01A
	52f8ojG7u4+xMXPnZJY2oPDKMzRlEY
X-Received: by 2002:a05:6102:4188:b0:631:37cb:1e64 with SMTP id ada2fe7eead31-74533b5d732mr6346399137.4.1783954432155;
        Mon, 13 Jul 2026 07:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed2c94ba7sm8128981241.4.2026.07.13.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:53:51 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: "David 'equinox' Lamparter" <equinox@diac24.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260713135551.569365-1-equinox@diac24.net>
References: <20260713135551.569365-1-equinox@diac24.net>
Subject: Re: [PATCH net-next v2] mptcp: sockopt: implement IPV6_TCLASS
Message-ID: <fb3807d7-69b0-de1e-6dfe-5007fe7c0738@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:53:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/292567=
17852

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/77f3e419dc22
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1126717


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
