Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DF23D9
	for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 09:59:48 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id w29so4864643qtv.9
        for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=KzG2D2cxr6vkddYMB6IdxMKO8nrEhJD0zwUsL4dqRvo=;
        b=TFNLeeWWsGk0JPxcDEgU2TwHAS3qf5JyB0xYo+5AJZBiqzgK/2hPBh0O4q748+kaPZ
         7bd82BuOPq78ZcuAFFsaiZqBs95CGhk5bQXk92nlCF9ruwYw+taHXu4OBcywK/+kx39K
         4W7e7wYDB6tiuKvW4fEnA6kxiy5cLxIjK4V1tnvRvKgo84j2JOx+6ReaiYPThKZzTVYT
         ER3VTcls/eWksqG2NxaDS/qQu5Z+BD+ii1ejPH11G4mlreJQBr1QnTFiN6eX1fxuwC7e
         nZYqzzvnPl46B3VpcYH8fk6uLUW3JmY2BYcbm63x0dw9cWynR38FqIrPpO5AAsFI2yho
         yHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=KzG2D2cxr6vkddYMB6IdxMKO8nrEhJD0zwUsL4dqRvo=;
        b=x629S9euRI5STcj7OOuU9jCGk46IQNJniYnveTqD87GqQP/a0rT7iiy117O6CC7GMs
         MHiZhd5lcR8auWJrXojM7V3j6jUCe84Pvgn16Uj7/gmEh8oI7o8Rd4V13HnJkvr7AO1/
         C2hvLcTP40HQ6A9rjfH3Q4LsyR01rT5fIBN0hnYfFMe0yP3SRh4u9RYgw3/NXrkav3aw
         lSCWKiMGwWueUf2rgumSnz6ASZHFrqBshixyhQiz4lZYAKmcy43ceStOGWm4o1sqQyyZ
         xh4cTpZ+z9/FNtftnXWI//QNPylHKwSs9P1qk5U8A49U7KrwbWb3q8jwG8rCN5vDQqr/
         C7Vg==
X-Gm-Message-State: AJIora8IHpoZk4oB+tWtjwnQXG3pMGuev7PTNTkc8g5Vm8rhFwvCDVjx
	Q3+K604v6KrzEFrala2ufWZtg8osLTYt
X-Google-Smtp-Source: AGRyM1tpwB4sR/ko5lS6znY9o0KbV1Bi8TZ7iX8PFuiNJZh+sCWGwgif0zoVotfjkJQEKT176ewRYg==
X-Received: by 2002:a05:622a:4cb:b0:31f:106e:17ff with SMTP id q11-20020a05622a04cb00b0031f106e17ffmr6659268qtx.68.1659175187252;
        Sat, 30 Jul 2022 02:59:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.230.32.241])
        by smtp.gmail.com with ESMTPSA id t17-20020a37ea11000000b006b5bf5d45casm4255406qkj.27.2022.07.30.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 02:59:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ebe1091e99f86b5488c8c200a3bc85b69af9ad86.1659165378.git.pabeni@redhat.com>
References:
 <ebe1091e99f86b5488c8c200a3bc85b69af9ad86.1659165378.git.pabeni@redhat.com>
Subject: Re: mptcp: use common helper for rmem memory accounting: Tests
 Results
Message-ID: <f3564dec-038f-aa6f-6ab9-1415ae895f61@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Jul 2022 09:59:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6571960086822912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6571960086822912/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4742372738203648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4742372738203648/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b3684a6eadfb


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
