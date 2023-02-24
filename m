Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7F5CBD
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 15:08:13 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id e10so7563436ilu.4
        for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJabugDnoRpJpv2x97Gxpy7q4sCd+8VJ3w8jWypmihQ=;
        b=PM41QkDdd8COLD+pTiPvO6cAWJvh4r42kuw5qBF5hisBIIcAM0gS+AQt4H9nHI3t3n
         D8DIxV/uP88NmIRFSV6ggvTenrrMbo5nvW2zZIdxueTu+s20Qh+7/CdKaFMsTodLvVi/
         VW7l0zdScMU68MBMlPUNXfA8n7DEVCwgArP2Vs3vqJT6ztHCr7q5tPxXxKZoSzuianen
         /R0cPoHlcXccMF4/H7Fe5jDN+3JtDHg7/pAx7N5a0ns33lKWXtnM/RlLt8Cw430U6ivG
         2oebgwQCD+3OC0fQ4clbDy9xkEW++rC7B83mIAxipYdJmktMBeouKrwp6fK1w3hTb1yD
         JyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJabugDnoRpJpv2x97Gxpy7q4sCd+8VJ3w8jWypmihQ=;
        b=B8JvKmGHk8dU0mDWasggQHaezAJEXpY09ZobNpspBVAl3YE2ORJPqvY41/uTCzwcHO
         c2gQIecrERV6PVgWKl2Ey8ufLb7xkBNaYFlh7CevyoOk8i4H4qMqlWIHFKKLUh3dJHzJ
         LErQKG+8sa/5qe++o4gdIC1ypHq5hO6co8bVKP8BzUKzf/7uIny2zZsWYM9TCFAa4I45
         zO0s1e6dki2HpETAPzowI5vEyLxyuYpSQW9DXRkoUbYmgepVv4lFrNqFqN/5OlCy0AoS
         4pAIY8ss6jn+bJ+SIEE4VanlV8HsRnTK1QRxFXwtHhPuhVF+7cwdFNQJoMkgOHfiv57O
         Pkhw==
X-Gm-Message-State: AO0yUKXNkiM+q7pBeXAe4GvUpCGX6KrIm22NdZhHx4wTl/HzdYK1qkfA
	KIloHQhE3IMT4y6iRc6V3g==
X-Google-Smtp-Source: AK7set9RltHZHSaBeVDa4gUx0h27C+O4pye7V9TYvlxPwOAhQHIvCVyToDfWA2vpwZ5VPd4LWIlG9g==
X-Received: by 2002:a05:6e02:20c8:b0:315:4793:f7b3 with SMTP id 8-20020a056e0220c800b003154793f7b3mr14234780ilq.13.1677251292490;
        Fri, 24 Feb 2023 07:08:12 -0800 (PST)
Received: from [127.0.0.1] ([40.77.45.146])
        by smtp.gmail.com with ESMTPSA id g22-20020a02cd16000000b003c86e420f9fsm4699798jaq.100.2023.02.24.07.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:08:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
References:
 <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
Subject: Re: mptcp: fix lockdep false positive in
 mptcp_pm_nl_create_listen_socket(): Tests Results
Message-ID: <55f2389f-7503-8ca5-cf6d-a0ee6302db6d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2023 15:08:10 +0000
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
com/task/4710129321377792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4710129321377792/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5273079274799104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5273079274799104/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6398979181641728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6398979181641728/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5836029228220416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5836029228220416/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d034405ecf19


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
