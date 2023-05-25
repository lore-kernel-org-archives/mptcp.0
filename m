Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC03D7C
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:52:01 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6259c242c96so5492066d6.3
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685033520; x=1687625520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK4ybPwz5nODcLlbA7MhXXOxAwlydD7W946B7MQdP90=;
        b=eWtJ7iF9ejSOdXIGMkPcryt9zvhK9SHRGJwsDjlTg+ACCf0xlLhFEVQ0RPGOo7ewE2
         98hqDRH2bRadWqk9ygZAexGfBK1Ssp7/SxgAgoKQbT83UET8rNEfxNldxp/DVvEGKfcD
         gXYbh5iHpImJf2yvFzhyvMfN7Ed19sMG+ZxvoU9yrZxQ6qh3nxTi0sWYxQxEsF3MuXZ5
         SqbLlx3+ctr+xiD/VAt1RAZLuhMCv0zE5HGkAXBAoeuvIaNZQfhgWL1Ehng6OwDHEQhu
         C7oR9tDxVJ/v2ZsAZ07elSMgVNvsHuUNSUzsFln3hT1KhGMqpz9Fj+p6w3skNDDyxMGS
         nbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685033520; x=1687625520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aK4ybPwz5nODcLlbA7MhXXOxAwlydD7W946B7MQdP90=;
        b=IDUpxbOMbqkpwukWZQzOp6jUMjbnyzjoJj7Bgc+CXXq3plA479tFRy3ijOapgM3NZ1
         cyvnwSStNiiUBO9lhGtRzXv90LUepBr74t0WTNUU/mREzo7rNGDGxVMzwhKvhoASZH7R
         uF+gYRFyh1uVy8wqdmrMg/FXuI7ydXPJTzDRLWxGf1h3fTWyuGxPROxhPtyD6uQ/rbXv
         sKcATHALclRop1N6nE2kG8BUqiITYvp3r/ANoEUWIxepevhsf+PY1VNJoIjebe5Wxy07
         qKZcdo1vmRyDafXXhpwDBjMxH1yPCpdaKDjRClYj4gyN5gAV8QCQPEpzLnfYZQkd6H6J
         n8RA==
X-Gm-Message-State: AC+VfDx5dgUgwWql8FknA9EBI0cZ5xnVs9HGNt8pI/dC/vXtb/omiREZ
	IoK77WYJYS+qFDWlv/91zA==
X-Google-Smtp-Source: ACHHUZ4G2YjmsWh66n8Rd/nbmzfbIEGFV+wKoKxfRmkMIyjdXKBNWaaNEqCHfidhR97q6HRHBBBB4Q==
X-Received: by 2002:a05:6214:c6c:b0:625:aa1a:b6d4 with SMTP id t12-20020a0562140c6c00b00625aa1ab6d4mr1584734qvj.54.1685033520407;
        Thu, 25 May 2023 09:52:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.119.53])
        by smtp.gmail.com with ESMTPSA id pr1-20020a056214140100b006238cf6d2a8sm550531qvb.2.2023.05.25.09.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:51:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
References:
 <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Tests Results
Message-ID: <7ed3094d-8f2a-1792-cda6-48a163a068e3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 May 2023 16:51:59 +0000
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
com/task/4764400553295872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4764400553295872/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5890300460138496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5890300460138496/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5327350506717184
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5327350506717184/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6453250413559808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6453250413559808/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/de1f158647f1


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
