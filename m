Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F19363C6C
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782969282; cv=none; b=SEruxGc4Pmz/EjeHnI735LsAU3pcMqBghcRshP2FXPqaveRPW87fb5cGz3EVIiYsCXnXjqOHIwLVh7xZVvc7xguJCgt2u0q0KnCbLe3qA+JoZgrj6l5aMr1YVsKLcrds8tt8yRKEgNTI+UdkPJ+iF8pdPm3tpsuDv8gmkuAQwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782969282; c=relaxed/simple;
	bh=FRJxPhZ5wmNtGHbXY+OiT39evP0DAIXqIi0D81x9+Ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=TcFZZSuQM788gcpqmhAqKsv9OmqZiv9EWvKFn/ASVKIRh0f8pd2SpKJO7H62ZGA5M7zT2tDDzDuyJp2ZNlYxkLu2j07MTfVgGBJx9kBk5yYq26vyiW9ubwY8W9XTqchVSa6yv0pYwL7zVpmtRfCW2WBJzC8XFec4WQtQR9LsAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSX/ybo7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSX/ybo7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ca1479dfe0so12554025ad.1
        for <mptcp@lists.linux.dev>; Wed, 01 Jul 2026 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782969280; x=1783574080; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxJHQ2jpd+uokPObiBn7N4ZyfAlubJoAo7hwy0tk8Go=;
        b=rSX/ybo7q4nkh5oqc4cAmh85mouRuyR1QKnaWOddmGlfq5S2oWJtrc7BtuZVJtzhnA
         vWJIqKYA12XjbgTGtcMgxkczFSQsWe6LvDgRA69IU0MYb6zI636iKZHwLKcVMJS5FJIg
         2GpR6VDrkXXYVHOY3xAtGrehmvg+jRmFvwZ8lESQX9F3F51/DBSdfQWuG88AFucVDaGK
         U002+fGYhx/doHQ/OoYrCIo131lLp771nHnbkVu1TZj78w+dzyWQJQrM48IYitJ+geaa
         GizKtqZYErh0QOK7RN5d2nPgSRqHcmHsXUXCBZRwbZTyN7S32b8JPnEzZv2+wmnjf5hL
         R2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782969280; x=1783574080;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxJHQ2jpd+uokPObiBn7N4ZyfAlubJoAo7hwy0tk8Go=;
        b=O89MupWizzUY8qTyzP2RMlV6EszcKWlxY/ZInOnOHfENtGiiZUVr8wUuNEigTQRRtO
         bIycnBgXX7he+OMf5GLAUJLuMY208Vo+Ke0llmO82rjb/JWH1Bp93XvGFGQUFNUWwv9j
         RrP72/TkP+PdXZ1NzBeyBz1BAfNksO7WXdStXwRQiXGXweVihLXMY2qztyGz0pI9fo1X
         Ag5hQoOcSJt5KaAz981/S+FK2ROIiSVmnrQvM9u8GjWFfgB589AiIZQY0Ghji3wTerDd
         YtLV1YR8G82baBFkjRe99m/o1DWqqw7zcP86Pxm5M/AOF2Bgi7DcXb4fazUB3Nfml9zQ
         E5Wg==
X-Gm-Message-State: AOJu0YxXBw7Dx2Vdfs8QwdnsLFp7VM0kIcwmxTtogin636cSXnM86s0m
	J5T5xDEdjdaZjewQY8UYLHDJQ0tpMTjNzCGdsA7xIRcDmWCnOB//Ed+3e6PK
X-Gm-Gg: AfdE7cm5tcDU2U21WRL7FbwR0BBRCKvbUw7R2b4HbWv+yE79duF6DLoSVitq/phMh+9
	lj2zXK/46Z5CnGIDaweoszsyFUsITSjvyKjuxIIKtYjsAzvd5VfNHYiysH9/+Mj+djJFptWGojr
	af4nX5ETxBcQIhHLtIWIMJ/j+PX2zfYZYPx04D3GCGsd3Wb0KmH67XQo7xAe2fKCLTCaXpddwH2
	jl5/BLwDeEweQKpf11U+yb3JkoroiOKm4qSKFBHyPeWZCiWrw50oolI8mCV9ntHQntf5+WuUxzW
	M6IGfPHAVB8Y3YFT0MTiRIdt4YydusSy96QSMPUVA2FgRhLupW8DlXPcG0/vD+Ux2lCw2vMAk5c
	KJsHjtbz/TOlSMChJhC3njoP+TL5XFjgjfINsm6Tq7ZvzqMHAr8xeprDwewUf1nZPTNEqEN2rwJ
	pWslQP6alZ+e8JnEBTHuyY5XVjIGk=
X-Received: by 2002:a17:902:d2c1:b0:2c9:97a7:71ab with SMTP id d9443c01a7336-2ca7e907de9mr51860005ad.38.1782969279510;
        Wed, 01 Jul 2026 22:14:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.244.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa00970sm7567165ad.71.2026.07.01.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 22:14:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260702041118.2193877-1-yijiangshan@kylinos.cn>
References: <20260702041118.2193877-1-yijiangshan@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: diag: fix stack buffer
 overflow in get_subflow_info()
Message-ID: <846e3c27-2c59-641d-b5c9-4890ec0be352@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 05:14:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Jiangshan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/285654=
41751

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/67bc102495b2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1120219


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
