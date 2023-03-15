Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31926123
	for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 19:25:19 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id t10-20020a9d774a000000b00698d7d8d512so2605397otl.10
        for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678908319;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARvQRXY+XV1/OdfEyFp4SglXQZsOf+4qHFtOCDiO2xE=;
        b=YTzyeFDipClSCE5ysHmZftVawX0TxBD3CIBb1I+2XUgmSEeYWUWjmJgyugVNO0K7AB
         pEGb8PFouxV63tOhIqGeoyur1bca6ZN2mdh42no1SypUyGkm/+U1ikSM3fF23s3YteWT
         opN+nLdblVPi4jWk+zasMO4q+Gute0PLFXL/X4SRyYcn5XdtOdPN1xHrFMo6Yjt0fdML
         5NxWj5RyUUNoOtGG3GAUlvqPVmHLei1N+DIts8V1ifWwYHDjgN1fYS7oBTRjGetuRz8L
         SFo6cXIB5RF31aTbZxQY8bVNC3mMIgmHKyzUU/NKwcgPMVis6XoW0RCnLJzKD++82OAn
         Mpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908319;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARvQRXY+XV1/OdfEyFp4SglXQZsOf+4qHFtOCDiO2xE=;
        b=dHpIn+7xXSPPbG/L7UvwG3t+UPGN6lJdBPoOYrPd2g9t+LlXnEeI7YPH7CfOU2cvjr
         iNnacwc7YvlHr+M26uM9Ehy5eGCqmebWDmZ8/sRxhuzr4bCB5XOQspIhTY6GiduGS2gU
         ENufjp56I9cj3lkDXIp5FQbcI2TQqPUCyQ3DOLWaCywMTnn5IPa1QKkhbxH2vJTNI7hx
         wnWuAvoLMtLO/hkWJC+PMSefYFoH1JdLtjcaIOHgn9iVsIy2nt9jCbPydzivXqE8+kr9
         03NH1tgzXFDpLkhp6fRQgIUgEALPbQyNkuxebWhQiEomNX/ctmDb+lNh7IF/uBtiabaz
         LQ4g==
X-Gm-Message-State: AO0yUKWsaFbSBbICB5eXog+zDSqcm4mfLIobVdHDE7bWGnQNjlEmPvgu
	IrwJxf3ge37l4ol5ASSK1A==
X-Google-Smtp-Source: AK7set+X6fFURic3dpq0vo286bMdJcEZf5pdObvsjFm2tW/xtwvmH/fkeXR7Y/SMcc1DLmZ8yxXdpA==
X-Received: by 2002:a05:6830:3296:b0:690:f6d8:1f7a with SMTP id m22-20020a056830329600b00690f6d81f7amr8505017ott.19.1678908318837;
        Wed, 15 Mar 2023 12:25:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.174.133])
        by smtp.gmail.com with ESMTPSA id j45-20020a4a9470000000b005200c4b6267sm2551341ooi.9.2023.03.15.12.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:25:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230314-doc-checkpatch-closes-tag-v1-2-1b83072e9a9a@tessares.net>
References:
 <20230314-doc-checkpatch-closes-tag-v1-2-1b83072e9a9a@tessares.net>
Subject: Re: checkpatch: allow Closes tags with links: Tests Results
Message-ID: <cc784671-68e6-00d8-3a2d-47cbc67a8e50@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Mar 2023 19:25:17 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6215348928643072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6215348928643072/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5933873951932416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5933873951932416/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4807974045089792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4807974045089792/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5370923998511104
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5370923998511104/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/90e7f91b369d


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
