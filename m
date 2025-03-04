Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65127C869
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110711; cv=none; b=rxhG6dIeKoNhTA1+bfF4EDqe1p3/D6TOxd33qti+Uwqc2NsPlomXfE5Q3qIdkm0TWGAgiKom5eQBTaIwPUS5zApSnmVsd0YN8+liZ03vNJ90QQKoeqRBdc3mvZEFoV2OpkLX7IgRIhvTQpLZ9Hn1kJW6sgi1CcJe0+D1tInPhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110711; c=relaxed/simple;
	bh=j/ceCBoL4sRyx2Jgs1clVp8tbHGnHigU+P9OeD9cO7c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NRO4QNiBVKyYwkGwpn+hpIyg8OZz+5bcMV3mWH6WHvibVRSIH6JmzAQufzP67I0nBwfn8O79vN97Nd3w6SmEq8TFHJ0kaqs63dSuZHywqGyqiIqPNJ1Db8CIPTo/03nCaYG9JXNBvnYRh1k3zIF1Yp1dkN0tj17VptjAzZM+x8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMciHRjP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMciHRjP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2235189adaeso865325ad.0
        for <mptcp@lists.linux.dev>; Tue, 04 Mar 2025 09:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741110709; x=1741715509; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQaQ6mEsY9Xz9ILEnZ8SYQVVgDvBp6EQRPEVTsadfaI=;
        b=GMciHRjPInzFU+rHsYpXsyCdkEe3eMf4H70eFmpppZdahlAQKQRj6Q1SOR0EEncqJv
         zjeJ2CcVCi4fEAJ4gFT+rfMf7dMK37BgHDhsSrOSeMxoOlGCRm0+g2aXwLYMb3qix4a4
         /59Mqf4MY1XWf3t1rDbFIhQcLmA5eGmIixHvlh3I7Go4NOL/NdpVcIRsPuhvUbcNeFPM
         2MgevN2juMTdmunI6wbeUVKrKZeVoPxLGdXOysQGTBejzDYaDNjmtFdpYy+juEB9QxLe
         3GYuK9+ivsrzky189m8X8FdaYb7+/XsW5wLlmgmRSzyRn6/KRooUz9bM39P6U6/9H7Z4
         6R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110709; x=1741715509;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQaQ6mEsY9Xz9ILEnZ8SYQVVgDvBp6EQRPEVTsadfaI=;
        b=eN3Ry5x7S5hpw1+vadvm49HTa7cSaq4k5kTpdeGP1jN4gUVQgQpbHqyja2RVO9uakC
         V/1dQ3qBBXj4SFzF8OlddQtY45AuV1ziRlvVUBhBqKfiEN+0Q8yI4uOXUXcJadazSgFI
         1v7Aoh5UjSiKCRKN/MZeLhCWWlTFcVVyWqRy6LXmrzuOeXKZrQq17hf3WN6b5ENFav6Z
         db97NcAmFx3u37sDJ9rcu3PMlZL1d3r/t6lArnJ3j/qXJJhDSgVaIT89Noh+WeLpFmSV
         zT3f+HGKKDG524Dx0Gr2c/RUdPz788UnlHmJH3iA88GkvjIXMS+P0+HxdbviyNWB7XNq
         5OxA==
X-Gm-Message-State: AOJu0Yxl/xPiwP2O/MnregHE7NZegaarLxLEZA5DiIl4aqMvY27Dyfbb
	iKGJynNZ12OkPaHfDun2xGMs+SINcLvO7F4hK4gBxee/9sQmxwGHJhkk
X-Gm-Gg: ASbGncsIdE+ZfwQ0e3eSvYlJPROGowlMEUHaX7af2SmeZ751SPb8LKXA5w/ivXPJvD/
	dzWBXyN+tG8Y43mPbMLzbYKN2jISd1Ftka1vtUylBumP+zoHrk+x8OOHfCkH8UMzapAIM/yiiYD
	SjT+zXVlAuqGprSQt+4IcUX1cE6HH0QaI97QDBGrHqyquSkm18mqsH3OA04tWfU2QFe68PdIfVB
	KRpisLcJZ5Vpst4te6lkwPdtkY3lBK8J6i9jxO8t8859tnRLTommp2dJnOXXktLuAYIL7OPibo1
	wPOtFNhH7YEzr0BSU+by1liFXCHcXtWA27nuAAwo5tHB7E7Yim+uwVj7+Q==
X-Google-Smtp-Source: AGHT+IEbZjibishLYXgs6VIHw9yJsfcc0TeAlj1pxzb53I6WtVZ/jOIRByJZI+oa14H+oJmViPRfiw==
X-Received: by 2002:a17:902:d48c:b0:21f:40de:ae4e with SMTP id d9443c01a7336-223f1d3ed62mr603365ad.9.1741110709154;
        Tue, 04 Mar 2025 09:51:49 -0800 (PST)
Received: from [127.0.0.1] ([20.169.12.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9dacsm98955855ad.83.2025.03.04.09.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:51:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
References:
 <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: sockopt: fix missing get options
Message-ID: <bf4f0c59-c134-c515-f066-c8a1bd6308c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Mar 2025 17:51:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 =
failed test(s): selftest_mptcp_connect - Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/136530=
22673

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c0b81bfd0e61
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D940005


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
