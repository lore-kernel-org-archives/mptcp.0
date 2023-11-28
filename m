Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822C5B5C9
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrI3vbiW"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6cbe68095a3so4216564b3a.3
        for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701182017; x=1701786817; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfsOOLJ7cIG12cQ7kHbg4jy5pA988s3NtWU4I6yLAlI=;
        b=DrI3vbiW9MuRjIAliaM33TqtWfeyRs1ZpQW4EfelDU3eBBuEqN5JGeLuAqZPb/8pm4
         igcTYtg6wgg8gbUGJeDjJNjQMr2upD/2EC8/PXYjujtahfbd4q2bM/f4eHg0q5qAjl73
         SLyE/WAmeoY8AKT76UePb5dumwYFGPvcWMzoV5F0Fl7wY9Nv9jGGQO/EKuVKu6rD4gli
         mpCCGpGtNDxELdPxOU54AoYF/D6M+JDjdH278mdw//SE0nC+ZvurvIbYNKErL1mxHxQl
         Rj2X7+gVBYxd6L7hdPvVNadUA84MOwKaquE1jIN8QsR2tyLi8WMpVTFC5Spn1603Xg+c
         sRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182017; x=1701786817;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IfsOOLJ7cIG12cQ7kHbg4jy5pA988s3NtWU4I6yLAlI=;
        b=SzN5oXuKbxDVqFUUl0KMOHMS9sOyPT8+gxyKVhbBcC2ypv3ExeDl9ZMm92dnAniGpC
         78tugoOG3KwkLSCW/rlK8WC4gBVHIYhH6tHnRA8beURvow16OAWXwSDP0ZcJc56WqdW0
         8QO+AUNlEqMWkxkC0AvniNez8lEkMDJb57hC9TmN0T24RPbgpfDBSpfll+1vQqnMsHZ4
         c/g8HOI1YrdvsHM12P3u2mUiTmymm1P1mOtMBY//7tOKe3RPmJhJVZArmSUys7YGJZ6L
         xvph8wBj4wMi+yw1D9MCtIOxhwpwEDjt/y+y9o/9S+CpO1bUx9Nbfy5d1DCtuzqsHIno
         /O4Q==
X-Gm-Message-State: AOJu0YyB1UexZD9el3FcCC1eqaVN3glSswkwrR7YsRz30ZnJ98hXmoG2
	aRsPKzeWiKUaJUIpluyTUQ==
X-Google-Smtp-Source: AGHT+IHZkhVHOqq7ZWa3miPPATJ/6Wv/2b0kyJw8iEO2Ljk/hTRADM+p7lIi54Pt1/As6qXX2lq61Q==
X-Received: by 2002:a17:902:ab1a:b0:1cf:cc23:eff with SMTP id ik26-20020a170902ab1a00b001cfcc230effmr7407302plb.52.1701182016880;
        Tue, 28 Nov 2023 06:33:36 -0800 (PST)
Received: from [127.0.0.1] ([20.171.70.62])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfd2cb1907sm3652298plf.206.2023.11.28.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:33:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <957643abf70bab8b5e0a79b7b93be7a32dc3e324.1701180969.git.geliang.tang@suse.com>
References:
 <957643abf70bab8b5e0a79b7b93be7a32dc3e324.1701180969.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <bb093a7b-b057-1b32-8b99-2718b894883a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Nov 2023 14:33:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6138520423628800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6138520423628800/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4555223679631360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4555223679631360/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6701470377050112
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6701470377050112/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5575570470207488
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5575570470207488/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6010fa5e2dc9


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
