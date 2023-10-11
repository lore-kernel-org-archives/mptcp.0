Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849602031D
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A26tUmnd"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58111e624bdso2252849eaf.3
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038652; x=1697643452; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpcXw/HMpyRzGaLoQl4RDgRAI5fGZchKgs7KNRKDKGs=;
        b=A26tUmndZ+ikaUkCaZJsIKJey4P7bU0xNKksiFp8moHkaOjJcE7wHdCRjas5AVqFFv
         rjwc8osTkwIjHWQn7UhseNBVBI6K/7/yP6ixr+I5E1TG2IBKX0rhF5BgVniU3tdRAlLu
         jy4CycBOb6TApEHphlQNzgQz2BuOQHMpGmvn2AFDavc8Et287D63XbRxe9HA7gvpYMVq
         nW0fwosU87/YPUvysBp7FsS1MtU05tICuPz1SMN7xCvZh56V3BxXGYlGFRa8lM5wiXwx
         VrwY/3inZ2B9nIEtw0BXxGuTeca68je1K31RXorm14FAVJWS8B/HU77KGLLnmrhKjaXR
         Ua7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038652; x=1697643452;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpcXw/HMpyRzGaLoQl4RDgRAI5fGZchKgs7KNRKDKGs=;
        b=BO0k/pv6JQLqUUice3viAfFUh6r8HAHnoyLfxX6KYyXgddt05VCyg8LZLA77r/SSNy
         7BzgOhASsVY368M//UMZcKOnKyGJu/pILRNjEKBWt45m2OVkAeg3qBiuQJIehOtZry8L
         j2vWRKZlqqmQ+4zNtZSwPZ+Glgd7TiUSm61/Yqd8vZ4w+LVEanjSFmXgkI2S129/GveR
         xdF+gNq2Wdo8p4E7C/d4sStj2MaapLt+aO7V6srFwAbxgUzrCRmS3KsgRZZOp+P83y94
         ShWfLeAbbA7TtMX0PhwgEGmltUxlSAqbvN9p4osTbC8ld+V3D8Hlns4pQFZTxt8VOsDo
         mNLQ==
X-Gm-Message-State: AOJu0YzisU4kzL2LcewdkxR/Otz64xNAwjpEnlPzVlLHGwBIb6oFjvKb
	/2VK5FcFHufPYs/pkC4495MjWpZbpQ==
X-Google-Smtp-Source: AGHT+IF0ZlEQItS4KyrI6KMOmJ64w7PSW9fw7Da4MgCELP6+Y3tdh11bSAlzqdHP/FBy6e8loV/WFQ==
X-Received: by 2002:a4a:dd03:0:b0:581:3fd3:cc48 with SMTP id m3-20020a4add03000000b005813fd3cc48mr6288546oou.1.1697038652492;
        Wed, 11 Oct 2023 08:37:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.171.53])
        by smtp.gmail.com with ESMTPSA id p124-20020a4a4882000000b0057de3e449c8sm2379931ooa.8.2023.10.11.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:37:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d17f1677d7c0b65309c98f48a8b88e909c0558a0.1697031190.git.geliang.tang@suse.com>
References:
 <d17f1677d7c0b65309c98f48a8b88e909c0558a0.1697031190.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <c6d8fbf6-d81c-5e53-25d8-44215237cb8b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 15:37:31 +0000
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
com/task/5994835887259648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5994835887259648/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6432463807840256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6432463807840256/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5306563900997632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5306563900997632/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5025088924286976
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5025088924286976/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a5d21f5759cf


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
