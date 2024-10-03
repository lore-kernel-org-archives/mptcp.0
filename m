Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748C176AA9
	for <mptcp@lists.linux.dev>; Thu,  3 Oct 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985020; cv=none; b=qHZOg6ms+mLgJu7PxlIiK2ZkuS/pV4Xjll7aTxuB3Y8tbQkRJb0gRASxjMt9AABlC2b9tch1+IIIRG+KKU2XjmaJn6HmZjM1OjsdVWJeKi2pe/hUoDaG9jD12CWTcdxYgQAPER4oU4MYrau8/w42pKQ6oTDZddIQc4fD30xqSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985020; c=relaxed/simple;
	bh=V81vpoXAt2KDEf3auADVyH8yCm0mZz/a0Yrde/w4kss=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=g5SCij75yYQPZqUEszFfKKvZ8/uc1AwL9HkRDNR/OiV7j3gHhj6EWnHyAyL/yFSXFwYuT9KWU4IrhYyZTwd4n40cjNvvbe9NReWWiqIDUM4A9+E6zXzES/DJpmzsGJ1fup/nj7z27la/9qsRI91flbPmG9IxFro0urnoUdM7ARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwhPom0D; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwhPom0D"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4581f44b9b4so9085821cf.1
        for <mptcp@lists.linux.dev>; Thu, 03 Oct 2024 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727985017; x=1728589817; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07bqLk0GGr1wt1qLXbxBhJYm6L/G4/dvyZdqToIFfWo=;
        b=AwhPom0Dn479OtHGTMwgyDtybXnL3uEUGbqRqiTvsw/k9Z61eqhYyx8Si+fktrkXER
         nYM3Ou7XvAdMA1YKqO21BhK4n92rWQXT0hEU98n50pKxyCh9mYa3ESoz8TGutNNQtjtv
         usGqVbEorJG/KoGb2DbV1FjO+yG15KTeZsvRP9Va1Z9UG2mUzLZB4f+0xuq/LJQi/uQ7
         61Am+eaetbfIvPSs8+1t4Wa+ZUqXoqWY1vQE/sYpGgIFeqvmw0KMtnNe40M6PJWVgIfc
         I3y6a+zDiuUF7YhAlikKxccDMvr185qpWbu8gidLnk6iy4mOxP8eycG1kvBWllrUJ4H3
         /p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727985017; x=1728589817;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07bqLk0GGr1wt1qLXbxBhJYm6L/G4/dvyZdqToIFfWo=;
        b=mRzBgs6xYZmqqtTuJ6HaADf3V5Nj/dnqAEgDpGuKcdH1kOWuSO4JbmijGpc/wStFTe
         0OxTZItxg5GJG1zYBTuWaod8ezrEFCDrNxxcpGu6J4b9tVm0I5ND8bXN5xVPFVc1QDpv
         tQHJNhOMuBBKekj0bkgmvTOl9kzWGAyLRUjqiT4/qQ1IU8YCHH4zW3OhCbdaSZwgNLHp
         OR0Cey4sHG+ST6gBJAldjEt/BFBJ4GyoVqxxpj8PH2a0VhrMbGYRGRibUrh/7V5cRqhN
         KaHxYASLvt2HnvxYV+CSXmFWLph6htvVhVCpmsDICIAdJUnNyEUCiWxeUm7T7ZMYKpOe
         A9WQ==
X-Gm-Message-State: AOJu0YyPd88XLpi6UmVePnPoqoz9iJCwrn4YGRPIVdSLR3ajYPACnfHK
	4bjppUDvnjvtersjwEA4Y49Nnlq43m6n1rE9FUsBnAsy9Fv/j7c=
X-Google-Smtp-Source: AGHT+IE25Go4dwqfGEBzd0s9QmQEEts5HyLFVeq147aKF3F8mjqfa6RL5D3P0Sa4tDgnwAXWG37U8A==
X-Received: by 2002:a05:6214:3f8f:b0:6cb:36bc:197a with SMTP id 6a1803df08f44-6cb9a1f5a9emr4490016d6.4.1727985017042;
        Thu, 03 Oct 2024 12:50:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.159])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937f5283sm9178076d6.117.2024.10.03.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:50:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
References: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fallback if MPTCP opts are dropped
 after 1st data
Message-ID: <df890777-c6e9-2ac4-1837-3ee171b92357@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Oct 2024 19:50:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11167965968

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fa29a15b09a8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D895307


If there are some issues, you can reproduce them using the same =
environment as
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
