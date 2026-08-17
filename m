Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6226296
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943486; cv=none; b=FpaFnUlpRE1VHPAP/9cEKLyKrFrMIH6Zxw/amlPo1nN4albv3x7uK2ezYL6xFF64c2ijNAkwx1p9h8CtX+Bg8u7/Kz3vq2W28m7pYl5LB4e/yXjUj8CH8ChhDnDw8jsxUzCsMM9AJkvrvpNP0KxQeYqh+zCr0LEn1G+9etXhB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943486; c=relaxed/simple;
	bh=4uBLu3iUMHjHw6LQlYa3GaUD0TsFmIZ1LTI1uMLX1WM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=tR3oghYb8Q1CXOLw6gNcCNN8lsBx6o88FNRp4YBSVqnyq8PIfsedcpIn2gcXyH7sguvAelhvVnTQX+Mbw+P4OhcJsB/JeKW2eBTJserXCzgEUnGNkGIB7qZRZg9Tr7psLZHgl1W6WvPs0NNo4pGeBhGJmLqWOyQ8g3qo9cTNdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBI25Wy8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBI25Wy8"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2a76536bso29266121cf.1
        for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 22:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786943484; x=1787548284; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V6OQU0wSK8ELQeFSO/a17Fv0OFLiKS3RU+ido2dujEU=;
        b=CBI25Wy8X3bE6huDPZatloraf213OWkpBV9YL/mNJqo29EFuQWN1uP+ccLM7L+z++J
         6PyhnRXofbuIOEx20TwjYjAMVx0HR2Ewhp4GfdAfhK1IBMCRYQWWHXGvXfmzztaFu8iM
         jMP5A61xGnIHDWHGcwKq2kVDxWP9/pVTZy6nc9iZUL/Bk5X8NLbjmfSEcG3l8CdL6GSP
         7z+pSWRosyJ2rpTlGpJz6yvfwy+Q8zF7C1RK9tmaK6CviT7uWPmu9koKwZ7G1+UGFrp1
         kbd9tSK1VFanN0fzjci0shCQEqwGcWpsdx4S36sOA51VNJRxjWzdeQz8NiCd+OLMM+jr
         NOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943484; x=1787548284;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6OQU0wSK8ELQeFSO/a17Fv0OFLiKS3RU+ido2dujEU=;
        b=Yw8fyk9QTbkodqRN7beOR+lSADgW1NiXyGa4VhzO+icZ4/B3BM/Gg3MP0O4lc2JIFE
         T5fRiudT99TOTwfro5pQRrqrIggAQLI9vRMInL34CG0Z0/jKP3dMEDPgED4WkXvDc626
         1abeYs5wHFpc5eyFfiFpRpDhE/CcUvScbJLWPxpSY1byYSpzCR3Glu9bc8yLulYD8bLK
         UWuyxHOm2iUGvkwA9lGjSO9N+Hzm8lkUlta2dHXqviEPND6FIauUOwO0AbE5esl1+hDv
         NEoYi+Ul+Z1WKqgEFmK5JaCdFu14qkZI33qyThLVs1jFbPiPkywItveoHx5Szs//bSf+
         xgHA==
X-Gm-Message-State: AOJu0YzNTw3IZSEm+JZRQ0Qcq9n+1YRlY99k7ajDglF2FMBCPGx/YwpH
	f6vPGYKD2niJ0PukLb1j04yE+pz1gEJM1cLeesLfkiEALwo93mrSjD0IUL2RtzM=
X-Gm-Gg: AR+sD119bZ9BDnA4OwkDQ+hNPWuQiQSlQwgFrKfp5zkYCAxvW1Ji8sePxEqmZr65oH5
	BU3FHNvlQbZDa6Q2UfOeUFmvdElr5ONZThIqUottu476P8QqAQcbgLbAmNdxtdqlN8maxChUWMU
	VP4+Y3CpHCrQKxNwVnu/93XnsRm6caGhLwkRN8jewqEa6aVRIj1n/IJb8/rCAAcUNirASemukce
	ZUSOerv2VpLD8p+h5uqwEWagO4Y8wTKPPrWsROjZ4ioVUWzcHO5zC7uSyZPLh7iEOxTyXUXcqSr
	tvs89c93mO54rgYZjGnpVnHm1B1smwa+s42cL0zOkXBQDBfN5Dbazb8XmpROrGZS/CMI9oLic7e
	kmDc4bq7XnDfFghSTunenecsrUPmKwfrZg1IuC7IgWzSiYApTueQWShsUSH/xYtH/KME7FZbjke
	+4wU8gt4saE1iOVwUcxopXdXZgB05oQdb92JoTLY38MrmtXnfYOaUMBDc65fBGJ7pGey47ZdqWp
	bOK
X-Received: by 2002:ac8:5701:0:b0:52d:7b1a:d7e0 with SMTP id d75a77b69052e-52d85517952mr234300711cf.32.1786943483604;
        Sun, 16 Aug 2026 22:11:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.253.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db612bbe0sm5577421cf.10.2026.08.16.22.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 22:11:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786938892.git.tanggeliang@kylinos.cn>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/6] Fix socket options used by NVMe over
 MPTCP
Message-ID: <cddcbdb5-b4ab-b99f-54ae-ee6cf8fd8cc5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 05:11:22 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/319942=
06151

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f3f2396df333
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146924


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
