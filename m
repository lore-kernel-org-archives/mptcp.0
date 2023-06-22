Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9217D0
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 03:41:36 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-62fd844ad58so53229326d6.2
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 20:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687405296; x=1689997296;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL5FfLsafpYRgVQE4CCzom6fgYAE7uxF0FFsMO694kw=;
        b=ShFNX/Bl3Mju0REZh2vE5OSc54L6o8R6Jgwe4J23BZJQ5aUg1lm9XJgCE8lmCsSq1C
         NQfZz4VKJCe2B+iAO98ZiggGkzaIcNqXIkW5kaIU9hKHEv2K4YmQEhYEfBVAAGu2FsyU
         AhczAV7NMj4242gutOBAaHn+qZ4+Le4MeKREsnz+YlC7zjF+4IONacnyI9ttylSEDX+g
         QhnyTRdF+ObKHEQoGQadB54h1plISkwWuPTbCTKemTNS6zZT+cltT4g2kPv0PwdNP0Vd
         E6SsmfxINTWJTjUgJjnrd/Ei7nvHdM8PNyOWOfmzZofDRRqDuU01aaOK5HZ/5FQcNgZN
         3VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687405296; x=1689997296;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uL5FfLsafpYRgVQE4CCzom6fgYAE7uxF0FFsMO694kw=;
        b=Le4xjY8/7ZXrP7JTskWKPicQPR3GpJf8KHWRf2Kh+pl59+qnRtlUAfxUUhj/npSxNR
         jxA/kzSwM8wYo3YY+z8+YraTayRxg9TI0DhD8/VH6GCTPP6VSYgDeJLuccxJQx1cEpgN
         gC2Sk44pdhbs5s/8Zy8dtHYrQd79AjsDsr/u6dVbpRu/p7ShIFVkgRIMv6tRuO0gtIDj
         dZZBxQwzWJ/72aQu02dr0B9zuF8Ky1MW8y+gcFtbwGcDNdmOsq5ujDo9pmGFHuvWy48M
         pvdxioK39CDgYuVE/b9owlsnrNMuHyGimYcIqtbUyuBMwUm1D9odWQ4X60wIszpd+0GL
         eXYQ==
X-Gm-Message-State: AC+VfDxSRqZKdL+rVpMc9Kqw54GakAX63r0t4X9gM+Fd93Xx3ztWWd9g
	/u8cN4bDae72VmZV6Fdiwddx7/vxfA==
X-Google-Smtp-Source: ACHHUZ5CqCjeg+t15k6wMLOSDV6yUjbBQswXGyGMThtch5DJXqlyJ7caW4rM9+LnAerFZkqwzgeLQg==
X-Received: by 2002:a05:6214:19e9:b0:626:33bb:3fd3 with SMTP id q9-20020a05621419e900b0062633bb3fd3mr11522808qvc.19.1687405295786;
        Wed, 21 Jun 2023 20:41:35 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.232])
        by smtp.gmail.com with ESMTPSA id i5-20020a0cf105000000b0063003786840sm3271819qvl.99.2023.06.21.20.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 20:41:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: "Yueh-Shun Li" <shamrocklee@posteo.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230622012627.15050-9-shamrocklee@posteo.net>
References: <20230622012627.15050-9-shamrocklee@posteo.net>
Subject: =?UTF-8?Q?Re=3A_scripts/spelling=2Etxt=3A_Add_=22t?=
 =?UTF-8?Q?ransmit=22_patterns=3A_Tests_Results?=
Message-ID: <c57c9aa2-c299-d5d0-ad13-a706aaff1eff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 03:41:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Yueh-Shun,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6237738685431808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6237738685431808/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5393313755299840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5393313755299840/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5956263708721152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5956263708721152/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6091654969425920
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6091654969425920/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8c694d04d00e


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
