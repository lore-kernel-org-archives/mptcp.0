Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D141E536
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 21:25:41 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so1478811eaf.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689283540; x=1691875540;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2Zl7CWPExydXU66s9MlWRaB17TCUD0yyj/GaPYtuYo=;
        b=pVc6r/s6TZDPN4lLCb7xUYxpumTxcXmxQzgGHsGcZjVeC4yhc7bCg2FIMpgFbwh3PP
         s4SnAKMyBBdFNO+84rqYRrTKoMiKx7epa/0SzvtB/zDi18E99ijX66fCEOv1UQkkl9iD
         zP/ff8aBKFT6+mXLCbEb/CZ7PAhUaRrHvEg6x70QSoAHe3fYRjaZTtm6Nclb1xrJqPH+
         OclHLVyE2T067tliRHQY03vpTR/vZYZjBiYr3KuDzsj11ZrXKgbJ45QqCumuUmVz2fdw
         47MzDGRve4/m8Gnm0qtQ++q6lXloHhv0Ks7BGo9+YEJ5RnnKcmgCEstVWGBmooYjlxAp
         5sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283540; x=1691875540;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2Zl7CWPExydXU66s9MlWRaB17TCUD0yyj/GaPYtuYo=;
        b=RqYDmyb0x8o8E6NxQx3+GrhvYHr75PpiRE/LnS1Bpda9rpPJ1X7qv4pKArItAorlxA
         /oTZaqtr+xVKCIKs+6rhqGUxvFZeiF+fW/bpljTinheeQxsN2OklVBXgf3yHamWUAJLY
         zLeX9Km2Ij9f54fsRYddlEwFE73k7jfg6Rbr8vH6yZVxF/2+SPaxVCn1hXK09hWTTOkq
         uKtQ83V8g0OfqQoDCQFUIT6dyGMqaVkkaDIGU1dsJCLEtgQUJM5k6+tmqlqtfxVIhJwn
         xotnvXP0lk/pj97Cpor7d9V/qTfQd8kMyEn/kx+E6qBuYRjEvam5/1qc0v13159r5gSV
         zIDA==
X-Gm-Message-State: ABy/qLZd6jdIDFAxUurq4xAKXjWgWVJjYG+ONhNRGVoXA69xmWSjmGPE
	HZWIqq0pTEVdTJzSBoQ8Rw==
X-Google-Smtp-Source: APBJJlGlACm58KvAcL4VOnKUWmmWmHMgrPdR6BoE9koqpZm+zEnduAmfzBouV2j7OUkpNGWTkgLN2Q==
X-Received: by 2002:a05:6808:d52:b0:3a4:20bd:403f with SMTP id w18-20020a0568080d5200b003a420bd403fmr563574oik.20.1689283540360;
        Thu, 13 Jul 2023 14:25:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.72.44])
        by smtp.gmail.com with ESMTPSA id v6-20020a544486000000b003a1ae2d2638sm3306424oiv.7.2023.07.13.14.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 14:25:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-2-eb9582b8e24b@tessares.net>
References:
 <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-2-eb9582b8e24b@tessares.net>
Subject: Re: selftests: mptcp: userspace_pm: unmute unexpected errors:
 Tests Results
Message-ID: <4b91a01a-b739-6b37-9cc9-f8416206252f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jul 2023 21:25:39 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6042680732418048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6042680732418048/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5479730778996736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5479730778996736/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4776043337220096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4776043337220096/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6605630685839360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6605630685839360/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/eee505968adb


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
