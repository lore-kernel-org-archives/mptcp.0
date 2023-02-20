Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701416D39
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:07:25 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id d11so612482iow.0
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwjl9X9obcoRtCtlH1+2KkQ7phOHv1G0V3bOml7oBN0=;
        b=Bsm/yKvQuN3odgVLobwCUIps+IWgjUUhHFvvhCrweY+5bXILdNnPTe17CYAdRr/G01
         dVd5Pjglp0v/F6/0RvYkVaqGkJkrOD+/YQk++cr1V2PUT/ermLEKVd9mbVJI1OwqRuGo
         bg3lFKCj8G6+8k6iThNuwXk74TWdkHICJyD2tcFsjucctpDtc9P+FcoL5yoUk+Jin448
         mVSGPbJU2KC93rTKoFhdN8vcyiOtaIbiHqOnA6ZguJ8pro9yJ6aQ9R32Eo9QOTeOpLF5
         QEHLLsDxvswL4emqzcnqhoGkdrv36EIiNAPlV3Y4U2cAiZQYntxpBAT+Ch+LJX8q+Qsr
         STrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwjl9X9obcoRtCtlH1+2KkQ7phOHv1G0V3bOml7oBN0=;
        b=cGwsVgpEN927JkAuk1JPc9xP7voHhIKOXBEivSQ+Tz1qW3ZMiYDtcNn9rNoCxsF9b2
         r2CF6VXTVAyMmdK3zXdhvcpM2G28NunsasjXNC8xk4HjPuyAMI4odqwRPpPyqfqtGlaY
         6Vv/WYb2rZgBTMkgMCXsGUt2ZUAMU4iJOLYm+0CSG/xKT7v1fp2NNI3YPUzZtJxhiFtI
         6FD0S4ZAJsyhVE7KaLY6w5c4q4DAQdOLQLfQbk0z377koU2H7ruvv9wqXwesG6CwFmKL
         +XDTLUw+225TCuosIboylHvmi0T4XD439NNJHxaGfmD4Zg62CmBv+BMp1Fy/ifwQ/8pW
         govQ==
X-Gm-Message-State: AO0yUKXf2iYYAxMHbI4eH5rmgVhYi9vYQorCTtZNK8E/mYODKjuRGijq
	PXFbr2t6YD1GNgZl8akaKw==
X-Google-Smtp-Source: AK7set/Pzido7SnmiO9Fajy9lE241fMaq7nQhyLxxGoacTBLY2zT6Yzy1B53HdVQfA5reSy2CrAlKg==
X-Received: by 2002:a5d:9904:0:b0:6e0:3110:9ee7 with SMTP id x4-20020a5d9904000000b006e031109ee7mr7595029iol.7.1676909244399;
        Mon, 20 Feb 2023 08:07:24 -0800 (PST)
Received: from [127.0.0.1] ([13.86.66.34])
        by smtp.gmail.com with ESMTPSA id y20-20020a02ce94000000b00374fe4f0bc3sm114333jaq.158.2023.02.20.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:07:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
References:
 <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
Subject: Re: Squash-to: mptcp: refactor passive socket initialization:
 Tests Results
Message-ID: <756205d8-ccad-99b8-8351-eb86cf8ea05d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Feb 2023 16:07:23 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6251088240705536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6251088240705536/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5406663310573568
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5406663310573568/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4843713357152256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4843713357152256/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5969613263994880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5969613263994880/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1869e5ad0fba


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
