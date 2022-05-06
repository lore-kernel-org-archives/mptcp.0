Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54B2F22
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 19:16:22 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id c8so6068511qvh.10
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=9EBsDdlkGx7RqhDiAoQuBKi/A6R1cCvabS5SoPEwB0E=;
        b=OpfPkK1RuAqn1B4Wpc4Tvy/Z/wsMlM2GOA0Q/C0iE5dKDBM8PS2cHhLzOKW+sTi5FB
         n9UFaCxubbHVQ3DaIeufxVXMtblDuVQMJ/fpNdw5SsIaOaafFMuL9vu6OUz2hi3bEQ9h
         dY5IlxN+bL52n5OGpvtPS1H6Ym2/3TwBTDC2oQOsGWwqEC93Fx9GWwt3KQEguUy9iZL+
         rnElajhljN5+B5z6kXQuZ0OFvxmbnByHPgHnuAb9NNyIuM/mqE8V+jVyjZ/uKkCf1Suu
         cdty+TRlzpu9iJpKf0TfjVTPUT2ZjGTlZYEPkJQaPhufoC/R5P28DFNtrI6FzFlpchrH
         E19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=9EBsDdlkGx7RqhDiAoQuBKi/A6R1cCvabS5SoPEwB0E=;
        b=4s9xpRdbrpAAA4Ok97UteFyhc17EflyzcMENPA8rqvhx6jTpRwqsju7iO0zSq5mPrP
         fUWPPztLP4ihhwPDpm6feT7jk5zOwCTqjU1ZJKmD/VPgoYkDmbnQ3Nb2Hs9qv6hh4yVh
         L853vEcBiaSYAgUzOp0P7JmfHT/ehXwcCOjim1kSjfKdW3Se7/ZCutCAcv03rt/9Ec33
         6G9cdDKGttwCmAbx8EdfU8jeX/ESoWw0dXGePO7NEonJUmLBx6l1m5pqdbCNz0NdVVQ9
         DITNeSGN4D+RFuDkjrh9oFF5V4b52khpeRkXS+G3Mh2YNP7IrYlF7e/hkny4tKyF1UhG
         nrlQ==
X-Gm-Message-State: AOAM531qpu+rXdf2OnoNYZvsk53IKkiQFDSJkJWHuBEYbMiTBrat2sjS
	9FEFmwxzhLlesLGAPfSlaA==
X-Google-Smtp-Source: ABdhPJxqLuekqvpld/f5GpSfMeJKYxm2vNNpB5SB1eg7PUHnE560D7zuyHrFo4TF94LKmcnZ19PZCw==
X-Received: by 2002:a05:6214:29c4:b0:45a:85af:57b3 with SMTP id gh4-20020a05621429c400b0045a85af57b3mr4105453qvb.94.1651864581695;
        Fri, 06 May 2022 12:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.39.34.97])
        by smtp.gmail.com with ESMTPSA id p185-20020a37bfc2000000b0069fc13ce24fsm2909627qkf.128.2022.05.06.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 12:16:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220506171819.1104074-1-matthieu.baerts@tessares.net>
References: <20220506171819.1104074-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_subflow_limits_test-cases=22=3A_Tes?=
 =?UTF-8?Q?ts_Results?=
Message-ID: <fb07699b-2b2d-60ac-aec9-a567698e6036@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 May 2022 19:16:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4956666226540544
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4956666226540544/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6082566133383168
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6082566133383168/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0f00674526dd


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
