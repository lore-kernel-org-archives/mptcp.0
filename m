Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35238BEC
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 14:50:30 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id v8so7583665qkg.12
        for <mptcp@lists.linux.dev>; Tue, 06 Dec 2022 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjiKyMOubCzKiGiq0Oq/mV/mrQcQmhZeTcZ0O8sTVcw=;
        b=Q1I3qdH/t+6tRPJg61PJkQHAL66DwAoCcRiY95HbceN0yVTJMAWymARQ3yYkb0+hhz
         qSTgddcXSlHHV22vFaSQIdW+6KrxRfBLppo+2aZgdRJ69HNqbEqUAft57B5ZuNW4+rU3
         iJCyQ91y2pMyyBxP4RPU9ymGEVnL/fUrknQA+I2gC8fjSMYSCqTVCUWDbZ4q44Q/qqeB
         2nHEHV8Ck5G4KBrOmgRKZZEXl51CMNFAjQlGwMmLkkrja0aV/rfV5LVLTMe2dlH1YtVu
         KRi1FEdAtekxJ50mossAffKcwAHwgAqxWpCV6b4hoXj3cpHosI2VT9UDBcjDKkKoLStd
         JlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjiKyMOubCzKiGiq0Oq/mV/mrQcQmhZeTcZ0O8sTVcw=;
        b=nzyRk7WZv5DRmd9PAscw5h18pYMNFY5ej/gENi2asIA7+9Zpk2Xa/H81yjQ/zegHyQ
         YlV3vJbeoglSB4sE/6lO5gOAPr6Vbk49qCDFlKn1vYyocYi5Ac8EKJehWg2+9b88VFff
         d9FTFB6r+UVnvfnBYS7OP5H4jvcVv+blq35jG7gO+sn/3QhgqL6bW82yt+VVT6wndZSD
         2ON+G+ZFnx54J2R26jorcUpwUBJRECNWjL/+Qfc/v/XlmqTsxgZeLesdMK3Is7Vy+pIX
         FkF1NXj5kgSySLwhpVtHqxsqzKTLRQuOw1B6fuoykUnLy2B8xwEObahF766Brc6A8JaY
         bmRw==
X-Gm-Message-State: ANoB5pkj3fySoeAWQ9bUmaWaqCrwv/bgbJTR/mHiEom3KSSD0MaCFr4J
	F7jIJ4uiek15WjGN3Kh6RA==
X-Google-Smtp-Source: AA0mqf40KmfcrayYOAOCgI4Jsw/puzFWkAK6BkKmpbzVJhKrsStzh6SibpSQed/Ll+EHy0KCP5ezmg==
X-Received: by 2002:a05:620a:1a84:b0:6fb:ffbb:e8b0 with SMTP id bl4-20020a05620a1a8400b006fbffbbe8b0mr59410800qkb.612.1670338229677;
        Tue, 06 Dec 2022 06:50:29 -0800 (PST)
Received: from [127.0.0.1] ([40.117.252.185])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a448d00b006ce76811a07sm15356354qkp.75.2022.12.06.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:50:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1937ca954785e8dad06aa2157722c7c5409e0957.1670332660.git.geliang.tang@suse.com>
References:
 <1937ca954785e8dad06aa2157722c7c5409e0957.1670332660.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <78ad5392-807f-27ae-e865-ead196314eb6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Dec 2022 14:50:28 +0000
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
com/task/6216965698617344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6216965698617344/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5372540768485376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5372540768485376/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5935490721906688
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5935490721906688/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4809590815064064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4809590815064064/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3b6f8d0d0621


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
