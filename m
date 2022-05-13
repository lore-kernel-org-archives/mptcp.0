Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597520E0
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 02:10:44 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id n10so5746464qvi.5
        for <mptcp@lists.linux.dev>; Thu, 12 May 2022 19:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=ogLxish0KvlX5UR4L8hylZUhlKp/8GzlrbWJ1s6Tq2Y=;
        b=HTF+PhyfQ/a80y7GEY3mSC4uEnQQUtbGdk7V0o4A1G9+V6EIziIyvnHdEGWt85eb+I
         1KhBLqfTVloc47CmzKNrApbtLkwhp+Snhz4FLB0dlbXB2pgOfbF1vLiS/VNOMJOJGE/e
         rMLDAjNkg1fBuYt0xUPtXvYMef8mCBoGEYLFnKTrAn0NDDicxgTQB0jOCk7i/fmHGgKO
         XkqarvoQ7ybglGU6PbE16J4jSvRweoFjQxwF2pg0mdNaPf+N+wnrxOtBaUDi6AbMiu24
         0n0l0ZQhGMXGP/6kttGgns+VSXQACpJALCwBwfscX8Mhg09ClUr26jN4KjDielv2Tatn
         PCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=ogLxish0KvlX5UR4L8hylZUhlKp/8GzlrbWJ1s6Tq2Y=;
        b=T1jYBqxSKV1rJU65024mMUJTgSC81zNk/yUZdU7fPZ5IF2msM5norDC9r8i5xkGWGV
         8eqO47X1hXiux5rhSdQpHxjv1tTfGlNKtbNAxoNR87Q1/VEh4pMxIhr25JE5HRvZsnfK
         22ehUMylirm2qmzMKrs7h3mTln3v5EDGKjCsAU0ApsUrFy7s4xJw2E8UT0lyzdjbHkGl
         SKWXYsNdA+/0MS81A89g0PEc9jOSJAJkIPcv9bgPCatppASfkzogHt1TCzobF40wKtrV
         3hXYG0iVYTLDkHP4ETB1/wZw4DOzPKleVS4dralyBFv2dxAXOcJZBX6+DJgkqWZ1EwoP
         8Pmg==
X-Gm-Message-State: AOAM532etw6BZGqDOXzZ9do1ahtm/n7hMVUcCoYQlt4kEgzg2qXXJ8cs
	eOPLQTh9/UdFb8MGbognvCBTpbQ1UQ==
X-Google-Smtp-Source: ABdhPJxXfOWCdQNFuck156kITzaF9WW2aTKTJuGAQjzidvWVL8ZjR8B8e/8tNQzfVUjavvvCM1A6MQ==
X-Received: by 2002:a0c:fb4d:0:b0:456:3a15:30d7 with SMTP id b13-20020a0cfb4d000000b004563a1530d7mr2479730qvq.93.1652407843623;
        Thu, 12 May 2022 19:10:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.109.131])
        by smtp.gmail.com with ESMTPSA id a79-20020ae9e852000000b0069fc13ce257sm662412qkg.136.2022.05.12.19.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 19:10:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220513003521.548193-1-mathew.j.martineau@linux.intel.com>
References: <20220513003521.548193-1-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Do not traverse the subflow connection list without
 lock: Tests Results
Message-ID: <c86c69ca-fa4b-eb4a-3722-dacd7f461083@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 May 2022 02:10:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4747222951657472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4747222951657472/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5873122858500096
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5873122858500096/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5e566d71122d


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
