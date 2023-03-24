Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03E6FD3
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 15:12:48 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id x8so1761603qvr.9
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679670767;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zWMTHiXXEjYbzesesbehqaNDf8STs1WAuoOsR0K4sw=;
        b=aMgdjcKiBHNezUXXbaoDBhlsDOIKLaC/p9LJxehz6rI/oIEV7lpJoKYePqJMbovjTJ
         5XdoGR8VtYFLHbEYXwvAUPmwHErlB0Qwi9Zzhnet90evuY00txUaz1eQZHyDzQmrm17+
         J4ofx/pkiwksrqJHh/gc8plGTKAjAINOSSm+LbviMUTb3fSGKvh/7aBulAv+DaF4jQqY
         EqdA31cBCZYxkvtgjYHewqaMh1eg/ORgqTtpImI7x3s3cNdO4//drgQ7+UWRLO6a0DIR
         dEesH+5mChB2QYH306wCGNWMRbHJkWxMehPMYQaj0ntn2m9D2aQnpE2VVwcF69DqpUxh
         T+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679670767;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zWMTHiXXEjYbzesesbehqaNDf8STs1WAuoOsR0K4sw=;
        b=lJHIj+F/kGiQhRu5/Orcw7aPIQUeZaHU2Fg8QMiCzpmgybOm0MYqufqGLwTFXNwX5E
         xnXc7EGXxmQLpOR2ARS2mTs0Vb2AGw9TiDy/txInPKxxBACqBzHWTPJK7eqJ/sYgWPjS
         dyu7Fjl0dPU5LPuNXiVUo3LvPiYZO8+aaFo2+SO71qR7MR+LezYv5Hhm6gTRz3vYsRMR
         tIx8LdKNp5q3RgdtyAQvu9P2FLWb79WMCAzzE37QuB8jEa8iWvYi9UuR7Sa2yMspILYY
         it9LKy8spYZzk1AwALemACVoUFd4WkXXVl1yVKUNTB4bDtU0zLEGDD6E4Vjsi4lIem9L
         S6rg==
X-Gm-Message-State: AAQBX9eSExf0i+G0LyDePEE2D4LMcQSDftUrh7FVahwrywhgPo1EMsR6
	8o9oB75G2FTWnTHKbc1K1A==
X-Google-Smtp-Source: AKy350YaxbH9XLMkNPsO7VC3Of084+E/gdEyo6G0/aJhozpkamimM3zLdqzU2eIpyiqU3vvOsCGzEQ==
X-Received: by 2002:a05:6214:501a:b0:5c7:cc77:d203 with SMTP id jo26-20020a056214501a00b005c7cc77d203mr4945457qvb.3.1679670767505;
        Fri, 24 Mar 2023 08:12:47 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.17.192])
        by smtp.gmail.com with ESMTPSA id t184-20020ae9dfc1000000b007424239e4casm14229147qkf.117.2023.03.24.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:12:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
References:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
Subject: Re: mptcp: stricter state check in mptcp_worker: Tests Results
Message-ID: <78ecba6b-9c8b-5607-677c-c39af7d93e96@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2023 15:12:46 +0000
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
com/task/5434954880909312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5434954880909312/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5857167345975296
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5857167345975296/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6560854787751936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6560854787751936/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4731267439132672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4731267439132672/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/79b03f33ac6a


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
