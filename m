Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B663803C5
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293811; cv=none; b=qSoJDSe6AxHlJv5lRhNzg9EPeNOLKeWTKvvJtllKg1iLor4ebprVkdLT1ClECNrCJ2CXiEkUff1YZMboVJYYzD4aFMAlJ3yiqutnFFYUrrGiy6XxY37NB5llPwkUSsRWf3+XJ8qyoWtu2pk5UfJsx6VcSHZL/o6GQoTYSti63l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293811; c=relaxed/simple;
	bh=6tJHu6b9PN1pAL6j2K0iruEVkMc6+P4Zt0WHChmzPZE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nrR8kWC9/p3LQOom4wO3m6FqXZEvVe0qgxkRspugPcAkUnOVGMm5lOwSfpXzjxIBc9s7YMGrlIha8keLppu7QJKLPMzP5VvKqPtn32uObVMgzIAKEYGgZ72zQFR6WEe9izeyvOb1g5PRNaaZHTMOJttkxOy5r3odelM63TaUreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9GxT6lO; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9GxT6lO"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2ed01b95dso808519485a.0
        for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768293809; x=1768898609; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iNHR7Kx4Xbemq1Bx1H9B8N3gLfVz7yUGFE4WPOkD7I=;
        b=e9GxT6lOgUhRUJSBkU2WAdP8ZhO7JkjOCDhDkEX3QgjRmfo78SB9JRt+RCpzyruHAE
         YEKwUOm01fCEPlN4kYy8MWRqgwtY6z+7JctsTF6Ng8dIqtN44OeMV3VWlsfeg8Uvgena
         2Rif20IJQkJL2M3OpwlRBctApebtPjtUWt0Gb0iEtuDuzGC1dWNFv1g2ZpzTXHIzqDjp
         376vAPoXsV0sDu2bnGDuVHAwsCu9w9FCZgJgvZqyjEO3K1FMMQcDaoGG0T3cUrD1vMre
         T5uy/xrEDj791yhbFdxEpldWSbmnZAa5u1mWCzs6IvBi+XA92GyQMhN+md0RIbGq1WIR
         0VOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293809; x=1768898609;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iNHR7Kx4Xbemq1Bx1H9B8N3gLfVz7yUGFE4WPOkD7I=;
        b=W3NrQUOH0g44oDwr7noIHyayIxakUJoW5pbGYPLRHErNGbdiRd476EqO/MwzE5YIJs
         cu/5wckLhtwClsLtVdVAPDhVLjCIyFafZw51KYYfvwUbp11DmKqnq46T1Eu5vhCojn5n
         sBoRQpqXkTlEZa166oTF5uPkA25GA3dds7MP6lWxGuGwkcX2sHaHUgjJm6OSrlidbQyD
         YoWyxp4v8zZngyhGpKMO5ntA62ryYJAxyhk5LI5mCyE2ar3PwlQgrSMi6n+8y5Q+2PXb
         1Xa9e0gxPhGCVISMRWz7yOahmg28Rnw4enueEtWK8STIhcfu11ms7sapW41rl0wEWC/K
         5AUQ==
X-Gm-Message-State: AOJu0YypHHQ30kvCqlteADTCqZN5dLF4fJftloxxw4fIU8xfszKwNBIh
	74Q6op+4dYI7YymHd0FieAnrO9OsNaIKDVR5rHv7Wx5xFe19xFI5vvPo8qZ7hnnkmQ==
X-Gm-Gg: AY/fxX5ZJ40YsC70E/4pfzQLRcHgNz4riZI5vh51qDe7DIMVg0o8QNppDWAAMGyyWHT
	YozjAcvT3MIEYdh4Khy5FzT01AkAIugHZXdr26PeDivicQuXQ2+Yjpzy312KtZS1Uqg1e4jk43V
	CBEQPm+Ea3ao2nDP2pbO3SzK1AzTZhe4nlSy6LP4rhTF/99piKz72w4dnGPQLX2iQYYwpuc4wtD
	uwx3BXukslfJ1bhohyiYrQt4784UQeEOJudRxJWekZ0oCMVSZv5hk3+ezlY+v1QO7PaIAC99Ea3
	P0kine4NNNIaOeGMiGkrKHK/ltm79ri9IT0ZYrfXwcoa1/IQE4jQ5TFHW0szGK5+2PvXExedUmL
	6/ukjMR3/2C3MARUiI069yaXaLdHHtW6GRV/YDnLo21EFGwzsY5VNWSBXBOqU+KF/xQfuInjtDi
	Bq/l8+TnVAK0S6Gcl76rmbiiQ=
X-Google-Smtp-Source: AGHT+IHUUqN2kKczzcRHdYa0Jh3O35VvlCO6KDtSC6fLS5xGRNacQc0ZXRt+bW2UAhxfykyA3f9nQA==
X-Received: by 2002:a05:620a:3709:b0:892:501a:290 with SMTP id af79cd13be357-8c38942c61bmr2742911285a.86.1768293809219;
        Tue, 13 Jan 2026 00:43:29 -0800 (PST)
Received: from [127.0.0.1] ([20.55.223.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51d06fsm1648873385a.32.2026.01.13.00.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:43:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1768284047.git.tanggeliang@kylinos.cn>
References: <cover.1768284047.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v7 0/9] MPTCP KTLS support
Message-ID: <077d8e76-6db7-46eb-a8f6-df95f1c03860@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 08:43:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_add_addr =
packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join - =
Critical: 1 Call Trace(s) =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/20947288044

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1b5bc620d3a6
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1041572


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
