Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FED7B
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 06:17:50 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id v12-20020a9d7d0c000000b006054b51c3d4so12391978otn.8
        for <mptcp@lists.linux.dev>; Mon, 25 Apr 2022 23:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=XFA63x1fs4QiMy5Jkr54eluRDzYVDWnF9uLrxZ4D6cA=;
        b=T2Rk3KNozbvMLs2sPyfDNuLJb6dZH++RgoX0tRgi2+1QYr4qQaEP66g6EmJu5rucY1
         Ust0X9KMOWF40+9S7cDYjNMFsZfiIn+j6aSCcteSJMw2NZLKL/oUJq77TFk18KovP6le
         Q1qMNLPgstuak6NzGJtG0TRY3FZjS7ffAzU3imYjzvouG1S0CT+y9FQbMhQfFyJaRHuh
         1I+ysxDUg7Xm3QeV+3Z6jNGPB1Ng3tRx/bmsYsHl3FOysGeiDye5xurICk4jHF5w5UgW
         QL39Klq4eKXpT/0jNzq84cP91UzrnmkUmAtsybxht0uE0k+TRbcUTPvc29+GOAyHQ0Li
         OSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=XFA63x1fs4QiMy5Jkr54eluRDzYVDWnF9uLrxZ4D6cA=;
        b=Mlsx6oTOkSaqSP2akc/9IeT3xcF2eesuKvUznSK/qn3Y6O1whs1fIDtCwe9RRjwKzQ
         htCTV7qPVUgwJz1n1B/wAnC+1oaWfEy8ILAufyd0ZOarX6aaMzUvQyXreUvMcS8EvAUB
         hgRBiIBb2jlnFAK/ElvN7gOaLovAN6upScDCPb5QALJDqLOuN3Hengrtd0O4psBZ23RR
         F8NBxzhZqI5dwQ/HjvoKqlux6wUwt/a6mfASJol+qjzryP0vf6laokAOgzES4zqJuCEh
         vGJbrsYlZKkh+rBXZhkwaM9OiXAER0gfI88x4lf7KVLHhcmaiS1jFQzlVfyszlTaLnBa
         G+Ww==
X-Gm-Message-State: AOAM531L613jnK+9YjnrWwEFAg9rvO568oGDL9fbI1TEkjz2kM/zXCoP
	DlPBL7+SfAxUbDV/iwn2Yg==
X-Google-Smtp-Source: ABdhPJz8uvB6ODTYUbqHwssNzVB5Zsvwf2QMUhSH+Xl9e9FhB543jDD7u9De7th9ImLAmSWNhxGmAw==
X-Received: by 2002:a05:6830:1151:b0:605:4d1c:2bba with SMTP id x17-20020a056830115100b006054d1c2bbamr7881383otq.308.1650953869776;
        Mon, 25 Apr 2022 23:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.109.51])
        by smtp.gmail.com with ESMTPSA id g11-20020a9d5f8b000000b00605bff9c2dbsm1244456oti.42.2022.04.25.23.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:17:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
References:
 <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_add_bpf=5Fskc?=
 =?UTF-8?Q?=5Fto=5Fmptcp=5Fsock=5Fproto=22=3A_Tests?= =?UTF-8?Q?_Results?=
Message-ID: <3ee53203-0cac-0ee1-e218-bc849ab21c1a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2022 06:17:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5696628827881472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5696628827881472/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5133678874460160
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5133678874460160/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a16226877702


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
