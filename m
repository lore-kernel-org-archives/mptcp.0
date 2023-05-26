Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0F1C02
	for <mptcp@lists.linux.dev>; Fri, 26 May 2023 03:37:26 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ae6b4c5a53so1884235ad.2
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 20:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685072245; x=1687664245;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe8587Q3fLWXE6NeTXQx/CUa2bOABerB3n9uAi7WrBY=;
        b=Vd60ESPHtvNuF6NqplKFzgPHwxuoTgI0wD1OosRuInxPcnfhnOrSCvQFCmwEu2PVnN
         x6xUZ6aBt+IAfabETxCyAb37SPZZUdodqKx01TfM1FQlh6do+NfvQ6NIwn/aXnO0Rp5a
         uDRzASY/32brbxdjv/1L23+0SBh0jOFYKzIriqUXTt4BjKOG/5wsIOISApP5gvizm12F
         l6bEpbU6SJeKzoBz0U9V5PZjBf6Ax5Vcg2qrObK7hyMMBPKMOSW/rkL6lQ7KDg8Tke69
         ml8mOPIJL6ew+BfEZHmFJ/H4keGEZmXxVunGJH8gDSKGAfifSQ3We0gbZznmrWyZK2cH
         iXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685072245; x=1687664245;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qe8587Q3fLWXE6NeTXQx/CUa2bOABerB3n9uAi7WrBY=;
        b=Kvp+geo9hiDApy7Y+G7KajWE54np3XhxR4mzOmfmcOGAhTUmUEdq5LxsrBrBhzlJ4S
         RUDDQve+IGEA1oUPXGRJn9jmTmk33I46JGgUMwNkPUOR8kHHXP1kfFzQO1y/VJGGN1N3
         3iWvJ8ShOCRzloZ5LM0KUaop3nnPhm35mla+OcUsjvThgCrq9IZKVzuo1WWRLzxO4r+y
         XDtlRX/rTEcPl0IcSOt2BDuI8c+rQDGUB7RniKoqdgkmQ+cnYhkxzf+xSuZYZPXH7Xsi
         b7Lh7Hpn9fP46tWmmfWTi8gqfmAGplNGMK8woX7NCLt4K/FnER0ckn7hPvC/O2xVFAYW
         7Puw==
X-Gm-Message-State: AC+VfDw8u+wk+qKfwVItY0UvMF2K2+Wm8djaTiAWcArfk5D5h4NS4zW4
	FtJOsFjfQyRE/3X0BgrIdx80FYDsHEhj
X-Google-Smtp-Source: ACHHUZ6fkfSNqDTD56New4snZFTAerqZ5+pauFgim5WdqGmrSVP1Ca/ZQiiGY4ezb6aPSgKfuZ24Ng==
X-Received: by 2002:a17:902:c94f:b0:1ae:4c3b:bb0b with SMTP id i15-20020a170902c94f00b001ae4c3bbb0bmr1343292pla.5.1685072245371;
        Thu, 25 May 2023 20:37:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.101.193])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001aaffe15f39sm2115514plg.30.2023.05.25.20.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 20:37:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ae994823d6d110c718c395a2756e58c52848a12f.1685067241.git.geliang.tang@suse.com>
References:
 <ae994823d6d110c718c395a2756e58c52848a12f.1685067241.git.geliang.tang@suse.com>
Subject: Re: mptcp: unify pm set_flags interfaces: Tests Results
Message-ID: <c845d9fd-4cce-a645-d6d9-42732b0d46ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 May 2023 03:37:24 +0000
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
com/task/4878987764170752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4878987764170752/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6567837624434688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6567837624434688/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6004887671013376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6004887671013376/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_add_addr packetdrill_fastopen =
packetdrill_mp_capable selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5441937717592064
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5441937717592064/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8f6008bcbe52


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
