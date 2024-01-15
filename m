Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF117BA0
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyMdk14Y"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-429dd92b842so20934211cf.3
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705335221; x=1705940021; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4ds8JZVJqG0N/QUvMCrqLSE3oLakUeg5huE2/2rvfg=;
        b=RyMdk14Y1KlfAlO2guL+36L/lECPnJaPNjjk91QZvQgMqZOv4Mqz6SA+RLysovKifl
         QEW1pya1CpuM2mKHl+E/dDDyv59zUUC+INVArjCLPJ7F4Qc8IPnyq3F58df4F5iUlJhj
         7NY4BI6UktO/jFFv6TUHXtkq8RFK5skyozE6L9iEfEjvzjugTnmVitZJBW5ODowqEVnk
         4q2ebWpD0IawRsnyWwQtlooOxh35nhJT1y0Bz23hSBJRfzZtGbOIpSk0RYSUVgFZ9bqQ
         9ki01ELXLM1/ZMbHyICeojdAbAYornpfWRQJNWWa8zL/EyPcDi0CpwHifSYmGTwJxKM5
         DZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705335221; x=1705940021;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4ds8JZVJqG0N/QUvMCrqLSE3oLakUeg5huE2/2rvfg=;
        b=ioOAbqIMHfkx2bG/gEdvN6iGDdKL8XIITxMZ/A5FJ90r0xare6+i0tCbyZhVL+bcKF
         TS7mD06cOpY7a45/Nqg4e3a3KW0hzxp7BYGCseRF2efMtAnraYMIHgq+OrcVD/kelZFC
         2qCSfIcdHZoItit4BFgfwgc44Un159Dz7ataHtnCC8xpcKgIqJUnNEfdXl3TzFQxX61A
         DOPgsiemKZAd5UVTeCsBSgjEDLitcD+9JEC4wgZ6eeT0SnvBwyYmLVm6rlkvvyLqL6PT
         dVq5XkNdsGg4w9eybZKswScAVD/gFlsIoteVWxlnqT4ls9vdrlDrqyS97BmlcNCCwDYX
         JNPw==
X-Gm-Message-State: AOJu0YxsbKAX8nWxepLPpxC9KuyTxob7yZt9aBqIVvd6WEWiYbBIwfby
	LNwMDU3d8q7HWj9aA7nD2g==
X-Google-Smtp-Source: AGHT+IHK7QuHhoDz6iefeoCoe+lJE4NOq7VR/BPVphhB0u27ZYFc7vPKi+9ACegLxM20SsPc4aJ/Xw==
X-Received: by 2002:a05:622a:1983:b0:429:fae0:d5c2 with SMTP id u3-20020a05622a198300b00429fae0d5c2mr809643qtc.12.1705335220792;
        Mon, 15 Jan 2024 08:13:40 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.238])
        by smtp.gmail.com with ESMTPSA id fy14-20020a05622a5a0e00b0042837900d7bsm4028176qtb.11.2024.01.15.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:13:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
References:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
Subject: Re: mptcp: corner case locking for rx path fields initialization:
 Tests Results
Message-ID: <5006a947-9e61-ff92-30c1-387cd843f83d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2024 16:13:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_fastopen selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7530=
894597

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/61ffb2fba924


If there are some issues, you can reproduce them using the same environment=
 as
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
