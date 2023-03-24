Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FD107BB
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 19:52:00 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id e13so1243350ioc.0
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679687519;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE/+mXF4wPcez60dSqDSj16XhTn/dcqIZyclNPAXXfo=;
        b=fBRVfoWSHId9CIEJ4IlcGv99TcpCwrkP3Hrg2/K7njiua+JfUYYWN+XKbOMYoKBEQG
         ReP1T1onFOLW0TLd9rBgEMxVcteVsFdIYcnytITnE0AcosFvVXgHKaQvdY8CfHmRYLeL
         xWDy4Xd6Zl6v/cImBglRkSeluOFGFS9dUfSWZZjdaF3+dCr29qD4zQ/qBdOUu1bakAkt
         uDT71tFwg/Qom4+/0O9gixQbMqksbC/VsNrY7REVYNgiTqpVg6O+YjbwtSIpbS5MlIZo
         OWO+H/DKbUfkvoS1EFOttqJoSsyPJU3QeKsWpKU5t/vtgIPih3/zLbMxYAmbOFxPec2E
         +ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687519;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dE/+mXF4wPcez60dSqDSj16XhTn/dcqIZyclNPAXXfo=;
        b=dlcXXp4BZX6e7HzOi0yty30CtILba51SdD02oOLu9Pji/Hn7YNBCB9nx+e7O7IYPZH
         N1M+/0y4PxBusOnPN5pJU3JxZRMvt8cXHSZlBi7DoNH3Yzo8IbifPf9f9gdfjtC3HcnZ
         r4QAHCjE/+xK7xqzjG+a8GyG+aeQHwA2hhnnkAFbWK4HhGsAMSf39NRUgNEhZ02yerPq
         inXH/ZQ9oeIqhTTi/LVs5oc7PV5Ep4QPMhG89V+nkBVfzIPm95Rkx09u9OU+t+oULxaQ
         54XA/1oM64S5nzNMfGMr7I8BmvN2Muqdyl7aHLewkQzjxV5ui+7hLFDsSIU/y1wllnWh
         uOBw==
X-Gm-Message-State: AO0yUKW7ppz38QGdtC6NkqMfBl6iLOaU5TUHtZbJ9rzPrt8qeNMq5/UE
	xNmxlExA8NL+7h0PndkDN7gj8/FQfo0a
X-Google-Smtp-Source: AK7set9EwonSYsS3c16BgvrLaJ0G6PuBu1o2GpCTjkMc+y3aziwB+UWmJjNk/7gebd+ZSoN3vR/n6g==
X-Received: by 2002:a6b:650f:0:b0:758:6728:7023 with SMTP id z15-20020a6b650f000000b0075867287023mr2659826iob.21.1679687519568;
        Fri, 24 Mar 2023 12:51:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.123.112])
        by smtp.gmail.com with ESMTPSA id f5-20020a056638112500b00405a03433a0sm6766454jar.156.2023.03.24.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:51:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
References:
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
Subject: Re: checkpatch: allow Closes tags with links: Tests Results
Message-ID: <2ae4d775-b19a-0a1e-63ee-f74a4562e70f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2023 19:51:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6489951185928192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6489951185928192/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4660363837308928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4660363837308928/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5786263744151552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5786263744151552/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5223313790730240
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5223313790730240/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/00f74aa62486


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
