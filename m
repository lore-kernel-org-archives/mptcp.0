Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F677E
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 12:01:37 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so8694237pjd.0
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhV+PgL05p+AOgOP0hCGBDcg4BK7UCN4HGTbV9vLTLU=;
        b=YtFzjsuF6TChDAdZtq3Mu0bJrsTxtwP+ANwaYDdRyK/iooD0praLT2n1Mqu+HVjQNQ
         4o49vCrrW+RMlmytSpmrExh4uieKk9N1Ek4FJf7U1RDjOXk2bfAYLEAP70DnK7MjwuF0
         K7RSjXREM1W8prTHh/NvFqDHFT87Jy790YQ1YhBKk6LFBi3dMs47KQQbULgscPkAHjX3
         RTm8I2WmPvju8Yz06JunwyLwx/4ms6vlw/Yl0xwtFpFQ3kEUulqz/Of0EuNj8iF3/xT+
         WKHWo2NBwlX/ztIHl0gk/kp3fXFoX3nWH6qBJbHwWyTjkp/QxBUk2kZ+L5Oxt+/kt6ay
         9XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhV+PgL05p+AOgOP0hCGBDcg4BK7UCN4HGTbV9vLTLU=;
        b=po4Afej+YaSFguYP6OLcxNDU10TEDCUFuF6zjsGEsshLuhQTRIz+01Twkb98n6ttEN
         QLd+7+6HwpIc69N7k1iUlZmso1evBKIqF4+F0bh8A/nouO3oNVITmeEWJPTSiuaVppSD
         n+/z0/nEkR1VQfY4fhb8B6IbHAxuQSwz9XZ3/VK2dte481idIeR6JOjthiN9DSiad/mS
         UNpPY0Zst9cNewsqIlHq04qI1JBB5+ac2IQ48+jD71mw9go0sYvgOIbalMdnrlgJad6M
         L4DpUhkB6UAbP9VnmdR01sOMQ6DSbF9jz7CV6nZ1CrpNyV+vcdefZsmo7YCRgVJH2oC5
         87qA==
X-Gm-Message-State: AFqh2kqwmNvJ8AuC5miX5YvipxXA+lN4K84uWLp8nvcnjzQB1flvFbfg
	BNlJKX6fCfUJXoqkNz+lUA==
X-Google-Smtp-Source: AMrXdXt1DiLpQElPL8wuSHmaAMzOrcPoxM2WLhun7WA+vxhcNCNsGX4KB/KXILG/w8JYt8H0AzmPnw==
X-Received: by 2002:a05:6a20:1604:b0:a7:16c4:d2c4 with SMTP id l4-20020a056a20160400b000a716c4d2c4mr14528608pzj.47.1671451297142;
        Mon, 19 Dec 2022 04:01:37 -0800 (PST)
Received: from [127.0.0.1] ([168.62.206.162])
        by smtp.gmail.com with ESMTPSA id r8-20020a654988000000b0046f56534d9fsm6167088pgs.21.2022.12.19.04.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 04:01:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221219102316.627491-7-imagedong@tencent.com>
References: <20221219102316.627491-7-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <22212329-5e71-e562-d13b-5194d25d74c5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2022 12:01:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5688095572492288
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5688095572492288/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5125145619070976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5125145619070976/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5447656726593536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5447656726593536/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6251045525913600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6251045525913600/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c88d4cb39174


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
