Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133D256A
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 04:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qie2qkrJ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-429c9c4c572so28847531cf.1
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 20:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705380310; x=1705985110; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QA/f7pca0Ha453TpFAFiCyRmlkmIfwMQ/lGteeasjM=;
        b=Qie2qkrJU3/CNbJXv9AZOn5iLuGwSDF/TZGwzOk0kZ1bFBw5elMXBoCnbEXh+1Tr4X
         arq2pPFgiDJykrabMJXbMhD02hdYXx2AblAs/MlnIswKxGh02whDXflFQuhNQiBX1uEY
         aOjmoN5wvzPJSxZnfOEz86y/9LhRlXWrGMF2MRuB5jtOBvDvqzh4arxj9Q2l3Lcx1e6X
         BO0xMrXY0bIF47CGQlhH2+Ub5UxdZfIoYxmWPH41vionYH8b/y5eDlCreOUjsrGrEiPR
         yipBj2M1j7gYumQlCne1MV14iJWWBateQoRiqhRQ58mpk8OZ3ZBgelYzwKv9iKx9bJec
         ESxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705380310; x=1705985110;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QA/f7pca0Ha453TpFAFiCyRmlkmIfwMQ/lGteeasjM=;
        b=wdZEtlDeueIrml0Osu2eLOHSA2JeR1jmO3pY+nqKvMlwdYsKYvyYunz6Ioiw1Reo7X
         fLsy4kP/hjWIHYaUVoK8VPV1N5tCdl2MWVXo6goSUrs9gF0g+L5XsoftdnB93F+9nsFJ
         7JTq2547t1FFL0AhlgXIJzF2QgAInT05FgZSho7rdtvauPPlnwJIQPLLVT4yjBKVPCBo
         v1AeiraEdvLsW9CItF+dVOUN2d9dItfcw70is+GOspE2r5mCkrldaGi3ckh2YuxkDP1P
         C5GxLWfcWwrurDecRvPafFu9I3JFnM1/hzmlQ64bH6Bfi4f1Xchv96HMKA5w55N03Q7H
         oDGQ==
X-Gm-Message-State: AOJu0Yy+5hZk+xbwifPvuhx/ltU8SdRO7WxJw+uYtDx/X5SA7aSXD0zV
	jMmLRPAOP9U3XqRasvRVB6mTMjwCgQ==
X-Google-Smtp-Source: AGHT+IHhfX2csWL3qV5me18+tUHQKOr0WuevNxz/a9+cx0ZCNvcf4/4oWL1Ej1CXN3iMucpsDChUnQ==
X-Received: by 2002:ac8:5d8a:0:b0:429:fc6f:5c85 with SMTP id d10-20020ac85d8a000000b00429fc6f5c85mr1597599qtx.43.1705380309785;
        Mon, 15 Jan 2024 20:45:09 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.194])
        by smtp.gmail.com with ESMTPSA id g7-20020ac87747000000b004181e5a724csm4497455qtu.88.2024.01.15.20.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:45:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7bf6b2a10a756ce5fdc739663cf9eb2e3ae72d87.1705375746.git.tanggeliang@kylinos.cn>
References:
 <7bf6b2a10a756ce5fdc739663cf9eb2e3ae72d87.1705375746.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <98d6201e-effe-5cb6-17e9-5765a2b304c3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jan 2024 04:45:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_fastopen selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7536=
807523

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7a37e241bedb


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
