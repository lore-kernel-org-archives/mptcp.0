Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D653236
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 19:14:07 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id a27so11846048qtw.10
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 11:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8CnCPSqbBbckpxoAKqyABgEMK1xvC0whaxlJ61G5ao=;
        b=oy5ULKPmnEYc20Nd6dSm7zwYYUGflCgp63C0PmdoBWQKkJIBhwpBSu/8Do629oSI61
         2IdiSbT2V/Xcmi2/lOQb0ZBUf8p9pefi7qwo/HDieCCXgl+VWuDMvD/vdzNlhh7GtrRV
         AfWHedDqF+io3szrys74TmldyKm3AavjUxbsB0yZdGMSl6T81uVZXFX1Lbv2Hn6bvGIZ
         d5wwfy61wTn/PPQ+QnbFIMQvUw8WEO9rVpydzTabGxiBqrFwNcez73oyb5/Keh2eVAHx
         q2DvUsOPaePQev+WyVXtnPHFKbUHek0CJBnff+CvgMPj0cnIBLgT57VIBDGfhmkya9iG
         MF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8CnCPSqbBbckpxoAKqyABgEMK1xvC0whaxlJ61G5ao=;
        b=ET/RBIDw1Nl20HK+EFCoeNnbpLNnQdgW397CfIF2+B7S/WtPdgG8bIkTWYTdtofz/k
         hkgVtF2ww30tOC57fuZEplLjaJlIKdBVEO4Shspzz4q/m2DqghzBXAd+Up/igN7kraDs
         +J8bU27DTU86RpEXBSjWmf4ezg6OpvYkeHTFgGaNgzliK6kL1NLHt8XPhUNBj3++x1gM
         BTnRnYK5/wK0stxV2wRgdnegJt6QOXI14U1b47DxVW1MSgc6mJNcPVoFJu3ByDU4qRfA
         wSwwKSzaL9ZYXQJZ5FQdCwYnHDBpRNuZs/RopsR2cbKTY9Uct/T3+YIK0k46yje9LeEJ
         NWSg==
X-Gm-Message-State: ANoB5pmlpjdTqHsxNrVYnyUcEAFg1nsqiyO82WoTzTAohtiIbDOPXWph
	8Y4aSJDg9XavZkkNyXlzrQ==
X-Google-Smtp-Source: AA0mqf59kO5Vo3dqBudoKq/1lvf6LrYpyyPntnH80b2IoTwmqdhdtT0y19+ks9E2i6O+oix/ZA6iuw==
X-Received: by 2002:ac8:1197:0:b0:3a5:74c6:e265 with SMTP id d23-20020ac81197000000b003a574c6e265mr27825894qtj.405.1669230846959;
        Wed, 23 Nov 2022 11:14:06 -0800 (PST)
Received: from [127.0.0.1] ([20.14.198.85])
        by smtp.gmail.com with ESMTPSA id bm3-20020a05620a198300b006f474e6a715sm12570985qkb.131.2022.11.23.11.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:14:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221122034923.804955-5-imagedong@tencent.com>
References: <20221122034923.804955-5-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <a60aaffd-d6f8-9c7f-55ff-e61bae56b445@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Nov 2022 19:14:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6563194622181376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6563194622181376/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4733607273562112
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4733607273562112/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5afcc5ab13e3


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
