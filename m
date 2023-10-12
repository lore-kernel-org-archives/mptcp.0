Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C86DDB6
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPIHMhrt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c9d922c039so6522555ad.3
        for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697105376; x=1697710176; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9oNAodwKYmmSCiQhVR9VO4itO3ZADHIV2hOsMFnu30=;
        b=IPIHMhrtNtG79XIBAYIq/OpLmOIp/3hU3mUwCwrDMmFHrAADiVuCPSkOEptco4FkuE
         GJ5IFKhvz4nHti6tzmJQYAYLB8t1neJXt9Akzc6QD+2N6TnULlR09siKLOqvuY/8o/Nm
         oeGo6D8png4WK8rlj/v1Iu6UkfyidP5PCetzkLy1nL2lfNsQiZ/V8YO+GOat4PA1Q8O0
         l5Li/BQE3rU1MCirBDRQ2quVQFSpXBN7cnqOm4Qu9SZkwg5gcXZQv7rJPHYf07JKJCML
         7fZBaNOKnZYm9pgweNKmpqDUz6PbKCmvLCNA7wPPer6W3+w3D0wjzzQ6HzbqnJ+uIR8P
         hbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105376; x=1697710176;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9oNAodwKYmmSCiQhVR9VO4itO3ZADHIV2hOsMFnu30=;
        b=V7ZDJpxf2uko2+FSLLcFTXN6q7VrWaAOzwoMQps+6KJTVNod++wv7PdzUlKOmih8dx
         Gx9VquLVtnHb/4SSwxnHgQexjUoicjBSUBSnzrev1KhO0NVpmNkG9oWkI2ieUGNe2i8k
         IGh4dftimBHjQbunucLv3xQ/A00sOUQUWOD4PWXlxmXTT7SF/ZitxWbaLbJZB6blpwc4
         1JTtPZhEFrldslhU/ajJKuBVupve0iNCBlLodu+IpohBwKq/k6NjfyU5l1t1u4PlGReZ
         DOoNcb4EtG/4XtaftZhelNr45Bkrzc/gRSTZOOinsLpq4GbldB/XKHPF/8nHSISaTM6a
         yDNQ==
X-Gm-Message-State: AOJu0YxAubJczaEOtqSpBAwN31fFL5rVyIymucyDBowPZr/L66bdmGE8
	f1YrYLi/vQbGsZNsd6/s0A==
X-Google-Smtp-Source: AGHT+IGNmjnC9iwGdZOKQQUWlalYY1vCbUyRWjKUVXZBDATn/UoDUMyNwswX56SODvMp5JVTLDGJeQ==
X-Received: by 2002:a17:902:ea09:b0:1c5:d747:a124 with SMTP id s9-20020a170902ea0900b001c5d747a124mr31073995plg.9.1697105376130;
        Thu, 12 Oct 2023 03:09:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.117.51])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902ed8300b001c73701bd17sm1573484plj.4.2023.10.12.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:09:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <befa0cf195bb4ec5f638ec8da893173fd0e805fd.1697100600.git.geliang.tang@suse.com>
References:
 <befa0cf195bb4ec5f638ec8da893173fd0e805fd.1697100600.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <745aed52-85cb-7c8a-cfdb-f7471ae09cca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Oct 2023 10:09:34 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6202261332819968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6202261332819968/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4794886449266688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4794886449266688/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5223938112880640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5223938112880640/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5920786356109312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5920786356109312/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/216ab3a32b79


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
