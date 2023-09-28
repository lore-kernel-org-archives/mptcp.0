Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C318626
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 20:10:21 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-693375d2028so3180276b3a.2
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695931821; x=1696536621; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86YuOO0/GWfHisLB2S2OpxRDyLRvwzZhw4vRq8eozhs=;
        b=JLUrpkkVju1KuYAbdXbQvVyE7+NjXmzCWjcAkkrXVK8WB7Cgxc/RAIM0YEjPPmCHpE
         TYV1G/TAFmZ2SGjxnUWg0Z+ljRLimIGmf3MSLV+oKiwhXN+b0RkeK17Sfn3j+V9ZWQGs
         xMsLTbX/rSGnJeWwKBGYtA2hlURVAep6n/AIWXzKPoJNkMd5y65899+ADpZT7x0c3Uml
         DU97gN4gDWnUzfOLB2wLTlkeoEXfqQsyEfGi7jN10nI6/k8/DKQLjFklSRI9ZFsaHXqJ
         q4deXatvoxixRWn0G4idjRW3TEuhZNJdcn1/PdoD0mE8iiJS7hWv1KPAB9inu99NAaqS
         QhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695931821; x=1696536621;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86YuOO0/GWfHisLB2S2OpxRDyLRvwzZhw4vRq8eozhs=;
        b=h4IoSyd+b+GlLTeysfI0WmulDi7AEKKu28TOZBlCN6Z9rr3QIP7zXxekqLvVB0Y/UB
         KvsknBEqFzTNrZhViLXvqOA3VsZSd2cGCpfL1ajufSoKlGVz/S5u59hgPMMibRZwW/C2
         sHwqhJqM3QpRvudjQruiDWVe3tN8WnUMgWA8xCXJVnmhhDr17loKcLVu0LptKdCdE5K3
         RIjP+A1jnIeO313SRxyZKxK6N/rwx7p8ozZ6b0E/YjIb8FFeGqTxdBTJpc5cmMZHky92
         wJDJ3/uEUwS1b+H3pFJ44nh9SQELP7HIkpeNkx4i0l84Vk9eXOwgYFhmvTAICEeqoV3Q
         oG1g==
X-Gm-Message-State: AOJu0YzkC8SbyXtTU7nzoqUcq+WCpXOP4G9Rdl7jij7Z0VNnw0meuvL/
	ATqlDhhUwqItID5PkaxOvA==
X-Google-Smtp-Source: AGHT+IFWjV1SG/pQPVIxaobepJ/U6zpddZob3YTXHf6/R4+ZleDNppU1yNeK20axXIg0t2qCrLfdgA==
X-Received: by 2002:a05:6a20:5611:b0:14c:f16a:2b78 with SMTP id ir17-20020a056a20561100b0014cf16a2b78mr2131733pzc.45.1695931821387;
        Thu, 28 Sep 2023 13:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.7.28])
        by smtp.gmail.com with ESMTPSA id k9-20020aa792c9000000b0069353ac3d38sm1231963pfa.69.2023.09.28.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 13:10:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
References:
 <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_give_rcvl?=
 =?UTF-8?Q?owat_some_love=22=3A_Tests_Results?=
Message-ID: <0accaa40-1864-9cff-2b4a-f9065452a501@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Sep 2023 20:10:20 +0000
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
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6195135847858176
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6195135847858176/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6121534134157312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6121534134157312/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5890237797236736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5890237797236736/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5113741331660800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5113741331660800/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/afb4cb897fe1


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
