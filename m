Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC93358B2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+QiquLu"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f084cb8b54so2814216fac.1
        for <mptcp@lists.linux.dev>; Tue, 07 Nov 2023 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699381824; x=1699986624; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+4iuFouqel0Lr1y+4XC5AoO50v5CHvoKxSvejI9RUU=;
        b=A+QiquLu1cV0KM6UaEBvo1VtTZkJEpgh1F/HnYe+uMeuMIR4i/Mlwb5fxm/WuTcZ9Z
         t0Y+irX+h4GQEwX7RHtKVbKzjFvJn14aTgP7UTV+HHUhMSusUK5D0qCMMrmdnbZS8EoZ
         nVPeVlfdXM7H+cMs6Gi98Thh5+Mi8w0KkVH14auJ7XIBCyLLl7sHYwP2QRfH5vphZlDL
         42sxmEnwyx74iP5oXp69BEKrHHESM7mDkQjAwlFbXdNq2PIjzUqptIoyu86UHkA1lRU/
         4iRI2ADf+rN4cgCVtT9dFfEACLV/sQ7x5sE82aY1tHDChg/7gX0GmRWqkkOkEZcCzPPJ
         laDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381824; x=1699986624;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+4iuFouqel0Lr1y+4XC5AoO50v5CHvoKxSvejI9RUU=;
        b=RAWxk8z5H3uO42Amj5LuI5qbAqkwBnxbznn5buicFb62lsrbAEqVKvEC7SUwrnF7j3
         1LoHeEEXoy8/Sh2mUMMEyC3UfWkwU5fy0Vn4xSVPmJbsuRIbK17/Dq1pKn84Cr4k01ah
         BlJj+FEDfQBdC3YwrCYv52vYISOWRpCuIfJR8H8bRDsoGTn0Pf6AnsUo2xDJVlM6AsVn
         EuLCGRNQdBpyJT4NNMndnChrRNCB6mmZTBDaDdrOxGsMLvW84lHtJAHNbKoJSLHjaNuz
         nq7Tz5giGoLEN0l/29cVzcx6mUx9KZo+IQn159Sa19L6kQhJz54M6Sp9xivoENneotoL
         1Ftw==
X-Gm-Message-State: AOJu0Ywr7thTtkK9hRUBLCUilWNXcdcznmcMKw66YNRAJfQd49EDq1LO
	tpe1Ugle4fSDhlomG38WsGMfOrWflw==
X-Google-Smtp-Source: AGHT+IGhIFCe9oQUAeksGF9B1wPv+kTE1Spf0VyyBcvQCUQqJmPq/iDy5AR8exAFWcGp8D8S+QLBzw==
X-Received: by 2002:a05:6870:f81a:b0:1ef:abaa:cae0 with SMTP id fr26-20020a056870f81a00b001efabaacae0mr4039156oab.29.1699381823755;
        Tue, 07 Nov 2023 10:30:23 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.192])
        by smtp.gmail.com with ESMTPSA id h5-20020a056870a3c500b001efa3446d4esm1848068oak.43.2023.11.07.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:30:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c872b639f2c3c9b6b20ec46d3a109bde6ab7b5f5.1699376301.git.pabeni@redhat.com>
References:
 <c872b639f2c3c9b6b20ec46d3a109bde6ab7b5f5.1699376301.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible NULL pointer dereference on close: Tests
 Results
Message-ID: <06b7ae20-11f5-12c1-984d-c33e8b26f750@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2023 18:30:22 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4571618257666048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4571618257666048/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5134568211087360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5134568211087360/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6260468117929984
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6260468117929984/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5697518164508672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5697518164508672/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/aab410e93569


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
