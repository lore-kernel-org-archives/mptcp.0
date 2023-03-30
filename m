Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094E9455
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 20:12:44 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id o2so19228218plg.4
        for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680207164;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nL1PbzvIOliJLHFeT/q4dHiTHPuw7JWGfSdqUj44zM=;
        b=epzCqMlzlV8+lovZ0CbdjIV8PgqhLNOI7bB0cMWNetjggErm0Rk2YsSDJPJmoY8WeQ
         waQYxgo3yVX7dRju3XviX00RSxkMrzUNxYSehJflxDZKVlj1Ls33qBDFnbbP2BNiW574
         X60S7Lm5UCa49V4tdoVl1JH77rB8FOh+4Of8PpG6a+aaNLCoO8uX6iwDUCWqI1Jxt9Vs
         PWule5bySjqddC0b+CUgLT1/y/mNNoBJxq5xhqvfRQyLgqEwodgZ928xLh7fJcrRdD2s
         L4MuM3i/d38XKb3TfreuOm2mFsBMHq40cxTAujSs7nKC9uRPqkaLZ5sItOLWRkVWzpu/
         J1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680207164;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nL1PbzvIOliJLHFeT/q4dHiTHPuw7JWGfSdqUj44zM=;
        b=hc3cC7oLjkmmJ9P3kSgPYy5mxSvW56hlqk6b4GCYhDshAvqggXcWKoO9kMChTV/ogG
         Nlf14MIkDaR/ClyHKYL5frpGslKeilsLYk5eroSHSQEbcPYj3uLnhzpKNQA2qqGYBA5T
         2Xk5tEDZWGH+zmMgw+kDpwOr+eLzxibnmKT4ola8nCNEQKuzrpFT2vi4XyWkmB8JXV2J
         VLU7VHp7UNJwYnKGdIxECl3MGsJOixnQcfHGN7Iv5MKP+vcWP82Nvrfe5t5ZosFN1u2k
         DuD6UqbbW2/zbVH8GjrziUKiLj8LRUox1/7tI2o19MzY3CAmfXXvelYGiAfyC+kWCAl0
         7V4A==
X-Gm-Message-State: AAQBX9dRTqzSxJOqhlCejR1dQaqeOzatyfzeuRDyeYhCRZvG7L1BByxr
	ko3Qv4uU5/4gXXsbZy0hYA==
X-Google-Smtp-Source: AKy350YAiP+3RaMkmXF0aG/VeLAYOyhTh5oISEHaveDFYmzjTaHm0hDT/M4Jbb6psoQ5PIXuu+B6MA==
X-Received: by 2002:a17:90b:3851:b0:23d:4e9d:2eb0 with SMTP id nl17-20020a17090b385100b0023d4e9d2eb0mr26760682pjb.36.1680207164299;
        Thu, 30 Mar 2023 13:12:44 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.90.108])
        by smtp.gmail.com with ESMTPSA id fa20-20020a17090af0d400b00233afe09177sm3659398pjb.8.2023.03.30.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:12:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b12779f37770dbdad059232c9cb45fbd56afabd2.1680204074.git.pabeni@redhat.com>
References:
 <b12779f37770dbdad059232c9cb45fbd56afabd2.1680204074.git.pabeni@redhat.com>
Subject: Re: mptcp: fix accept vs worker race: Tests Results
Message-ID: <b9bdeb3a-080b-aa63-7683-cd6583f793e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2023 20:12:43 +0000
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
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5776733312385024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5776733312385024/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5213783358963712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5213783358963712/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6339683265806336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6339683265806336/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4932308382253056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4932308382253056/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f3b6d044228f


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
