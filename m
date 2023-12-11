Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1521A12
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bevwATo4"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77f46ae7e5dso213358785a.3
        for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 02:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702290125; x=1702894925; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92Hs4NoD/IsLCO1tVRsMlDHbGnSEcnN96NqbHPyaozA=;
        b=bevwATo483f8AN0atAMdeu+7zgXhH2kRkzC03Qjl0Z1NGr6CWU8KQwSt+6gy1JebnJ
         keY8j4dL1yWKGrsnsm4tDcGwVVRmwB/2SQw8TXHEAChu0SDJJbh8faZbCjvFaw57xQh4
         RTkLk7vlWti7Xy29xkbPikRahUEH+R/X7K02cHFAmFBAiCeVlnv1+oTREV3QNpKypI3u
         tXsspi2H5+0karnjxse/6P19k+Wlna53f+qGqwNA/F5EoOb9XDI7XZTmoDrag61po5Bj
         ZikJ7Us8RfqB+Q/epitADmJAdvw3oOWweqydxs40oiK/L2nUTqUsA+3d8879TeHwagP3
         gKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290125; x=1702894925;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92Hs4NoD/IsLCO1tVRsMlDHbGnSEcnN96NqbHPyaozA=;
        b=fgtRhJqiP48bU0UE/Wr1JXJOQHsG5Zbzpz+2DGgQU31PkwfslEMCZjDa5O+SG2xn8x
         Kak+baxeKYniTy9g5Dgx7fS7r1CZ8fQRJG1qSlzoZXaJng2rYZ4UXaHl/RLeltKRpKKO
         7cQe7zbqddnTmZl7Wsm6n3J/vm/Z0rwUdnKnGyvP97XMfD/eakT6tIhFn5l6tg/1Nq6k
         xNPupPOUq5iyV1q3OSc+z+ryY+3SI28vrHPRS6T6faJ+Lc9T15FhhwihbGWTmF5BR7/2
         H+/Dn7jk/kY1cYmuhGywkqNV0aagMZtPthHaaf7kWOOzPnGts7kOjJ+8MhLrajkcZ8vD
         3EBA==
X-Gm-Message-State: AOJu0YweaOb62I23C1XP32FOeNWMfjcUwg1i+yLeT1ClOvFrr1kVaLZS
	PUJDElxQzjF3Oy8zNEgBfA==
X-Google-Smtp-Source: AGHT+IGYHBkFxgy9NsRyZ9l9XZaj/UJGJ6N6f8T4KIcUcx39PXkT31R3zc0Nw1WRmmn4EoFoW1Bk8g==
X-Received: by 2002:a05:620a:1922:b0:77d:98aa:e12c with SMTP id bj34-20020a05620a192200b0077d98aae12cmr5614344qkb.71.1702290125137;
        Mon, 11 Dec 2023 02:22:05 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.244])
        by smtp.gmail.com with ESMTPSA id rb17-20020a05620a8d1100b0077da601f06csm2794070qkn.10.2023.12.11.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:22:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c9e4a8d33fd053688cded770ff95c52dc19a95af.1702282650.git.geliang.tang@linux.dev>
References:
 <c9e4a8d33fd053688cded770ff95c52dc19a95af.1702282650.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: join: check CURRESTAB counters: Tests
 Results
Message-ID: <4f6acde1-75e1-4df0-3ab9-51e61ac2a5a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 10:22:04 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5150973962747904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5150973962747904/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5995398892879872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5995398892879872/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6276873869590528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6276873869590528/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastclose =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4869498986037248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4869498986037248/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/392af619f825


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
Bot operated by Matthieu Baerts (NGI0 Core)
