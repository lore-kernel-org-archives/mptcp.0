Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0990C13D
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709462947; cv=none; b=Kg40TFHdE3APCaoBuvF4piLwUP727sMKJ7PuQN99r+iiD/36qgqTOKw/frnIAFz0z80cdksNXN4dwMmZXBz56I4hkAxVZ+wEgM8uXcamk22YdDJ7wZjCRSPzlYBUi8LGXpow5r3Hrq6O8D+6q38uGmdktvyiyVP0jdIccJ8t24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709462947; c=relaxed/simple;
	bh=hjBef/owiFPbDugG/vmaFUpFYh6Kdavo8gCTMxrhu1o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hkiditmsep/MFFm9brYK3JQH7DIbYpZrBnebQ0V8g68BgRVlqS1K1fGVHifJIwL59ZFFWCxPoaF26IwdJR2Tf5XNEK0kpSN7yRq3ZybrMNqU923bgRAxGQ/9qhzADXDqkvG1HYgSiGj+NQjrny0Gz833AjtyUaaBUSldD/SmN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiY0DgJt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiY0DgJt"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42e67ee5b48so15537231cf.1
        for <mptcp@lists.linux.dev>; Sun, 03 Mar 2024 02:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709462945; x=1710067745; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNDMe1yYRbpLE97Ny/sR9xcK6jlw4j0BnEphV+zvjkM=;
        b=aiY0DgJtTGnchmv7aW40zWD7FfFvFkHOnKWVHr9YsgI0I3HdbylSh18hU10N2g51o9
         MgcS1/kQOJ7kb+ebf1K5itMq6wVBT+eyoKJEqAp1u+x6+vmJSZYl/W26HX1kOV+IHeWF
         wH2bCNB0fk6R2GeI9rJsf59A74ha6VzhJWodWhGqCVhHfIPPekxfjyTUOb5WSLOQcFNC
         mTyuUuz11IwblSYqoKo1a+jYzlUCpJ5YFcEXYUi93nc1/K1FpWlcaUKlMsg7KFCXrpFx
         htkYM6+FFhxpNRPuZdzAqIMmxQC9F7akjH96Tie1WH4UPsatGKV/Ol9se2KbAYxIM1zK
         qKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709462945; x=1710067745;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gNDMe1yYRbpLE97Ny/sR9xcK6jlw4j0BnEphV+zvjkM=;
        b=Bbh4ZMGIiw9x3sFQpr5Yl5EPVttTH0Uq6awINNFsl78PfFwy7vn8Sekzbcv/NEEun4
         aoJO1ZdxWYD6zKBQOjGShhiUb8gZ3c6J1V39luA6MSljR4bYu2raNi+Vjw6tyf0kRGa2
         m/Tlu0rPttX6etYMwrDH1tW/y6buddWQvJDjd2fpUaibHqDAtg+TG3LFn4RK/d9PwScv
         XsbsuabZnfu3aYjVi9tFrz+zTR4DVz7VlhyMT5Nt4xTSBm2HYjjJQRX0aRz+2PzChQtH
         JMUDCfhEk9nR+xLgYC1lJnV+GjDhqCoXEtcsi064Q9olfvw39aEYl/VpPUtfEbXMC4RW
         hDig==
X-Gm-Message-State: AOJu0YwbYQiBB3GGYf6J/7FtTJK+i8gaFcE+3NlXvsoMw52zt+7OgUkV
	c33N0flkRmD4JejXO845R9zHkfGgVFWPGOrcEGCZWA2aRiFypWfzmL2fW5MRVQ==
X-Google-Smtp-Source: AGHT+IGKCRxvnlVvie3ISvA5u1kn2K9H26aM5uxBDAhXGlzKbC8U00y4Gi7x/Qks8g5J/Q+i0PYVJg==
X-Received: by 2002:ac8:5812:0:b0:42e:6100:8bc9 with SMTP id g18-20020ac85812000000b0042e61008bc9mr7584482qtg.1.1709462944716;
        Sun, 03 Mar 2024 02:49:04 -0800 (PST)
Received: from [127.0.0.1] ([40.71.163.64])
        by smtp.gmail.com with ESMTPSA id j24-20020a05620a0a5800b00787f5d1546fsm3321492qka.64.2024.03.03.02.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:49:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a30bdbee01b90d4725ae09c19fc782ff31492e9.1709459360.git.tanggeliang@kylinos.cn>
References:
 <9a30bdbee01b90d4725ae09c19fc782ff31492e9.1709459360.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <2b4ea742-f52e-002f-4ed1-baede5da5a1d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Mar 2024 10:49:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8129425474

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a2a80d4555a2


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
