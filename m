Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DD1BF3F
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077307; cv=none; b=laA7bc8yVlqOZ5Jl6jbOC6sVZtTDKHcRq+atqs2mYML/vJ4WzONYjfipzxoXewVOA0BdA1HaQ/CMrxZLvPYeqzLXBqHFTtDLgs10FWjMi/4IBdmwJY/JkqWvzQpJ1GxrsYBBGb16Uqx5+MnDiP+obYmigugWH5/0iiSAn/qDXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077307; c=relaxed/simple;
	bh=v/10UrgDvw+XhXRrHSOdmF1iB+Rc0E3u6mXkPwE1Mbw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=G1cC8k1bxK5ixvu0FtFPHEP7jSotppC66laHAWW9/eRVPTVNb3RJIpalih1SbtEHYNJ9n6k/YsR2+F+eFwrLGdwFEIs85xul1NCP/uc65WoF3g2iKD2h4/oZWYMj+vqKmwXc83eabKxfVlEhHIhp1WdxK4PKVJvwnCKwNTKi1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnXTLcZU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnXTLcZU"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1453511a12.2
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 01:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708077305; x=1708682105; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0aH23QmeRf+K8XNpWvdVrSu8p+OdH6LesSHRZFrRcE=;
        b=PnXTLcZU7wNichYFs/0ze2eMhZVp9BHMnZWo5YL2Gd7VkUVZiE4byBLe57+rB1U35X
         VrHRg5uGq+ygoFIAQAo/C/sY6zakdu611nhUlQ+zLFD/XaRo9zoFy4uCXWEYEY4Zts1c
         xMpr9xSoD9qUNoEDlS73CVMs2fgIMkkwO/xiOP77D+TF3wHn9Rhdo0xgzfh0UAAPChXB
         acsZX1i1F/wwDVf3qDO1pUsLWuNvqvxI00nxvBTsMuJZ2/N57q40vpqRyGegf9uCeoXo
         ZZASZuTv914OqpWOUUhGjGCeXQ1jR4/SUdUXdZr/eNmNf/5NXXkK0Ud6o3S0Atm2IpOW
         wF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077305; x=1708682105;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0aH23QmeRf+K8XNpWvdVrSu8p+OdH6LesSHRZFrRcE=;
        b=uq37sFXQCPetSxs41MPpCR/KqbhjOQS2JvWMyDLdVPly/qnz5GpF6x1LqlR/+nFIUi
         OnReN+nDchLnIpSGv/+rLZlWKQQ3+IH7iJyoSFJsGv3d9G2uYsZQs9qRnAQEcVlFVnYI
         abkyS+FEKeae1279bbhql0JQdbgIEsZOxtWKybetH0sfgWMODJuCY7KEw77zQPG6ToF8
         nT64ARQuEs+cQQ0aYZTUSLll2Sgd9OUgrX/XeCeHL7cz6FVS+J43UwrwchUJNrk5HNjY
         8zae7B+qO5vQVrOXXXmXPmW7y4Qe3mOO/M6Plk2T16XQqNGfiNVSqxxsmvF7bZ5/ElBB
         9KgQ==
X-Gm-Message-State: AOJu0Yz0iefh197Hu+eyP6Lvo+ptcO9oiHRa0u3ONlrgW1xZj+2kwNHS
	8PGN83ybB5xk3+wj8f4mXBqZbVrfVbpUMADX17wEUimnE3uKKF6kGunZ4J0=
X-Google-Smtp-Source: AGHT+IE9F827uO3OOmc0dfZXtY0t5mq3w4F0qL1bzyAM+HGrfPgIcPiC6/tPQoriUdTJ5pYI2miy0Q==
X-Received: by 2002:a05:6a21:78a6:b0:1a0:73fe:4255 with SMTP id bf38-20020a056a2178a600b001a073fe4255mr5386569pzc.17.1708077304866;
        Fri, 16 Feb 2024 01:55:04 -0800 (PST)
Received: from [127.0.0.1] ([20.171.122.37])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b006e10718fa28sm2695255pfj.150.2024.02.16.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 01:55:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
References:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <250792db-8fa6-8df1-dc9b-8828d46af288@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 09:55:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5149468870311936
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5149468870311936/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6457206082633728
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6457206082633728/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ce45d1802870


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
