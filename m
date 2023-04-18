Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2800C94A
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 21:32:01 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id e13so13500422qvd.8
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681853520; x=1684445520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbqLtM6X+yzY6srlP8TREyljCNKm1rL7owvquxV9YVA=;
        b=mcRB+brOfJCMogUX/6cYnKgmIep7wr8RPTzyamJp6HFOmOoPnUW1CilVQCqn4nyCj8
         Zob32S4zGMSvrU/i+WBvnuA4ROwg/Dk1+dx5E/IKp8J5N5gG35foZzBg2jbK7EIM801/
         m3zUfKKm8FewJ+fm4M7EAA3/rIolc/Ia1AKuy+uRueY8XN/mg4l2T4NejRd3bwR+nR7Y
         OzyVCTV/vkMSmkXgUCJvyIp7ucflFy2QdeGP9PshS1rzCZPa+WoxStmI3YGrn9k1XvcV
         z6gpSpBkpDyfSDy+/hPU78GJW+ypZ3vQktHOPCDVrffohtKLBFoGK2jwjtsUXrob5IcU
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853520; x=1684445520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbqLtM6X+yzY6srlP8TREyljCNKm1rL7owvquxV9YVA=;
        b=EfbHK2F30rhy4yJifkLrGFvVRuOXLTbwRdmo4dVKh3GT91RM23E+/zGkEydvpL8Scm
         0b00RCqX2dbtTNA9f+OOxJwU7xmZVg3bJm1E4hI9Smljt/kIgFbheEAn51Ziv9x7skWO
         5UwJ7x+KeoNKF2Yjvqp0QgX0aW/IW6YzBNlAbWFNtggrTjv9sOq/E12HQNYGQwZm/LDz
         5Y/RHL3+vP9tJ0YirXS8j0m2zTKz7nMDR48+8+f+2Ert53hS9MzHQZDZRiP3ktBr9zy2
         Ufgo+zFU4yj+Ug+iojbGNt9NEAYa+ymZA7ppFEsRx2Yfbbq5gvnoIeLgh4hVusZK7uWK
         1MeQ==
X-Gm-Message-State: AAQBX9eKrqinVBMYKVRFH31RKreA8Kqm//8XXr2feJB6gy3TA+w9XGR7
	Rld+yD1JS/umsGfnNhgmTMpTlljeWJca
X-Google-Smtp-Source: AKy350buh9Uutnt+aLT+qVO2/1p5Nt4rqMLQQCmTeucsiMI9Dx0Li7adn1HwGoJ6AfG4rHgk8l6rPg==
X-Received: by 2002:a05:6214:20aa:b0:5c1:fa35:fe6 with SMTP id 10-20020a05621420aa00b005c1fa350fe6mr19579485qvd.24.1681853520640;
        Tue, 18 Apr 2023 14:32:00 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.178])
        by smtp.gmail.com with ESMTPSA id i8-20020a056214030800b005ef41801845sm2990565qvu.89.2023.04.18.14.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:32:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230418185730.40775-1-martineau@kernel.org>
References: <20230418185730.40775-1-martineau@kernel.org>
Subject: Re: MAINTAINERS: Resume MPTCP co-maintainer role: Tests Results
Message-ID: <f00a654b-50a8-96c5-5f7d-640fe9390667@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Apr 2023 21:31:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6516116353187840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6516116353187840/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4686529004568576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4686529004568576/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5249478957989888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5249478957989888/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5812428911411200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5812428911411200/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/442f1921b5ad


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
