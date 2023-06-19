Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2212B91
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 15:57:52 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-3ff27d3d2f8so2923401cf.0
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687190271; x=1689782271;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnB83ndp25vfa7fx1CYJ+7Nm89bysbQ0vTbklxZk11I=;
        b=TWMzjY+iLPuHWlk05WcB1dvZjnLX+od55c4IkRNucaxrsHeV6SwJc5LGwzs4HXkObq
         0h/+cfECBU74pLpTwEtpUWN8dxxk3qOKXx4q7WhOavYgLFwYN0r/VjAi6yZHVX3fd8PJ
         eKE6toANa6lwSTkUaVJ9vGmf0CfwMWnkNxGWS+8saUOUeJAotWDQmbzAijHU8Mex38Yc
         x/IKrWoosnUYkp+mUz++BK7eYc9CtHOuYbKRcNxwQuv1qYILH7TtWOjdcF0w9p3wkRsD
         k1HDM1li+dM1FP8gL+MexJNyn8/Onc3JPM5n+HTxUUVcOc306hHy6MPiTpkcMJfDYoof
         0+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687190271; x=1689782271;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LnB83ndp25vfa7fx1CYJ+7Nm89bysbQ0vTbklxZk11I=;
        b=AoCjRljCZScCC2jvgIIgiJ0BS7DYF5OtIX7XF4D3jIuqmJkNS02sVVPT2DS95k52YI
         xIIdz+egCuxuHOIjI3STv4felEeiYo4ZaWOywXojwd8586wsATZvKsTDwBcNSlwwnEei
         EfmNe8TJh3DpQWVdUBgUQHQ8Hv3PAy78QE/NfetimkM8MD5MyU6sQQc3PqV42zjUbReA
         P7PHJ7L88P8FMC53bxadkt9t/H4+nKQwrh4QbiPn7I1q9KQqeoS9Jk3kV90bFlkYN2I6
         tQ5c+Gadk3xF+gvj6Yw4oa6K4cHCa2Y/6ZGF84oy8V8OIVTnWHYUxCvHh9/2QeyTfPxA
         7NFA==
X-Gm-Message-State: AC+VfDy8tsuVdOY7yZ5k9Fq8LiRHYKLcnaFIB/1GqdhvsvbodzXiDlcx
	mH4mTHVgJ3Kd+avzMagX+w==
X-Google-Smtp-Source: ACHHUZ47txnOgec894j64e/OP3cTV1ql0PxvePVNz3eRZDD43N+iZIwqXUb8d3Jy8y/FWqFznu7CRg==
X-Received: by 2002:ac8:7c56:0:b0:3f9:adfa:319 with SMTP id o22-20020ac87c56000000b003f9adfa0319mr12655730qtv.64.1687190271329;
        Mon, 19 Jun 2023 08:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.65.72])
        by smtp.gmail.com with ESMTPSA id b5-20020ac84f05000000b003fe0a89447fsm32932qte.14.2023.06.19.08.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:57:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0dd86c4b502f4d977add42b983c0aecccef8b289.1686900596.git.geliang.tang@suse.com>
References:
 <0dd86c4b502f4d977add42b983c0aecccef8b289.1686900596.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: set endpoint out of transfer: Tests Results
Message-ID: <30543239-59fb-dcd9-4031-e0a9bc554772@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Jun 2023 15:57:50 +0000
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
com/task/4730991546204160
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4730991546204160/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5293941499625472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5293941499625472/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6419841406468096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6419841406468096/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5856891453046784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5856891453046784/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c463ab649871


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
