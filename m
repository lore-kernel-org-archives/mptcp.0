Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBE2CA6
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 11:28:00 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-79277cfc73bso65479039f.1
        for <mptcp@lists.linux.dev>; Fri, 01 Sep 2023 04:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693567679; x=1694172479; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Hw62eVoMQ21kl0uOr6/RoBNcYYRjWn8ScpDkpqrMkU=;
        b=FneL0xtBUL68N7RkSn6ZeUBcXNmusIixNIRkDVyXU0fn2wH1gaDQp1M17G71qqQHB9
         webCDHgQ+R6nb2jVv66p4EoSdV9EbhXHBMYo3twgwzZOBaSJEF4WK5C1wp+gorL90Vq2
         VrRlnfylFgJes6Sjunc4Upt+Icwe4Xjo9wXKYoHrNC/hFu3DrvXfF7L1B9AdpwWfZSOy
         39SlIZkkDUj1XzZTKEO8p/KQjwR700XPNpwmdmUQ2lgSWsNJQDk0l/L8Ml0xM6GMc4Jv
         3NkIpS8D304xpQrCij50eexcgNtZxtHbh8s92J8sXiKuTBgj8O/acPTuoFPqQ8TW4Buf
         o+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693567679; x=1694172479;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Hw62eVoMQ21kl0uOr6/RoBNcYYRjWn8ScpDkpqrMkU=;
        b=We5sDCXc1KIqis8PMk9JmUORyFuSppah1jza22O2NQ/IqrgB6RT65zOHaqheDAXpyA
         gp7u8gwWqrW2xQGh1kU2VDYFl5J0S6te+GATnn9trq1+iV0w25ZKODL+3yYEXWUUvXQ0
         tpH0cSoChncH5c0nfUqKYY9AjfUf+nfXyRzwmE/4NiMviNaWpb50znJDr6P2ADPLuCFA
         mPwS+eaFKtbHnLNMQimVxdMFzafiAX9z9eJEGL8cpe0txP324REbRTlT7S0EhJ9w5ir7
         LLGAAc4fnuL6g8PPhkrz6zKVKuw9scebhfOallCVkd/znV79zPcxwbUbzh0yuboo1UO1
         b0pg==
X-Gm-Message-State: AOJu0Yz6Wk6AXoCqQaP0o5SR4aCXuM0k5SQl6wV5Zy+OMb1ijWwqqAq5
	t0kzT43+igZB6yUSnk4daA==
X-Google-Smtp-Source: AGHT+IEVY3PVmnHckchQ/3wisZKI79WtlihhePlRoYY8xb0UO6y/8EoqTtb2OIFB7ZdOkCUUN2ZKsA==
X-Received: by 2002:a05:6602:2252:b0:791:1e87:b47e with SMTP id o18-20020a056602225200b007911e87b47emr1932420ioo.15.1693567679298;
        Fri, 01 Sep 2023 04:27:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.123.113])
        by smtp.gmail.com with ESMTPSA id dk8-20020a0566384bc800b0042b279bb086sm971898jab.66.2023.09.01.04.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:27:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b3366069d537f2586f2c0104569854cd8da4cb54.1693560377.git.pabeni@redhat.com>
References:
 <b3366069d537f2586f2c0104569854cd8da4cb54.1693560377.git.pabeni@redhat.com>
Subject: Re: mptcp: implement connection level timeout.: Tests Results
Message-ID: <a079b3f0-9fca-a96b-76f8-bbfa89159f6a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Sep 2023 11:27:58 +0000
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
com/task/4814912237600768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4814912237600768/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4928069559910400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4928069559910400/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5940812144443392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5940812144443392/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6503762097864704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6503762097864704/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/68a89eadbb3a


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
