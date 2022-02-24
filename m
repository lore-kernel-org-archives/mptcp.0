Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3F7B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 16:42:33 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so2515841pja.1
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=p0K3J5GoI+mDOQacmAlT26cXh5vYHvy6uquz6mpl7dU=;
        b=ml9bEYcteCbE45jYIwHIMNYD3r/9W5ouzVJh4A5kexvL/jpuQV5AyyQup9VIlDgHvL
         bdkDRf7qcKoZso6bnDG05LF+RUt9dZx595+6Z1lTTAKuEFh+n1iI8oWnvU5Y2fPpVYy3
         2oIDgeSkNJS2MXgPfqH7hMgBBHgNEnRcLtO6wEandBacexcKBWXpBHBR9Ua82Hf8HJtp
         cGoxOVvQtMJR9+aSRYRmyXFopKieCeN5zBAMIXArq2EMTccbCihs/Ksi946etQB68xMA
         qteuFN5rItbp50lWxNtLKol5D3qxFpT81MISvNhf1dyk6/RLdecXO6zS385ma4EKgslE
         j+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=p0K3J5GoI+mDOQacmAlT26cXh5vYHvy6uquz6mpl7dU=;
        b=mreOKUwvLwxAkQsNlxJxx3b+dqSGIlRGjnCqmtltQWFtR+D0Geok1HYk8NAdCCq+AG
         M5urcBHiTEN7FrgsM0PP1JdyZQ32tKC2TI0tuNqf1+Wi2b7SeOlBX5hilZ36eORgBKSh
         fIRsErHI3wc1CKAbc7a/OoHrE+vMySFhNPj7sGHKn0h9Ae5fWejf873WwOMLZD8Gk5hY
         wowdqjY6+pJM16k6srOe5zCV0FSpMn39IwFAHapP2qYUiVeLG8mHIaZ/jV2AnbvZ7v9l
         IdBmTCiQNRH/Xp8j8MlPFAMAdln2hFItD35M43NdLVxlKkNnFXFsUt2FTrcZX3G5NNiN
         XlzA==
X-Gm-Message-State: AOAM530LxIfuZPO1WPnla9XjzrqSpPbM5YRATAhSrDIim9xX/vdMGoXG
	QFTcKhnMfkygc011pyAVpA==
X-Google-Smtp-Source: ABdhPJwxOckVcgSJuN3XiidpNhT4GPYls/hLMGYt1luFdpti7Qe50C8SZuS/dPzhFKt7pAJ6iPrS7g==
X-Received: by 2002:a17:903:1c1:b0:150:12cd:a027 with SMTP id e1-20020a17090301c100b0015012cda027mr3580038plh.26.1645720952636;
        Thu, 24 Feb 2022 08:42:32 -0800 (PST)
Received: from [127.0.0.1] ([20.83.242.186])
        by smtp.gmail.com with ESMTPSA id c20sm4532287pfl.131.2022.02.24.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:42:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4561ea0907db7c1db98a7c6d90f831ee337da5c5.1645716043.git.geliang.tang@suse.com>
References:
 <4561ea0907db7c1db98a7c6d90f831ee337da5c5.1645716043.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: exercise bpf_mptcp_sock(): Tests Results
Message-ID: <81a6404e-9d95-37c6-c727-a50cca02f906@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Feb 2022 16:42:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6505060480843776
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6505060480843776/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4675473132224512
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4675473132224512/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/edc40de57e0f

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
