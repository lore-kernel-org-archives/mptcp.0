Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169A7F
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715475643; cv=none; b=pqUcKEkQ5ZxA5BAVbY5s/WRMLCHsFUr72v5tEOEZT5Tt9mft/TAZifoyL7GJj36TDd8yb26tsyhszRW6H2VPuSzmonT0jfvrz6OXY5Lb3ZrsS371z8Ejrr9kHmakKMT59R5hs3kV8bMD4+0wmWqnqhldaad0bVsu50ibR91zhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715475643; c=relaxed/simple;
	bh=gj0S80gFxlgRvrPRz/J6SlYkvZVMtq7QtMK43I/uxXo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=T8uPNvJgHSZIiUvlNYBcglZMwFXLaV9Oc+jr3A5WcurfjDNZKx7pl+CXfalT97/tGV+3w0QR/M93uKgzdO+zoqvn8DDmlJRL5DseiDwV3WrxCqVfOWgRz3WLfelaJ7QEJVsk0MAOu//TvNr9LBpcpGTxmCLpVBeOmczACdpM2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aESeVn4z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aESeVn4z"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so2876127b3a.2
        for <mptcp@lists.linux.dev>; Sat, 11 May 2024 18:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715475642; x=1716080442; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBwcc/vdMTcRcaYRnYPu2WuZ5GUIV6+v9d5pXOXRVtM=;
        b=aESeVn4z8bku4MG0dvhx0ul91hwt3KdWAsSX+hIiky8MLAX6pBGI24ZJtk1Jxz+O4z
         M31iard+qBpN9lb+QnrIx//rZqo5twFwwphHsgXJC3e6h7o1AXk4c14uYWKnrQoQStIy
         C0CbD3clpHDwVvk7Jme282MNMmjWPYf3se5HhuZvts5i1BSZmCZ3ctvgNIxBZfu5n9Oy
         B2T7gRdlUcYNLxObU5MZQq6vCUbFF8KeYKyiRYWRmJ1AtIR1M0cov2bJQtr13tSdM+q1
         bme+e5vSeotAr6KB02QyV7HtXmrLYRUE0X7cNjd14L1Sb9ag5ydoibphV+7YVD4y0+NX
         py2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715475642; x=1716080442;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qBwcc/vdMTcRcaYRnYPu2WuZ5GUIV6+v9d5pXOXRVtM=;
        b=ij2g4jbmHLo8qiZ03cpGFxokPKAX41HjcebyWxZbjDVCzOtHqi/cIV+D6jXuvm6368
         yR0nD3c8ydZlLeKpoEx/3FMOxp3JsvnWRYD/nUJGsgargp0x5KDKsN+i6IZ1iRpZaLMo
         fF1r9b95LRC4ZkqYvsAMy39A0ofT9GCC/UmnZBJbQu1QbnYCLsi2oZ/coqOwBsY6/JeL
         BaCIeSjAC7Uwy5yC6Ehuf5I9zJ0JwGhNdczKefMWY3vMoOgxyt7HywnRq0WVRHPPXc17
         sBCNjAG7A5zveajvOi4fjFU28GYReiUxeQuWkcjbB1FHRF56Kdjge/HtujKzA7q8QFjZ
         82Bw==
X-Gm-Message-State: AOJu0YyDlkGdZf1MyL7Vg3vdj+f9jsD8KcHQjd2APXvJkaav5NazO3dS
	YANXkqnrxGK5B+Eg8a3ORPnNBO672eLanslODVqkATFl57+ct0zkzCQY
X-Google-Smtp-Source: AGHT+IH/TLDTmKP7fZtDNhFv23RXtCMiOnn+7ZVzCpyIeTEvkPNChONmxF/TokA5Thh5ihlTBNVc3w==
X-Received: by 2002:a05:6a20:96d5:b0:1af:5d8b:87f3 with SMTP id adf61e73a8af0-1afde0d5537mr6810042637.23.1715475640050;
        Sat, 11 May 2024 18:00:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.100.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae1193sm4977649b3a.133.2024.05.11.18.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 18:00:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715472312.git.tanggeliang@kylinos.cn>
References: <cover.1715472312.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] patches for new MPTCP subflow
 subtest
Message-ID: <377f8b6c-a9a2-264d-ecd5-1448809a3554@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 May 2024 01:00:38 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9047431345

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/01fe0ae173e9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D852600


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
