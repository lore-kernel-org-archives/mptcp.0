Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9E17999
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqGNuAi8"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77386822cfbso450038185a.0
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697021925; x=1697626725; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtTzj0xTkhqfN6q8ogCI9R8jW0MxXWdLR3Nk35ljSIY=;
        b=LqGNuAi8jQhLEcYk99r6T5YaWStDi2Bhjdws5FUCwH5TUu7NkL+P7TP1kEa/XDkFE2
         6GC4yGsR3VUpsoUHvqrszf1bmY+ZSP0+DICOgT4S59a8mLiCvKHHL2haW8KWmkQEGgn7
         0dXsm0R0gkmLZVSEiRJx/lUcPP+fDCAjdxXspBWhSNagM1yeGUmerdESxcUy7bHLmeG8
         Wb8lvOG5nL9/51af6s4U1uqE7HCKiX5wf72MlmBJw3qxxWOaXtxFTilr/z3DMXdFdjUI
         vRMqqKFNaveVmsUAp7TDoCBBLcSFl3v7q9hgnxBTecXAnjbYgMbt6JMaCf9q6efiW9Ov
         LoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021925; x=1697626725;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jtTzj0xTkhqfN6q8ogCI9R8jW0MxXWdLR3Nk35ljSIY=;
        b=l0++IvG4CtnbqWLSh4A8Ia2/kxqW7o7iefl0rtQ1SRIdHfEikdZZ4MblcRWoNYQS8j
         XywKdgkSywTRwNqXQCop89AECIp3Xpu6qhVkAWIlh+T7bn0S2b9Nf2flhvQiY7cb+Yqc
         9avgiHKmWtsPzk6dCuhn2FgAvnvhwrEtoxxgFNemZ+SoWY/QCJ2ksEuCduPiIGVuy/lc
         u0m7EudYwvjOB6PLVt7mrtqTCDJfV2w9Fqf9WV5SohH3zBD/y7ZjaT/JfIdW6+nxnqhI
         JQSnxrwAjqozZoDjZiAvIZ+Ldnof5dUOwBSq+bT7LhQRd7wEFOIru211tlB6F8bSHa1O
         NUxg==
X-Gm-Message-State: AOJu0YxaCVKQvpSHvROLC/iDDbWaANd96xU/tk0DvdT399lFZKDuXx9O
	h4X3rAnISlrdzPNiYQ1wCZxnUPe1ug==
X-Google-Smtp-Source: AGHT+IFeJJUdgG3DB5Zt4UQ+P+yVaEtySTUfvCs7KmhChuSByKLxM3IHEdgi+ykbopZo+cRAnCKeGA==
X-Received: by 2002:ae9:f712:0:b0:775:6e1f:df5b with SMTP id s18-20020ae9f712000000b007756e1fdf5bmr19461406qkg.38.1697021925487;
        Wed, 11 Oct 2023 03:58:45 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.203.200])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a074700b00765ab6d3e81sm5100852qki.122.2023.10.11.03.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 03:58:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b729ef20b982fa6a205af202aa8bc12c3784036d.1697017655.git.geliang.tang@suse.com>
References:
 <b729ef20b982fa6a205af202aa8bc12c3784036d.1697017655.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <54d1a8bc-bcb6-4bb2-1f1e-499954bf68e0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 10:58:44 +0000
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
com/task/6366654293082112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6366654293082112/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4959279409528832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4959279409528832/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5522229362950144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5522229362950144/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6085179316371456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6085179316371456/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/86e012595297


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
