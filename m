Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A10380
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 08:45:30 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-55b85b94bb0so318120eaf.0
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689842729; x=1692434729;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrdRusKffZdCB/A56mJ47ArcmjcynGR1Cq7VF/2n9xM=;
        b=aJZpgTiNVxbx8MIA9w4S/Fb0Nt2XE31lhXYKE1LWZ90BDR6r6prL2qT8BsanB0iAtH
         eMfAQojCY3fiJWwoEOylgtWGp+y4pyLCOVr1GCOa66D2L9eFnEYTnYjiRC5iRdnsTAi+
         2K1wvpfbJ4j+HyyuLTuohNcPivRFwXumkzsTwU4H1P+Vihbh0TRFpujEot/bs1R+Ung0
         nM0tGifd7Ow/CaBO4CAlGDwMnwvXRju1z9ZJz9VQZWWu10olzlMunmwEgd9SrMEJEC4L
         hSNas+P38bQn+Y/8m8p8+lFYLC9bpwMi22fpx2sqwVvR8N19LVxl8Gv6T843EIx3u7tw
         9nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842729; x=1692434729;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JrdRusKffZdCB/A56mJ47ArcmjcynGR1Cq7VF/2n9xM=;
        b=XgKMoCJOPhs+PwM+dL/Otl6xSlf8ZGw2MqkNR3dfqGf5PKAYgT9bZZBTHTtKYueEAg
         usMUs1tGeQfG5GbInAtW2EQBCVNcGVkignrDokcSZwuyC/uGCabAc+keiNZnyDcNTJk4
         a59jD5Ut+XCLuxR62bIp0dKPIpbRWdGDdjMCJbXGhNnyzA2LGjOyTpSAN+0leCjHBij4
         jkCB95JAqoWW6A6tV3YEl305Eq9letTiavkxp2wCXJQAkEieomlJXcRY6YHf/nySo+1j
         utBsIpSV35cY9LP2oRczxDP6Emh5ztNGaKqB7a6ai0a+YARhaj+DkVbNrfIuwhYPF0by
         Thuw==
X-Gm-Message-State: ABy/qLZ3ZNd3UzpbpO2rrbIHJIt0/JziL6//lD2hDobIbhauPeaSI5MS
	1e4trpMH2btAb7qfkL7r9A==
X-Google-Smtp-Source: APBJJlG6UXnZbPxTHWe8b/ZKztpx5LcDfvDUtUpA7tSJawnzwUd5S8syAxlmoSaTPwzM2Eq9yp+LUg==
X-Received: by 2002:a05:6808:2189:b0:3a3:fa64:bb8d with SMTP id be9-20020a056808218900b003a3fa64bb8dmr1113424oib.10.1689842729339;
        Thu, 20 Jul 2023 01:45:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.65.63.16])
        by smtp.gmail.com with ESMTPSA id l6-20020a056808020600b003a3bf96e055sm170321oie.8.2023.07.20.01.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:45:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <af7285778734d7e4f238663b457602cea05a309e.1689834758.git.pabeni@redhat.com>
References:
 <af7285778734d7e4f238663b457602cea05a309e.1689834758.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_avoid_add?=
 =?UTF-8?Q?itional_=5F=5Finet=5Fstream=5Fconnect=28?=
 =?UTF-8?Q?=29_call=22=3A_Tests_Results?=
Message-ID: <8da645cc-95b6-8a30-3270-16578b8aed67@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2023 08:45:28 +0000
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
  - Unstable: 1 failed test(s): selftest_mptcp_connect - Critical: Global =
Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5012928097681408
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5012928097681408/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6138828004524032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6138828004524032/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6701777957945344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6701777957945344/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5575878051102720
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5575878051102720/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/821056f3e6da


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
