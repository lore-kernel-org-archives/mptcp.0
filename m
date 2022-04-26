Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33587B
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 06:16:12 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id b189so12474461qkf.11
        for <mptcp@lists.linux.dev>; Mon, 25 Apr 2022 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=gdfeug9d8WFiTGsq3vtR3zPH3zEvJl7KNkUIWv9jyh4=;
        b=e/oFY+DxX3MCGztd16zCapGKn9PWGsBN1nzcaxE+g2Paw0KWOTOIAiQ8RS5Qyzbi2I
         0MiewUf3YtwIkyC1GWYJVGRSipEuRLMAB2Lhn5Go0605tePGSlA0+Qnj14pFppOUZ++V
         fmpoLD9NRUBtaGBx3C/fqw0wRnuhRMvslAOElVv50kj8swlyZ5SgQltHDXfUzQcvqGjN
         BypcB6Q7kZttkKqfzD4UAIdfsJAreVWq3OpShjAwQPI4q4gxq75tFurUp8m2Hb9QqLuz
         umaIkCxO5i3p/on+EUYF4goyQaaB0yg7DTy4yKCIgsI2pgniD5YIlUFLtHg1XWaHjo5x
         oy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=gdfeug9d8WFiTGsq3vtR3zPH3zEvJl7KNkUIWv9jyh4=;
        b=oneFX57QsWBXfg6ijtkQAP71U11eiRU849X/f6La4SY7NHGjpdS7NmSvqEHnQOz3YN
         ljTN4gmwbsN7CzSqxyrKKZGudhL2r1bACnvzLr3VOVUyqCYF8mBaciKl1HtS0Xw0MGWT
         QYcDdmkRYvU4cv1P8y66+bj4kFBmkrQ0G6m+jpTY5qeJT2vw1fbSOOa557DgzH1/XqVD
         UavBGEhXLmSXdwfbtGnYp63tJNcte2S1LLng5t/gNMML+tNNNp7yWHUsPrSj0bhXqNTo
         COOnQGXMyLTJaWGz6mn4LRTkcf6rm9QY8szlXK5+lxmCQ/1/X93ZROeOuT4mod0OxXbR
         cgMw==
X-Gm-Message-State: AOAM533OdZuhaCPVjJaoWp/uGLWdDJZAaCa0KMjvBgDeiS83BiN4aKyQ
	lcMFLv26rH+gh3aSisCBzA==
X-Google-Smtp-Source: ABdhPJx7rVFLOeVDb/vIL5xKi9mbLpQND8Yl3zDjSEOLnQQU5/C/xy3kzrkfWxfXrHwWVmufMIL0ow==
X-Received: by 2002:a05:620a:29cc:b0:69f:402e:ac38 with SMTP id s12-20020a05620a29cc00b0069f402eac38mr7109334qkp.131.1650953771763;
        Mon, 25 Apr 2022 23:16:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.70.82.114])
        by smtp.gmail.com with ESMTPSA id l130-20020a37a288000000b0069e8290f28asm6132336qke.97.2022.04.25.23.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:16:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
References:
 <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_bpf=3A_t?=
 =?UTF-8?Q?est_bpf=5Fskc=5Fto=5Fmptcp=5Fsock=22=3A_?=
 =?UTF-8?Q?Tests_Results?=
Message-ID: <7df2abff-b550-01c7-15c0-e9618ed445d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2022 06:16:10 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6067994064322560
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6067994064322560/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5505044110901248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5505044110901248/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5bfdc296d0ab


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
