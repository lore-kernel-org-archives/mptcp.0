Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CC1C6B0
	for <mptcp@lists.linux.dev>; Wed, 15 Nov 2023 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTq14wwP"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b40d5ea323so4313506b6e.0
        for <mptcp@lists.linux.dev>; Wed, 15 Nov 2023 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700055519; x=1700660319; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsxtyTyWDFqUnO/T/DoO866HIuz4LbWfOV4XP/Aw4JQ=;
        b=dTq14wwP1mncyisJ9bLcwP03G1UXm095GInS3ajJU1vraIjQZ0tJmFENbdqG2D7YCA
         OvycsGan6K6QxsnmNRi2YuGsrEFUCprOskcP8qp2Wo72rlvY3tGVakmDXgXaYEpJr3VC
         JR+YHcXRLkW8SxDu5SB/cYrjyoCg3UNnskDXTNNSfkwJ2H2p9t0IOAgAjCI5RfzmvXs5
         qJX/UArTQsfEHxde1mACYPoZMf9dSJD9uDbSkwhaUVtt4LyoBBL6Hp6MW6gf/nnymkaf
         tHgMDJMr0frRj28T5L4sYaXdS+s2vgUjxx+YahykpqNo//vZvXlggenXfSAEFzTdDyc6
         4L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700055519; x=1700660319;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsxtyTyWDFqUnO/T/DoO866HIuz4LbWfOV4XP/Aw4JQ=;
        b=XU7aNYwdzj4GGjxyyUbxcGPUqv7HC/1WYCoS8GRuFI8nBqSfJpfgRcxCv1eo3VCjMh
         6eAodpT4d2+4x9VJkHoRUr3nPM+tcJ0UmTGpEsqRMq87R0jVqZY4tz0a7ITpB/7ekdi7
         ynZBI//HTjA1FCVFBMPBdPaIlUyITZmon8bVwM9u2QsefYFvXtiz0QXy4Tyc+/+nqpoh
         DKAruVfDwLloVIRPbTGRHtKAorV1bu0oFN+C93Zfrk7OoqfqRlbwv4pHm7p9J64/oj5b
         LIeJ1bFsw1O+7Al8bvrCjjVMiLqLJRzDSxd5j0PtxJ9VS/NkiF7HtNkDY/OXg0vInTtN
         SDZg==
X-Gm-Message-State: AOJu0YyI3tx9mWt/b6RqYubJ2bgjDwF8Z8oCT2+kFUwTdUTWihn6x1u1
	yjccji7gCYOEdTmb512Cdg==
X-Google-Smtp-Source: AGHT+IEKeGfg9+yWFT3uiLkYpcrpQGncuxRBAw36TQ4GQM3QcOLRWFAVaDNQD8cupN5iTsEOc9naSQ==
X-Received: by 2002:a05:6359:a22:b0:16c:499:bbbd with SMTP id el34-20020a0563590a2200b0016c0499bbbdmr2598225rwb.21.1700055519388;
        Wed, 15 Nov 2023 05:38:39 -0800 (PST)
Received: from [127.0.0.1] ([172.183.79.0])
        by smtp.gmail.com with ESMTPSA id y2-20020ac85242000000b004198f67acbesm3528932qtn.63.2023.11.15.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:38:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c753d1520719374102ea5064d3f8eac46135a165.1700050135.git.pabeni@redhat.com>
References:
 <c753d1520719374102ea5064d3f8eac46135a165.1700050135.git.pabeni@redhat.com>
Subject: Re: mptcp: fix inconsistent state on fastopen race: Tests Results
Message-ID: <84dead56-8ddd-ad1d-69aa-7aa01dd3aebf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Nov 2023 13:38:37 +0000
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
com/task/6397760975405056
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6397760975405056/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6438726373474304
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6438726373474304/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5875776420052992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5875776420052992/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5312826466631680
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5312826466631680/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/031c8377c63e


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
