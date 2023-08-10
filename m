Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB71E51F
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 10:15:04 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56cd753b31cso530444eaf.1
        for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691662504; x=1692267304;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpW9lZ980qCi9jN+lC0cazKxxm/UhI8Hlgvt4MJKMiw=;
        b=TaocMWU3VfNjGQOpzOV9GSasLt8K8lJDPn3075rhUgkK4hBlwUp/ZgY2MijH2tkf5W
         iWXhoUbo9FMa8eIrQEyc687LgDWs8tw2I+1B5C3f+osSOaMBWG8PIm4iiZaNZgeEJzYL
         wB0zx+KXsL9K3SQ2vfea6A0xfbi8dedZzkpmYGV/qSdJI/ryJMZHozvTAAeH2bwpFG70
         1A6xz7UOc+2HHEYY9RvjSUZFrrI4IqtE5eqGnRfc0ELD6hFYxQ2DGG8oD0KX0S6U3su6
         j/XXOwphVo5I3WAZlp61xsKinUXJT3meFEJQ+gM+51A4mK4s+fRmOzGc0vTnrcxibPib
         enNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662504; x=1692267304;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IpW9lZ980qCi9jN+lC0cazKxxm/UhI8Hlgvt4MJKMiw=;
        b=XfSF9bwgO60nzWkT83hXu0gDP3RqTuLVL7d4nb47a9zZzsM41l90llaOoCGg2kUv1k
         BXhF7UWg8rmrCpubqGBcIuZv6KwKV3rvnQ/KufMoLiSnzotO3oJWYZlwQfp5PJiQS1G/
         IYmX8P0zbnhH/M0yX9HBD4OZrHT0fTODMKZEcpw5Cm7c8BtweUjJ6BSdMUbd1gQ5lFWy
         /nnsOrYRDsQ6chngaYoEnVafTB1iII1vjU4w2JQx2+8Z8PN+IVv2l1EAa+4rAp0g4S2L
         lBtIK2dwzOjCwkyAqya5EmgzuVPrDfaDhaiTR7gpf7n04AH6AR2xILrwPeeZsWf3L65q
         8USg==
X-Gm-Message-State: AOJu0YziC0ms/Cjkt8Z4vP+j9luqAVzfhPeoMezrILybCSJj3tYFh0u6
	3Kcazry9f4RrO++4AiOomw==
X-Google-Smtp-Source: AGHT+IHk+mwccHT8SMHgBHwxdBhKajqWuWJk1zo/s0a/4Ye6IkQdG/Z/2cULdtA6+60mf5RpXH/CqQ==
X-Received: by 2002:a4a:8447:0:b0:56c:c061:a9a8 with SMTP id m7-20020a4a8447000000b0056cc061a9a8mr1387035oog.0.1691662504018;
        Thu, 10 Aug 2023 03:15:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.10.247])
        by smtp.gmail.com with ESMTPSA id n5-20020a4ad625000000b00565d41ba4d0sm450046oon.35.2023.08.10.03.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:15:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230809225918.21523-1-kuniyu@amazon.com>
References: <20230809225918.21523-1-kuniyu@amazon.com>
Subject: Re: mptcp: Remove unnecessary test for __mptcp_init_sock().: Tests
 Results
Message-ID: <a9e1ec01-f0d9-ddb0-0fd9-62a9f27633a6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Aug 2023 10:15:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/4953412383539200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4953412383539200/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6079312290381824
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6079312290381824/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5516362336960512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5516362336960512/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6642262243803136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6642262243803136/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d9cabde674a5


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
