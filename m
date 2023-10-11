Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F418FC18
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Wkhr+v"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-79f915e5b47so270908839f.2
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697013063; x=1697617863; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeZm3awpAmMTMsSQ8bX0iUcNSxmrv6teJ31jvAZX8PI=;
        b=B7Wkhr+vfpr0PdE/Bj+9Db4pXjDS8m1Q8HsmE1fQcUiA07SyQ6g9xtT+C76Nst+QAa
         HiS+n3t6DGNevrABwkl7Y4LJFhDC9Mr6I5jJk2Spp+UEc8LBpICgI9tzgDxu7cJY95Ub
         pss4/kcsxg3apXpSWEi2uUejzLocIq36jFiS7JnBmWY6Fc8RtJQycdpfRGzLMeYBeyvY
         68bvBcBaApZoYb6OFjwtoCl6nmPaHcoC3UGd0H5BiIEsKl6fqbA0QXpmntNtTI7Pk42A
         ydg1gwy/pgE+6Ra6taO3ArxGvYXiV3B9loVzfIwGJ0pOzbSdq0ZStlMfRsm8zA6rA7RN
         TnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013063; x=1697617863;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PeZm3awpAmMTMsSQ8bX0iUcNSxmrv6teJ31jvAZX8PI=;
        b=gLQ3LNky+Bqg+raIX2cUvWS5rAATwA92Xl5fjxUlhCx1MGlE55Gv0YVsV20nzMDNzd
         1QjcT94XoNoY7WDsWPRHC3/VRz2mPSEWhPBmZKEof55SqgD26czUqjwuXP6Ki9z/L2HC
         C9xTNG5lWM39epYM/EWokxi7Cwm+oDVTzAB6pEv5etmrHYzYpU4bQQlBLqHR1Yvnsl6U
         lie7k79svs9TiCrsVWl43wNI3RfpskYquojHscFmh+LaYJEUCA26jDzbxpUUMXUnXQOw
         1h3jkyc7OExH5GAcNHMK5a8g1tPCT7pO0Z8eO9DmCElXOd1vUwcW4hZcTSktKHuL4dZ0
         z7WA==
X-Gm-Message-State: AOJu0Yzs8zT8sguh0sQ5IvqzcaJ6JDbHiz6ENgiqsoldec/ejgoala9h
	vzFUtZoOJLgyh9BILTOXHA==
X-Google-Smtp-Source: AGHT+IEXJEbexUDzGl5fbU/EuULLNGG86EI3z12EGNHgiCiWkB3r+w/IgZcnawrBy4YY5oryt9op0A==
X-Received: by 2002:a6b:5c04:0:b0:79f:99b6:63 with SMTP id z4-20020a6b5c04000000b0079f99b60063mr23834029ioh.9.1697013063556;
        Wed, 11 Oct 2023 01:31:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.135.33])
        by smtp.gmail.com with ESMTPSA id m6-20020a056638408600b0043194542229sm693287jam.52.2023.10.11.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:31:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
References:
 <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
Subject: Re: tcp: allow again tcp_disconnect() when threads are waiting:
 Tests Results
Message-ID: <35c4df47-b9fa-778f-2a89-c59114b92541@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 08:31:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4809685430173696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4809685430173696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5372635383595008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5372635383595008/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6498535290437632
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6498535290437632/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5935585337016320
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5935585337016320/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/79b9130a599e


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
