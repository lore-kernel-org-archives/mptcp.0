Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831B28C3A
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 10:26:31 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-75d461fde66so290359385a.1
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686047191; x=1688639191;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aORjcs4E+Fi2bn8voFEN8n+x1//59UcSW1RPZziM0mg=;
        b=fx+sGx3ccvxIV+RDfByDzZS6yBXZdNULGOtt1o/BftyPXHX7EGANI/rsTy6peQyW2C
         4i9inNOpUH/c6Vqve5Pe4lMWcemoU7Q9VtOeSaauMHRmuZqE+QOoKn9UUGDkDmtKzzoV
         y1duV2VNVRprDmuVgAFpFUfW5/ALiHhEe/diAL669YVhIgF5gwmPDMIQ91rjJ2P077nE
         IRN8TvPTkeBd3rmhCSZOBCRPz4OrwKD3VTmzzsFx4edvq6Va4Cj1+XOMpUXnNoW7eTj9
         VvJXYlX64bmF7ylL8dsKwAzHPetlg4OkcBMv9s8Wpna9xbLooSNeEneTF7SFX9FuVdKD
         QDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047191; x=1688639191;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aORjcs4E+Fi2bn8voFEN8n+x1//59UcSW1RPZziM0mg=;
        b=Z360MkSWkZaTj0wPrUlKuBu5COoEKwlTrjKlfX3N7Cb9Q1n8DgFZsuTaf2i1/eUVCr
         orrtjUUvFGS2YmA1g33XFCVc9JLpp9m6rs1Lvh42hRR2fz5UrnxrEfrEejm2YloQN26d
         yv2AFy/Jc49A8k+0OWw6Whiq76DS8j+vTP7sQouG9/dIwqBhddJRul3uopa42Ei47jFm
         BoacqNPAtNj+Dvx/XASi1ymukEwPGGA+NfpuPv3KPu2cgF9xIvv72oa1CB37nTq0C7Ee
         lLahzQiO7qhe/4hN6KSOmAfPsOz9GQv/E3o5BjKP02Yw68Y9JtMnR5spLSfNiOuYzPX1
         L/mQ==
X-Gm-Message-State: AC+VfDzR1ECNhCpQcsN1ZloRXOSBGYJFp+pF47rfDpDDQy22OG67PW3g
	Vgd9ZUxdj+Vp2/a8IXOFCg==
X-Google-Smtp-Source: ACHHUZ7ztnPsGIsD1/0SKzeElyDZw+QbNtXm8bzmJRjqq9p3XU+TdlR/QBiAmMea/rdSgQmwGLYo4A==
X-Received: by 2002:a05:620a:24d4:b0:75b:23a0:e7be with SMTP id m20-20020a05620a24d400b0075b23a0e7bemr1910443qkn.31.1686047190826;
        Tue, 06 Jun 2023 03:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.33.117])
        by smtp.gmail.com with ESMTPSA id a2-20020a05620a16c200b007593af0c85fsm3258873qkn.88.2023.06.06.03.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:26:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1cf433961986135e884dfc35b981c82ec6a5f528.1686041504.git.geliang.tang@suse.com>
References:
 <1cf433961986135e884dfc35b981c82ec6a5f528.1686041504.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <f0363211-960d-5074-eabd-52a3b1667010@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2023 10:26:29 +0000
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
  - Unstable: 2 failed test(s): packetdrill_fastopen packetdrill_sockopts =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4723489714733056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4723489714733056/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6412339574996992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6412339574996992/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5849389621575680
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5849389621575680/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5286439668154368
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5286439668154368/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a49d687bcd1f


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
