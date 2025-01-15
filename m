Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426A248BDF
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939421; cv=none; b=qnNBDmW8DAGAEv72FFKjRo/5+c+DCUrXVINJLlqtlXC6+ia05mHwVnPrKDT6b2jIHlyMPkOoNeCkCFUVMsK+FSbpxhzXx0tPyv97lCG3J+WgmxdYB9rflI+4vmeGQnZTb+FJ9wp0On4N7m2QBQxbZsm9aXgRxnCo4zCrdtmgwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939421; c=relaxed/simple;
	bh=Fdsc5STeJxRlZY2F8e/pEBbmSyaO6N3iXzj8MT7MMu0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ASeRP5WU5j0mV5lcJF3/MozIxBzuYIevyclgON8TCdaV3oiQH+vzmj5y9x9qE78wbunB0ti9Lvjj9KGE5g2jOP0/MqbL4ZCewmLel6qPO8RIsr/I50uPr3uPRUrRqBCvpJufxleugH+5yjuW8BwOAF8L1Qf5nZVjWb1X/eEdHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9rEcnPx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9rEcnPx"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b9bc648736so562671885a.1
        for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 03:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736939418; x=1737544218; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryN4H8wkIGb2f8o0oo630j9DLup+PqsZakQPltPbaY0=;
        b=P9rEcnPx4CV1gr8vAB4MACsSC2UnFuyH7hoVEeiPue/bofkNlA0L7nuiGnIl6X9dY7
         DVDC+rB7c9dbmBwOtOQkrbQaktgEcaN5AVjQ+PTUmYhH3OI/AXD5g4faaPs12DcM5ftU
         4MMLLfc0Q9UK8ew+3PC87eLMicaVcfns8+RrjKk9OoVsJ9nsGbeh8JzoGmamy94wNXlT
         fATdTGEy/S6PI8cCArCCdFMw4QUxTQPw97THRGRrb8KkAFvKD50ujnF9/PGlHQIc5jXB
         z4iSRPnHNpIwqDGAClxPmNdTjZcOhOIuk93w+PE5lAQGTchf5VC9pgHQdM5LtRcORkwQ
         pGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939418; x=1737544218;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ryN4H8wkIGb2f8o0oo630j9DLup+PqsZakQPltPbaY0=;
        b=Fp0uDX6htRDIg5Ll0xSoU4jYMvIRIzK5c8NHzUw1+4m0ekeFJo7EVw87z6E2FGj2bI
         YR/En1aklfZqvpCn6rFA4xMmS4IciVinqU/GrVqC1qGf8OkE+NQpsLbYq32ErLWkTg87
         2JjMlo8ikBPA7xg97wjsZO+RaBjwWTehxupnfb4MW2AZUAnL0fAUCic5e4oRKtAgbVr/
         +DnnYq+CQqUJZRfDbWOhoYveHIn3I0mumAjEp2tnxWFXPgmMGUGDvtYqgkhBvPOKPH4I
         Jjz5jb2H9QIxMQTUOUbbfZ38e6RXDRHLd1QTnPunPiE3CPok4gyiqBwGBEQDtyb2+UcU
         JnOw==
X-Gm-Message-State: AOJu0YwPhVp6mFcUcbGWlZ2cC77m21lutKn5+4vpMaSe3uY4ceKcg8Rf
	AnFtmBx4Wwgy5wkHbfKSwflSRj3hNYBdDx51l+1bz7xQEIUlEcjJ/bEni94=
X-Gm-Gg: ASbGncs78JYBINA/VvCOLQdp0tTpFMFkSAy87+HtLo/pd7xA6uc3unILz/3sfBA9LIL
	KzjvbeMkRD2GJ6CatKWe0mT8dVGuP8OPSyl5hqpujQEriHpNKv8JIlrCuUGnRku2qCUWfxpsl01
	hNROxxycPfQRLinz3oYRFpG53DrdHBqBOMNAgN+lpU9DIh9hJ/dikt73x+thyRSTo0zMAFyHkTr
	Kfi0cIwJtpaPt/jiXfIVkyeAcUIB20JxA76jdsTVFryCHTOra8npzZ3FLL+x4xkisLzJpQn
X-Google-Smtp-Source: AGHT+IHeBq712TfbDGaAcW3m28OnI0OkP1NH2zdSqhhKqiDCOFA3fUmjz0rqmjhdqlTL3JYewtpOhA==
X-Received: by 2002:a05:620a:36c3:b0:7be:55f3:32ca with SMTP id af79cd13be357-7be55f332d8mr75722185a.19.1736939418208;
        Wed, 15 Jan 2025 03:10:18 -0800 (PST)
Received: from [127.0.0.1] ([172.183.175.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce327bed4sm703906285a.58.2025.01.15.03.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:10:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736935086.git.tanggeliang@kylinos.cn>
References: <cover.1736935086.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/6] BPF path manager, part 3
Message-ID: <c4543747-0c25-7d3d-0b22-5ad4822c7104@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jan 2025 11:10:16 +0000
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
uns/12786150574

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1647cc52b82c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D925637


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
