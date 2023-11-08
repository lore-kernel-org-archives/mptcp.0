Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BDA16400
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjb1+i5Y"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a84204e7aeso79797737b3.0
        for <mptcp@lists.linux.dev>; Wed, 08 Nov 2023 03:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699443467; x=1700048267; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7KBXU0IMlJCNIeB/9znWqxsd3KC97ufTCtiuxlhhoY=;
        b=Gjb1+i5Y1RVvP8Rv55U03vyhA1d7Jn+JnoQ1t9LBL3KiE7OYJuRZwj/ltK4wEMBYZc
         4sry5mUnjabuQHCBhoxAz0T9S+ea/RQyaFKOgBiUB8IzjJ2AshoUCfBngij2H6SdVg3T
         A2sgWx7G4u/vrW4yHrkMoJmRuzWXHasNdZmU+BiMTgp9RE+xsD2BeH5KHcCFeS44EDor
         u7hi6STyEexgtIvMLdFTzpwb0tC7TCxtw1sqFA/pyrpSvou/ujF614clE9U0XD18ZBsy
         ynfOeHIJIDs5Ug3lhbS5rwMzau1wrV+xlhjWpajt4FdmG98CumI/0Z/ph60ZwRotIUUZ
         Z2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699443467; x=1700048267;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H7KBXU0IMlJCNIeB/9znWqxsd3KC97ufTCtiuxlhhoY=;
        b=SdeFZJ+WeBnO5OgDL/Rw9NDZeTWLWP9Dh9XVB3t2H7Tqkq0Nrd8zuUBbbeQlTEMueb
         tG74lz9ApTjYSpCTA0uMrK1GDQwC36MZlkswF0kIItNu9e1aY2DrMa560APHPivgthzA
         iNDcfTLdGPzcSZ9+ryfNEu0Wn3gZApK9OUjWb+gVyu+okZbLDqy/ERZnKNejPmAToOdq
         LI8dXLOSgWsapKXgkjAnIiLU0mmBuN/zVV6izS1tqSWGumqYsC23k8EriqgeKrDTVLkk
         rZR4+BV+kqsL5ZPZGbPCxtMD2pGzGr2cshId6Ym3Adid4/avOU3Ya/CvlFZbbT9JrSoq
         f6lA==
X-Gm-Message-State: AOJu0YyS306pjzamkxp6+mchTz2dsEj9xuumyFQiXF8RoNQHqhPoUqNQ
	0Sev+xLi8ldXCwPQQsRqfQ==
X-Google-Smtp-Source: AGHT+IEWr23sXAR1cx8BWPMKPhHcOoZiHuU1fRsWNeVc3yeK22LVtdDo8wcHIIdkxVprOzFfM2j9pg==
X-Received: by 2002:a25:69cb:0:b0:da3:76d7:ddcf with SMTP id e194-20020a2569cb000000b00da376d7ddcfmr1679721ybc.14.1699443466814;
        Wed, 08 Nov 2023 03:37:46 -0800 (PST)
Received: from [127.0.0.1] ([20.41.24.120])
        by smtp.gmail.com with ESMTPSA id oo18-20020a05620a531200b00775ab978009sm938710qkn.36.2023.11.08.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 03:37:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6f0b31e09a2129aad69c0e7d5ed11c4f4c095a6f.1699437907.git.geliang.tang@suse.com>
References:
 <6f0b31e09a2129aad69c0e7d5ed11c4f4c095a6f.1699437907.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_add_netlink_?=
 =?UTF-8?Q?pm_addr_entry_refcount=2C_v7=22=3A_Tests?= =?UTF-8?Q?_Results?=
Message-ID: <28e1cbbb-450a-5df2-350a-0c7a175dfeb0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2023 11:37:45 +0000
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
com/task/6470760051507200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6470760051507200/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5063385167953920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5063385167953920/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6189285074796544
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6189285074796544/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5626335121375232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5626335121375232/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cc75dae20010


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
