Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C003234
	for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 23:37:07 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id p1so5076475qtq.10
        for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=s7obv0O3Af8BN14/qmbVuo9Di8aX1Ipo6mFpl3t7Gmg=;
        b=YDPCB+OIMXbVE5uhzdMKWgUyF6/13nBjqbX2ZjCp6BW19Pg7+/qJnuTahOVVY86a7m
         S1k7V6c2oOSs29+q11DPKVfTxN1u6P/HlnItgzSjTl6v73RGOAq0bU22/4XmyvDfiMDk
         AiK/uS11GuqMsfQYOMktvXiuDlREaadmer1XHAxsTXCbsq6xztH8QsZZe/I0BI8VPOnQ
         UGfBlsyZb1IAWSx/BNP4DSjaLG+tdGQ1bHRYgAMu4ni6P0kDwHNHpnq6lphipQAqEKwG
         XZsaXZaMa+ZV4UlOa6CKhVWH3nb5GDdQdg65hyCST+71FIoCzjEKXarFiiCfm4eLfsUm
         XUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=s7obv0O3Af8BN14/qmbVuo9Di8aX1Ipo6mFpl3t7Gmg=;
        b=A8V+PDl0xSmT4uoa87rluUUVeid4NJVqSvkKbKBZ0vyVSATX/DeHUF5m0Yi4EYkbzg
         7wcbSi+OM4eJFABCUKtNA5fMjiH7bMv3h9xfH+JRI8fSYY/Su8BuyQiWUwmCqi+eG/Vx
         EjbNyQjuTvXCOfLUz+EmkhL5H0MhOSmPlNalN4av1GKg164Vi8uo9+CADhsfbVGPJGZr
         U/BJCbb2yqeFqxMCC3Xhw2QFD2Wg+/9B8EtRBmgAQ4wecF25uIaJJqHGl4T75XTOYsgH
         gn0/N3ThNjDSQRqUq9b3jAuFMfWbl5REO1KujZmcZI00eqdBGDf1sFJTsm7dUnzo2qP6
         hqUw==
X-Gm-Message-State: AOAM530IoUsGb7dkMJqjqTHYCBn4XeXiOWsTnpOshkNV7rK6NTVGYLCv
	xKAzplIdFGNrKKZYsPhJkg==
X-Google-Smtp-Source: ABdhPJzeaelC2RmaA9rkdduAdRVOGBjJSs9qHqayeJMlGu0O9Arx/7XsqlIrbPd0iDcKMVFVYn4CFA==
X-Received: by 2002:ac8:7e82:0:b0:2eb:8ebd:6f3f with SMTP id w2-20020ac87e82000000b002eb8ebd6f3fmr3710751qtj.79.1649979426098;
        Thu, 14 Apr 2022 16:37:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.65.78.253])
        by smtp.gmail.com with ESMTPSA id m187-20020a37a3c4000000b0069c9136a858sm500900qke.60.2022.04.14.16.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 16:37:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220414211920.1987961-15-kishen.maloor@intel.com>
References: <20220414211920.1987961-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Tests Results
Message-ID: <53d3dba6-67e9-42e7-221e-5a7fe33998a3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Apr 2022 23:37:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5991301920325632
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5991301920325632/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag - =
Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6345785569705984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6345785569705984/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/273491464f4b


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
