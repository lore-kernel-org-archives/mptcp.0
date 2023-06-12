Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C280134AE
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 10:42:07 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1a6945925ddso710712fac.1
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686566526; x=1689158526;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkgkA3VOfeKAqR07/bU9FqFBFEkBpqXLvCqvFgoq6Ks=;
        b=qjt0ZcDi3oBHdefTQP0/rKuevTAQGMBN2nHz8QQkQyMxew9ChBnryjKbMobG8anLXh
         UbeT73Sxg0KSvHjzpOU/4sBnGIKH5o6YzOHYRuw7LgZP+HF1clsxzAGmLC11IU6Efjev
         TAqG3fuNeyMO4ZCRwppV/N6MUd09JGz1tN1L5z735HZBeuY/tMhec7W9bDY9tqa+9wAE
         CiDwtWQBsys+vBr8jGx5yQCSgbqRcWAbzi7flJ28gfCMIrTaWh32sSfB1hAraAYTu7Y0
         locWIcUuDZAZz0ScdNIlCLhalCeEtiCRFGvhbOnkO4VFrWWLVoW3rfY2E1mR0QRbTPn1
         /kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686566526; x=1689158526;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkgkA3VOfeKAqR07/bU9FqFBFEkBpqXLvCqvFgoq6Ks=;
        b=CEMR6E/9Y/M27dZp+1J01JYUPRG9yYizuABYk6jaE9qLSKIw3gL1H6JzX6+PnfzrhV
         NszSDbUlVdvSeh0iqpfwHnRo8PsV+DEygGJJepJhpojixC+Jys1lf/1HFfaEWv8prK2u
         xdv7FEOKg8dqrkzN8izeRLL/b+ERxNdegIP1xMYL3TNS/rvi/vRIy1iKwEbHVL2VG2XR
         tM4EGc0VRw+wuxeISrobFwmzIV1VBPi2Yic9XiPTMZ55H12bKQgn+uOBdBYxIesKA2g/
         r0WPS9NH+4Krfik5MFkqH0oAu3SQB9pFYeIAKgeJrGE0rM6EiCOG0RxbyqpJRnM2dIWk
         AG+Q==
X-Gm-Message-State: AC+VfDwTD7mGEx9rbtD/8YmAUntu7ZQzWJLS0XptFAWjgPb2KyZRFUjc
	Z8gzJpN5Yms6WF3YFEkONw==
X-Google-Smtp-Source: ACHHUZ65T/x398vU+VPI43y2sSIj3jTk4CBzzS9YEcg5SaU4a+Uj7JE4PnuC7J2+7t6vTfN9o3ND6A==
X-Received: by 2002:a05:6870:b786:b0:18e:2b7e:a849 with SMTP id ed6-20020a056870b78600b0018e2b7ea849mr4192634oab.22.1686566526095;
        Mon, 12 Jun 2023 03:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.185.204.70])
        by smtp.gmail.com with ESMTPSA id l21-20020a9d7a95000000b006b15ddfa7basm3746559otn.61.2023.06.12.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:42:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
References:
 <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
Subject: Re: mptcp: convert netlink from small_ops to ops: Tests Results
Message-ID: <c287ca75-36d2-7d13-6923-80367494fd6f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 10:42:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): selftest_simult_flows selftest_userspace_pm=
 =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4646421962424320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4646421962424320/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5772321869266944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5772321869266944/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5209371915845632
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5209371915845632/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6335271822688256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6335271822688256/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7c8f791a2d25


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
