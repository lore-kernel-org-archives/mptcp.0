Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED3341AC7
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158489; cv=none; b=JZY0rFYZTau2pVpDnAxEjYxqSWTfLBfrw9V1TdCntA2dZcpPQBTujgmVNKfHgzY9MtgQDtRxoZeq3oPrXm6XQ7JcYAVgj+g7sYxuX7eCqlF5j7oAZoCXPYJJbQX+kqW+IpGEjS4gpYcYzhVhMyVIm+0Y6D6XiZbPwJ83NGtJbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158489; c=relaxed/simple;
	bh=rd9Q3e8AaM2DyK1TNCymOJ3fISFXPbSlO7Fs+ogvEsk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OQJKKkkuUtxTJJDplisYt9e+A6N4vNsXKN0AZKUpj9nr0w2m+LGW8722sS9H0Mi6CvliDzt/KhkOm9L+w9SEZLAeHY+5Yl4a3aTQKz8XFSz/TPMXMd+dv97QBlF9bGM/rYq+1sruBKuBwiLDCikU5IAaF/2e+As+6WfNy/BKBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as6H3eTH; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as6H3eTH"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304c520fe9aso7388266eec.0
        for <mptcp@lists.linux.dev>; Sat, 30 May 2026 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780158488; x=1780763288; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIwRqGfLOUe15+3mRWYOtsjZt8ZhXARAfBKnXqw2s6U=;
        b=as6H3eTHRNvWcGMzG11LUnOC/4CLTu0/gwLDgmmn8pB2ZGIB3pLfqtK124PeViKlGK
         zT6Q+cBTsSiQWXMwNgVzOILUlAjoD9MDVTvd+FDhOI+xL4i8Y2cHxTGAXtUgEqD9+drt
         3/3mS3+QUu5tBc+kDfd/9GC5rqvZD6A5Ha0/LjJWE7J81rQp3Xg1IKRkn3e2jLaKAgwq
         8XBFpjgjI9tvhsE3p5RRc8txa89f2hmv9bYfN+rRrrEbDztWK4lGeJajHKp0Db21KO0C
         3Sasn3FwGSUS+HZ5ZjKeeeRTR5dRufkLteLCFRIpzU4QV09PWfbo2HDEK87jdz8f5siD
         vALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780158488; x=1780763288;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIwRqGfLOUe15+3mRWYOtsjZt8ZhXARAfBKnXqw2s6U=;
        b=R2n9Pl4fIrT2107vEaGC7BDNKat8LWjvAgc8Pk4BzkYQEpUyVywYUusLFSZYGBRjXs
         mHBSSdmvFtypOFYByLgYhhSO6DZyBLmOc2DP6PicBj3m+js8j0tWtG9SsgsyceqCQHrZ
         cJB60xRgFPBspI57ozvkOpG+hM/SV8pIGOxOBw4nb9N8Zcupx9USf1arWk5YD0MryKRH
         IYm/IbPzAHikt7JiBiQjWsV8mx8/ryK9ossmsbR0xFIY33w2nAFm6fWfCLCaOgQGYaL1
         ZIhJ2uaRIMKNzTSicqkRsUZUIRYYA9gDp9nNndV3e/wKq+uhzUQpijIS30NmGQVLwHFJ
         oHSg==
X-Gm-Message-State: AOJu0Ywk8lkLac2cHUj8rxfbFQLQBoAdkWg2HnZNN0yJIjzF2qkgtg0T
	kLwadlKuAQaWjC2KNtnlB6XJ/oc1b74uT5a58f1LKDKFiWGpl/K1fhc=
X-Gm-Gg: Acq92OFFln2GCAYendl94mFUbNTWcB93geaf9SPXHI0Hy4dy4eSWKv2EwBsWwHakQG/
	4vOMGhknI6tRJjeRW9v9q+ztEs0qg9u8RqDsSEOq19iwyqeWEfL605JhwYX+nS6QbWDIKc/zaBs
	erpkBMlAgKh57ZH9lgGEqP1k7LQYSTlC0RUsGgBfg2soqPACvp4jF922jzuPKkWfNoajtbkjT9k
	rLeR/pvW3jjVPWQyl1eSevgrsPUv+n7zmIoDonMc7cAc+2gbN/VbbPNmKjVgGowXVX+nUPrLxVM
	Dqxmz69DLkFfb032ba5CVqpjT6RYayXFof7rWb8sjtKcPzYlnlYGM4dpQLxQmtmieLYOPoU1prA
	9kCGBxmJypJSNmEq5gjokeDged+dZzJO0ZXa+SFAwDtz1Zvpt++95KiSRzSq3uItf6zdnt2+Z5J
	wO5aOgWMvIkcUmW6AU2erJD0bSb+GrQ9ip0vQ+ajQFjGY3aHfE
X-Received: by 2002:a05:7301:687:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-304fa5a9b27mr2420570eec.22.1780158487783;
        Sat, 30 May 2026 09:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.126.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5f6426sm4197002eec.31.2026.05.30.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:28:07 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780152380.git.pabeni@redhat.com>
References: <cover.1780152380.git.pabeni@redhat.com>
Subject: Re: [PATCH v11 mptcp-next 0/2] mptcp: address stall under memory
 pressure
Message-ID: <ee93cd75-a62d-b9bc-2faa-acdab3f019bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:28:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266874=
69839

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/89eb2ec6592a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1103334


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
