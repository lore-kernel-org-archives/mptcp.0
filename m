Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507F2C80
	for <mptcp@lists.linux.dev>; Sat, 16 Oct 2021 00:57:08 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id c28so10338547qtv.11
        for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 17:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GYtKpefEmSJvlcdFZqBR0/41EQwN8p+6Ny5o8iS2DuU=;
        b=KK7BknLMutAEyKig2ZV5SwdmKmF8z2/umEOPPm2QP7Wx3zjxzcRdffbjgZp1glR7C/
         Gr27srKFbia1pVyL2F0Fz2KryHbrozI+A7eJqJ9uGNNuvKxGXrSPnW8P1TTc1UKp1M6Z
         61lJJB/yUBqU+PXfSKwWhGkQGfXe2Q+cmbcx9BApBWoqzVlzr2zfb4D+JjYLf+JfMzAN
         vgQBEf3AGyPEvtANp5v8UAryWii3y30rwAAWJyoBcXTqCtRp8sh5aqkz9hVrmzJsswzo
         H2wBJVf4/oHmquhsWYPg1DXOBptO4dwNBfQnKg+UGKPBg9wXzBQkrYGzbrx1+paKNnCa
         nzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GYtKpefEmSJvlcdFZqBR0/41EQwN8p+6Ny5o8iS2DuU=;
        b=LuiESdI18IJGASq/K1IJrkmjaosBmvT6Vj1bJRfTdhyRlNpr08Xylj6QpS2CjUd/QX
         Iswy2xNlYmWJ8k7rW2OV2pXFikthReYKE4Qc6+P0TLTIA1JAT5FuBtwuKXqv4HpPbii/
         fDNmJAAvsaCDnpTyT2svZr/Du9cZSyHLa66EzhXDGeS497bgUU1xD4SRQT0/uSGhjLi7
         KYJgl8GNMS4m9VrdGQwKuRrjyt3lJQNaIb9Om1rKGpgxJ6XXASyRM7RmO+RDg01di414
         iH9oCGVe2/Gy/gRrB1dZk5jKY7qIS6HrXSALdbHh7F6NCLf463i361wwqF7qqLg0ojsq
         qvBw==
X-Gm-Message-State: AOAM530IsPVRAO58V98eDWdfxXH7ZOpdIiYJHfgpdjRcDayEPhta9aAZ
	zBJu+PeEncv61lDZDlB0lg==
X-Google-Smtp-Source: ABdhPJz4WQZJmMM/3puOwZxHiYDUTarc1fXpdzBxKW7adkK8lVCrdEHUS8fIObDX85Z6p4soR/PkTQ==
X-Received: by 2002:a05:622a:3c9:: with SMTP id k9mr16967051qtx.170.1634345827502;
        Fri, 15 Oct 2021 17:57:07 -0700 (PDT)
Received: from [127.0.0.1] ([52.146.40.220])
        by smtp.gmail.com with ESMTPSA id m68sm3388529qkb.105.2021.10.15.17.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 17:57:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cd8cca4fbfa3bc1528ed6923cb4b660fd20e8e88.1634312286.git.pabeni@redhat.com>
References:
 <cd8cca4fbfa3bc1528ed6923cb4b660fd20e8e88.1634312286.git.pabeni@redhat.com>
Subject: Re: mptcp: allocate fwd memory separatelly on the rx and tx path:
 Tests Results
Message-ID: <926abe8d-71f5-3ce9-2eb1-7338d52ce715@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Oct 2021 00:57:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4939983434809344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4939983434809344/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6065883341651968
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6065883341651968/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/69bf715aa905c228e0d41db8ec96

Please note that some efforts might still be needed to stabilise the tests
suite when ran on a public CI like here. It is then possible some reported
issues are not due to your modifications. Do not hesitate to help us
improving that ;-)

Cheers,
MPTCP GH Action bot
