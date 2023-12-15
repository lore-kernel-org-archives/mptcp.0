Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065883EA82
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9kARnBc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77f37d19b6fso54234885a.2
        for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 09:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702659829; x=1703264629; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDCoLj/+EsJ/GUcZb0jRweHOtLk1KOf8+S20KM77hN0=;
        b=a9kARnBcaec1OYAzQk3D1Gg0P0Oh88eML8e63KAVC4yN+7TJEUVCjTz/6ir5/xYIGv
         qEowsAHsVrdnDE3rOU7QqdgdRJcys8XEItaQrtAHiaV83c6/MjUqaF0Lo136F5OBMKfd
         IPdFSdPCh5J/rWhSS/noYlPmadwY1Br8mtgpFNRHR1y1ksrU9N3ITEqP+isWOXjcH+bc
         IWtf0XZMmhSPB8NK3Ar3zrsj0ZoyEHIq7xallKeLigoQz9f5T7nIpfN/Ti2xdvP7A0L+
         Z1aKZr47+uTqyJedo+4Q3sp7sLUazZioKVm+T667c68EC78lE5BgVdHHFzkJBaez3LoY
         B4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702659829; x=1703264629;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDCoLj/+EsJ/GUcZb0jRweHOtLk1KOf8+S20KM77hN0=;
        b=OwZzA+D5d/p2E6pzqJ4xJu1KeiKwIc6sTYX1acMVCDfiSwo41xI/RxmeQGn/Awbo6T
         qLBYOMjsOcFD8Fkf2QvlnMjjrY+Vkss2s3nRJtBoQnQjD2vyEKQjWVkIiMGPp+oxWSMu
         tM698aiA2b63xzwfm+B3kHdh3mG3lc9t8PQ8gK4uW3z8fvtsI2TAGsFjf6gvpKTdfvMO
         gPs2pS6OdOeJBbfnepfRlMryLDNMJmH7lfSEBkEpx6K3/s6IyQ1m8Jwqv74dP0sLT8sC
         ZqQ8EwcK/3Etxj2gyvh48jKyxyMDh4ad9za4VLBHCrQy4pCRECogVyqgY5SC+TQ/eE/e
         h76Q==
X-Gm-Message-State: AOJu0YyM8lzrIO6jiwLJTuq67IOP5zJy02QGB6E8VSfJ/ZzBx9YlKC04
	COV5r1dF4sd/N333bhwRWg==
X-Google-Smtp-Source: AGHT+IGuKqHjyKekFpsxd1IVUSe4DdfcH3iRA/Cg2QVZS/OzXaDQAKaM2sMlzXFv5XyEYggEs45jww==
X-Received: by 2002:a05:620a:26a0:b0:77b:b1d2:955f with SMTP id c32-20020a05620a26a000b0077bb1d2955fmr15968988qkp.4.1702659828817;
        Fri, 15 Dec 2023 09:03:48 -0800 (PST)
Received: from [127.0.0.1] ([40.76.254.132])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a124d00b0077f084f4cbbsm6201081qkl.20.2023.12.15.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:03:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
References: <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
Subject: Re: MAINTAINERS: add Geliang as reviewer for MPTCP: Tests Results
Message-ID: <71b4cae4-8501-d63f-a7f6-cc0e8e662771@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2023 17:03:47 +0000
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
com/task/5056554173464576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5056554173464576/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5102919788265472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5102919788265472/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6182454080307200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6182454080307200/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6745404033728512
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6745404033728512/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7573d23cb3e5


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
Bot operated by Matthieu Baerts (NGI0 =
Core)
