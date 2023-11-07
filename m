Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C41873
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcSqNMVE"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-777719639adso335715985a.3
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 18:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699323618; x=1699928418; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVc6i0hL/SrUe1J731aihEr6YO3a2a9l64D++O6etUI=;
        b=NcSqNMVEblfD8RCY6HxK4jC2NCGMbLO/7dGaHbsH75wzjMakOox4Zh1JsdQYMSpBcr
         w7Kdpg56d4qOrCpRKLMH7lI61BmHl9xRs+j+KpH5/c/1r8jwiZMbeETlmgRBklljWXzU
         5U1NPY0UG63rsyDmi2h7BTWm2b5zjy5y9xSxcLnG27TxoNy4ZpVl7i96Hfb4CzC3pMd8
         yKfBGR0qm2j8ew3pweI02CchlXKtvo4uo0w1gWocdItgV8h9o8x7DZWVP15YUSZCDPYD
         Lr+WtqmliZPvnp+IoZnGdI+SePN4aSTpqhLSh3Dnaee79cctP8yUqD/1Y7PhUHfH2E0E
         q8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699323618; x=1699928418;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVc6i0hL/SrUe1J731aihEr6YO3a2a9l64D++O6etUI=;
        b=fCm9jkMimhrimnOw6GLzfP7vLFsL1aHYIhHwMI3pATmvZ0BdydLfazMxcWtfpW3Prp
         oKiS9tP4iYoA7kHLMVk5T3AyPABf37SFr2clHjEYFYxkV7BQV6eoT/5Pisgn5raGe/Vj
         IcND6ist2EL0LtsbYlNiPVsLeb4l8BD5zWUbh2O+bStFYp3W5M93gSUFz4BI+Gi0aVZd
         1B0GduMIjhnHEYFXekZtwUTsIv06Dg2K7vvHlRwDUhGwjbCOLi3VZtMKFQF7CdPcxbxe
         pG3UnKNRUvq9dWbzX7FNgUvbqZxtdF1lwcHx41Btxn7VuJzAW046ju3LzYHLGKdjQyb5
         oxhA==
X-Gm-Message-State: AOJu0YyAAJIoOphW9rqOB9Qeb/MHNTTVdk5X6nsEGG57LZAtfO6zd+SF
	EHCCdajMQTkYLDwMmTSRqu6HhPySBzpL
X-Google-Smtp-Source: AGHT+IH8dw3y4D5OmiKZcqHVbF3RLE6UwFJUJFkwVDW2lg/JKWG4jLsKbc4ebqcgvvmARsmNZx0t1A==
X-Received: by 2002:a05:620a:9009:b0:778:991f:2f78 with SMTP id rk9-20020a05620a900900b00778991f2f78mr24403812qkn.38.1699323617807;
        Mon, 06 Nov 2023 18:20:17 -0800 (PST)
Received: from [127.0.0.1] ([172.183.36.16])
        by smtp.gmail.com with ESMTPSA id z19-20020a05620a101300b007671b599cf5sm3799284qkj.40.2023.11.06.18.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 18:20:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com>
References:
 <02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com>
Subject: Re: mptcp: add validity check for sending RM_ADDR: Tests Results
Message-ID: <069f599c-a98b-b7b4-4cda-0ca23215f496@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2023 02:20:16 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4609094967885824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4609094967885824/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6297944828149760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6297944828149760/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5734994874728448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5734994874728448/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5172044921307136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5172044921307136/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f51f98faccc2


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
