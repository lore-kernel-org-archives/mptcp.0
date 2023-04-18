Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413BAFED
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 19:59:08 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id e13so13082747qvd.8
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681847947; x=1684439947;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeG4l/cplLjp3fM7EgX46v3oIWTBensSphvxfOUF24k=;
        b=Oav9qQFU21sNfFyYb/urX2UWGuR1g5fAikI0VRCfU019QPAita8WxZPM/GNld3wfe0
         WKPWlE4dGxBXm+PGuAXtK6H+kdsXmoP74hC//r6TcH7xqBnaa1dBHXR9jmJU4E6JEY4s
         TdZnEuqI9Xnq+GhdfyPgDFfVY4IJrPCLBA1n2sZkAeDkk4YYVYFELlZTJ3/EhrT/T2Yp
         5LGB22MSDxYX+XTS7ym05Zar0IHbHMM4xw7e5fsbYYxP3IxweemoAJAHArJ6wxbqMUWG
         1R+EdukS2GVvkoKFXWrrghtM1BZ0Sp3UAf0hdclLJGPIyNkUDBjU3/y7nqiZfLi9wbBg
         kpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681847947; x=1684439947;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jeG4l/cplLjp3fM7EgX46v3oIWTBensSphvxfOUF24k=;
        b=B6Z6yi/a0wmvy5LtOvSok7rcFJN1zSecUNcNu8DZMIjncXVdU5bUYtW6mzoYsvym4m
         R4lI5psyReYeNqlmkXbGs9JRbYvAShogo4wrIHCYQJUX2pbpo36GA3wnZ9/6mEuHlMGu
         Jt2k3/xLwW8t0AnS8OrskqYI3nG8iBE8K1l1ZzC3NLPYUiXmrtsGrOp0pCsH/KH9AwSi
         fyRrbnD5rg5Ft6MFBYp24LIlR5c+9WBztk7clT4/Uce4lJ0Lj+CQMHt63IZnsNwqQqmk
         GcSBWkXe/yDIAKYczjKmB7n1CU8xGw4660OXc6C9wrrvakHanVOvhfQubr/xkFQGTQl1
         XtAA==
X-Gm-Message-State: AAQBX9d9nflter4q1Iw0ZAFk6wqG5Bped9XHQsrzss6tyoR8EVwgkf7k
	xdT3NyWlTXit0eafV8nDfX0sRP9cMoLQ
X-Google-Smtp-Source: AKy350YQlDaaaX+SVaUgAw5G419dbrANbLeo8fzF7Aq0T8Cw3chLShHIoa9fAGvTbLCbjncl2Oh3qA==
X-Received: by 2002:ad4:5aa3:0:b0:5cf:fff6:57cb with SMTP id u3-20020ad45aa3000000b005cffff657cbmr23882523qvg.30.1681847947486;
        Tue, 18 Apr 2023 12:59:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.65.70])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a269000b0074df20fb43dsm1785178qkp.97.2023.04.18.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:59:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230418185730.40775-1-martineau@kernel.org>
References: <20230418185730.40775-1-martineau@kernel.org>
Subject: Re: MAINTAINERS: Resume MPTCP co-maintainer role: Tests Results
Message-ID: <96d36a13-c855-4e1a-435e-31873b490e31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Apr 2023 19:59:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4911126266249216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4911126266249216/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6037026173091840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6037026173091840/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6599976126513152
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6599976126513152/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5474076219670528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5474076219670528/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3daa6582cd5d


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
