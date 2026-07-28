Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6933A9DB9
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242794; cv=none; b=Cm9aO17GGK3wyxvoUlPb8cpJeZQgGuF991rsCdJsjQQH/vpKGLgTbuK+HUlYpfDKUGVI0TfRgNVqrvIBhHzx4WtHpNsOatA+v3oq7EdjNcXq9TeQIzmvGHrNoge5PUAXBi366wTW/OvONGFmhUWwvuthQpRle5IkZR+Fow8wqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242794; c=relaxed/simple;
	bh=dnrmnBjdj+6OOkXbdN1fQn8eWJoU8yFcj3104saybSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=tnVqPTSrQSVsbC/bY15OXOqwj4WlFqoWHj40VXQSAKYa375J4Q0tE7sk1TtX+iIgiFPZpYGTWnyPwkIJXhF5sXA3akVBjhIofXAasDLMlEG7MfOuK4GBD2s9wdXxBpYS3Ayi8FxLHEl79VW5YrNMFU/dvXMtSLsOllzFJu8lJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzByZxmN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzByZxmN"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487088510aso3124221b3a.0
        for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785242790; x=1785847590; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Aiy2+2AxT1csbjehVhsCOSlg+cOCWzZVuR/l/3yLdIw=;
        b=TzByZxmNazZOYhDg0yPP0o5m8pNaUgFqWdLPFYJRGz/JtTqyQHQ5a5virs7jtTiuII
         e2aeg7oKjbWsN1AabESAbWWqCtDLhX2PKYiCaaqmNsfZGjmKBiYokBoJSVfz9gCSZde6
         g9eDfaZFJdi8WQ4lms1Ga9dX9o63zORQ4+/HfWbd875FKneHNbwfbG/n9It+pc+svt6S
         HBz6lbzsYVP+jXym4f38c/CkEcCYF3VFqZ2XxC1sTdJ3DeVC2Ip3VHm3G6q80NcIP0Pk
         iU5QhY069Qzf0JSidBn/HfglTFu94MlpHrUnuqs+OO2ZXaF5/GqHxKlz0yUJDNkla51O
         AtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785242790; x=1785847590;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aiy2+2AxT1csbjehVhsCOSlg+cOCWzZVuR/l/3yLdIw=;
        b=ETRLlUcICv1oz5KM2ywDnN9V0zCPextIs78DVYmQ639/ny/hrPn6E1Z37NH6jeq144
         O1szwf5rWhadxpeeMEYbichkX2IoTRldvNiY0bWyA1AqNkTo3fG0HDkRJz7GwL5fydDn
         TsgZQxV5XI4BCkT7ElzqArXaRN4/gaLeoduPeBGB5hO+BV3+DUKWR/HGzRjvAm8Rz51V
         xXuUGFK4EtnkYkybCsPoCCm4eOzl9NoG38/Nu/5xDsXKtRTb2Fj1s8AN/2nfJm8BOxGT
         b8xEUkwOa5HqAu7fiqIcFzATZuHAwmYQOX9Z7sCbEYcRnPYT3+EiBxf52PB+r+xKExbF
         FtUw==
X-Gm-Message-State: AOJu0Yz99ljpvOvEZUcuM430EJsMJhoMKlNVWC2XDM+ziuKqPV0l0GHB
	qU7LXMHaYg7kT96lrz7JybWPBPECI/AdDmXkvTOysAookKckq0v8f+8a/VLX
X-Gm-Gg: AR+sD11PfHjhQzVL8SD74TgLwZDI8eUDTIy5RoDC9uGxVfH+5w8KhNXHmv1MQ+CDJgW
	gygGi1Bf+g4EOaZu9tEi0P8WZMMZp1HACIw4Lg5PhONv3zFlLoKi+JDNwRUfQ7GRrTKy3HVkuiS
	oam6bYIm8dgLIxCedpXpDHe5IF48xOXa8SuQl3ymC40mO3PlaBSkBzNt86VgswALjVYnbhQwEit
	5vRYn/KLph/yNe7Kak1ueomIKBOI6LJbqT+KQ5wX2UYG0iUYimr/S/y/S4DBqnP2pteFI8Toegh
	wasGV55u/WDd/jJXtiZVJzAt+iUuJm7MJ3hwGwWoiQHpzkkLCFK5uj+WOLhhJERkq76hYzbnmCG
	pLOmjDqRpZouXhJkGhcbf69cVt5CdRUDrDs6fLzHPlIVLL2KVufn4xHvGXFT3MtZ21vUOxz8Nks
	ATPsKgPtiaalUha1U=
X-Received: by 2002:a05:6a20:7283:b0:3c6:3c5b:f32f with SMTP id adf61e73a8af0-3c8ba5f5230mr2955681637.51.1785242790138;
        Tue, 28 Jul 2026 05:46:30 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm111053929c88.2.2026.07.28.05.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:46:29 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/9] Fix socket options used by NVMe over
 MPTCP
Message-ID: <abe707b8-0389-2c46-8875-502c21de6c6b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 12:46:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/303567=
97327

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/87186bb3a0ab
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1135876


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
