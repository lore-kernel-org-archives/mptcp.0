Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD421ADCC
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 16:09:28 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1bb575a6ed3so4605176fac.2
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690906167; x=1691510967;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCxsx/Z1tVZxuVI/C1ojMefXICPgET+6uJROIvCvwDU=;
        b=Ah4rKnYYXsDLagkIR4MrUh03WBa+J6kceCSLJbqpjbHJmX49ZDQRIJVMDf0qAbVw+k
         /QQA4Vo6MMGYnQ+6Axfdn8OLiH66TIE+X4ggK6ozQbvOn825FHP75E8xNSmvpzQq1fVp
         0LKVGmXjsUEcr9eL8mjPXk80vJZReM4fqdtruEKll/21uXLbp+04YRxteLuvcr2aSsYS
         FNq/4Y14Ey1YNkV9aWzkWB7ZtYixofIGGyYt3b294BSg7Vy/PZEuoN0RFhNl5G7efDN+
         WiKYsRxIrzawbfRD1bLF+Eu+bePPPrq8j5FPluDIphyKfl/1U2MDpZ+3TUtvUgVSvMKf
         yFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906167; x=1691510967;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCxsx/Z1tVZxuVI/C1ojMefXICPgET+6uJROIvCvwDU=;
        b=i0FhAwfqcOgFgWe/NXlsNBg/ty94sYCqQGJfGfLrO8hGhUQvKSmmfF8vM1LwpMc2v6
         jTPz3JaiXUk/pqvw2wVv799fnsZv/u5bmGVeOAP5vi4UUGpDQ8vv8G2EtSK8hcZCBHlR
         CRBcOm2Ev7aPtNHEhfLoigIusYJ56xeWpuAEq9P0HmrR2rlMt6iFHA5AUPcsY00eyFVk
         r4QZMp5ZkXCmj+80CuefU/d7WdVbIZgow11Wc4iJ+WMNux8429TObQ5PPEOXQHBwKlDz
         snyIujYHGisPwOiYcS/wCNz+NKU5t3DsZQ6zB6+5VJDwKgLxXPXDCzscuXRYTYN5KmtW
         YDJA==
X-Gm-Message-State: ABy/qLa0V7vhA6pKcgDj2nMWajd1W4fLhkWbBbMeNudwsojHZpU2G10z
	ppQ/KK4sKur16NJTeqLt+w==
X-Google-Smtp-Source: APBJJlGTXJudzDvRji/NxDGzpnc4N+ibtkotktrPSRHVLvGEtF6pSnQy2RDCb9Fldz1HtHUXtTsHNg==
X-Received: by 2002:a05:6870:3927:b0:1be:cc5b:6ce with SMTP id b39-20020a056870392700b001becc5b06cemr8678323oap.20.1690906167536;
        Tue, 01 Aug 2023 09:09:27 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.139.233])
        by smtp.gmail.com with ESMTPSA id v17-20020a056870e29100b001b3d67934e9sm5613215oad.26.2023.08.01.09.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:09:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
References:
 <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
Subject: Re: mptcp: fix disconnect vs accept race: Tests Results
Message-ID: <0bd61236-6177-a11d-b651-e02f31403b59@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Aug 2023 16:09:26 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5488088298815488
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5488088298815488/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4662034151768064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4662034151768064/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5330855518797824
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5330855518797824/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5816899318054912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5816899318054912/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ab577d790497


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
