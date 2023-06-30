Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B5800
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 04:31:00 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-635dc2f6ef9so10234556d6.3
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688099460; x=1690691460;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAJRFu2axx6hBAlh+cxhsCaOIUHoVvqD/c13riRk9Y8=;
        b=av0NXVsWW+vHS79WimZp+94qVxXruVMtANfpfsmhul8sGTdfThoU2HhMQWYsgMdn9H
         VJhX2j3x3owqvSDRYWNQYmZm8G3VJMSf332+C3xR85ghexAoxU/i62ADP5wxlf15oKzK
         hxwWZPterbDnOetgEvbHkwGmjC8QzkM2i5bz7vAwfarvoV4ivtHYmetApcouLIRrsKWO
         5Ea3kHrQaKuUf6T4IRtXkX5RqZuEnw20y8bm9i91yFRpSrh9BJK0FFGna7xrLubSuSMj
         SV5NgxMgUuPHu/ZrrJMDNtrsIBBsq6Ht3T+viQGoq9nwb2rJVqFcQWcDBqTdvPCQWBBv
         7Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688099460; x=1690691460;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAJRFu2axx6hBAlh+cxhsCaOIUHoVvqD/c13riRk9Y8=;
        b=Dr7MNct5azUb+bERTvfl7IMA9IuoeVkS1uLVsYDcbVZyXDk3kgYhqlEReHzMQAz326
         fXhQwNbFYkjlEsTOcJu1/DCNNpp2RIO97BU0LjUuRGXvKe7NMkfJHzIfACP/wl12U/AV
         4WpisWu0cgpOTYLgMPJ2tQrYBJVU5pUi1e+DeZXzdTyNdhii55BB2lIWhP49YQhP5YyC
         iCgtGF1oGk2wiu62BGjzDBChBrdI86ZFTrQEGfFG2DL61fik9m7aIqO2LTHaqSx3t2GI
         aOLvxfGu4Jcj83+xtMrhkTwyYQyZj5+Hw+gFqCxS4kMCBzafivclev9gXGHYaprPzwyO
         yDzA==
X-Gm-Message-State: ABy/qLZax07GnLjLKhftFYO3sxqngQYg+zPuyYMArI12YLPo6OEI//cN
	NAsyQSamZ1m2jyFr6CaaqQ==
X-Google-Smtp-Source: APBJJlHAp1iIAWupAjmhPbJt2CQZbGYs88q2oBNMAXik8NLTecweN9H3b/fRc7l2/ItTB14m04jw/Q==
X-Received: by 2002:ad4:4353:0:b0:632:372b:69c8 with SMTP id q19-20020ad44353000000b00632372b69c8mr1581413qvs.51.1688099459666;
        Thu, 29 Jun 2023 21:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.36.120])
        by smtp.gmail.com with ESMTPSA id i12-20020a05620a144c00b00765ab6d3e81sm4972746qkl.122.2023.06.29.21.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 21:30:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d0352b2b949544ce4b87ceeec55109fe22f1fc26.1688092826.git.geliang.tang@suse.com>
References:
 <d0352b2b949544ce4b87ceeec55109fe22f1fc26.1688092826.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add speed env var: Tests Results
Message-ID: <00f2b977-222e-8a39-9c03-50b5c8901ef1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jun 2023 04:30:58 +0000
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
com/task/6689833049915392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6689833049915392/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5124472760434688
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5124472760434688/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5106536305917952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5106536305917952/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5163557768134656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5163557768134656/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/520df9fe8c2c


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
