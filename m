Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0424B23
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqAgWki9"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67efbd06f43so3795666d6.3
        for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 03:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702638648; x=1703243448; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXotY1z8tHG/cmo/jNf6NN9WirUx08uunIFZz1RCN0k=;
        b=VqAgWki9KzCE7wugkwwMtbfFd7TGLK4UwaUbQHc82E1e/GpTyyFjb85SUKZudtfeig
         E2nwjPSfaPnlYa5ccB2pDY55Cu09KP0UET92mGQ2i1522qA8K5D39Wb77T+o/ExJ53VN
         8R8FEySY/dda7waCbUTlKy/8RGPI5mWUKNhRZGiUSjgTxNO7t3iZ9ZAfm++4NSCvKMCg
         Ie9+dE+qSU4G1TCu/wPj/ZT0CKnWgQphQWJn/Mes5ZiP2Dp9AStkv7sJjLbl1OGh9HWK
         QSpSBJ87/jyWGUyXJ+L+2Nz2RxksECwz2i9a5hT7f5X5NWrtogjaqL4kJWARNuqzZXRd
         63mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638648; x=1703243448;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXotY1z8tHG/cmo/jNf6NN9WirUx08uunIFZz1RCN0k=;
        b=MIuwe9PwDOOuEiu25Oh2zDaXwF9lFmElLRifFMuA/9Yv7RgqP4S3/XVEB7PI0v2Wx3
         CfgMOS5DLz2FejurTaXgaVI2yB+9cmteuM75eD6kgJqofN0EXuKdGF36hzSZc3LaL114
         Zn36E+KcaP8bn4rlYCYonY7tYCuRqAh7umkO3HyYe/JZj0i/MwasGrPnx7S5iQDNJ9eL
         2HtNT/ST1wT3E0LCXSGHlgLo8i+spzQm2iF8yxjyZfD7RNeZPleSDlTy7TqBgORzD+P+
         7cmvHpJwyBrgBXk5XEEPP0Mfa338RKv2DTnDBpDSH0jjGg2EG3wlbO7Tf4uCYHyLrrVj
         UnPg==
X-Gm-Message-State: AOJu0YxGZEJLM83aPt7vvNddFUafNfFGtgTkpHhcVLnV/lINxFLHb5SF
	s3PdCM674cworboOMtZj4A==
X-Google-Smtp-Source: AGHT+IEIJb7jAoIfMpI3TPauG5zbulYrsoeQjgvahF34FN9zkSSBuYRBORsagLcGUu/Xq08Bkj1lFw==
X-Received: by 2002:a0c:fb0a:0:b0:67e:ffba:8279 with SMTP id c10-20020a0cfb0a000000b0067effba8279mr3820872qvp.103.1702638647923;
        Fri, 15 Dec 2023 03:10:47 -0800 (PST)
Received: from [127.0.0.1] ([172.183.121.20])
        by smtp.gmail.com with ESMTPSA id ff17-20020a0562140bd100b0067ae405e0a8sm593477qvb.57.2023.12.15.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:10:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f6371f65b1ebabc0f308528494ec39c9bdf786fd.1702631517.git.pabeni@redhat.com>
References:
 <f6371f65b1ebabc0f308528494ec39c9bdf786fd.1702631517.git.pabeni@redhat.com>
Subject: Re: mptcp: prevent tcp diag from closing listener subflows: Tests
 Results
Message-ID: <82051172-7b1f-3f21-f027-4e0bcbce991b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2023 11:10:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6646535530741760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6646535530741760/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5666210654715904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5666210654715904/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5731741856432128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5731741856432128/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5168791903010816
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5168791903010816/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/23b0f9732a26


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
Bot operated by Matthieu Baerts (NGI0 =
Core)
