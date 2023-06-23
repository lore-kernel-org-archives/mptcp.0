Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865C100AE
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 16:13:39 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-763c997ee0aso67498685a.3
        for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687536818; x=1690128818;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4/HWZFoUzfXbGWE5R93boLicWCdqYV2o5rBvnIsJJc=;
        b=Qig7wqNsppIomERzwregkr1HegblAunS6DX8JLYz4yof7FPsDrfpL8kCEiKt311CEy
         d7xH5AHEy+5jnjvqz+Pn13ICf76FSDpsxpwFMbr/ctMgrvp9NBStDVvK5JzUTmpdyKxA
         XWIddsN8++saWNwO+xBxUFCQTy8uGN0f4zERWa8LrGXy2D4BfZKEY1WIltD/SYaJCPYL
         V/KE77CDSD4OEMMMej/fsoaG/+k0kvilmbPM5aua7U1zSbyjVh7TyIXOjkwkMX5j6BXM
         7v7TUQpk890HHsTEOfB4+XWhBLDrjDV1b+X06PRJN/BnnF9NQ6HwyhtkMtjeroGpAw1T
         IzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536818; x=1690128818;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4/HWZFoUzfXbGWE5R93boLicWCdqYV2o5rBvnIsJJc=;
        b=ALl6vEjYgdW13w1tL4kG5uoT55J6LTj7i697rmkgmxE1Fn+7+x+v3k3zDfGg+/zPX+
         dqLzGyYrg7AGk3mVk0z2w4yTin4OW91rWeYOJ9wkwQVt/TEwwXBbR35xNbJggDB8rLZ2
         oIwI6kpW3prLjuykSZCHGz55V/grnAIEJs+V0eXIx8YwuLcke5pRJvYyPbkKQ86T+htW
         TBnCVGgS1kS+L7BrQFb8ReDB2AvNFjSRFtiEgJSillbauu4LFx4hSYfatkRp2punCUDq
         0uBU8UAqs5S7D1/P0XpwFets6hiyWwEsFfzt+9mdRtDUVBVmO3JWBys7DkkTwTqOwM/N
         mBKA==
X-Gm-Message-State: AC+VfDwYS2NmmnRh3iqyPptqolVAYPYDf/R7lvlbJh7fRgEOquyDRRJH
	VDprXFvrhzoiEk3ylOebjg==
X-Google-Smtp-Source: ACHHUZ5yzY+wBL7PPMKE72vXBD4YZkp9eX+dW0VGA2ZZ6FOjryGDphOdqC4Jr2r/+TqI1ONBJZWQ8Q==
X-Received: by 2002:a05:620a:8e84:b0:763:c017:67f2 with SMTP id rf4-20020a05620a8e8400b00763c01767f2mr7845487qkn.50.1687536818010;
        Fri, 23 Jun 2023 09:13:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.65.68])
        by smtp.gmail.com with ESMTPSA id c12-20020a05620a164c00b007624af3ece3sm4483749qko.78.2023.06.23.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 09:13:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
References:
 <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
Subject: Re: mptcp: ensure subflow is unhashed before cleaning the backlog:
 Tests Results
Message-ID: <e11f9a06-8603-59b5-fa35-5c271e265c1a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jun 2023 16:13:36 +0000
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
com/task/5428204190564352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5428204190564352/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6554104097406976
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6554104097406976/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5850416655630336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5850416655630336/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6220233875128320
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6220233875128320/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/038400f3a829


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
