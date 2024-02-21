Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521C3A1A2
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530455; cv=none; b=Jd5ZFj7QPVuX2DUH93YMFEi10iijTubvfElvqVc6Ll0OK9Shu9J1AqdYLVZ2qc9FxZ552mTj82J6PAjoUw+AeV1te+pfuHsHY4cMzGqIfcmrf4GHclUOHhLlbBSNAJF4mGOEJLzjUuT5D48azMCGtl+XzCSDKNANY3yDs+VmgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530455; c=relaxed/simple;
	bh=ThC9bI9tK6CUaWS9UkIQR2JSh2pnS+VZuTbY/Ktodk4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eMr7NyFmemroJwYKuqgqv2V2LcH1OOFRRCiMgtMj5lR3m23yeQm38ag8caL8JUbd281eZ03wN6n99xDAK8YgL6ODwrtnshd69pt7dYtd6SCFB+oiztAWWJQipRq9K54AyqKrsjIlPMiQbA85mM/GBHkNdxg9iPuuES4+83NpOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtW80CQS; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtW80CQS"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso833591276.3
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 07:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708530453; x=1709135253; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+AkPWbtk0azzltEe9l9FqdYZ6FVjE0HTPjSW64b7bE=;
        b=NtW80CQSOyV99rdRzrjK1xq4cpvQtznsSBsCoK7nweTFIfjfDK9Er8cDNNH+D2otU7
         BNbq0FIBKAPTxa+cGdl9dQPPRRCLNpYFTSVQJ8xHUfi+bF+xBv2N3x81IxYCVRE0tNVZ
         EmS3mXjE5pRJOf4GLSFtIR9ClQVZY0TVtKq+4mXlOkfmAPDiOybVxOK6yuX1KByMLhLR
         x2b6ms6GANWt83+x29BCGzv9fPF63M5WP9LYCF1OmWJTNCQpz+ZU0l2HFDz8tsB2uTFd
         XEbYjZXoqKA6E6ibJxfH3DjjQ2n1rZvyW6r8juWl7xmfJpM/EgDuQeWQHI0IkTj0eB6n
         Dk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530453; x=1709135253;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+AkPWbtk0azzltEe9l9FqdYZ6FVjE0HTPjSW64b7bE=;
        b=LOAZjkGhgT9Ug3G75qHHBxmT68S+XG6u9oLaytZ4/keebxsyRUuLHd98U+Q5Vl3W90
         /4zn1GeOMa/eW/40EKl7/kWbC3bXU7wRkmj3swPsyA384ZlOFnAQRKx7FY/sil3nfzYO
         /p2rgpEYv5Q1utJVpHedAYFhaS/HmKYRirycEec5ZjcMJLQj9JSt4EwSMS3t5VJ510+R
         eNW5Kk2d76DXiqs/R4SSMW0Ao20nrhaHhrMzQvbgIhkefP6IdoyQAjUGiWtxOrEk3Z6/
         wjNdSKvgZxxwfGLEf6mLC2kZbRflvly2a4BAWbnWNrhn5FZH2PhQnlWhpIrhEd0E7NEY
         1/3A==
X-Gm-Message-State: AOJu0YweRLnVo5Gn4OeB534kptB8RTNNHGszkD46s6g3tvMF2CGA8hlf
	Xe6avqYSuLcZ2brcjBpbEr+S27teyfOPuxQ9sfuPyn6hEz4OKRBnKpRPlSDCug==
X-Google-Smtp-Source: AGHT+IEDDtu/Y24hncs31XTBGe/eO+X1i206KnIEYDkGDzRDSH7zuZNB09M0RlirxNAbKW1ZFf6eRw==
X-Received: by 2002:a25:ad23:0:b0:dc6:7e7b:4797 with SMTP id y35-20020a25ad23000000b00dc67e7b4797mr18143899ybi.4.1708530453288;
        Wed, 21 Feb 2024 07:47:33 -0800 (PST)
Received: from [127.0.0.1] ([20.102.210.209])
        by smtp.gmail.com with ESMTPSA id h25-20020a05620a10b900b007873c8f1b7bsm4424876qkk.62.2024.02.21.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:47:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bb5e3f97c4a225f616d82112570514114fce00c5.1708497039.git.tanggeliang@kylinos.cn>
References:
 <bb5e3f97c4a225f616d82112570514114fce00c5.1708497039.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <ac90ab4a-b6f0-30c8-6380-49c8e8476fd2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2024 15:47:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7991240119

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8bd552ab6146


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
