Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080C332EE
	for <mptcp@lists.linux.dev>; Fri,  2 Jun 2023 18:03:17 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-62606e67c0dso21443646d6.2
        for <mptcp@lists.linux.dev>; Fri, 02 Jun 2023 11:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685728996; x=1688320996;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QOgXSzPTMZIimptnE9XzRmqxM0JRUiDQ3uJLCp4+FE=;
        b=VYWEfzIcj4xK8ihVsGyxGUg8w4dAp17YrJpJfWzIqlYH25dI2u8VK2JgkOWdFwIBSh
         aaeoWlpI/CzgSEmZHhZBRHyDlJocf8GjXqHfAPpAzOlZ/qrsiarNiotgfDSbMdMRIoCW
         Z96+I6692rAF78g4LEkC0sTMjB8zB8k/c7WGJUqf1xurFAn82cuAHPRed+uhfBiveRxh
         hUD7yi/kFJRWb+f1/xEweFsi0vU6ey+zl7k5V9zdBWRiShkllHKD+PfSCxISABJ1Ehp8
         pGoD7wfc3GLINlTsA/znn5v3H4qs/goKPmJAicPYG0obVIYJEDqCkUZTz0UCYVBht3jD
         VQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685728996; x=1688320996;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QOgXSzPTMZIimptnE9XzRmqxM0JRUiDQ3uJLCp4+FE=;
        b=Du9tKCt99z2qOcIKxkbISjdv+cCKCcLg51rOaPsn6BpWcQHNs1UEIc9ZEMKcZhmIZ3
         DvGF8b2/sb4FIKK4ZRp1fSHxl/rCsM4+8U8gYoi1ek3Zin6QENjkvRej+QxPiUrGXE9H
         Sc63DOHhvk5u5rdJUORsQ/0cnv/YPWBODCzJK/1SIqe3rCcB8qWY+jpXzT3lWI1Cx91q
         XUg01Q+yoxEACa77+744iabklZHINgr+lJqMur1pEdQe9P2C31GyShPnAm1uIteQn3Ti
         Gjl2yxpF4Pfwshf9qmCDIdJk22DUDA2PwPuc/XRLAAESCu/E5vtNgZtEAkZs7akpyfut
         pLBA==
X-Gm-Message-State: AC+VfDz6QGTva76EgIz6QT9GZCOPOgZpfeoHAH+tbkQbx39CA5GOLKpi
	1fICcYGqQF4elza4YIe4ZA==
X-Google-Smtp-Source: ACHHUZ6ObBKhEwpide+gMqrcMeVr+zKqU0RGU7Qu6DBh2zjIJ9Ksl9gpdr1aIHrdOPtirxPVQxpIlQ==
X-Received: by 2002:a05:6214:21e9:b0:625:aa49:ceb6 with SMTP id p9-20020a05621421e900b00625aa49ceb6mr13889059qvj.63.1685728996524;
        Fri, 02 Jun 2023 11:03:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.255.1])
        by smtp.gmail.com with ESMTPSA id d21-20020a0caa15000000b0061b2a2f949bsm1087878qvb.61.2023.06.02.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 11:03:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230602163044.1820619-1-leitao@debian.org>
References: <20230602163044.1820619-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <6c2b47b3-aef1-75da-ad33-23276bb119f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jun 2023 18:03:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6647851757862912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6647851757862912/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4607158176710656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4607158176710656/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5733058083553280
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5733058083553280/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5170108130131968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5170108130131968/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9685d1594fdb


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
