Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311018053
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMR8FW8"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67ad032559fso42554436d6.2
        for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 23:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702451532; x=1703056332; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAsdhcqVVRgOKXcf46m9UC6oHbb4/P4v8mFUOd62Sh8=;
        b=FFMR8FW85DnA2zc39YChNceZ9NK9I6gneYkEGl9xI9RUNg6agxAYHO0EmwHywq5b20
         K4/zN1Fz0Sd0vNE4mFNSj6Pafu0Dx4q6SqIsEJtCXx8S68kJEx2rsdpO5Fjp/zeKT6Vg
         P8miMkLijCStDXOC6cOUnvAOEqA0xvIfzTny9484GHbOTk/PmrUCmXQwjP5a7v1WaavC
         cqG7BixLfWq5lDXMoiX9rBfA4fNQSv3aE229PdAlBiLUz2uqxI6idbyQ4GXmHQCM9uJ+
         FGhfKZlF12PyYofBLBqu+DsprmweBEyauw+GFk46Xxifd7q1sQ1iQK/ClcOuCG4TUfEY
         cSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451532; x=1703056332;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAsdhcqVVRgOKXcf46m9UC6oHbb4/P4v8mFUOd62Sh8=;
        b=jwXuPxA9z3pZgo6/6f2i1RX/iw789Czr0NWhBYDi42hZV00x2urb/bRUSyikQG1csj
         e+klF0b+feR4BZS7WORAMW98Lsc0AwVVd74jMK8lr8iIC9UnZg0uw5Lv6hspkIQZTieE
         ITwpVa02zghNF9BXbGSt8+hOv1FiHgfu353bJ8sXUTr1i2q7OIMD4Zki0il0b9CmxzMN
         fqOtRuwcB38uzJCs1+w7JO2lPGUXvTwv+Lfkwl0ErSUohuCF2QwLIghb5W5U3hHFFzZH
         0R2U96nabOlAF1tB5iuGTNEpguMIiSU8ML4rWv2XdQq8TswyvusggC0dmszxr8MwWegG
         9v3Q==
X-Gm-Message-State: AOJu0YxnQWtz4y/y3+bvE+A6mLpLUcfONb6cAKhOaQ9HAWd8YuytWOIX
	pf1m3lBJE56s4nU3auQrHQ==
X-Google-Smtp-Source: AGHT+IFD6EUsG5zAPjiQ7UbjQ/87jKXWoS9e6OWngn56DBxkujUhG/8dXv1yR1w+xtR0bUSFSVwCaw==
X-Received: by 2002:a05:6214:1022:b0:67a:38f3:10d9 with SMTP id k2-20020a056214102200b0067a38f310d9mr7988656qvr.7.1702451531692;
        Tue, 12 Dec 2023 23:12:11 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.226])
        by smtp.gmail.com with ESMTPSA id a19-20020a0ce353000000b0067ac2490d95sm4841644qvm.136.2023.12.12.23.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 23:12:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6b76a198cc11f69bf8c4621f1c8a5cd0c9d1a6ff.1702446832.git.geliang.tang@linux.dev>
References:
 <6b76a198cc11f69bf8c4621f1c8a5cd0c9d1a6ff.1702446832.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: check CURRESTAB counters: Tests Results
Message-ID: <210f2ad1-ea10-85b3-001e-8549d4c49de6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Dec 2023 07:12:10 +0000
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
  - Task: https://cirrus-ci.com/task/4995622244188160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4995622244188160/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastclose =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5558572197609472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5558572197609472/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6684472104452096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6684472104452096/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6121522151030784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6121522151030784/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/01856a57a654


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
