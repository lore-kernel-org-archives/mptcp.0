Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BDD2FA5B
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 18:43:12 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3461053677eso3035745ab.0
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689878591; x=1690483391;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FRETh0f0lQpcfwWiZylZgbaQqUdTRgFpuQpGImv1dU=;
        b=eymwuyWvTO3pw922oxTsk8St8j0E0IckDNfgPPJaIuJqxYM67HhrNKGh+b+vcb2PeK
         dRl30PzO+lARZ6OvhltJAM8EcVhrZT4Du2hl6kfRhGMC86jRADpB36G2uwuPKTX/1c/s
         z4UkWmGetD+bAxQ+kAdk+J2ZmT/MQFFd+s0FyPCNB9/IrYBk+atgjHnI6pdQAAtyFqzn
         DBvCFfGORDvNRx5ejjex08ykiUucySA/nhhLpfFe/E4SnmvJWNGNHuKr4VPTF0F1XvZu
         vRqT4yZG8z4A+baJ1RpWy9m5Gu+Ece67dV4FPclJWrD2hJ1AeKO/3JC+Kq5OklOM4JMP
         Kw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689878591; x=1690483391;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/FRETh0f0lQpcfwWiZylZgbaQqUdTRgFpuQpGImv1dU=;
        b=a8AhXH15dV3jdepXkGdZ4h5XK6NBByPT88DMVouhVm8E0NyHXxOKAy3cL2L94jcTLR
         5RzrmrSzAYvl5iWgBwPiFDILi26p36Eyvx5x9RBml84WauIiB7xSATzw3sY98E2riXwj
         9sqgCPfWTugOzWS4Yokjj3GbAexP+OWHedrB44yMejBby9yf0OpvD2sXbB3+8owiOHxw
         kGFHciNPSkZDROVt0dzWPyGH/h57Vp8W9zu2Kzh3pQ21cINhGBptC1oM5cnwWzVH1lGn
         MWYEr76E134ICCMh2jDDIlb7g9oDiLMkFo8JGJXOo5EDa5ZTFj8x/viRFnQcHnFkd0Fm
         RrZQ==
X-Gm-Message-State: ABy/qLbi+mZmE5LCp91Z/gp9fJhWisqW8shbER12sVUueENhBuuaaZTS
	vsKfRyqbf7klHxFRxvFYKQ==
X-Google-Smtp-Source: APBJJlH0Y/y2tYvO6mtJoHD9b68Rdk95a7B65ixgXH1cZGs4X95HZpPmIiUItwSxvdfnEa5iGa816w==
X-Received: by 2002:a92:c266:0:b0:346:23b0:3725 with SMTP id h6-20020a92c266000000b0034623b03725mr4931641ild.13.1689878591077;
        Thu, 20 Jul 2023 11:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.22.97])
        by smtp.gmail.com with ESMTPSA id e18-20020a056638021200b0042bae96eba7sm510824jaq.7.2023.07.20.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 11:43:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <af7285778734d7e4f238663b457602cea05a309e.1689834758.git.pabeni@redhat.com>
References:
 <af7285778734d7e4f238663b457602cea05a309e.1689834758.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_avoid_add?=
 =?UTF-8?Q?itional_=5F=5Finet=5Fstream=5Fconnect=28?=
 =?UTF-8?Q?=29_call=22=3A_Tests_Results?=
Message-ID: <6a825049-7d6d-42c0-ed98-0b9bb1328711@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2023 18:43:09 +0000
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
com/task/6269486597144576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6269486597144576/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5990205023322112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5990205023322112/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5427255069900800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5427255069900800/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6553154976743424
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6553154976743424/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/421d0a90e2b8


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
