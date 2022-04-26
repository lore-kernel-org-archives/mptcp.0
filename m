Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AAD7B
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 11:43:24 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id j6so12896443qkp.9
        for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=9Ma6ree3M4pfQBnrfj/csu3oPEILjhkiA1lLaRa1EHw=;
        b=KzUvUQs/l372auAqZcXjtZamg/e9NOrEy6wTrPWNZu7ZauFfS5m+iNkbuhHb52zxhW
         EK/s/NDX1pIUoLhlWhhoME+hdgOgeFDNqvf43A+qoE4Hg2Zmiq9mRhoRKlj7TAOW3Hyo
         d5m6c2+ITM+JCeyN8K77eHjLj3ft4YH86jeNEksSnL/k5oukDzTUXw4gYT6Dd5poe0Tc
         svmcAbSq19Uma0QrTQvKGjFg3ea8L8BSSm/Rwn7NjWkvhantPQqzO99NvXHX7vtUhq6x
         QOSQ7KsHgExwdAk/2XYpmBAhSanCSG3q/ZU6zkzFfru7cnfo+3o84DdZ2l5T+yZO7jxD
         t8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=9Ma6ree3M4pfQBnrfj/csu3oPEILjhkiA1lLaRa1EHw=;
        b=1UD/+1HP9iM1TDVeENpyUPx35njb1D2JHU47lpdhs+kIr+SZtbJfleVMJcgm/V16KC
         Jyn4/hIDPounuBhGy9tNIyGghlpmxNYRMm2AgHSOsVfWk4DTUJgdDUra4v/GAFTWMFzd
         F6SzsQ1bjwDab7Dqg/930KHfdV2GWRJZJ/SdeNIeafsuwpIPlnx9JXIqHbdAEtdop7m5
         ddipHa9HMWu6AhGQGpsZYGbbL8xoqIyplSwYSkishyTmyokwK0kXiCRzRDRxdbn0U/VC
         J8XaSkRc7sRC3J44u5uMDW1e/l99EH8eeJLKMFv5JPyJhU1eOJFZxtMfYO9FKaRQfrWk
         j8Lw==
X-Gm-Message-State: AOAM530HhFnEvSZ8gUFTUFFfOwmvLPdN8F+DmRXvK92x/7fHelXZNwcZ
	vpNnOlFxEw9zxwXlfueQ8g==
X-Google-Smtp-Source: ABdhPJwraWzjqRmMFSDYh9ZU0W1cjDQ/o/qp0NSJzZTVEfS+GUCaad/HF9EUCh5G3sGO1/AMkkbpWA==
X-Received: by 2002:a05:620a:2848:b0:67d:35de:bb5b with SMTP id h8-20020a05620a284800b0067d35debb5bmr12540915qkp.499.1650973403015;
        Tue, 26 Apr 2022 04:43:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.160.213])
        by smtp.gmail.com with ESMTPSA id z15-20020a05620a100f00b0069f7be00fe8sm614331qkj.17.2022.04.26.04.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 04:43:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93623928052528277b9a67f19a1a102518c538bb.1650967584.git.geliang.tang@suse.com>
References:
 <93623928052528277b9a67f19a1a102518c538bb.1650967584.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Drop duplicate max/min definitions: Tests
 Results
Message-ID: <9d5626da-8b81-e4f1-4193-84cbf8327783@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2022 11:43:22 +0000
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
https://cirrus-ci.com/task/5616027676442624
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5616027676442624/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6741927583285248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6741927583285248/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/946d79797988


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
