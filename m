Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1932106
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQfhbPi0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c888b3a25aso41109995ad.0
        for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 20:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696993305; x=1697598105; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nstSmqjrCN+cVVOuhkZAuyZaSqypKh0SDK4PTAiFoO0=;
        b=iQfhbPi0NWDCWT41Be39dHcEalAfcTEhLY14hQG8aHFAKVp+foBeHF8kxExD27ZoHn
         J1X0jLG0BujdbbK7hdSFUShgzrcru6iycTLNI/GtWEiPUjjZGaPFjJg1A3QbID2Aj6pI
         eYYdBuPsenUcnJ84BdeAN+2otzHrJhcUknkEU/NiKd4gbrL6AJmabjkcZkA9eRLEHFG8
         neYRO75fwsYfqmvRnZzN1sxi2+9uEeG4UBSR/orLqjl0R70x1DfH9zV9NMBLBKDIi5qd
         Z93Wrcr8yis59VT7hwvGXHz1DzEVzFgnMU4cdZiLRLVayqNamb6/xwMqwe/3CeKOmJhJ
         LAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696993305; x=1697598105;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nstSmqjrCN+cVVOuhkZAuyZaSqypKh0SDK4PTAiFoO0=;
        b=uyew++02Mxh/Bmsz17uxy4IPI94ZTxKcd4DtH22PlQ/NFo4Yt8C68of0/q3oQJR8I0
         lfgnwVua+gyIZZ9G0z6kwaymiUx4thTSWXrOzTXBYtsifFnjsA213+K5ydScPoUuM1hB
         hi9mk4321U/ws3ZkW+u0nWgFSRo5X4jzADK7QH1sEUis8RBEUqV1T/7mIkgCUYU8+hda
         7nO2tDHoo8ERiu27VmDNxW1K8yBkOm5CcpApPggGBoT8aCMqxkhC6OBOOVczVhFxaC9G
         ZXIpfe0jryGatywiphhzr3f6rhwms5ejuPNiemp2H8XCCpPnBHaX7JLfVtrrXPVzVMVw
         2eVg==
X-Gm-Message-State: AOJu0Yw3uYFpKE+x5B1/VlGBwFBUdqXHzyKYEi0egckfnELKwRT6Rgiu
	Wo9GFAFtTWS97yh0rAOgZw==
X-Google-Smtp-Source: AGHT+IGSN+9S/BfGh0cALrBs/Owvvf5NvndqYv8Tmq6bdE6BqzveFcES3vhmR8KcNCro0Qnp4kGTXw==
X-Received: by 2002:a17:903:11c6:b0:1c0:ad3c:c723 with SMTP id q6-20020a17090311c600b001c0ad3cc723mr21430658plh.10.1696993305190;
        Tue, 10 Oct 2023 20:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.61.34])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c9d011581dsm66432plb.164.2023.10.10.20.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:01:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231010-mptcp-remove-id-0-rst-v1-2-5ce17026f748@kernel.org>
References: <20231010-mptcp-remove-id-0-rst-v1-2-5ce17026f748@kernel.org>
Subject: Re: selftests: mptcp: join: no RST when rm subflow/addr: Tests
 Results
Message-ID: <323023e0-a8b5-d367-19d7-f04b3653e82d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 03:01:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5313016149835776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5313016149835776/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5031541173125120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5031541173125120/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6235504379691008
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6235504379691008/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6234872751063040
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6234872751063040/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8a4e323b67b9


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
