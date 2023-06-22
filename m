Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE580C
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 09:19:51 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-763de34c1ccso108161085a.1
        for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687425591; x=1690017591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKb+NRQfWMsj5OlhjIPr664l0/RyqBIgT5X3uBCnIZE=;
        b=o/xr1XiW8Bhhz2yLryDwxmn/TVZkozQrWh7XLJcdEp9tmC6eQFKW1ubvei9X68HUS7
         fQl+VjmtI3++ltSGFcoWGaDAnZY++O0XytFl2nOxoj0B57QiRkchvUFL1JpuNv72p+b8
         Xu85HOiteZoHPnjz9kRfti08IAJsBB1cf7Nc0RgfEvNbyLzSMXZq6GveWtEWJ2pg2g4u
         tJviIyQi6fGbOIt6V3RASOPYDFBEawNMyZM4imeQRiIeuY92KXoKM89BumkKt3dP6itp
         ZeH9dRXdNjuK8QyrSCX9wftJJ/he2GteUgEyte3p5gXLh3pv0boZ0yYtoAubJ6rT/bXc
         bv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687425591; x=1690017591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKb+NRQfWMsj5OlhjIPr664l0/RyqBIgT5X3uBCnIZE=;
        b=cH78hzCk5qyPzuVcLoWFVCVFhczp/YbWKrWnIyKBlXTgPgBYxLtgEIrPP8O1vOhmWw
         asLVAV8I2Eyoo8L+9uFKhSwXRD/f6l30VSPZCmQ90DpUoz0jY1v51EM8rWbr+2nMA2Nu
         NGsOwoOumP+hvFZHLeL4DxS+2MFyvhhasRP+bCERBcLVTEjFvO05HUn6TJOujDA4S7go
         b4QRz+QJ01A9JjqbV5twPFvo3wPeIF/t9QK3a3n1dNRfwNHKbRkO8RUsYbLu7fEpmAZf
         m44/ik6RTd8JN1XYnyowepX8oQhMqUXVwVshTOFq03QkBk1KcyA/zWhBc2kmh218yS0S
         4KHg==
X-Gm-Message-State: AC+VfDzUgfGOKPaTdBAhh+9vaPNyKGW9PFwieqjd2UrIz/M5FU9ajFok
	dQHLqfuRiANuXXit/YcAUw==
X-Google-Smtp-Source: ACHHUZ43rr7JbZsUn9lPTEppaAXKAxJRXhE/w7MCQfZ9GuFjtcQvp50lkyJqcyJnDzsTrSGyy0aM+A==
X-Received: by 2002:a05:6214:124a:b0:62f:f3dd:602a with SMTP id r10-20020a056214124a00b0062ff3dd602amr2530852qvv.65.1687425590740;
        Thu, 22 Jun 2023 02:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.184.138.36])
        by smtp.gmail.com with ESMTPSA id t2-20020a0cde02000000b0062fede81d0asm3481734qvk.144.2023.06.22.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:19:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: "Yueh-Shun Li" <shamrocklee@posteo.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230622012627.15050-9-shamrocklee@posteo.net>
References: <20230622012627.15050-9-shamrocklee@posteo.net>
Subject: =?UTF-8?Q?Re=3A_scripts/spelling=2Etxt=3A_Add_=22t?=
 =?UTF-8?Q?ransmit=22_patterns=3A_Tests_Results?=
Message-ID: <2a9374cc-60e2-285c-f2c7-43db43817778@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 09:19:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Yueh-Shun,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5325537292320768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5325537292320768/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6451437199163392
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6451437199163392/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6169962222452736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6169962222452736/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5044062315610112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5044062315610112/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6ba3554dcaf0


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
