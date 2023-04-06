Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEC7EA
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 10:32:55 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id j2so13313866ila.8
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680777174;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxIPB4K6meLwiPwSvueILzyuhuMNVYwiiTJ29nsBBCU=;
        b=lFh/LnrKEU9P6/VIgNhH3ZzTckKiBZL/CMYQ0zp0H6IjBBgvnSeO34izsBd0ie0M8m
         ld3lnL3wD2KF1L1+CtjYWBMKqYj7j5SBoyKdEe3WWeSG2wqwyGaQORrX1RAISxVIpopN
         h02xAfe8z/J0nDWmuDmfBFblq8bhV9l0ilGzMPF8Q0dkBM+7/7j6dOBTFCwkWOWaTI2M
         2UqknwWPNvOtQWHSE672Ofu0svbjfWF9VGiO6cXE1pdkejwSDvU0AANMxbzZ8Ng3c7/i
         3iAFNkY7HK0xKds88on5dUebXg/e46Ns8mS1qf4Ses/CHXOChhlqbObs08M8TlGmnHQc
         Kegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777174;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxIPB4K6meLwiPwSvueILzyuhuMNVYwiiTJ29nsBBCU=;
        b=RY3LU7xmKzlk+vpMYrz//PEIu9RazR6VoUL3F+lZzy5e049iLyg5xv2dVhO9/OhzCu
         FhjkAIgC3lAvCu+KpFOZ6IYDpZUEnVbgSEw5hmPkZImXiWJQAEsMQmhW6dNI7J4U8GIN
         FNttPCMLqvm5zfTk4xq9LD1oNwqRj+DheTg2pfd3dwx9+nTP5RH8/NoDyjvL7UkF51Xu
         +TB7D8UOlzvcKrs8DT4R8dq56DFH7yOgsttFtoWcLPBjDHoDxygLo6H8XxGPKP42oC2y
         xQX0AZjC/LTTYSpOFjnyUNCXLVND0dR/eHIs52B1OABeVHpQccNQCKWtdq3rVukW/Yq3
         wFlw==
X-Gm-Message-State: AAQBX9c31DbtuxgmuWh+ayQknnGRlvdZUFozEiye/wrgmncL60soijac
	S3ix0gUStOeIr4ukEl6I4Fe3mngn6cXI
X-Google-Smtp-Source: AKy350Y1JuHmtTmPyODHsMiajenLqQP3ZrNL5XuRRxqIf3tgvmh2unn/1gLaMLBdeOGaGPFs/zgQjQ==
X-Received: by 2002:a05:6e02:544:b0:326:4e72:b83b with SMTP id i4-20020a056e02054400b003264e72b83bmr6476448ils.27.1680777174091;
        Thu, 06 Apr 2023 03:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.43.58])
        by smtp.gmail.com with ESMTPSA id r14-20020a92760e000000b0031944d1ce5dsm254784ilc.58.2023.04.06.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:32:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230406092558.459491-1-pablo@netfilter.org>
References: <20230406092558.459491-1-pablo@netfilter.org>
Subject: Re: uapi: linux: restore IPPROTO_MAX to 256 and add
 IPPROTO_UAPI_MAX: Tests Results
Message-ID: <ee57c360-4cee-eb3c-87d1-28c34c420993@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Apr 2023 10:32:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Pablo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6514203557625856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6514203557625856/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4684616209006592
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4684616209006592/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5810516115849216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5810516115849216/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5247566162427904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5247566162427904/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/068f4c127b31


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
