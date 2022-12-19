Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB91C02
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 13:50:04 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id c184so8718816vsc.3
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62UjoI91z8wssTiCOyg06cmySAFwGQYEPg3lS9wrDxE=;
        b=jyEIDyqZZj8yiyJ6a5ojAsgT1I5K3hybubREoGt9bl95kWypNzi4c/LADdmYFfBuEK
         uHEbhn5ZRhYNTrfBbyzU2P3iC4XGy9OhUA/GnVTQ8yGwZmIYoP0PSUOeBWW+74xHiJMC
         W7C6of8ShLHowQ4DzjgubNkCBX0mh5VOVxISALOZ5vAmsd6CKXjpfari5KnA8GA3uzFy
         R0z28F2qa6zPIeSIY0Zttc7fuMy66hDGQIBzItFQ1ExdIQFcGdAEIxpjFBL1E5cKJDEg
         q2p0U0hjTTqx3l398SZpAC/N0y1o3rEDCzh1pv9UW94yASB8spoNXnR68EU1nh2qfyBU
         vSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62UjoI91z8wssTiCOyg06cmySAFwGQYEPg3lS9wrDxE=;
        b=ZQPQ3JECji6JZ+/NNJIlowG+6HtXnhn1ANkWnJ5Sry+69j/J7K7N+CkCaReob6NedO
         2SpC2oCvjWxliawf93p4TUZGxYCO8XwzB9RwEAwb475afcQrmv6AVwdqnXw/Pas3wGz7
         Cbm4ND6a12LwBlWuj2dhV0nujz7GGWLtim4Rdq+iLjcc236gC9ogF9yx/hszREYoo7Mr
         UyMR4mthyzEZ687zrxTow7RAij02pxiD+lkeYoOPc2ZFGy3r7nvMEnT9e/hXbpldYRKW
         w3884hDgSChkQCEW+TeNzSUovRLP2ogtkAWA7c1EPjr3LkhGhR+wQ9xU81zUDL1j01Lg
         5bXQ==
X-Gm-Message-State: AFqh2krUpGoFwJlewIH2c1JAS6dfQLwd0MePEQTG5XvI+9QpTjepDseO
	1Q5L4cCfa4PQgplVjZffIw==
X-Google-Smtp-Source: AMrXdXsU/JHzRNMh+dAGq0bU7U9TsE/OhE8CJ68QiUeMOQSnGnnLu60gEFI8PWYHFCiLZshPNg5FjA==
X-Received: by 2002:a05:6102:b0f:b0:3b5:1f39:bcdb with SMTP id b15-20020a0561020b0f00b003b51f39bcdbmr2770467vst.2.1671457803013;
        Mon, 19 Dec 2022 05:50:03 -0800 (PST)
Received: from [127.0.0.1] ([20.230.10.79])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b006fefa5f7fc9sm6772607qkk.134.2022.12.19.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 05:50:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221219102316.627491-7-imagedong@tencent.com>
References: <20221219102316.627491-7-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <68757bb8-f1e3-8ed5-322a-72024043301a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2022 13:50:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5235989799501824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5235989799501824/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4954514822791168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4954514822791168/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6361889706344448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6361889706344448/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6080414729633792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6080414729633792/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7683ddc9684a


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
