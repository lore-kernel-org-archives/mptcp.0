Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7533E3
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 17:37:51 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-43dc3f77accso507087137.3
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686677870; x=1689269870;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SfAglnT7rUHGN4Onjkzni0NAVqbvAgIdfLWqKVfz28=;
        b=dHPfsfUWXM56vm3qu8nY1LBLB58LLfpx8TI8bKslQSK5Z2S+lhilMTnTPTe8/3f8B5
         8uLKTQksZKXHQ2uCvsjTThjtFl1F0g9QsufcfnMsIJbKU+Ing3vvfRJ/7cUVEZnrLaGT
         Zz2HVbwGoVB0mIuwECwR8+FjJrtsoc64nqGy8GNRmU4oSCDzLfI9ETr7/+fDCrPVQrhK
         aPJxxs84MI9BGG3B58CNJsndty0PHxCDBfpF/i53Y7pSq6wBk/hCTta9q1RUOuQhYetp
         9emhsl6XXD6X2ndxIDP+sSm5aNpRx9Pcc8u7FLcjNMxzDnWAKuSTjt79lqFLIMLnDuIi
         CaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686677870; x=1689269870;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SfAglnT7rUHGN4Onjkzni0NAVqbvAgIdfLWqKVfz28=;
        b=a/R1g0sxpBUQPvnGBJFcWwieClZ4a889ApbsHBsyj/4io6AiGzO6r6XQVrzI+B3Hom
         PtoNyosj4hflLhGkyfFPjVjCoCQ6ogQ5iAfyuswoIaxj5qcxGsbR1Rn4EF1VkOpuGH4B
         1lTmqvq27Efh0NZkER4scScai1W61Caq7ky2Z8YOgIaJE5wILj6aLRpMsXs8WXDn0e6k
         ESbYdGU5rCHT3az13FZjwvGjFdWN0fplgJO6fHJPlSjrfM6S7C2WIOFN5d0yCPl0d5DH
         Iya9M+pvCHMRNaeT3mg3CY2z9iotQkDDwU5LEC9EDzce3r9MbqnL8yAG5CNudIDdzWuW
         TBLQ==
X-Gm-Message-State: AC+VfDziJpMFwAqiYCPOTPFZGjoW18DrNE7/TWWA1I9rbBmy0tl4g3DN
	D0/C8+CLPpOruQ9hlSt3cXTgfv0/5w==
X-Google-Smtp-Source: ACHHUZ6HmOErrI0m6JBJyN80/mnrpuox/KRsCPBgoIt99T15i5I8IngUwHdOrXB98xahXZXRjholYA==
X-Received: by 2002:a67:be09:0:b0:42c:9864:3adf with SMTP id x9-20020a67be09000000b0042c98643adfmr6547015vsq.31.1686677870107;
        Tue, 13 Jun 2023 10:37:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.122.115])
        by smtp.gmail.com with ESMTPSA id b10-20020a0ccd0a000000b005e750d07153sm4084320qvm.135.2023.06.13.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 10:37:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com>
References:
 <3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com>
Subject: Re: mptcp: drop legacy code.: Tests Results
Message-ID: <65899697-756e-3443-700d-64812b233a8a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2023 17:37:49 +0000
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
com/task/6108358801883136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6108358801883136/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4630615174152192
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4630615174152192/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5545408848461824
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5545408848461824/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6671308755304448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6671308755304448/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bdbf7858d22c


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
