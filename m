Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE521516D
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731018; cv=none; b=bbP6uVazgGU1Iyh80xPD/UwHsimq3N7GfOjk7UzW6HubcwpCubQqnn0ml01doR2pvpDnvzXrRYSC8nGHslyUyU0nb/f+998bJWuXkuONk7nHDrtFDG77FKe8sF7XcmCqsbRGaAyPPI4lw3r0quW/C+5yVyNjsOIxGiDdhynvfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731018; c=relaxed/simple;
	bh=zWIVHUBJORZQptdK2S9aBMKy5rMcf/WWOh2LOmgkIBM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=JT9eicpNMvAfOjlmqLuEYn4xPTsJMN2IxGsVCMBXoMRc8CNArHYwheTYeZrwoO8CVY8LbTBRGyUZLF6KrK4kGVpACF03hORGSKeFl36fBQPO2ZaQ7gA67M6+zPa2T5PJ8v80OTrtAhDCP0M9r63MnKXkkIuSEmBwDe45ErU1mP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KedbV51U; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KedbV51U"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso1020527a91.0
        for <mptcp@lists.linux.dev>; Sun, 08 Dec 2024 23:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733731016; x=1734335816; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjbEGnR7ed5BT2qQmP5H4pWojWmwRARCb43kXB69rY8=;
        b=KedbV51UQ202XNR+XZSTWPb/iCrvUnZdxAWHoQq5k4juhJs0o7FgeRQD3vacB+0RhP
         rm1uzmh6msEFLtMp+jCdTmCWJEw4nQWs9BYJGBA64YnhNzgNNyO/U54o/yOBIQpZfQLC
         DlnN+QpQTPuvCMBvcZ9xYNGkVK1i4YdR2g+ARwEp4zMDwcI/WgqBjxV6NDIdd1L+faS0
         c4C0vm4Zixqc4zfqXcCIcIrSuBeatSdYu5I4uvWWpIJfmDoFxUhxpzw/RIoSZT0b5loa
         PbLjUbSbSlTn7oGD4mU/aX/sYaElamFJyP5FIqKKF5fpjCVkU8ZyJi2/L10bU5OtX4jn
         yVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731016; x=1734335816;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjbEGnR7ed5BT2qQmP5H4pWojWmwRARCb43kXB69rY8=;
        b=h3Bk29C77EHumjgyquCaTAflsTXhnybxhrOPqu7u1yTzmtk50C9O75N/BceM1SJvDc
         CcEjHG5viHPj9vbAJsiorB1GITGoPFRGT3IcEcFBJkcuFgLcivmkwyGQousnvT36Ca3C
         C9jwkM/SVQulFWGLVX8v/BV1G6mu9H5ysR2p4slGDJCF8JkvgQ8j1gkkjVoSRthgpi3H
         8TvxEutLj3W+IBm/XIxYElMYihlejAeYdAEkc2pPVJsaGjQLBp68AR4dCQCro72xXGK6
         jq8GG6v3SzqLSNvgM6xqC4imJmY0cLDaEVDdHfDMCpB0veQ5vvKv5zkXAjSSOAWdmBKw
         cQAA==
X-Gm-Message-State: AOJu0YxdUaI/XkT7dcH5lQ6LbV68GTVG2kF0vVTbU6ianMbzvJGKh3L6
	isjqR2o9TweBYV096/bKz5L1x/kqwwNCqUYEO4mY+jY9oUzwQeRJ9SEo
X-Gm-Gg: ASbGncu3mT3zZbJKNb/GqCVc+su8gSmhj3vBdvrBy4w0TMATX/2qYNBZKAWIS30pzUP
	LpoUJrRD3YZd9gaurKSD3UNhAKZSathRDz/Tdeo+F3Ly48+4JCbekb+h7hqd6GFfQIbK1jBueIS
	mvIPdPduKhEpCVRaM3RhWf7l5n2HJWZM8XA3D2SL7ScAhoUP7skCohNSzcnu1X8ar3qgH2wcssb
	IV2EZD1dww41Be5tm7E5udL7ii39dUaxSc7JGHnwWAWzZocpJZEaNuTEXRW8w==
X-Google-Smtp-Source: AGHT+IFcALw5faFmQ0WAVdXqH0jn4EJK8a0z+GqDGv/wnCmJM5/AgC8v/pXMw84WwjBOMMrE1G9Www==
X-Received: by 2002:a17:90b:1a8e:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2ef6965469cmr17318359a91.8.1733731016460;
        Sun, 08 Dec 2024 23:56:56 -0800 (PST)
Received: from [127.0.0.1] ([52.234.36.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6aaf8b60sm5687657a91.8.2024.12.08.23.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:56:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733724383.git.tanggeliang@kylinos.cn>
References: <cover.1733724383.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <991ca591-bd4f-e7b2-a3f0-1c2b162b48ac@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Dec 2024 07:56:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12230234356

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c420a7ab2b44
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D915780


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
