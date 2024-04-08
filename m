Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA894A3D
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543322; cv=none; b=N5BN5lmdhKH+Sp3+fjujdTkKgF+9lby1XISG73jrU1lGseXw3zmh1vtlyTPXkaeqL3ULdONXs3t2jyGjAHblzO0S0nRgpsCMdmYOhsKJGNwQitZOUQPDw23pJm4s9aoD5YqwFvGMCnTAoJgWjvckjzsRhWhTe403fDC5oGd9DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543322; c=relaxed/simple;
	bh=wNu70L9V8s/OZuIv9XEbN806ySB56BGT41Jw3fV4SXw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XVM0Ae9c0xNem9+73vs3aSghrH8ZJpsPGflrJ6J4LamX6Tu17P7RWceaFOfIq0JbJIxw4aWXgCQWNgGeWMdymuuqqD4YbKStECOKA5c/mqT0Q61JWxWzwfhv0miRK0p03i7mXkacBiLqAMBTh+zUE5PGHpaqxRQMx1uDLoBNCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyV7jqnj; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyV7jqnj"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e6d089f603so2663320a34.1
        for <mptcp@lists.linux.dev>; Sun, 07 Apr 2024 19:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712543320; x=1713148120; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWK+GHrgqkRNzqGg4eP6EIyzJrZGmK1UXmMDhK4L9mY=;
        b=HyV7jqnjoRbGON0hdt6uBbzWGe1NjuWRFhyr5f8XYMMGjfIIPFcAERJQnzemG4DWyL
         jRige3q3V/3R+UMnHXUIXI1/UhwzUcUzdm1DM1BGFGN5Iis6nbXe7mFxD9u6vDwxQJkt
         laYKIV5I6G+WK78N6hG7USw1te3AZmByQyqKLO73vrKupr/tkx4HWOzXdf97j+A6cgCQ
         LfXNHFgyucZD4NAf2bUcNKSI/cGe00lArZhnt5Orsk3LpHk2Po1HTmBiFFc/nIXubq7N
         arnmliZr4/YS2cC3iEkp/1D3nGbaRy/+HOrs3IACFDLUZOJ0gjohtvwTUkLuAMVkRRTf
         KWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712543320; x=1713148120;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWK+GHrgqkRNzqGg4eP6EIyzJrZGmK1UXmMDhK4L9mY=;
        b=h7CfpisYzEN1s4DWmYeqeZhpXRdIsh8myzF0Ep0al0IgSDHT64zOh1QEUAn2zNpu9Y
         WcLKGmxJeZ86WcqlI1uZSbr9JI2pDzLWoGfKUCFomq6MjuMUVYidSMqGhaGfakC9GAXZ
         hGpgUb2VwBY8GnEhdTHKz0677eZoqZIEFdOPzS9IhZWyI5yT9YGGeI9tpkhxYIPfd6hz
         dCqRv5gNURZgCYI7gnznWHCEWSA/nTYnqq46hemFTWiBa9E+Q/bsR/wmhvSiVQEjUD6/
         O0PtJVV4TcS2U792dPwUN6PkBhNAHrhL6MUvjF5vQQuLG+cbTmuh9S7boBmflU4MgWGG
         BWMw==
X-Gm-Message-State: AOJu0YwZHuUSMgZpZ52OHa1Lj1HExucgkMGQ2bL7TkCVHA+thwL+wLsk
	+/fhTWTteil0LAWa9B//OVpgYkbkYAjnoOXXtWaB+TKw8xq089FJvejPGCM=
X-Google-Smtp-Source: AGHT+IFaM4flArVgWwJe4+irxRtV9Mh8ClxbMItMvnGxuzomlAuFtJzCZRb707jCN72NeuhUTakDjg==
X-Received: by 2002:a9d:69c8:0:b0:6e6:8070:abb1 with SMTP id v8-20020a9d69c8000000b006e68070abb1mr8158510oto.23.1712543320125;
        Sun, 07 Apr 2024 19:28:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.142.96])
        by smtp.gmail.com with ESMTPSA id e1-20020a639a41000000b005dccf9e3b74sm4580948pgo.92.2024.04.07.19.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 19:28:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712539403.git.tanggeliang@kylinos.cn>
References: <cover.1712539403.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 0/2] Add F_SETFL for fcntl
Message-ID: <1030d892-41a7-01ea-2e06-313dcb0ea1c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2024 02:28:38 +0000
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
Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/859341=
2186

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/49fb69b19ca2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D842235


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
