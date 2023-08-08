Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4710F5
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 07:15:51 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1bc479cc815so4210952fac.1
        for <mptcp@lists.linux.dev>; Tue, 08 Aug 2023 00:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691478950; x=1692083750;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DHLhT5uplBOidStyFX0Ann8XDl7/3jeImdIZmkgz2o=;
        b=aCJJ2yta4MzqHnKrCkCuE2ly97OIevXrPc3Vacv9DFOijbjN+HlABI1Hovdryaipfg
         1cWKrrNMYD0FIStdgajwhda/DwD2VTxBQTdEeCKs+EE+WCbgDtf1iHZAGiIq/A3xMogu
         MNmXhr9Tmf7Gcbwbz4Ajo1BAwZGohjW4ckbGJ7BfARwK1aeBKQGi512V/mFOvCRevoNi
         UR3ofVGElkoS7vBXlmnYbA2L0D1eWk6CORSi+u5ElQKz4X0QDYGigiPrfnQQjpHbKQgG
         2fAnBAjs3pa1iWtEN3NhNbk2J9CxTC1UgU+WaIaG5VbYMahEfgd3nlZrbha8pP4CNvBr
         9tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691478950; x=1692083750;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DHLhT5uplBOidStyFX0Ann8XDl7/3jeImdIZmkgz2o=;
        b=TPIDW4gV2hHYlOPDoBaNZhKguEycQAPm76sxt0qQHEnqRDc/yOl8EvlKJWTk4nqCZj
         g//tKnIAUg2YjVC7cCb7Gw+L3Ld+LnP3QdXqsv6R9GmAQvWeEzHdm98TDuaYod8sdiDE
         fj2TPq7974mDmBAtj1X4OOH3DLIjnKsryzt54CVFSA+z0867aBk5cAKYw6LeNhOaIZb7
         Ihe2DqwkHMxo3juSkKrP0Ha9l6e0NB1RVdcK7oZJieBNjfEjpZ4uZHpaZwUtdwvHp9qw
         1krJyz3P9RhPryU9yTnKDci7Ez6g+jYjkGyLZiM6cDpXkVkJ/6N6sutqYr/DuMU1tt+9
         x/mQ==
X-Gm-Message-State: AOJu0Yyyru/MDKpr/G0n3AiuUEo48fnSpZoYVi21omDaWeXcz64xPKbD
	0NPomjotuhIGFV51bEBvQA==
X-Google-Smtp-Source: AGHT+IEWqdwI0ChRla1ydZN3yQszQcSL5w7dSW1zXUsYG0BwYfN3yroaz/TBKtId7wGq2pBGbpoo6w==
X-Received: by 2002:a05:6870:1693:b0:1bf:b863:b64 with SMTP id j19-20020a056870169300b001bfb8630b64mr11340288oae.19.1691478950653;
        Tue, 08 Aug 2023 00:15:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.170.41])
        by smtp.gmail.com with ESMTPSA id zb10-20020a05687126ca00b001b0550b2affsm5790014oab.10.2023.08.08.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 00:15:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <da02f0f5c092e1d069fb0fcca92653e9fd4adea1.1691472939.git.geliang.tang@suse.com>
References:
 <da02f0f5c092e1d069fb0fcca92653e9fd4adea1.1691472939.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: remove id 0 subflow & address: Tests Results
Message-ID: <12d502a3-6d1b-c27b-06b3-a34927084494@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2023 07:15:49 +0000
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
com/task/5332343926292480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5332343926292480/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6458243833135104
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6458243833135104/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5050868949581824
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5050868949581824/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6176768856424448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6176768856424448/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8b35cc97750c


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
