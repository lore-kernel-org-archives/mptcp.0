Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760824252A
	for <mptcp@lists.linux.dev>; Thu,  1 Jun 2023 16:30:55 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-392116ae103so626871b6e.0
        for <mptcp@lists.linux.dev>; Thu, 01 Jun 2023 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685637054; x=1688229054;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DzGFOhisUQvEwowR5Mjr0cgPtU1f/fjssP9ET5W3a0=;
        b=Muj0SWEpKt02RQwfO6ClUTPu5AEppVzb9x8ZLreYJftznztXLSCxMo1kWoprOnVmsV
         3PFR60EFM9Kh3uBY2kjmfJ0O4kIw0KRwJtXVmMXe4esGczc09PoH1fOBldUEDMOfAaJR
         ViUIneCnTSGbRnWgr2obC+weU9neAvMtaS86qNYWp2KCO1guSQuds5IDm/EFTw1Ug/Or
         kNmTA7wEn+UWB/jRr9j12w0uMmUcDs2Znzbt591cQMdrrSiK0RL+wabV9fMjo0DkJMr7
         4o9zi2OlDCiS8usbFh3ISpYcCeDRIpxCxXel7eEHQueXmDgZG7I/Cg2dZzpWt4xTHDNF
         +gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637054; x=1688229054;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DzGFOhisUQvEwowR5Mjr0cgPtU1f/fjssP9ET5W3a0=;
        b=TtZeQE4G6bvLgFlg9pt5sgXMTpNlZMacTzMZSbT30LU+BA3aTqfTfhDQA+DTduNc20
         2XcpAFCDd+giQ2e9N8rnim0ZKDWIwK3yLA1DIChaZ7X0vFo82UYSVoMtUZOITMTU/mP7
         VyFogr65oFfEnYTvDaeJdbMGW6/UzubPuxWNf1tngFJMVvLr3j7WJo3Xr5vPEOv5sd36
         jSBNCMIVVKHtlzHfiJUp4s4VN2DS88+jpBVWWAdN1UtgVrMAmWDo44BTTCsWGp0Boc8r
         P+MpoXKx1hem79poRSksuiYtj1gRtBXBcU/zklrjKHxuESPlVXyjlvvdFNrczcvcQqvr
         bOvg==
X-Gm-Message-State: AC+VfDweqzD99x4/cQS9LeMlCdreSKbaNTt9oVxWtH/qRv/7y3ICcKfJ
	jXwLWSupuMECjmF47vEwYB9HTlVGog==
X-Google-Smtp-Source: ACHHUZ6a+WS0ax0DRGzQbl/s0pNgLOD5G/wBzQ0/Rqs75xWiUtQu52g5QHx6wQJmAwb4Md1+ufycrg==
X-Received: by 2002:a05:6808:200c:b0:398:5893:731d with SMTP id q12-20020a056808200c00b003985893731dmr7070228oiw.13.1685637054304;
        Thu, 01 Jun 2023 09:30:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.36.115])
        by smtp.gmail.com with ESMTPSA id em1-20020ad44f81000000b006263afa6ab9sm3253249qvb.144.2023.06.01.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:30:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net>
References:
 <20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net>
Subject: =?UTF-8?Q?Re=3A_net=3A_skip_printing_=22link_becom?=
 =?UTF-8?Q?e_ready=22_v6_msg=3A_Tests_Results?=
Message-ID: <a6c61bdc-266a-5a53-8f6a-782e982e3a0f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Jun 2023 16:30:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen packetdrill_syscalls =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6453074252791808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6453074252791808/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5608649322659840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5608649322659840/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5045699369238528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5045699369238528/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_dss packetdrill_fastopen =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6171599276081152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6171599276081152/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b9a7c2986f91


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
