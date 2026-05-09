Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A238AC65
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778328285; cv=none; b=uRtDyCzaUeuchfox7dL/YnXWxKzOj51+LkGYcZ/hUT51P8YL2X8xyue4HoiSrEWJuiuQBjqh2a7FaHuXq4g+Id3pZS5W55AF/SfuZCBk4tAn9El6UYOjcRjNLpE+XQ8moJqNIp08SF0gn1pMOyqh5FFU3NpOLv6CbhNXOaX9IBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778328285; c=relaxed/simple;
	bh=PwZ4n+Noh+TFjj8V300uJX6kKPj8Wgv6yb/craiaOuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=F+/BSA8fpFjhuyUdNAx8w6GYFjAdd0MBHLe0eXEmU1Hjsrn9Gicq30ZsWfVC453reFl10cmMhkchE1Xrgw+bCZ2HDkHCYr38rulOosIIGCHs61B4EADev6it0c2HoKfxFO45A0oNHeT+nJkoMT4wJ2sO17Fux//1I6fJVqUN/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0mg0jFo; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0mg0jFo"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e5eb0fabaso28750231cf.0
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778328282; x=1778933082; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8D3XTW5TcDh2eVbEfWeQd9ecd6QIyxi/FzDTMAWG9Q=;
        b=Z0mg0jFo1wWEUnQRA3GWqVu8cSfp+dTLcVVxnoGe7UkUcotglaPQkd0A+OdUWredpr
         11eua8V0uj6Pc48Dct8m/FVIOW7h1t1IJXsMJrjwxXZCinqCkpczAW/JR0tYaO2EzGmP
         X2HNQVaIoYOskFz8FWmTTLrytL0PwuM19O2+2yO4anVDdkvrk36SkrOU6TI0oO8CPv81
         O40bJbjOnhGLhRsZP1Yb994/BhN3yquV/8BWrXWSOwU+4+2hSYkmHbr7gyhyTFOQqnBW
         kwmbcD86sjxeODTuKyzR8xxFDNK3MnRJi4hXub5vDTQZvLXl6HiaevtQNJsLYwziQCcS
         UUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778328282; x=1778933082;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8D3XTW5TcDh2eVbEfWeQd9ecd6QIyxi/FzDTMAWG9Q=;
        b=S4TBnS1sh7sZna4VOarOCSg/fAtOFX4dXQ/Jfv0wdut3qTDKi7qEbNFUMO5L0BRxXs
         m7ct2Ek0r564FSXdR3nPYcSvJUUVS+LVBQBE1By3WMZJY+eaLcn8h4LwbLh3W7SheOjl
         BLMrf9nHgdw/GbRb3NZ/XZMayuBpCSOSkELRc6rap4qSKDaT+tCOq5HiJfocqYe/WNzF
         PoGOy00REbN63zR85uUpa4+zTknW5cbKZRw0ZMq9nfwAP63mVDIZGv7twjx3qABMz+/e
         YEpKE4HQPMl+WuYGU88pey5qm9YVWtp9z/9Dxy45Gt6WpyoZZqWWspjdyq0Lv7JZ+09/
         FjQA==
X-Gm-Message-State: AOJu0YyuBxK4VY9G/V/KE4PgP39HMNffJA9eJJJ+tWQmKtRIi5f+KwLy
	5nJShtoggaT+uw7avOprmjkIeXl+82xZNBAK3gj98fRhfEVy1fFp3VsrRKvf
X-Gm-Gg: Acq92OH0t91HKpLs8yMfhKKZ0Phv/oVZOeqU9nft0EuY4KP/76uscJJvgv/2Uavq5oZ
	B3E+0Eeyho+xgUAxlY1Db+XTioqRspFhleajZvLKzD35gM2X3GkXOBsLVk58Xd6dUu4s6SKoWlA
	IAaX0aogdktKpmy2cDnae2BcY9PbCEZ/xnw/5W/BjWRKLt7jEDqIZQUtQMl/WucuWUJ2RpqOHRp
	Dfujv7pNMjI9iGpobFWJ5rOsRy49qDApeEc8vPkla4vHGZlLU51SvRf4UIhvZ+sBTEukp7av1kK
	elxaj0m0ORN04SoXxPGCnVzkFzgkvZwgY0p2V0KOLT7wyiASj5b4wqLaQMGpGTd4TiKBcgydxUo
	se8Qx9KplmcUdvNvznlxAq2TTjRZ7Xmg9l7hIc+ck+u+6gcMmRiCUKTB8YmdwvLNHYM2Hzkyp9a
	pV0JOVx+bO/+Dcn6K/LGIyQ+9L0cJqclUDkkEuI+FnKsdg3wwM
X-Received: by 2002:ac8:7d8f:0:b0:50d:b33d:bc6b with SMTP id d75a77b69052e-51461e508famr218404721cf.20.1778328282266;
        Sat, 09 May 2026 05:04:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.214.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149f5a6484sm18620791cf.1.2026.05.09.05.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 05:04:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260509075629.217791-2-cuitao@kylinos.cn>
References: <20260509075629.217791-2-cuitao@kylinos.cn>
Subject: Re: [PATCH mptcp-next 2/2] mptcp: pm: fix extra_subflows u8
 underflow in userspace PM
Message-ID: <06720156-ef5f-50f3-2350-eff060baa0d8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 12:04:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_fastopen - Critical: 7 Call Trace(s) =E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Critical: 2 Call =
Trace(s) =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/25599734872

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7b80cfe32ce0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091955


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
