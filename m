Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C42714A
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 02:56:09 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6b9e478e122so1401510a34.1
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690512969; x=1691117769;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GbRENox7WivqXpD7RPSSgelw6n4UeA1acy4yc8fzJo=;
        b=bkCH51+cNo+VEY9CtLcxFLYTjG2Q9NCLSit7iV5bUpqNwmfXvk/mSrhJyH6thtKN1i
         NnrlZ+OfEjuuIksGg6/kmTxASZ/GlS78Tg3ZdARcBFGMIpsA8GzbK5Rj/UutP/Fb7EHS
         RJKPjUd/DK/XETK947j6HVw6ShtHWjl0yktQ+Eb8rD2gj0uDzr/LE1sQ1h3otf2SbZ1O
         jR+lLramTJ8jncsPgojWzNhyr9+k568JX2/szw914aGi7dmdBV6u3y3UcBJ86oFGSU9/
         wArj+r0uNQHv+n0IFn5eUFuqNVzclwIkn2XAtfKcvwSkLw+sWNzHVJQ5rTk8B2xGImln
         7utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690512969; x=1691117769;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2GbRENox7WivqXpD7RPSSgelw6n4UeA1acy4yc8fzJo=;
        b=GyxIhPI0MF/uPPH/E7j5L+eWAtP3fCshHTuMomh0RMAzPWhZsh5bbfeWHh+/ZHPaLk
         cyKmKycmz1Ir9GYMqwW3y5naxhucz70MzSd7uQP5+C0fxCuXBM5R3UklW5cE98O0DYWl
         nguCDAaf2lBFQrXtKWjUL4uLkoaYrTzrXZ9RvqXv/kmvhvUf8VUMapmXU/tjIP+g3S/t
         zJdXnpBIZTdTYe5QFLnyVMCLVPAtwon5CF6qxD2yd9q7/0VaiLJz16zxT21igdY2zVrB
         t5clZR9LknYCqcSgK3dxWMGtyhf6j0IjqrYAx8phzGy6tQjl89OdTJmSReaQDmR0Pxf5
         DLUw==
X-Gm-Message-State: ABy/qLZ1krNJHEVBZno62UrnLGo4vNXGy4kZZ4UTUS0qaj9ZY0QNo34/
	Z+BZsRG3ak1FD1qTbxc/Akuxq7P/VQ==
X-Google-Smtp-Source: APBJJlEFzD16JRa3cz25eq30bu4psALvY+nzdvJB4jPAk7HgDaw4ALUbNu6Uz2ZyX0nsvwaWLLmQ+w==
X-Received: by 2002:a05:6870:e307:b0:1b0:408a:1d14 with SMTP id z7-20020a056870e30700b001b0408a1d14mr1526820oad.44.1690512968727;
        Thu, 27 Jul 2023 19:56:08 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.139.107])
        by smtp.gmail.com with ESMTPSA id ef45-20020a0568701aad00b001a9911765efsm1311528oab.40.2023.07.27.19.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 19:56:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bbc41ae5d06bfeb5de45b94f73319d22d41dd7fb.1689650435.git.geliang.tang@suse.com>
References:
 <bbc41ae5d06bfeb5de45b94f73319d22d41dd7fb.1689650435.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_burst test: Tests Results
Message-ID: <d74bce62-1d41-fca8-79a6-dbed01b457c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Jul 2023 02:56:07 +0000
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
com/task/5024200105132032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5024200105132032/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5619233783021568
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5619233783021568/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6713049965395968
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6713049965395968/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5587150058553344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5587150058553344/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8163a099bd40


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
