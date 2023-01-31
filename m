Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F833E7
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 12:11:14 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id v3so9896262pgh.4
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 04:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r36TL1YSx9y0BjhyShy1SglgqbwHsMS4oN0j1cAsWT4=;
        b=nBdwJlNPboeRM824VV5MHpSSDow3NSLTqaMu/Y3mejvWjOX9mUgH/6KKWD8W5Ivm5j
         AlDZ5GvxfM4/i24PjARxlDc8k8flQOPDDCgGoBwThE7xit62UgXuo9v9CcQp5+88AA96
         Zg+r6bnauS4i1d0Wsz5QM54m0zHEpHpXKceYuKLmaJTmK8ZNhfVWOJCIMtxt6Qwuzo7s
         o6QbPL/nh1Fb4yFgiqoNy09dlMLd2hcz3e4no/ueErnASrE7LlwhZCifM7NXn497XU/Q
         NR3ou8TLhRHmKCU/vVId4yKOSSDZvOcKcCr7WyXRpp/KOJVk5C5eQNktWczFUaEq0WcQ
         qQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r36TL1YSx9y0BjhyShy1SglgqbwHsMS4oN0j1cAsWT4=;
        b=1aD9LUCiv/Sy1fX+TAT80PpgyOQEXF9YC0jCq3BHBuZvVL7krt981jd8xyq9EVS5px
         Nocn4DBRP8o2CcKeNLIEgSXUCq5McC4kqf77IewdhaKG9/wIneVFf/DuQEameywfX4Vt
         zOWsfD+aK7bkYHKUqjPD0UGmmH0nt8W/IagD4FvQnTyeVuqfzM5gQu7h6skDCP6SlUE4
         xMg2R0OYN7iqVi0ldIJ0K7ClxDQA7q0KZJIJwrwwi4weZ/iruyXsJu9QtnTb5pIeoWfy
         2eZpuZ5WE/lhdQSzb14abISyZiFG/dDh0V8zMxzH7yxrYV/SPqMPMOVdMrmb7qso1CXh
         sEFw==
X-Gm-Message-State: AO0yUKXWntWgopJAOJ+rr/6BGx3DxRUpsemz9DyjjlkirlMFGuuoopIS
	LGXABZIt+x/bNN0AaamfYLy2O7zasg==
X-Google-Smtp-Source: AK7set/g6CWA/32ILAH/OGRTvD8795TLwS43OpSWM0wWNReAZ+u0M4ELz24XIw+XRDzTf1TPsRc/xA==
X-Received: by 2002:a05:6a00:349a:b0:593:96a2:d60a with SMTP id cp26-20020a056a00349a00b0059396a2d60amr11137308pfb.30.1675167074378;
        Tue, 31 Jan 2023 04:11:14 -0800 (PST)
Received: from [127.0.0.1] ([13.91.160.245])
        by smtp.gmail.com with ESMTPSA id 144-20020a621996000000b0058bcb42dd1asm9328908pfz.111.2023.01.31.04.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:11:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9da09e4407af3ccd51489686c71a3c07c2cb6d3b.1675101940.git.pabeni@redhat.com>
References:
 <9da09e4407af3ccd51489686c71a3c07c2cb6d3b.1675101940.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: allow more slack for slow test-case: Tests
 Results
Message-ID: <0766bdc3-0f00-0823-329b-aeda5e686b59@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2023 12:11:12 +0000
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
com/task/5160588897157120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5160588897157120/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6005013827289088
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6005013827289088/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6286488803999744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6286488803999744/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4879113920446464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4879113920446464/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/196a242b1927


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
