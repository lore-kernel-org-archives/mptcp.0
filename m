Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A77C
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 15:09:12 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id x18so16653032qtj.3
        for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Dvp2bQdLAFAUlX0YjkeqKARL8REAct479INLanDQfVo=;
        b=R6BizmgunG3x6Jozc5/NZ0yNM6MgjjlrFMRqW+/GJv3MYmFqm1VMhwvpuyS/L1C6cj
         l8XK9wnoC+E56i21+8kLJoVAP2DSf4m5Pnib6Zwex5EjO16zwH+FY8GP8m5qrSCwoHlF
         lSnAVIFmztfElcxiEjn7tQQg3QIKEHNpSjGy0MPiYP1CNMT318bpurczqT0VPPsAeNYa
         SIlUALtX7YxYQ38y/BCTFDAmp7lQDXpjTnmQoPL1BXsZIOkndOTWzzLwDCUntjXRTR23
         WEJCcHg5LTJRpfp23oD5OT5ZTJdFeNi8A8nfmO/91SlMslVD1GEwJsV42Bv733x+ICKe
         mK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Dvp2bQdLAFAUlX0YjkeqKARL8REAct479INLanDQfVo=;
        b=2PSplNEAJ7mUbROHy4cqR9MMasr84qpHaws5Nl7wRwVv0GHQI8zqGqS6+rZAHk60gj
         oRxwKZmdCIZ/V1/55r/pe/YYYsz0STnOF1g5PNhU9QK8VdjcGYvb+bOjO3GhvkvH35rW
         ZMEpkOjV1o7iXo9D5snwHqQVFMKpi/ueOpnj90T5PBo8RZn//gdYnipxFLcITUoSP1E6
         QuXNvmaSEI8VpRGgzrdAWwe8GSJPgbUkERevJ+huHD8izKcK2A5QkpI8/npYfcN4F4Sw
         kap73qDXLzgfwkSTK8E4VRGmj6cEa1eUbKI1kFTOzQfE6R2O9nXofoSSSoAMeybw9Xh+
         EhZQ==
X-Gm-Message-State: AOAM531Cx/9A1Sg8MrU2M68tN7PF8JnifDcwO0zteLRmVSCDmG8zVGmK
	IeDHjXgIbZXgg+HqHnUYINYoRoEAQcDY
X-Google-Smtp-Source: ABdhPJw7qlEnhJMXyw+qB4B4GaZ9mYPMms5hJNfJXVRe07eTf0RQ2hLTYHJ8o38RObVmmF/6EvUOWA==
X-Received: by 2002:a05:622a:491:b0:305:1efa:4447 with SMTP id p17-20020a05622a049100b003051efa4447mr1489881qtx.501.1654873751158;
        Fri, 10 Jun 2022 08:09:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.68.247])
        by smtp.gmail.com with ESMTPSA id j14-20020a05620a288e00b006a6a1e4aec2sm18697646qkp.49.2022.06.10.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:09:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <36aefd62089f887aa9e640d5dd1ec513e8fca592.1654865847.git.geliang.tang@suse.com>
References:
 <36aefd62089f887aa9e640d5dd1ec513e8fca592.1654865847.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <b1a209ba-677e-a580-12b2-fadffc316884@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jun 2022 15:09:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6031967358550016
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6031967358550016/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5469017405128704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5469017405128704/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9e69e1319523


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
