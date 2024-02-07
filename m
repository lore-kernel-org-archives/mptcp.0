Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD0168DE
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310360; cv=none; b=TYWsYPlVMD4BWVht/UpCddZ2lykU0TBrS6jrlljyChwyJfu1/UFWPrFVRqfyZ4y9/oVZGIWNklmzyrOpCCVnT0dYSEm4aw2W/RQzNuRwlNMabcSJ8GiMGCYCsnX66JzTC0dFNiE27Dvnwkrlfy7uqKUtgXc/B+AtKbRxPurA1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310360; c=relaxed/simple;
	bh=FqIaednKh299qqQV8MSnNpSGDTZGo9IQODvbBEHBlmE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tlz6yCRfCGYlV1iMkRkED/WNrQIiEs2o15HPRofK5dAPssDrY7A3Ogomd/81VQAXO3MPe0cHqwidChQo0bo/NNBrr8lIDSdMWcnx4Rw1VpE1x+xmyNmW6Mi/hxV3gXVVmmqNku0JQ5Ys+ZGSZZDhF4RHgVlobiUrKffMWVoej5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWeab5V1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWeab5V1"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818f3cf00aso3583056d6.0
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 04:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707310358; x=1707915158; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eTrtHpcSs9t0JOIpfXXknaJu9o2ilTuL60huiYT4fw=;
        b=DWeab5V1nzwxxz/B3WQRwzcwe7mfBYqx5lucNxZeJXc4p6HVbicBHwnXWNbn/9T0gX
         D+qi3+nih95BvFR4EAqzSZa1efGIbWCAG17zP8pYpY+PfMrgSgO4E2k6PMg3p6z5oHTv
         APPTUKIb/kf3DRJHAQ2nwDQnl+HfV9/qwM/IyErKK2QFmUu3Z53PeWpJEOERAfHYfvNS
         5VQaqPle8AYWQFq5zrdFmZtB6daEzuYAZCYLjxUoeh5H1Y2Nh38vTXdLvZOu49Wm2eOv
         TtK2xcL7jTm6EVGWkabs2odqjw38JGaUxuCqWYDwsoc50Cv/StUF3XsU1AdZ17NvuOLx
         tjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707310358; x=1707915158;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8eTrtHpcSs9t0JOIpfXXknaJu9o2ilTuL60huiYT4fw=;
        b=mxuYSlwuFyf+h4BBkKYXrUuwZtWlXi7akR4IsnG6Huy4kClyuVl2lXAjZVog2bngvI
         WTn2UiGLFV6fI5Z2syKdzE4kgLSZWocWX21Fdt4U6sk0TJZb5alUQjFIqQjahwj7MueZ
         aDA5uddZUARSDF2o4dFT2VVq6yVAvvM3uxT7yvb4+I5981/EzHO8lpNm2R+GocIaiue0
         vkQ/GQg+VT9kUusq6HWjwW1uKbmMcXtgpP/JPvauY2EeoVkzYo2yUhGRnzINna4/9e+T
         2Ocm0TTTc54beFfypfYQ7kzGec9B4nHARW3Yew7tduAZIj7LjxCismIKXiiRFbL9C/7U
         LZcw==
X-Gm-Message-State: AOJu0Ywpb+CVRJNt/kkf9VHRdtNtqeON3gmCLQDGFXJkEYZkO5jYZq2d
	cdTJS+Y6HZZs6MDXHQba5vKsab40l7iTB63B7gaf+Atn0JffRLrcGaRpssQ=
X-Google-Smtp-Source: AGHT+IHwrOFx+I3UndR+lcdyfZxAMaRabS9RVyUiq71yt2CuGtWbSERNHyRZEJCtn+U1FimRicUCEg==
X-Received: by 2002:a05:6214:1c42:b0:68c:95bb:b7ef with SMTP id if2-20020a0562141c4200b0068c95bbb7efmr7253203qvb.3.1707310357845;
        Wed, 07 Feb 2024 04:52:37 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.96])
        by smtp.gmail.com with ESMTPSA id e5-20020ad442a5000000b0068c3e010d8esm545031qvr.61.2024.02.07.04.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:52:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240207-mptcp-check-protocol-v3-3-77c69c596f55@kernel.org>
References: <20240207-mptcp-check-protocol-v3-3-77c69c596f55@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <eb06adad-5179-9530-fe3c-24adb0351a64@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 12:52:36 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7814594663

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7511efd6fe57


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
