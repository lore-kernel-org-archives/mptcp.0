Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC524219
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616094; cv=none; b=FJVN9FLOXbOQ+fLrpPx9OJjoi8RSmzHf3d0SkRb6IDRgrGMjD2l52rSxITYtkuxnVvqAS77yuK0XCFxMs+0tdWF4kA6uvZWeMHPp7mNmk/GY6S5bpG+3szZWZUVxY+/MK81SSnxooYMTfUTsVKylHCCrsKAcMk35iTvr0RXKxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616094; c=relaxed/simple;
	bh=/z6kHTbyP17fXn9magSb54zGSYfv5TXZ+A8hi3bp3YQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TK4qk11PnxB1B4jCWYvNm4nA/zhKH2DDACpE5RoZMAHLPN7AxXz8zGsud2dO/bdDr/G1f3sRCoWy6HA+bQbpLc52e9sXiMQAeQ7MoclxrqTZy9Xb0URUgqkILvGa7uBGT9Ouik8GAiMPYN0tRSwH/fMt+laJuiY3yIb3W7hhsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO3RTVs/; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO3RTVs/"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d43c633fecso306349e0c.3
        for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711616092; x=1712220892; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZckM+c2K9SabHOIxgwD5jPQMXF02bDMFfyI1igoT4Lk=;
        b=BO3RTVs/wvZofDrbGhLhz5pD9EgqnIoP/9RrusFPrIQTnDmFVaAv4ilw4SsrVf2ccR
         g049erTfKq1n0vDP2+oMyaIeihXw3NXdJStnVi2yx1U8LSVYKuerbpT5COm9vVzPbfLv
         uKQGIdTkWRZfMxbxNHP9qRCwPUGuC40KiZJWvlXI9Iz/6kCYPcjOD6UJLyOYrQ/rSpVp
         hD8IXVxOv8mJm8otybbhuWomFwHC3QrX/KyZpFNMt337dM6+euRUVosYcZH2ihTPfSqJ
         CtUm/bDik/r/m+hbYZqV13ETreMvMi9ppJCrWhnf2Jija0b1CBkojvhgWY85z9XZaN5t
         LMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616092; x=1712220892;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZckM+c2K9SabHOIxgwD5jPQMXF02bDMFfyI1igoT4Lk=;
        b=nmzbHNb8b+ZMUkIrrqr/0AOB8Z2apJwxd7abdr2mLoIA/UiCGjMlG7dmAtuxM7Rnpu
         rmlM06urtWC8F0cEDDN9ZfRQS+IgCp/TB92zcQlCfUHwHY5TBEnAKDw57w3Gqkb3Pu64
         +ROEmGVRKj+k7m/uXmf2SO4SHS/ybwH7CalhkJ1Ll3xpl9SX1tUbGETgDIeYUEAbHxah
         s6MYzxfoZv1FNTsZxJ/rhM7IpgzmA4svERcIWQC50HYyXJ0pgC4QlnVgmVtJvVRD/CCZ
         0PRwTIEfHDdZUUFwFjQYIyeug7EDBQxb9oKme38wyiLhX5loLH3cNAsYVuqTN7JXjit9
         /MVg==
X-Gm-Message-State: AOJu0YwUyVbxMWqHzj9fr9EsxK635OV0hOfu/o4dV2iidHBicPH1wgfC
	Egl1LVdu+YTynyZU5twJAQHvmp/b19MS46hQJJtlm4+0lpt64H5q+902JUs=
X-Google-Smtp-Source: AGHT+IEOb9PWZHBQQTq8pI62ZHIENqoA27NcIHBHvcBSG9FNJ0+PE0izpejce2GjLMu9LrhNNjMDPw==
X-Received: by 2002:a05:6122:17a0:b0:4d8:7359:4c25 with SMTP id o32-20020a05612217a000b004d873594c25mr2631151vkf.12.1711616092068;
        Thu, 28 Mar 2024 01:54:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.74.1])
        by smtp.gmail.com with ESMTPSA id qq13-20020a0562142c0d00b0069795001041sm459380qvb.9.2024.03.28.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 01:54:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 00/14] setsockopt per subflow: BPF
Message-ID: <38a5d246-8801-9bf4-5ab8-cf72bc9987af@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Mar 2024 08:54:50 +0000
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
uns/8464381916

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7c2febf58552
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D839219


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
