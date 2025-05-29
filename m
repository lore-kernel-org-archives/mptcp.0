Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8E13AC1
	for <mptcp@lists.linux.dev>; Thu, 29 May 2025 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496474; cv=none; b=A6510aXQ7lnGrR5wcM4OzrxfQAtLs75YxTxWk2qWElJmophd+yvQaDbcWVY4hfxgD4ISfU33lEYfmQkd8cDgEi11Is2fgHSGmJFDCvc189qczHAaD09NatrHiMEytylJriK6Td8bCYw+FgfuYsWfGxMwcATvLpYekKerDe90New=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496474; c=relaxed/simple;
	bh=2+kRP9geIgHe97+Jh268yDlz0HzHzeI2r6ifZGe8NXw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Ml0WDnDKhhJTyLIEkYb5kGZFe5TJzFAgxn7Nmy6S95P29jNKRfyolziohSzTbTKqwLq9Gj09KfNjGGrfBhzCV5CIhkLXZtBNZUOR1yZjFsFFNqnNT18qZ6H6PVbnIOGoTuYjz/IJ9F7jARA9f3z9gcSozelp5ZHFMWwFx3JWk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3jQEpl4; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3jQEpl4"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769aef457bso7314881cf.2
        for <mptcp@lists.linux.dev>; Wed, 28 May 2025 22:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748496471; x=1749101271; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9exZXNUpOdU3qIPInQyDRqkZAJM/mS/gaAE/Otoxrs=;
        b=h3jQEpl4S6tz5XcukUJDoGay1xyRU/X/4GNvGVt+civKuW/YLzCxSEVxUAzX13nF2s
         WyT+PAdmONRAirKxX3lqB4pnV23Yo6X85Vlf+Es/n6aeIi+k7HMZ3akH7KVvw3V7efjx
         V+wWC4kfoGYiElFcMbsNyQE9eR4JxIuvXGZkZbAuicxueU66ROfkA8nIEAQvImidT4Pp
         p1P/GDMxp3Jz1JRq4l3pbPAIZMzeR1bx8QiKOaJvAk2R+CAonSzVhkJbzMz55P7tByaF
         MkOsZanXJm/agSrOExmZFJ6okBNVLDMnbdwFAsuZTsYNJYt6s9ERnX8dWKaAo3zUKmT/
         YKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748496471; x=1749101271;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9exZXNUpOdU3qIPInQyDRqkZAJM/mS/gaAE/Otoxrs=;
        b=rVx8gAW6olfVSftoZtQs7FBeKT9Lt/siFlHKMlsg1bKCAfdK2LV8/Pgq4Z2D+EuP3B
         UM0uDX75jvmuGrOgbFiSEzCrFwNGnUQyG18yHC01h9sHG1uU+0QIJ7aBpofuIw/sGr+d
         g6HPMwYV62AtdB5E6eysEMyonnbALYLEjh22scPJG4z1tK/gX0H72j2Dc3a9yHTsvg9u
         jeGMC72vVQGKDTSCFNi0sZaEC3nwczKPvkRcmAL4IN7TdCesywlSfNVh8S/tQp5WfgEz
         vNxyo88VjTDuLxbsjBGdqzTm5Yy7VtcVT3FY+mln5mG0FSeWEFTEJdhR3eIodRyZPRnQ
         dSvQ==
X-Gm-Message-State: AOJu0YwuD4+MTFCR2RHoO5tW46lCa/zdN/mm4c/69U4Q/jPtPg8s9Xkj
	JJhV6Z140PXnf8ADCQNreYbKbR3hxtfr1f6oZtEuidc6nlvTQfahrWk04gPq
X-Gm-Gg: ASbGncuHpQH12aNQlM7Nv7yLQxbsLao+j9YV1YR3x+w5TAQ7kylgZ/aW2MVnkE24vUV
	hk5HBIqj/k8nJiDcY6xch+EpTsSYAubR5BgKEGtL5NlGTyZ2qNMG9mthjTLj5Bx0RbAyhtdY3Nb
	fkWK5dX20DvqGOLnyX8nWQ+uuOESGnzmOayGH3mCCqADiydHT31YJaHwioxDsVYKM1qnUXoKox1
	oeEA80wuIQsBlfnWGgSJkN6JNZ6xYBljmrsGhktDPji+sqscWZbcF6e92sFmj8/vpBa6TmAi7pq
	6/alC+6V0j90/fyyCLQ0mueXyAUUcVytLO1XR0zWAzG+MsBZPwR9g7+X5FYLgeuU
X-Google-Smtp-Source: AGHT+IFKTc91aCBgXnjMjcvxvEzoRozNVeJb94ZbdkOS+O6Uz4xHVHPw8PYozmCm81hEYf1msocycw==
X-Received: by 2002:a05:622a:1e0b:b0:477:13b7:8336 with SMTP id d75a77b69052e-49f4655bc17mr313170041cf.17.1748496471421;
        Wed, 28 May 2025 22:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([23.96.208.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358d55afsm4647291cf.42.2025.05.28.22.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 22:27:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1748484770.git.tanggeliang@kylinos.cn>
References: <cover.1748484770.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] send() fails with EAGAIN in blocking
 IO mode #487
Message-ID: <0db22c1e-12a6-b07b-3c33-b4b3e4fd12a9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 May 2025 05:27:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/15316193959

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8bae6145adeb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D967210


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
