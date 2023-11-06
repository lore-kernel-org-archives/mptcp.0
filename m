Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9123777
	for <mptcp@lists.linux.dev>; Mon,  6 Nov 2023 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfuHJmGi"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bbd3eb2f8fso4332755a12.1
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 06:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699279228; x=1699884028; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1KZ8NYba3lzZ076YJalSHdYE0eTHZtuHLJRfkkQhU8=;
        b=SfuHJmGimUVQwnGE9jwog+ZAxoi5BFftkD55euH2hDv4BSY0YlFVuX7Jkb59VNN5ig
         E5RcdmqEN7MFL0S/cJiKHY8qxdfBSuQlB3ePrjOVlW+RtQO13xX/Zty1z36bWu2wWQsN
         Ei22mGYgW35EbSoaB8Rznc+18BuVia+PNqc2kAWym0ERS1DJRMVDfRG8F26vwYP+MXni
         ZXqbYmCfjon/wiQwFMObCCq6ubV5/8PoIQuveku5z1+Iycs849yB+4BHTHG8fvBdJdfq
         9QMkF7gw9yL/m24uxEqy4yDUw7MeYoc9RWnXpawj0XE8nTQgJNrQkITtTpdgLvzcZmRt
         1Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699279228; x=1699884028;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1KZ8NYba3lzZ076YJalSHdYE0eTHZtuHLJRfkkQhU8=;
        b=HJaz8qe6QgfwcLJwd2jhUOyCiYBpcJtmFhTBhZNABk3ibdrsgdKgy4gui+FJ+nAkTi
         GqTZxT+7xuSk1e7Uv5bdZSBVE1+JLv4GX4koMFIldJcfZqJZbOAScNb+LhtLV2ELZ05/
         KzWtw77UE5RdnMli5QQdXnP21/vFWsj37vQkmq+iyeT0ptzAR8HIshafsP4UGa+Yu1h/
         gpoo3+IhvaW5Sz54uFFAgBf90PnKEsJQq9ShhayKxnBbdUrelUVWLsBPYsB/xf/QGQL1
         A1Y3i2MhsdfdIOkLbRQHCD3OLSCEIHc4z7rjIsipEb4HU74V2TdfcDDQUHbWvotpWIdM
         a8cA==
X-Gm-Message-State: AOJu0YyFq/G0u0F2cCzjgSzu1ssbyvv+qYDM9k6PYcs6HQidhM15SSME
	tvQBStXWkPc1fyy8CJygZJQ1LvVBsA==
X-Google-Smtp-Source: AGHT+IEHhYjXkvQdLtgcA5sVeEgHXJvLcFWZ7igG1zmhl39C0f/Txn/NzYXMvInngo1xh5Mpfkb2Vg==
X-Received: by 2002:a17:90b:164d:b0:280:fc4a:cbca with SMTP id il13-20020a17090b164d00b00280fc4acbcamr4474649pjb.5.1699279228008;
        Mon, 06 Nov 2023 06:00:28 -0800 (PST)
Received: from [127.0.0.1] ([13.86.227.240])
        by smtp.gmail.com with ESMTPSA id sf9-20020a17090b51c900b0027e289ac436sm5524132pjb.8.2023.11.06.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:00:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7cb131ce1dae4445c05b2955744c63a2d8a1c058.1699275225.git.geliang.tang@suse.com>
References:
 <7cb131ce1dae4445c05b2955744c63a2d8a1c058.1699275225.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_mptcp=5Flib=5Fget=5Fcounter=22=3A_T?=
 =?UTF-8?Q?ests_Results?=
Message-ID: <5deda2b5-5e3a-f8b6-68a1-49fc6564af36@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2023 14:00:26 +0000
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
com/task/5178603151818752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5178603151818752/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6304503058661376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6304503058661376/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6023028081950720
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6023028081950720/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4897128175108096
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4897128175108096/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/527685007adb


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
