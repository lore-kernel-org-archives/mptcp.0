Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96454168DC
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 09:39:04 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-39c4c3da9cbso2184152b6e.2
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562743; x=1689154743;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHuC9MNHzS7P5HKbNxT5fwyl5GuNU7gel0cSKi4DSFM=;
        b=k8oVdgpf89PeFhNPGsrSvkHYZu+Dw1X+ZL688nCyvAIjpD6lXgDtSW/uwmj/8HZ5Vz
         5xNnSQuxPjYn068ulXW4rlvrpgctW06y65q0p6lzSMnZ88JRzrae4pnPOKmCsPRL5esb
         t+9jk6PHs3vHN7yZjg/MaVt2HJ+pQnFwPKcADyi/QZaBP04r0Vw3P3VRoW395wt5SZve
         glQmIJCvix3ZDR2jRf0nQL4pUQCVvxDhvC4pvJPdR27Yma1sMqplDSWOvFLNKZsoHC/H
         IMq2ov+mYxZXWYUYU1rSQ2tLKA4PfECy9uQtUOzV2qoBDUEAoRvfvjEJNkCOABbUoQDv
         GDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562743; x=1689154743;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHuC9MNHzS7P5HKbNxT5fwyl5GuNU7gel0cSKi4DSFM=;
        b=dxJk6sXXABmeOrCcbmZRfd96ZANJd892zIGiGZWH+hwJGyOWjbqZ7S0qMOQqb2NEc4
         hWgb6s+fxOA+9lkqpQ2G+v0oTNhgriNtcd+taCwbqPLxUyniRXNBUmDB5losAmXVJiH8
         6bNskZaHFduv2bMpNTRKYmmIvGOFZ4YrxPsKzhq8Fq7BJRrzY0XNL4RnUyZD2KFL34om
         WBh7HWlNXi9bD7ZHoIMkMONBybp/ZKd/f5rnRMjSXp4jNSPZWEj+ecz9f0bR9rPexo6C
         WDlF/rr7ykJsCqAcC3V5zVAZbevJr27tC/avd6qUNSMicaKhmEqmBTfbMahLJaZriasB
         94GQ==
X-Gm-Message-State: AC+VfDwMJT94ScDlFg/hEB/AUKZ+j1wgU19frIXXpjKAlWoTNsrTq7La
	hF3WMfNa0qFUbFpJ/4d/tw==
X-Google-Smtp-Source: ACHHUZ7ZGTmlaCiMeRgPrltpa7cT7iFGbVRbVpFYvrUQvpdKEg9DejvwYjRgOcSEQafUNOdl+db6PA==
X-Received: by 2002:a05:6808:1489:b0:39a:aac4:4192 with SMTP id e9-20020a056808148900b0039aaac44192mr4494385oiw.17.1686562743383;
        Mon, 12 Jun 2023 02:39:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.11.148])
        by smtp.gmail.com with ESMTPSA id v185-20020acadec2000000b0039a016ec102sm4026331oig.15.2023.06.12.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:39:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <54a3b69d83dc1e965202eca7ccfdd4927b68de2d.1686554287.git.geliang.tang@suse.com>
References:
 <54a3b69d83dc1e965202eca7ccfdd4927b68de2d.1686554287.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add pm_nl_set_endpoint helper: Tests Results
Message-ID: <6ea59696-bc1c-106f-cbfc-83da5a98ca58@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 09:39:02 +0000
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
com/task/6547545413910528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6547545413910528/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5280908018712576
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5280908018712576/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5843857972133888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5843857972133888/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4717958065291264
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4717958065291264/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d63870a84ebf


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
