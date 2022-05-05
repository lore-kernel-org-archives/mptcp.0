Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F07F
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 06:15:24 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-edf9ddb312so2413481fac.8
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 23:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=hxGBSv/KC4suQz4UcNMUSKXvLrwAyVhvJCrQVE5C3oY=;
        b=W8wPzAtkR6U8hWYLxrXEgoOwGLJgIQ0v7IBkEdYGk0/yvqrAJXzusr/Q94nHUqPiYP
         6Gsoy6E3MftOVASjGAQc6Tk9AA7Sdcp9QftrhhQ2UIsZhzRNrmIXWgkYkrM6zJDtj1k8
         MTJhFp/vDA297A5XEJ16bsg9Rg/xrCWg3IsKDciP8HECXlE6j4B0N1dez6CtwQ19G5kk
         /HLIGGQ0F+yfrXMuh/Rcpvf3HpJL7Z+GKtc1GRkpQzF8rSqThIGLSz0QUth5ygRKlOKG
         RRRQJcsGobPvRybuJgM0SqQLLMK8I9e16tux6uXzDl5ogH1OsfGBN/nhBv/81BrSU2PU
         ucyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=hxGBSv/KC4suQz4UcNMUSKXvLrwAyVhvJCrQVE5C3oY=;
        b=WgfOxzk1rRNX6Y1xo2hZncyCi00n+Yk5AGfEK/DsqZ6+LGmpf2PShN3nU+xRqSRiV1
         zTdPEAjJdyLR/dta8fIOpVJBPWF4eLL3XV7fB9WzTXBtiVG+8JczoqwnqAZDpVe77/DI
         f2le0Jsly43YgLfQM9OIM7eUIGKKV0tUy0vrexW91PXsUpuxP5FTpRzDKoPM2HUtZeXQ
         X08TZNiapkyaWbR7koFQ4700zTj5FN1eVfQNEZqidjX8NNLdnnk8peVQ2xozpwly+TJ3
         H0HYLZwY3+yKGYaBNb9kOHT5FPwxA//gmv2YK/++ai11+qzHrSG3wEmHNzZ7R1/gw29I
         bPYw==
X-Gm-Message-State: AOAM533B+6sJUfbmgu9SApNnYMt6/OW3FVG0dOlQ1PYuohHYs9itnpsk
	uhKhALKtJyqlKRp1I3yxjw==
X-Google-Smtp-Source: ABdhPJzs0sXx0VD/88fFqLXoTANFCcayfqkr01ND8M2VJ2CF5U7rYCcByKjBeKn6e8XFW9ktckG/9w==
X-Received: by 2002:a05:6870:538e:b0:e6:7957:31ab with SMTP id h14-20020a056870538e00b000e6795731abmr1479162oan.89.1651731323492;
        Wed, 04 May 2022 23:15:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.125.96])
        by smtp.gmail.com with ESMTPSA id y10-20020a9d518a000000b006061debeed4sm272020otg.69.2022.05.04.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 23:15:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5f8677f1bf662a25beea0504c7981ab2e4c5531e.1651724227.git.geliang.tang@suse.com>
References:
 <5f8677f1bf662a25beea0504c7981ab2e4c5531e.1651724227.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_MP=5FFAIL_reset_testcase=22_-_clean?=
 =?UTF-8?Q?ups=3A_Tests_Results?=
Message-ID: <49da7fae-984f-262e-a27d-5d0dcbb51543@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 May 2022 06:15:22 +0000
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
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5938569435938816
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5938569435938816/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s):=
 packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5375619482517504
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5375619482517504/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9174503a1b5a


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
