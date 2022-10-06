Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7D2582
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 15:16:39 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id b204so1516638iof.2
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Vd/nGHJ52qZEb+sWoBe9CXjITy3j+Jp8uOuLUpeZ5G4=;
        b=HVF+hs+xK9oKwdLXWyiTrlBoQB0VDZRrWAwhP93+eZggLHwsjaMfElRdU6ESf5DLlx
         /qF9qPKGwbLIBSCAomwDFkMzBlbbId6sU+ZBQtOQKWkIwmte57b/gW3JK0yr0jZNJBEP
         dTHhiYvCQzGw8BmsMIdpPXCEwvazCTQe1fUrYjM1EJlBZLMGY2MevPXLlgS9xXRkAgA2
         uwTdzUMLiju3mVZ/FeY51FrRoHoXakz9TVDutC9KgAbncg/c7i5hm+86vj9JqhMIHad/
         5dMqp2S/e/dfhkdh8ptKvZO3/eKiYQtFRSL0Mn/6aY4Kj8e+U04QrcSezaEZXslb9NDP
         Jx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Vd/nGHJ52qZEb+sWoBe9CXjITy3j+Jp8uOuLUpeZ5G4=;
        b=QiCoj7QWkcXrIdWQ2m1JtWdt5tjg5/6Su8HdSdfmaax3J0JHB6tmBigLD3g62SuOxF
         RB8QMfK3nMnRuAkkZIfHToejga0KfOH9+4Z9Iwn6Ai1+LsLGFbYROG6fNb9UaQSiuvzq
         IARGOwg4rNSU+2gpHm4iAyhL1WSQuiVZBMlQs+7UIii+0ezgXJV1MBb2WL24jcS3K5NH
         FPMoUcBGZUdR1WeJ3P4utkV2gYHn1uewwddHZLEUlRK4hxGH/qRjkmOqXkgobpQtE6W5
         wMlwpTnNm99OV0HhD9ZpaPGv6utvp/re1IqVCgRuFuhat0kvcSyP1D0tJ2sexOJEPzup
         Xr/w==
X-Gm-Message-State: ACrzQf1w48CPkCAVfs5joeekcuDMiWLJpaNMMUnGy8HUUq4lit8AMYQV
	/v47ULI0iksZy78iL3Xp6G75hySFfz/m
X-Google-Smtp-Source: AMsMyM6OUhaAcyCuLKJyfKs45Q91rae4oYZurjOKdIFIPPWI2kwRUPnjujAD42zcQ6vSZdlRY5cGAA==
X-Received: by 2002:a05:6602:164c:b0:684:a65f:c23 with SMTP id y12-20020a056602164c00b00684a65f0c23mr149257iow.162.1665069398949;
        Thu, 06 Oct 2022 08:16:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.150.3])
        by smtp.gmail.com with ESMTPSA id o17-20020a92d4d1000000b002fa612b0a16sm1486940ilm.73.2022.10.06.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:16:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221001031502.29152-8-dmytro@shytyi.net>
References: <20221001031502.29152-8-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Tests Results
Message-ID: <940a789d-8ee7-8c7d-42c4-7c4f9a7f8fd1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 15:16:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_mptfo =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/6306020468195328
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6306020468195328/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptfo =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/4898645584642048
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4898645584642048/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7c22bca6e0ab


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
