Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6F8F79
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3spd5VV"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1e58a522e41so1822758fac.2
        for <mptcp@lists.linux.dev>; Mon, 09 Oct 2023 00:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696835155; x=1697439955; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5KIUYIzUinpGGE1CvCvwol6C64OVg3cqTMAXjVqSV0=;
        b=P3spd5VVvhZfX/GHDwnYl9eoV6ifUqarcWAxZ3F+adRFBX6o4hXfPhG/CtSydOjHcc
         DH4roJniBqUWrqPOTgj1RAkkIsw6in6zEKHkNGgi7Kkj8POJf/RnJfJe3gs3IkqV8QmQ
         xhAX1xGZRT01uOQJWzSg1XPJu1UVyvPrD74AhLFYeOuUv0o/LrzGZTDPSsDx2McDb/XW
         RMiHp7K3CnQM6z9Hryp2rvuGgpIeeH2+bGBbI00PGGKCj8QtrbGjdUoTi7L7u+2cQM20
         rht2K17UmvOBiOnSZJDx2I2vhVXVNaBuc9e3fmoVu94a/Q13FhECRd3EmwCJvcDyN/5/
         bSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696835155; x=1697439955;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W5KIUYIzUinpGGE1CvCvwol6C64OVg3cqTMAXjVqSV0=;
        b=O47APde67/dwID7EdfNscluV1RbqUqcXVEkT9BqZrcQJe7MR3IrMpTVDRbH0KazjiG
         2f2g4fX2du51XOwHf8UUx+WfDB/UiIrO6TUXwjY73uJh62fKH+8SaizzK8rFAwnYFcCx
         ICmLOWFWaRsnaw08kMHW3AqAUAFJs6NimURam2bSm/Ma940Ih6OQ+YwQcNLf4TJSYRSV
         DyvYMmRFMis6NBuOK4d7opD0k1aOFrPaTKvNrbBRg/MkgMNGIYmHVFQOttEo5EP5OYJj
         IXGBAkt8/NOtSZxS2u83N2FM2jU6saG6aaNnU0RAYEeRhECwCzfJw654bIHXb6gyRTV5
         68XA==
X-Gm-Message-State: AOJu0YwalNKm710m8pJNPOmJorOHFV3dB3dD/8r7qHcmtvoQGJJBj3NX
	4SxybdwmJaEDa1uGZ2ANfA==
X-Google-Smtp-Source: AGHT+IFChE68Zi7NNgBH2jcQ0e51uuOCQMHttLKF/8e3p7c2bDusP83wkrLHBvimat7gm+zWo4aznw==
X-Received: by 2002:a05:6870:8a0f:b0:1ba:1998:1d23 with SMTP id p15-20020a0568708a0f00b001ba19981d23mr18995780oaq.35.1696835155096;
        Mon, 09 Oct 2023 00:05:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.173.115])
        by smtp.gmail.com with ESMTPSA id ki9-20020a056871bcc900b001dd17c5356dsm1868558oac.11.2023.10.09.00.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 00:05:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2d013e9f4cb101e018269da31e3d70b8198482bb.1696831239.git.geliang.tang@suse.com>
References:
 <2d013e9f4cb101e018269da31e3d70b8198482bb.1696831239.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <b756a76b-b948-c935-0ce3-691af98ce89d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Oct 2023 07:05:53 +0000
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
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5543789025034240
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5543789025034240/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6669688931876864
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6669688931876864/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions - Critical: 1 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4628995350724608
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4628995350724608/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join - Critical: 1 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5754895257567232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5754895257567232/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5f8f6660beb8


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
