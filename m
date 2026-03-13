Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DE1DF751
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380107; cv=none; b=P6hPu5lF6RR/vJ0HX7cQwr+JDyAwF+3JNUqvst0z6SckvIdbZCkTL01/F+gaYpQ/RxpOdOlmdX4Kol92RKLwpKJGeYPOWMpYUx9p870x/4DLj5G5jLFZj0ewtq0nVQiT1z1q2IR1k2wDPjx8PBOgKYMnOW8Ym9eL/JUDkIY8irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380107; c=relaxed/simple;
	bh=I56/YVUdk62UCc0mcXC47aeoLiKK7Im+a5B4edHDcMY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DRb8LARPoxufbocWL2CtVcN+dEVSnp61+L/Wa4pESlCmLQv1fBZVQ+KGkp3U3MLlcS0jfYej4dJq21P6I+Jnr0XyZqDOmvrSfPZafZOScfZg+Mwlw0T+CPs/SyK7h6HyJAqiPqfRs01eGAyRI1JP4PJ438wr8KaGQYilvrSiFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/QpSHGI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/QpSHGI"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d76c145ed9so1908415a34.0
        for <mptcp@lists.linux.dev>; Thu, 12 Mar 2026 22:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773380105; x=1773984905; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl+PE/DlVnVSJopb2Qai384/8++fW3WCQseZofCVMI8=;
        b=K/QpSHGI2dGXNy417ibLArrr7q39xxac0o66vr5x/5CzRLihl/Syx5QWbgyS4n3Ysx
         eU754l/y6RQi9U6+jOMrk+1ni6biBuuXkx/4QbgBPPDINDDD9+uwd+2zy8mrSzcqdXJc
         CWYh5OiqxRJe954ecIU3ztXv6/Co8nmEJHCmciqo4tHBV3TYkcMl6dyktGhHBST9MGkB
         0cuH6mhoWadOzmNBHA8WsI/VjuXjUYJZ7W7wPuKRP47jMDRPDDkr4nmpdDMhrMW5ykFY
         ITgxiVHNg45g7wePpgd5Y5OKoE1yU9i8dzx0CUAbuTWrmr0GJEcpPYV3muwWAW795SJi
         niFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773380105; x=1773984905;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl+PE/DlVnVSJopb2Qai384/8++fW3WCQseZofCVMI8=;
        b=OiieNhvfdVmXkvijk5+XqSFQ0J5AcWzUvRZBnfrHEtMSryEAUqhRWUEu+Ood81hmLt
         7NMPBN89PJ9mXil7/bpW0h4DIh5ZPb4ZvhyOvmDhJVpzyAhyjswuR3eM1z4l4tBHVvjt
         rbmjEYLx/heidBk5zHLwmbH4eZWhGYxN+1JpkccQwl70vk1GtSnQ02/2p9o4XH2Ouu2O
         5Bk75LnSyBR+x1Tp+0FGJrGm49XHQGCs/vrQ62mx02dLF5HNimeg00ntgHaIW2i0MfNW
         3sRzxvrYE9uk+fE3fu8R2qDALu9UstSpQFsUgwvtc9pRPihRWyPQjud9FxW9Jw3cjzHJ
         7rJg==
X-Gm-Message-State: AOJu0Yz8Meo35hi83PZYMiV4FzoIzwSLQHGiY0LjDwjEx41QBPH9LBt6
	rEMvYkxjtXVT5Ry55G41FhDpXgasUjNH54U5LRIBjNeeA4tFw5TfIps+Le5x
X-Gm-Gg: ATEYQzxX2meaB7TDjUgXrBrtvq97af36qV1lQzwrIczpVztAYDODiZIzfS7+zqXOetn
	VSmmK6yzU/YZTuUpNMqHJj7nrY3qh47Dfmy13kS4fiYU23zCMQY4kfdTjFRiw8OFKn2uecXtOWg
	Af6eN4J9b9hhjdS1WBxp2wEru/ERlD+4LZFAvs1cVGtlwNoKSBZeDDUDyVZ+lZyQTPp5JaC8Hgw
	CualJydMfNGVEEFIAQwRFw1/skQvnMx+OhnNBsGZR3dsrT1w5Xeful9WWiwjGAq99v7fO+oHZO7
	dHNb0q5azbIspg7WcN7zIIFVax9LiNdvqRF8/2I6GTcTg5kt2p4K5LTWqSvtT3cWTRrYCWQHYdw
	3YwNZDqdle18b8Xon66mLRZq2/kBVO4Xh1+oNg7TTUGeF7HQnPHeTmxQAnUdBE+whKjL1S71cYA
	didyyahXKaji7uAwSCuX1xy6vKNJjFavyDvLNR
X-Received: by 2002:a05:6830:6f47:b0:7d7:5d53:4044 with SMTP id 46e09a7af769-7d7824c628fmr1437543a34.11.1773380104626;
        Thu, 12 Mar 2026 22:35:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.219.146])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d77a763ba8sm2893755a34.2.2026.03.12.22.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 22:35:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773374342.git.tanggeliang@kylinos.cn>
References: <cover.1773374342.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v5 0/7] VME over MPTCP
Message-ID: <ba742493-12fd-e1e1-ea5c-aae4d23dd8ac@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Mar 2026 05:35:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/230364=
13935

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/329e3a240299
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1066056


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
