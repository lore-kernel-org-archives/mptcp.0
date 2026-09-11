Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA136C9D0
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139634; cv=none; b=IzyT0dFbsEwo2SZUq6NfTFcQxqegNviu9szshgnf5oRJtMAIZMqq1uYdZ55mptsmMN4t13U4/WZb91E+BVv+R5eE/XjbuCOJfekUkvxST+HgLAP+LaKwSm1HJAICkEFJOex8aV9R128Lz8Y3+haaX0CdM0aXmbPKE7tTWR6C28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139634; c=relaxed/simple;
	bh=kBBBcdbFxJh/f6HOnIQyQygmGlowjlhHh2vYSEuJi6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=kPV4+1TLqqE3uemNVJCqIsCIDvUdqalE0aBLieaeYVv2GuBnU6NEag1WzlRsUGtEBJMsS9G1YWWfpUS0b7FaVFsbpRTO5H+GTolEPUBd/iAxrWBqqAQKdDEW6DunyLtLAsp2U9huqTheGPsTZl283cO33Vg8vCLVAsbtSpuRR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRkgXhqh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRkgXhqh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1286489a91.1
        for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789139632; x=1789744432; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SHZEY3KeusAFG4z3NzUOlr4EW6ac0mEnksI2SY3z/bA=;
        b=hRkgXhqhSZPmSb7/Hh6SVnI4AGeZSd2cwMetuTdfu5PkL8cZlJseInRZX2xvbVHCVc
         sCh8OB42hSMSARtyakD1W/R5RS9CtZIBiMXXpBWpamPT/QO1K2CkXp04Doo3ax35BAGV
         yyfjX9CiHIVer5ywAsOCJno8g4TWgmGzFipYzvQ4ji89gsi1rOaeL4AegRiD2Swps/Bu
         kfmxhJX9zCDspeMesmiiDnsV7Df566c1Xz5kQ4M+EvqWJaH1hzX432mf7o/K3Edg9E1O
         aw3eLOlvYJcIAFrb4jbWk/d82X3gxit5WOOFNQeYBbPvv52gWGdYUDZxUJwa3o/J8QMo
         Y68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139632; x=1789744432;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHZEY3KeusAFG4z3NzUOlr4EW6ac0mEnksI2SY3z/bA=;
        b=MAwckteQATnYF7nALlF0pA43qydJK0+7arwmbfpLkNiHrQFmuBRAUJ/5Sf841DbqAi
         svsFaLm94BAIELBmMLN+JF0NVlmpmEkhKfo61KYJF3RvvsaEOisgCo5c+oxsQD7E2ad3
         0IyVMdbPifWUo/o0V4j4VdUf+kA/MihoWC+jaL/BRIG2/C73Y3zBEspHLiya8rYe4ORm
         DT/7zZEkaQZx37Tw0kLtPZatWsudCXlW/iTIh+mAEGZL34q8oV2CRMxaoH0VxlJObEi7
         0QdXkAi1gSn+1DTCsOvk4mjSFQuBbRnvD2eNOl3mxTkyaJ+x255xQ2a5ZpbMyv7iCUW3
         WiHA==
X-Gm-Message-State: AFuF++kSywyVW9o+B6tAgxfNkOHdu9Hv8TTM6fkYJww9mdNEImrpxm5H
	e3Vgqv4NMtehwVcTxaOZ94Goe+Yr4zqAps+H7KlDdcpBOcsVOtHjRQQxlFOL
X-Gm-Gg: AYBFou2JeAYBPExOO29QqnyZIoQPMQHoAggIUPgASkWycXmeF0FcLyQ2LEfKFODjm0b
	kSo/3TgbJu+axb5DHF7BycSbouQsyMFpk8LDUzXZsMkp+V9/YGB66vM4kuHv1D0SAT4HFXDj87u
	ECN1Bx3cDRkl9Qb5FzxmfDspn5/+9ZklTvX9NreKwKPLDfWJxo2QHIhsFhilrw1EkPTajEyWBrW
	06AgUhq2R1ypKfsoJH+skc1zADV5R9UGxfB55b9hWcV4UUBpmzMLnbT6gA0m76w9B2ZTX8hguOJ
	y8b6MVN5hyobUkFI5Knj7Z2uHU9M/mThmJTePi8yp+L5dEOHKftUpH18q6keN1v3+qQSKytORVO
	WXZQBVA+qKLiXa8mhhj4+o+QkBeTpiOkhg3mkVoH9VGkRE1sjxOnpeawKWfug5Hu1vWOOzHgswl
	NRkdZ+zuroydUt0sXky1h1FlrS5vUR3DAZ8XXoe8njivCJtb0HrLupn5j05chY9x+hOYrSZBSDx
	9wTaLC9F9wd
X-Received: by 2002:a17:90b:5287:b0:398:9bd5:490d with SMTP id 98e67ed59e1d1-39d9c22e224mr8343074a91.20.1789139631548;
        Fri, 11 Sep 2026 08:13:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.125.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fa50efsm8132762eec.28.2026.09.11.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:13:50 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <22e4057bd8f3c7cb5925794637ffa37d5572acd0.1789135142.git.tanggeliang@kylinos.cn>
References:
 <22e4057bd8f3c7cb5925794637ffa37d5572acd0.1789135142.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4] mptcp: drop skb_ext from tx clone in
 fallback mode
Message-ID: <1579884f-9d48-e83d-b2e3-560f632324c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:13:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/34609973000

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f1cb98f36e=
18
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1162964


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
