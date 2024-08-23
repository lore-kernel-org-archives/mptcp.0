Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BF1865F1
	for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418976; cv=none; b=bi0osiwYFBW4eYqmvMtP/CWDgB41jFHszmCZ1RbSMcSQ07MNKL05wz04c0fzjs6WsqbdJyu5+8nsvKiv7QKZDKv7TqcW694LLIfTzZatUiMd5Osjemq9Bue/2mhDvX14GxG8ZVaP6L9gpuX5XOgiDq5WhFWgDRB8IxOcG86wsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418976; c=relaxed/simple;
	bh=JG/dvlaqq1OmgLG58PfdnHttZrKPWCnpyiC4meA5pF0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=N6EKlN65OL5pXuldkJpmY8zXy86dx3fV28YqxaSABoxAAReacyJ9Ccr2NcFexCiSB92eULvumorN0xgOUh25X0mQaqBchZ/Z3MWBSI0Y5t4mHiWNvbp69IiOazFbHwpQj+6t6lWLMjxpfanzddh56q4391IDaOEGLSXUfUCn+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSBIepEP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSBIepEP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf6755323cso10814146d6.1
        for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724418973; x=1725023773; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbdVGwlHf9PmR3KZ5+yQ+efANQwLjnvO2SVG2mVt38M=;
        b=iSBIepEPPGdozNgzwYS3f/x67t/UTz1mSUm3NhpStUa8eDNuWaFnZR4koklH4dlTEO
         lyN/E7AXVIxqHPcpGUYGzH/svrCzliGPEI1qUvoxbw5ms1ST0vFY7Ez/LS9FxKxt4+r/
         16sq+bgUzYOLWGTemz9Rpcd9hzwzcoTvFpeUv7r0/t+iGqgRwQydAiH3I9OeHK/BjFul
         WgrhJ3eIRk4zICqOdYyVscyf/JLIZXiqexHO44wZAhPKeFo4YpcopQxa1eT6ecgNu4oa
         jjI3ckFWeYzeUeokJwUinbR+QiyQRCVBNKbM0MaXnh8/Se8H8iCOru4rPvCN6Caydn9Z
         Z9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418973; x=1725023773;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbdVGwlHf9PmR3KZ5+yQ+efANQwLjnvO2SVG2mVt38M=;
        b=AcGwaDdDnKADC2czBhjasbSj5u/zozhypqby9iZVoD2YZnfn6K8CREvmfYHHnfS+RR
         OKHT053ZEkKJ2lJaevh2phGQowXNXYUyTxDjWH9wWwBx7kDCngNZMTK/oTRpHer5cbHQ
         g9R9xdqAy9TFampSo8XNY1k/dOHqxpkLZ6DoA622EtkREiSznS7GZSi5zGSq+qP+IRuj
         P3cCeKM5y/yiyVQ2PkNV2rW1Wc+fkRZY3DD6E/I2zGwffbu9pWFFUa20AbJMuYMUNuVl
         hUlE51qrXKfhTlQBmnwA944c24SRlkbxqVamy6XaJrQ76ofPMNnXkhVYWxETPtaeNDVg
         2gcg==
X-Gm-Message-State: AOJu0YyAtuXGJqL7mREhcKZSUkknUqDL8UqsHQDMA2L6ddKRPAVamK0d
	Bual4heONNC4RJqEihn5UZXyncaLkoS1KPV1ox4IrbsKYLKZxhznwv0r
X-Google-Smtp-Source: AGHT+IEQgRQxI+Q32XzDtg2kinKYhWbo8uWO8KHNkSnKEjWc/B5GpcoSZBUvdVUI44KeDUQJoJySUQ==
X-Received: by 2002:a05:6214:3990:b0:6bf:78ad:ebc8 with SMTP id 6a1803df08f44-6c16dc7d81fmr23444126d6.24.1724418973376;
        Fri, 23 Aug 2024 06:16:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.155.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c1627a1c9dsm18622386d6.0.2024.08.23.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:16:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1724415435.git.tanggeliang@kylinos.cn>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v4_0/3=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v4=22?=
Message-ID: <0a9f165a-ec74-3cbc-6b25-93b4c02966f8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Aug 2024 13:16:11 +0000
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
uns/10525835229

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8be9a8f01421
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D882630


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
