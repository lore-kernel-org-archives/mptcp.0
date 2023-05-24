Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5A15B9
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:52:05 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5343c3daff0so451167a12.0
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684911125; x=1687503125;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGgIGr+lV6pjs6WLp1KsPJ0UODIzeokKrwkKDb94+9k=;
        b=lYHFYIYRBRNxWwgBGqwZSGbdkGI1uGhUMpkXvDGej5SSQW1dFBSKYAE0FfdSs2nWpm
         hVP/yhpH02AuP+3+FsP4XSi7IuYGhtMCXpaCUmvpIwZ/LQAD4ZwOwELDD3QqdXiaxdCe
         VL2hj7MPz/0tL/oNoEK3LAy5M5ny+pKUIS/iO29BTmzcKb7u7OFvlMwPXvBzvI6UI165
         68f0M726WtvGEuXqCt/M6IhnrdoSAjNb7Mh0v9JSQxd4cpy13Qiqs4dmbhn4P87rBc6R
         GeY05IJ25lV/l+v9r9evX+DMns6CWsEd2WLgetODz/GAwQfuZHVDAf4brV0Rh9MLEbtj
         x6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911125; x=1687503125;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGgIGr+lV6pjs6WLp1KsPJ0UODIzeokKrwkKDb94+9k=;
        b=CCUX8WgXwe3t3/SGedmENcE4eTxhG2mjQShfOeV/qGEo7J1QJxHDc4jy5p/d+5u6oe
         lPFb7+bmw/ORixVB3PprDFhMeSe2yTN8T2WmItsNDNBMSdtfCOQ7TgR0LQpsIMrvUedx
         mC3sLPwlhH3f/yYXF23sfnjCml4jEVaasrChIuWClGy4HrkNokGtKSLQGa4ivmmMLZDU
         VU6QBC1jbj7PX/15TYxcohWy+wfviECC+FJniBAK6A0Qk9eE17UjlxJsmJY6qm5y6g+V
         fHUy0L8rajwnLxy9lQdVY5LrVxd/imoMmNGqja9t32yb4Cq1aaWnvOfyzjHdvzPWOWJz
         GLZA==
X-Gm-Message-State: AC+VfDwJO58kkred/XnS5o0u5aToo5LPvG8Dnjt225Pl4osdKB+c/4Su
	qWRBHF70enj+UH2X05dWrSxvIXjmy2LQ
X-Google-Smtp-Source: ACHHUZ57XI+eRot6NwhU1mH4AeB9Q/5Gcwzu6PsDjXa07r4dM3d5IT58kGCfUUpUmDeR3GLyGzVn2Q==
X-Received: by 2002:a17:902:f681:b0:1ad:e8f5:7c7b with SMTP id l1-20020a170902f68100b001ade8f57c7bmr20105068plg.62.1684911125030;
        Tue, 23 May 2023 23:52:05 -0700 (PDT)
Received: from [127.0.0.1] ([168.61.75.129])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902b59100b001afa7040a70sm6105630pls.276.2023.05.23.23.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:52:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
References:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
Subject: Re: mptcp: fix active subflow finalization.: Tests Results
Message-ID: <7e4db380-5063-9f5c-247c-0946b95027e0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 06:52:03 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6045200401825792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6045200401825792/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4778563006627840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4778563006627840/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_fastopen packetdrill_mp_capable=
 packetdrill_mp_join selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/4825292619907072
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4825292619907072/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5482250448404480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5482250448404480/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6e2e302b0b8c


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
