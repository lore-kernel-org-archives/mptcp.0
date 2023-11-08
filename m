Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520D3033C
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVPQliJn"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-779fb118fe4so453090585a.2
        for <mptcp@lists.linux.dev>; Wed, 08 Nov 2023 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457079; x=1700061879; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgUuwZXgMlEcLcR1OFyHZ9iEN1yA4zskvAviB9/9BNE=;
        b=CVPQliJna1sEFFwDGhvJZXsQ8orxy1U9GZUrHrHRnI8rHVo/xlqKYLhd1vTvbkFHlE
         nzm/liL/PThNrn+O/LyATNktDBWLE0hHlTIqIWaJNpg6KD5tdD+iYAsYpzVOxWQF+Uyy
         6p7tFkW6qEtSQjniv7vPfSUg2O07+GwSLHd5M5k38C3nJMuTNRxbTtlPt7J+pUC0S/eE
         /+3uK+cJM+6mcPleHQxdm9KVfOGvgswz7dRwtg3Xzlk7j2WViqxIf3GFaRJ/AMs2aqxJ
         B4gwYRfnLhRrIlNNRqAbNatB2D/oLZldtH/gJqeq2KJAsAnV1rLM2xynYkkCvWxv/bns
         bYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457079; x=1700061879;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgUuwZXgMlEcLcR1OFyHZ9iEN1yA4zskvAviB9/9BNE=;
        b=fcp+LaYjAc8c+yq88efWBsqpj+kYExR/DSA7XlwcQ/8buv9kbIF/n7iA4Pjl45EDmV
         tQttJhcFvF3Rc5vzB1otfcn7JvNUDbsini6LMqpg2JGjPdiyWkv4am7+xlPrFvuQyRdQ
         20nwBeJQRlHpvTtB1SdB4Vej7QOUfkymyM0FWwdlq/GA30hPUXNo7MoieK1LjxHOGb6f
         DcPEGkh5zZBNgc/1QhFpE962fmBl9j9J/NijFAYgtvtTTncupz5tnHMjseN0uzii2Gqr
         mHjeTwo7MOZoFMVtQ4joJxCfo1qbnB9jC++/SODptOrN1BjneGVi5Z/A19ICbFMLrUuG
         Dz2w==
X-Gm-Message-State: AOJu0Yw0P2juSoEwAw3PxFgbjAyNkxwbXnUFw2DshDBFhJ6SaWDtBOBZ
	wXRJIjGbpJwmoscwhXKmvmrytcc3+g==
X-Google-Smtp-Source: AGHT+IHi9oWu0A988nk72Ub1V0cedlmU67Pss98yMe/gWxkXX1yG4SwgljwHhRxT1F8a3cKPckJpyA==
X-Received: by 2002:a05:620a:2682:b0:775:7d81:f8bb with SMTP id c2-20020a05620a268200b007757d81f8bbmr2176980qkp.11.1699457078822;
        Wed, 08 Nov 2023 07:24:38 -0800 (PST)
Received: from [127.0.0.1] ([172.183.51.126])
        by smtp.gmail.com with ESMTPSA id qr7-20020a05620a390700b0076d25b11b62sm1151384qkn.38.2023.11.08.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:24:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c440fc3867b134f0dfa76c347d7c0c8bab0d8ae.1699452144.git.geliang.tang@suse.com>
References:
 <0c440fc3867b134f0dfa76c347d7c0c8bab0d8ae.1699452144.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: use KSFT_SKIP instead ksft_skip: Tests
 Results
Message-ID: <4431a80b-aa29-5215-138e-8aab26c67b44@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2023 15:24:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5522582133276672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5522582133276672/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4607788458967040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4607788458967040/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6648482040119296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6648482040119296/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5733688365809664
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5733688365809664/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e0e958ff2d39


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts =
(Tessares)
