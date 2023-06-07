Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA98F4D
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 09:42:39 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f6c81cc112so77848621cf.2
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686130958; x=1688722958;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krqExuhf8ZnRjKYUPP6qnIOIxWN7+n0yuuxFvk7oMpk=;
        b=IyrGxkOWhVeX0ffUewcaWNA9haddBAZCq+3gn56c88P/rVgd7crSZosuf3gS/uIc+V
         kYBmm92m63nlZHJ1bXwI0AMHzAoQEl6/CM0qyrxjThc/cuHcEZi65b97bJlMuxG+nWYl
         Ms76LAEgKOdbomigBdJGNnsbmB2CHbJtgRD47F0PrXCJS7czdBKnKuQgKGLUyz6DMgj7
         BnPy3YDHfSYvr1jFuOgBEZIEq3TDTKNWFVBKYRv41dFMKzFFThjU94jFjs2U80MElViZ
         LoeuEwTt0gBk3yUSpZ2PnEnEcD0RKo3oJWGt2Af4mJPNn91JU3ET9Yj4gnb3mzDVsLRo
         qbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130958; x=1688722958;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krqExuhf8ZnRjKYUPP6qnIOIxWN7+n0yuuxFvk7oMpk=;
        b=Oj9kVXTn5Ek969C1aPCkxS1wm5kHdCbPhdyVyIm++hc1eaGCRYP52zTaNwpS6cNwbJ
         JS60W7tQpm40DHze9zSgxmmcnPVr3gz2rSnyRTxbvKJep8pWw2OqxwUBYlHZvTR1bR3Q
         izU4/yL1yoVXUG3N3siQtatkwUEnyZHYEC1OplzWoFN8rJhXWHR0+qd1JA1RQGumnu/K
         Dh5KSnNo+IRvaVHtL8cIwJpNJGnnX87WfEbuJHfbJDhUlJEaiCIuErG8Y1Dj5tRs+WOn
         ZD1IKKO48ZQsrqDjfDIOpvyUS4eTfZ3LHPOZOkfzJgF/DIseNXReNspXZ1foBYQsL3VQ
         bGIQ==
X-Gm-Message-State: AC+VfDyBhMkz06VhPOSp5LtNvhudWXfDizznXqkzQwOzWwGNEGI0QNTY
	zHZMQyQjuajsYTYWNklXwu69Q3nbi8BJ
X-Google-Smtp-Source: ACHHUZ4BL7Q8AeAZ3x6vfepFoiZ2Ubrvef8k6RD6eNljvcLbhMcyCWI0EWDX71wcU5rHxqxOV9C+dA==
X-Received: by 2002:a05:622a:12:b0:3f6:a210:1fec with SMTP id x18-20020a05622a001200b003f6a2101fecmr2384939qtw.29.1686130958278;
        Wed, 07 Jun 2023 02:42:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.155.210])
        by smtp.gmail.com with ESMTPSA id bn13-20020a05622a1dcd00b003ef59e2b9a6sm4153131qtb.78.2023.06.07.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:42:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c999814651073121c97f2e5c5f273d6674a6832f.1686127032.git.geliang.tang@suse.com>
References:
 <c999814651073121c97f2e5c5f273d6674a6832f.1686127032.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <e04fa577-870d-e3d9-a62a-ca35d6d8ae6b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2023 09:42:37 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5525599754649600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5525599754649600/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5736705987182592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5736705987182592/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4610806080339968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4610806080339968/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6651499661492224
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6651499661492224/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/20fcd539d088


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
