Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58214F9D
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 10:14:15 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68fac346f6aso5983270b3a.3
        for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695204855; x=1695809655; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeB8Q1k06pOmFd/zB96J7+6VzYmBp1F6jOLRXKby0UM=;
        b=F/nGL7IqPTl1Hs9b7ttz5AvRZlxIBUxiYkG6M7wadHa2Je2DYcbwdoX8fY0YNuFvwF
         RYiyAajjuwogk1Q28ytWA/no+KjwDK+xdom1RkvUzy7aeb0vLSRGnNfr7DmPrKKPF0+0
         DdC4IrD3Z8MUabIg4Q+sdyQS1Fii54xKOLsvcLh4WCc+yWsIcc8yvMlVazJ06xM4MdgF
         UAYKCt95jDn62vYwGw14gmKms7qw247wzrgZ9z/c9hiXTBkhMGqEBPhXF2Ooi0dnd1t1
         qV2da+J5oN+2s59+d2ca6INkP2a6FnLybu7OKf09vXpThI2nL6fI9aypE8Hps2Y8r+Lt
         VtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695204855; x=1695809655;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yeB8Q1k06pOmFd/zB96J7+6VzYmBp1F6jOLRXKby0UM=;
        b=WZXz2n9eg/tSTFnoHp5WHYqrMtPDecs9b4sywMq2py9cDuBv+UJiHXoUGavpRnR7Dv
         wxuZLrucVrqSTyX3pW9bS13LMiChl/Rn+DvQFF1CFWwRCXG6Rja7aHrfmINhUaLkRtSw
         Kl9djJgjJU51cha4ZS7vp9GKTNe512Spn2faqIsxpgv1wkvh5slq+xqEwPMjwFoHDpYZ
         /Xmlrg+eC1bSdkao1OzKuB4tE7f+Xfjfs1pbZm7qWWOcUGD0clcUl1RZjleiiXidKxit
         yYdVqqkqSA5T5K7K4+2BbWFKqRBBjlK4aVvPm34vYbLaeVbgMQ8jBsU52mvTwhtJSS7S
         hujg==
X-Gm-Message-State: AOJu0Yz/oFG+aUwi7mdHcjPQGL8zslNByc/2HSH2a3LKFVNhWodn9AWL
	xeQOvqYGp1QQba9zGHeJ7w==
X-Google-Smtp-Source: AGHT+IE/V4/D+huoOLFtQb94H0ligXVe1efTg39P53mSAMnErFTixs6KrlsSD3sjdu2tEuSHJiRv9A==
X-Received: by 2002:a05:6a00:3906:b0:690:2ad9:1454 with SMTP id fh6-20020a056a00390600b006902ad91454mr2197020pfb.33.1695204855240;
        Wed, 20 Sep 2023 03:14:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.100.5])
        by smtp.gmail.com with ESMTPSA id fa35-20020a056a002d2300b00690cd49cee2sm2023911pfb.63.2023.09.20.03.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 03:14:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5c1ff76635a9a7453d7a315a739c83d71a44536b.1695200723.git.pabeni@redhat.com>
References:
 <5c1ff76635a9a7453d7a315a739c83d71a44536b.1695200723.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor sndbuf auto-tuning.: Tests Results
Message-ID: <57d44841-6794-081f-6b15-63816a4192d8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Sep 2023 10:14:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6640879297888256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6640879297888256/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5726085623578624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5726085623578624/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5163135670157312
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5163135670157312/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4600185716736000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4600185716736000/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/96ce451d7205


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
