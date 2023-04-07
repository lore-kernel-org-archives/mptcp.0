Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED38482
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:56:59 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id x8so30623693qvr.9
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680890218; x=1683482218;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDDXwc6RwKpI8hm4X8hOHx0BxAU6NnxbaGIjhaFmshw=;
        b=DzEhcIoQInrtA20M7VRWc9V+dbD3HDwAQD3GqlYQ7c/qLJD42uy1rqR/9XEgKv8qtV
         l2yMm3dmqMKwOzgacdLRhXm+pZWRH9cwXVmeooYXAE05sUh7Ors7N0DbtKNtsQINpQ+z
         Efp/B3SqzKW6PxR0MOVtFyKWyEBIJH8yRc2Oot3dH4GmdMlc4Yf2vWalmDTin77/duT+
         rKQfI8DT6WcvJeE5MznP0n+b1YvNOY5yLlaiu6UQRhN61DtpWZsnfNw0/uAXQs/TPRo7
         ynJVQBS2bvhmJVkh5b1ggIjljW+Th9+Qys2bDPjk0Tt+3GShXdrs/UyRC+Bg/TnMGT2/
         /ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890218; x=1683482218;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDDXwc6RwKpI8hm4X8hOHx0BxAU6NnxbaGIjhaFmshw=;
        b=LF7e6nGEihODp0jElfMNcUQiBMuqUpsao+sCjI/326JNxAA7K3/CuCpc30lrV5xriq
         Yd0w+9/zgiBTS1HqB8mHexZd521ZsW440E4SM2s7RxmQ4xkRRkvEXF4Nm5Thw3q/q266
         TjFggnk3BN1mnSHMv0GRec7Az/n4ibWT+mynK+5Zggv0FvVAoHigcWeXzS+OUG2LoZhP
         wiNJUHrLnlwnopQJoUC0ccr9+Z4AeJWGPedg1cImMA0s8Q6MooJnLAaC1nc6e2bJjWIR
         4WaMU2OlUmicYTCHtnz88SScp4mpW+Luc4ikIQ88boICsd1TBdOFurxhyDNelCD1uSaX
         xDgA==
X-Gm-Message-State: AAQBX9ciYw9JAemwgf8k9pXxmw9J43n7lHwHgAyO30zIH4CSAVLGY08f
	CVYFzrIHLSAkMx65MC0LzIC3LBg0mhkw
X-Google-Smtp-Source: AKy350ZLqn9L1t/HRDFfBPfQ8RSJ+E2gUzoiFT6Mw8l5gXcsLZh3u/LZLmXSoRm+0cvCgLTZpc3rQw==
X-Received: by 2002:a05:6214:23cf:b0:56f:c138:2844 with SMTP id hr15-20020a05621423cf00b0056fc1382844mr5528853qvb.37.1680890218081;
        Fri, 07 Apr 2023 10:56:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.128.132])
        by smtp.gmail.com with ESMTPSA id ep9-20020a05621418e900b005e14936cb09sm635459qvb.11.2023.04.07.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:56:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230406-mptcp-issue-368-selftests-old-kernels-v1-13-246ac567724d@tessares.net>
References:
 <20230406-mptcp-issue-368-selftests-old-kernels-v1-13-246ac567724d@tessares.net>
Subject: Re: selftests: mptcp: join: skip PM listener events tests if
 unavailable: Tests Results
Message-ID: <344be111-cd89-23f3-4d8a-62e80c22e2c4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2023 17:56:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_lib =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6478065266589696
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6478065266589696/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5211427871391744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5211427871391744/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_lib =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5774377824813056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5774377824813056/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4648477917970432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4648477917970432/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/259d8acf6407


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)
