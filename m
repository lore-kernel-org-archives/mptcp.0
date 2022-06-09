Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AF77C
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 06:46:52 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id j8so13759970qtn.13
        for <mptcp@lists.linux.dev>; Wed, 08 Jun 2022 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=4cq5T6weyor42e/N1bE8W8pjvh+SeixzNC/wetT8lqU=;
        b=cxrNQmOM0ZnmNnaATIx0IwSmx0Qi7arXaijeD58+DBwAP1H6urzFlvebgc8b1+4BWk
         umwuIUhYzwy9esYOJdstPcOWTmB35+Nik2u+S4IE27QIeW8zUFgp2tL6RdATO5lL0E68
         XxddcxA7OcuYYyAQ4XLXTwPDkgguYPmxh9qXr4m4Wwy0JahDlLOoCXUYT4Pu+Gan8wjb
         pFo5SKUBX6QIqDc93Pd+utzmKHiWTwtPUC+S+uDADGjRN7UdT7OUUeiBfLNXOkwMtYsQ
         kb8iI7oJVSRFAMKtC2q9yc4c/qyrmQR2SdmWSCbiXQl+dckW5AROocHTfG0A7Mttsx5f
         IS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=4cq5T6weyor42e/N1bE8W8pjvh+SeixzNC/wetT8lqU=;
        b=WvV2VrHBQUr1musUCMVSsW8mgNchZD8yMORKChNsEx0wcwJW230QPl0unGRKj+TsRC
         wcOFronX1EWrPHJUBJLbAYvfc4X4K1HVsHZGEP19ADQg6OSD4eiaWjUIEVU7o0rk9nUv
         jltXDMPtZnB09Zxzdk9eFxumqoB+PUJcz5LORT1DDY4gcCt70r7gg5TsoZKbgeM0nJg6
         EntDGDoKx9gR6JJSwH0HebE2MpgPkPuY78KViF0TYJ3X2oLZuR8VYSnUTtmTZnDy+7cN
         qny9DDSpkuFJCG33hKJbur0JVDoEwVIFzLxraG8kUm+SPTEJuozPFTBD2/DwREaYBKjH
         Q8pw==
X-Gm-Message-State: AOAM532cSO0mf9wCmjTR/cqe3Y84HbntonoSjlHYEOoA/jGmx1lRqm98
	ZCfQVxKRaTbyWihUnwGwjA==
X-Google-Smtp-Source: ABdhPJwyieyNPNdjUhsUpTi8Xq2xbThMG2I1Yaj4hvJsaA3gh+IQvcvtIp9AY3MvzJQs3plLFpk5qQ==
X-Received: by 2002:ac8:5bcb:0:b0:304:ff2f:459f with SMTP id b11-20020ac85bcb000000b00304ff2f459fmr7385727qtb.545.1654757211510;
        Wed, 08 Jun 2022 23:46:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.110.136.142])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006a6a6f148e6sm14378097qkl.17.2022.06.08.23.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 23:46:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f5ce13a35164d0c81c47b807d146632795f6255c.1654752190.git.geliang.tang@suse.com>
References:
 <f5ce13a35164d0c81c47b807d146632795f6255c.1654752190.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Ffirst_test=22=3A_Tests_Results?=
Message-ID: <111e9be0-8fa3-1eb8-fd1a-33bfc516b4c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jun 2022 06:46:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6029641566650368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6029641566650368/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5466691613229056
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5466691613229056/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9303f35b0fca


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
