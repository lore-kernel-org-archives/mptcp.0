Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B577B
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 11:56:18 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id i12so3027897qvs.2
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=3kHI5ZFZzD27mMjjT5U47kSfgFkjDVdb+1LIibnNp2g=;
        b=XkBB9eosMHqDY4zFcv+wUWsWeDIvKDkzh67lyPpKY6Co1pDWk81yYtbd3H09bH3sRE
         B6O4CBTpDrcyZc4oAua268IOb3fJJowLmSPabw8qeIOKXS1RSJzlmvEVUIgfyIwm34Ot
         9Fcri+XHPI/y7WykA6DW3GlfT798l7AOW+OD73oDuMWWsqcxJOk6F9GXElrkQ9UftEuC
         u6CVegR27/8Rf9Gw3X5loFPv3/I7I+ax+rVsw0ULs9PTam7DBUETDqEAKLvvhAmNkRwY
         WRNTssv/byBRW7rALqgGow1DlD7X+vLGlTsk8VQEs/j5PvdtaQye6bRlrkCKur79cc0x
         J5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=3kHI5ZFZzD27mMjjT5U47kSfgFkjDVdb+1LIibnNp2g=;
        b=Zwow6CQRa5FVxCVu79Ku3V5VhdHLvNAR5TZ/U3KwQD6SMMi8pTTTqHsU2vRjIzieMP
         rtcmxpkfQV5TD2jYx04kuK7xdPLmRdzt1Hyo7V8HCP1z13VL2QtUmH0zWPkduMMKCGNq
         7N1/lKS4NmxeSY1j5QNDVe5oWjrV3PxsADMefT3ZrVheUw1h5F5iMA5JzHacHNshSsmp
         2Y1bQI++7slCP+FKCPRe74yN+/LhKX8H7/Q9b44FS4ts9P2QSEBpwJl8GPWfjPJNniSr
         mLror2sz1T1+Wlf8q5jqtgnSSeQcAEbkKqTl3PXZ8cMK1MFzSCvV5qMi1GSY7RXAd1px
         ZR5Q==
X-Gm-Message-State: ACrzQf2gHywGlGEw2wSUlqf+WzJyPBY04Q1pn8/EyTRu2YHaWA+Px/wq
	Pbf5rB7iFT3l++aRqEefig==
X-Google-Smtp-Source: AMsMyM5/+PBlpxNcQ07o4+dJ067LeFJC4sr/2cybALkV1RvA1OfBu1Hti9U7i0PlNVYOTHl03HYNCg==
X-Received: by 2002:ad4:576c:0:b0:4ad:7db4:734b with SMTP id r12-20020ad4576c000000b004ad7db4734bmr25236897qvx.87.1664366176877;
        Wed, 28 Sep 2022 04:56:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.85.219.168])
        by smtp.gmail.com with ESMTPSA id cc12-20020a05622a410c00b0035d27b254f3sm2764230qtb.40.2022.09.28.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:56:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bdd374a7b884fa01a68ff0ef854519fbeb4db38c.1664358100.git.geliang.tang@suse.com>
References:
 <bdd374a7b884fa01a68ff0ef854519fbeb4db38c.1664358100.git.geliang.tang@suse.com>
Subject: Re: mptcp: simplify __mptcp_subflow_push_pending: Tests Results
Message-ID: <291c34aa-8008-b283-a69a-47dda26b85f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Sep 2022 11:56:15 +0000
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
com/task/5267113110667264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5267113110667264/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6156566679257088
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6156566679257088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9801ca9d6329


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
