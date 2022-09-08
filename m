Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6B3D65
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 15:40:37 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so12622887otu.3
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=6aqErZ8HEANn3yoXkdE5bFl5jB7WbP56+j06VvwuyEw=;
        b=CauAU+oev7lXNIKxOii06L8cFr+IBlkt2XzaifmkNPMYk7hQ8evl9ZmAdXQB+amATp
         RAhyhzRCDlBHaxmI2kTyx6YVcwyHKRyk+SPeU+8c5Oy2KUKe1Tah0V0r3JGzmd7Q/0th
         ZZhc7r45fw+DZ8MrdJ87Q+hGE7rPZXuuVxzmP/xvlhTmvPPMCcnHPn1OIs9+TVRr264/
         uzBMwYltoWwiP3dSXo352ocuweqixWc9zLZLbE927sIyZ4Zky9fA2+GrLvUTeqUXBfa1
         V8L7d9hv5K/5gHWyOa9GoyyY+iWfgINCQhadDyesYP2N/j8Ud9z4X9VLynOGy3YXevFg
         ovyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=6aqErZ8HEANn3yoXkdE5bFl5jB7WbP56+j06VvwuyEw=;
        b=pT/IuUopHiiLg1/PoWy0uriUuqjcyiub1psWoK+CyTeKTnWFErTA5tUGmJHKv/Gmmf
         wTwki1xoVKuqjOo+TcpEzE5JuYbzU5x2lqtya89z+oWHVfr1mf15lTds6CfsFFcnijkp
         Zpxm5KAONGBHfUgFjLdg33QE4Y4BTmMwIEafCyEVY5XDg58Ej//ZZG8hM6UpL3Nqkzr/
         RI9PV0yHckr8c8arZGEtg7oBsFML2II24TlzKCPSNjGtdj/zf/WafdvG7xfA2WcF7E0p
         7t1SQwTOGiEAPjP/L8KEohRxuo8yxXczd5tfzY+Jl6rfsvR9p36qI0is2m3mnbwaZsBn
         b4Eg==
X-Gm-Message-State: ACgBeo2kdFJLHC5kC8xpZc80YcpMNQqdBY57XWhLiyGs6VW4Ht8MGXeV
	ACaOruZdEoJZgw4sBCW8XjlYx7ciM69T+C0=
X-Google-Smtp-Source: AA6agR4EcCAaZwyt4dAjq/nTAaI1o5SWehEIg83YNfqHm3gEx+1F0JmdFiHyeJwCbs1F9rCyC7bBjw==
X-Received: by 2002:a9d:70d6:0:b0:63b:46cd:96dd with SMTP id w22-20020a9d70d6000000b0063b46cd96ddmr3628810otj.141.1662651636487;
        Thu, 08 Sep 2022 08:40:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.74.242.51])
        by smtp.gmail.com with ESMTPSA id k13-20020a056870f10d00b00118687c3907sm7300902oac.24.2022.09.08.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:40:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220908133829.3410092-11-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-11-benjamin.hesmans@tessares.net>
Subject: Re: mptcp: test TFO: Tests Results
Message-ID: <4bf81789-0df0-e864-7cfc-79141538fd82@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Sep 2022 15:40:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Benjamin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 13 failed test(s): =
mptcp_connect_mmap packetdrill_add_addr packetdrill_dss =
packetdrill_fastclose packetdrill_mp_capable packetdrill_mp_prio =
packetdrill_mp_reset packetdrill_sockopts selftest_diag =
selftest_mptcp_connect selftest_mptcp_join selftest_mptcp_sockopt =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4705920293797888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4705920293797888/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 4 failed test(s): selftest_diag =
selftest_mptcp_connect selftest_mptcp_join selftest_mptcp_sockopt - =
Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5831820200640512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5831820200640512/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/64da39cf5e0a


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
