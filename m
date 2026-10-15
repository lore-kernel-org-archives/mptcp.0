Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5383B388A
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064563; cv=none; b=bANt9n/G3VETmUE4ujajWBIlJReZyKWf5hstQpWiOZttFNdYFgmLQ7YqfqlYrGfJFv7wM2ea5qtUJfXvSSUMgFestQZBF48I+VhmnKVXqzoOHlsNTkEO2gSH09j8q1a8jY9aO2dYE7hWfExKAli45v7dv2JYF1iRVqaQIz5Fyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064563; c=relaxed/simple;
	bh=21DNqrv9sPW2N6xU9XU7BRa6vfowYkm6Z/ARLitdaoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=H1GXaC+b3TZI8iQ3Yx0iV5X8cPKqqOdbxNIvchDiBFwuUK6XhdwtLVgFRaOtKb+ZuCwt8uLhAKncPxGyFUD1IWFL1e6RxH/idHPuB93/mwxnilLyaU7jj/CvDgkYUONTlLqvGZ0R+1auNdP7HAjnByGKIFzLOmsBsBD5QOxeMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pcr3gkYu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pcr3gkYu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93a40a9a01aso265443785a.0
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792064560; x=1792669360; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=idmUEwDq1UDUPOcraB74QkxZGTmrzpu5hyVSdrO8ejk=;
        b=Pcr3gkYu1gaqVST8CS699lfR6uAJtY1HwbscZFg6pBNBxF10wH0uaYH/Xe6b2XG3fd
         weKLJxBHY9eh+PMW13GtKxAqtJw2a32x9QpWDeBK3hiWAFXCehbEcP0mkMdOLGEDPWVA
         NGh3gFMDGU9CtELmKXk7qALlXahSWsbhaAjNyK0P2x8Py24zeKfe2XxT+g7cItyRdOfO
         EtFuKS2UmHxZWCnWE5Iw3Q9yA7qKv59oIzVbnVJyorK928W6IQQb0BdVzxYP3R+OyrpK
         r/k0XVidMyqnNeOVHULAxUX1spFU7Us+NIg1sXz9Y3IsG9DJMSLUk33wI1fmzqWI1xG3
         1fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064560; x=1792669360;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idmUEwDq1UDUPOcraB74QkxZGTmrzpu5hyVSdrO8ejk=;
        b=2CFluJpMEzgC5xxT68nUez2YsqLsIX0phJ1yFGcbZ7aZglAeKuu2JG40oKy/d5qIZv
         tiOvxuPH9U0112q8Fekai/kHhREaQCcyDY0tVgRf0YYZncKGDgLzSeI/dgBht3xFosUJ
         dBWXeQ/FaYL5UyJIhjHKxsolKqR4QerV5mGdYKf30m6B/kvup0XW/lVJXEueDj38hGtW
         g8V7sZPTJAiNJwsTsW9rWl5NseTO2kkuNcDueQm+vYHeodwLOhqz6yPmeznfED4OHgkt
         E/SlTzK/eS3S+TUlUjv+w4gQMYy5Y9+zX/purZqoipJ9x4UTv6Xc2d2CPei5yj5IRCSO
         cC3Q==
X-Gm-Message-State: AFq9FYJ2aujbBGZZP4WM36JIdOgTwPKFXkOaekgfFir2Z6M1yh2zAzcV
	383Rsogld93nyZNpGT5SSmNR6CkqMEXNueuoHiCEvvty5hJSYlKe2X0=
X-Gm-Gg: AYBFou1RrwRinHHeesv2PiQKg4PFAbDqPufC0Yg6ufPndZhpCWfNMguHOhIQDGciLq/
	v/4qmsNfrzClHawnxc+7FuZFZ73tEa7bcVfKLchjBfovovsWMhyugk7+WGjuMcj9OtQ0GNQpiwe
	0THP8hqWlb+nz1X1Cq8BolJobwCRE4xMB2f5p1ezjojYil4pp3IbHbDdopIrpAEg07fgJvwdln8
	W/2mBxK9U+tlx7VdaQxVCFG2XVzc0Qo5hvPanDv/oZix2e3YOq4r/81XTLTTAM7pqtsKZpGHvjs
	WP1xa8RYLdHRwMjlwXm6IzAoBQNZ7M8O6ja+y0fJAR9HtIehh+VCUGCJXAr7EYewxRJ6gTxla/N
	S4KqRCo+B7o3UKGXh9jl3ZEsyth32BUVQ1zecNR4XSDtXmeWW+FjIt1Aw9+BLmTmZTyiO3KA9I4
	PSU7yF5xAt6djjzEwUg4jEIHkMsElz2yKP1HgZnUKVlTRmaQ11nZj63eH/1aanET02JxVs3aPrK
	ZjZWObOzZk=
X-Received: by 2002:a05:620a:370a:b0:93e:53db:d59e with SMTP id af79cd13be357-93eb962b233mr2940828085a.23.1792064559946;
        Thu, 15 Oct 2026 04:42:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.239.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b99ed3e9fsm72905236d6.29.2026.10.15.04.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:42:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261015101303.144541-1-kalpan.jani@mpiricsoftware.com>
References: <20261015101303.144541-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v9] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <dc4ca98b-75a4-1417-cba1-4fd7df917aa3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:42:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38721441830

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1a9206c4d3=
67
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186354


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
