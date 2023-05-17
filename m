Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE518B0D
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:10:07 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-62382e86f81so3206576d6.2
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684329006; x=1686921006;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH+7jqehuAYSSajpAgXu9CE9OWP+gwWVUChJU+5LFQU=;
        b=cCAkinBo+M1CzXR21Tr2DG8yPemLDCiCUOYjRXV/qK54MKaNDJbFA1Ar5FlgMmiWtW
         EYkf6mQfgB+wTlwDdqxaM4Y6fAaFD5gwPCkJO1VBSkE59zMLXu5t4qeRSgHVP+/r2w3H
         T7mrzrOtvvMqDPcxxj2qoBpNOmvBwQTC/W+t4MuiQ1dkq3adG690+8+RHkPwZ658dd+w
         tMM5RSTMk6TaEtSfyUkY61ccjggWs+J6XFFi+dTkyKwPj2m9gj+tGEcyxu2UZPJThb+B
         2LXL5hCZLbtMhxZfT3GT0ak0PRvY1TU/YmFQKpNhDhpvmTZfJcrz0GSZaLU3BNiucHYj
         fjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329006; x=1686921006;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GH+7jqehuAYSSajpAgXu9CE9OWP+gwWVUChJU+5LFQU=;
        b=GTLqrbpF67bEL0YwbFysxA/dUFNEI4IWUD2ajWyEOZhNMzFw9G3PpGDoYu62M2nFO/
         gHvWYBKTAO1B0bqzteYhVlojP2b7tWzxjqvVW8BHGBhEGqy59CckuZPwdDVVdOArt9qy
         hK3bNyCzkU/KdXyeI+3BbUXFDcqBzwURKA2cGL1R3gGQLOriKbmLU6xP0cMhbBtRgsNY
         yYTP3s17J8We46i1rJrBb31gUB0Gcvvsrag+3RhbYHMtA0vB70YczJvElTRiTNw6PJO5
         FwtNlSIwFnf40Ieeh/jglfawrv9Vcac3YyEesNiEFTJkCzSQ5Tzt5hfCJJ+s2LPogk+D
         LP9w==
X-Gm-Message-State: AC+VfDwVh4GZyA/2WqPAQ2Iomu2/cznFjoyydwT6Ouk+henraAiAczr0
	eTdHH6YWZnLGhMyPnbsAiw==
X-Google-Smtp-Source: ACHHUZ6+FIN5EdY/VdJqJ7BblavCZZXS19sC3LyqTIUd+kmBcq1OQn2rWUNIzq0aKyNXjj+uCZ/RJQ==
X-Received: by 2002:a05:6214:485:b0:619:ff0c:9246 with SMTP id pt5-20020a056214048500b00619ff0c9246mr67891620qvb.34.1684329006407;
        Wed, 17 May 2023 06:10:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.193.186])
        by smtp.gmail.com with ESMTPSA id r2-20020ad45222000000b006238888dbffsm295594qvq.139.2023.05.17.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:10:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4ea2e7aeea3fdfdaeaca9aa431ca66df205f68fb.1684321532.git.pabeni@redhat.com>
References:
 <4ea2e7aeea3fdfdaeaca9aa431ca66df205f68fb.1684321532.git.pabeni@redhat.com>
Subject: Re: mptcp: add annotations around sk->sk_shutdown accesses: Tests
 Results
Message-ID: <b16a3936-a74c-5265-3790-7d9ef90acffd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 May 2023 13:10:05 +0000
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
com/task/5312510186749952
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5312510186749952/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6438410093592576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6438410093592576/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6156935116881920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6156935116881920/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_fastopen =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5031035210039296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5031035210039296/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4d1ad0619b22


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
