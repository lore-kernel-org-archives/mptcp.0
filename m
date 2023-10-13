Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9E613A
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS2algJp"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-777252c396bso120654985a.2
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697189330; x=1697794130; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb06IdBo6NpAxeSqcy5XteUP1U18gmYJdqozR5EPB7M=;
        b=mS2algJp5Ytvn1ZzG2+JgUCh6s3nW722DSNazKuSWUrWXE8p3cBhZcyeNFzemXc+1O
         m/NYQBr7WZ60g/iB7AVszwE8/DzdbAmVQO91cxn5icGvuiPW7UM2SK85tELedaxy682J
         pJITH3rPHFzrxcWbI+65q91ypEWGhKP/xlues4hBjUQ9AgsQ6iGvBDZ+Upz8HKksilkz
         Jr02wYc/jKc73eKqhezd996T57rkwY4WddqVcRZdzDp6kn+QuwkOqQt9N/OyYGrYM7aF
         ILZvWAYzEx05BZEnmwiD0YMlR80Nr8vt7wZi3SDeYkwWVoKpdMCADZzRDQjlSaN5nm3a
         yM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189330; x=1697794130;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cb06IdBo6NpAxeSqcy5XteUP1U18gmYJdqozR5EPB7M=;
        b=lv8WtP/JzpvEy8K+EEEd5RXH6b2ngIeDmTEr73tSrC+dLkXWcu78mTHgr7PGhlcZ0m
         oqBxIc2fd0OnMAXn4tEAmtFp+9KQ4Mkrafxd3kxe04Ek9ECI4yLHRUiM07FgJMNN+kkf
         O+mvrkvJ1uSylX2oZZ7NOzGHGFISCPulGKo6E9auJ8Mn6ZSD3kIbT9u4J6o6yumNNt1d
         NQByq3fucANvtwvSf2067AgdycjsAeA5x0Z7osxSrY1JluXwgbcdSl8iAAQ9qn9AHJ7T
         ct8c3eIP+SilTa13dd1Szu3iUAbqj/g92T+nWaIMNABLdzbrk/a3YXt+k7AA1WAXk6/1
         hdkA==
X-Gm-Message-State: AOJu0YzzkTV7upxBmQlAMUoJ1rdm2rtv8ci0PGn22P9x38yK4wt4rJrP
	x0sfjUFe5Ys823QahY6/fQ==
X-Google-Smtp-Source: AGHT+IErtz3yfC5CSuj8iK8EKoudE0OqpajaQU4jOjEcLrem32xpUE/gWx4IV+jZiqyjc2Ar9l2wMw==
X-Received: by 2002:a05:620a:40d2:b0:774:1474:a819 with SMTP id g18-20020a05620a40d200b007741474a819mr29068851qko.71.1697189329913;
        Fri, 13 Oct 2023 02:28:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.155.159])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a035b00b0076ef3e6e6a4sm486097qkm.42.2023.10.13.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:28:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <71949d82783458d066f4d49bdc5a0e24d8687e04.1697182955.git.geliang.tang@suse.com>
References:
 <71949d82783458d066f4d49bdc5a0e24d8687e04.1697182955.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_lib_wait_local_port_listen: Tests
 Results
Message-ID: <5ee51fbd-c733-933c-3ba1-3bff7ecda252@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Oct 2023 09:28:49 +0000
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
com/task/6377983343067136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6377983343067136/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5533558412935168
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5533558412935168/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4970608459513856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4970608459513856/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6096508366356480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6096508366356480/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8e7e41edfd76


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
