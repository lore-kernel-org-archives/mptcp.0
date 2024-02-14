Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B61292D4
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940949; cv=none; b=accLWfoZK1CWQekGFK0V/BwV1bthwbbB5BKMqRtm+MU7qyIfUeWh2z/rfw7IztKY1dLta1dHWpjoODxaaXlsazR1O04O9s730ge3NjUSOrroArDivZunA20qJFFs1iVrsMXqF+06KPyc0eiKJ7bdJBCKx6hlJjUQZ+MYY57YAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940949; c=relaxed/simple;
	bh=52M1wMdhvT7fLmAk65aBh3j/XQ2fKP07PaiAPnF5s+o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=az55Lb0bFEq3/hJyLcNzw+njZYAREqsQVsKZXwIk/lQwOf+iRHTf9zQVnf6jMaTLE6t9v73TcOzOSGbXCH+Ga7ubFzt2Jgf9ZlJn4f24gvEZUdwS99spGArjubNcwySfLKf4QkqytL9WiHoks+5c7d6EbsJfh71mYwyKzl/Crk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/T63AH0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/T63AH0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42dadaf3736so357121cf.1
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707940946; x=1708545746; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wnz/8BS5OizTcfJKtWv4GHxpNo+nHO61zqJFU0laNo=;
        b=H/T63AH0XQZZUxRNmd7sO6PEnUIJQ4c8ikmpNHmmAwjfhbwhyq2QibClAWUEJjZQVw
         qLE45vz3bjU6Vv9qWF1w3wVs1PZrma3bLHXwEZS8HkqMx3q181EZf/55WhFT+h8Xq3Vf
         PtRVtVWW0Y3fjkDmN30EFfBhc0kcDgqL/u8h9k2RtnPQT/wgs7gwqP7km2T8qzv4Uoyy
         EsGZojRc4w1/+xlCDx2HQcPHKp6J4ZIxWhKeK9W15KJCgpiZXTaC2qw5LaPbMR+9hmmA
         WyW4EbeEuAkBnZagBPXOhNd6HiwfLf9NqNJGoayYEE83aLWTaCQLNfa9qkadlMIvrUU0
         9X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707940946; x=1708545746;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8wnz/8BS5OizTcfJKtWv4GHxpNo+nHO61zqJFU0laNo=;
        b=GygfQ9Yw62Z19jGvn7lrk/Aa+7JGWMQ1C8ix+F2hT3yvBbfZGAdXffCZMAI2gTJN3F
         TxzLcET4Mq8POeAxS4AMu+gWYZKuBDi9bDy6qU67mXvMMXQ7fzzVs6rY14N2gtMTA3by
         r7Hmfjq6JuWC8YxyyLAxT2TSsR2h+onC+m47RjuuTa7vw3iPGvonvgi09Bi28wI9FJNi
         CqFmRT0LEnjIg3G1gwigwnAVTPkD/39DNsVPcc6xwqOybe7pNCN1M85Jo7hRR4WLBQTo
         0zTHiaoNexSUlyZMNd8tAmByZWedsH/n/9sjxfZVA4XlEx/AliHfxtGYDbPoBlT/qPAu
         NJeA==
X-Gm-Message-State: AOJu0YxFwsseU9QrqoL5vL3ZsTTQeJ5glv0qbU4Z5JQrAhMcBKHECvm2
	lAnR7v9O1k0TrY3mD/5h2moCye0fx8edCO93Tz4rpaKxfU+uOBU=
X-Google-Smtp-Source: AGHT+IEqJu6er9hz5tsW4OSFYDj6HmwVsRpZFRWi0bjE8HuPGBTyWZoVCdV6xWD2uTN4KnQ/kB+rJg==
X-Received: by 2002:ac8:5992:0:b0:42d:b436:d4ae with SMTP id e18-20020ac85992000000b0042db436d4aemr4280455qte.26.1707940946189;
        Wed, 14 Feb 2024 12:02:26 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.242])
        by smtp.gmail.com with ESMTPSA id lu3-20020a0562145a0300b0068efbe2235asm1215370qvb.54.2024.02.14.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:02:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
References:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
Subject: Re: selftests: mptcp: stop forcing iptables-legacy: Tests Results
Message-ID: <8210ec5f-91e9-ab85-aa6c-2b4b326c74ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 20:02:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7906351480

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f4e0ec263c41


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
