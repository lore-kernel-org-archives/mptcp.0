Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80CB7F
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 03:07:44 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3422b25556dso11035515ab.2
        for <mptcp@lists.linux.dev>; Sun, 25 Jun 2023 20:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687748864; x=1690340864;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfnnbWKO2+MzyIxSXhVDsq3DYo2VyMAJoRJ5VF0uif4=;
        b=hh70n1JdLjbFVlhfAOqNFF9oMbIC9lqQf1atVF/o1H7z4U3yLHfvJlHl3KOwS6soxd
         LkVdPabUFCFtnKDjPctXqLbnLjOGK7BTJXldySe+cLkdkZgvPuxIY7dtcos7yOdH9xuz
         AahZsqYEhOI9/fDC4QmsEMFY3AoaScCGQgLxxgagWbAqsULUlK/vLtcBJh0LlDkweMny
         sQffpStsJ5bAdexbjIGldAvX+iWE5pUrizooPIlC/ciI5G/Z8TdRydEd3zStxS0XTW9J
         D8/c8L5X8Pq3B7eRC5MQgzUSCMycw5gKgVuycnm8bjOoln+yrVQdaxvdnjGXMJDseA7J
         LiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687748864; x=1690340864;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfnnbWKO2+MzyIxSXhVDsq3DYo2VyMAJoRJ5VF0uif4=;
        b=lMdcFsuUjgcewNmgK1erkwhppJ0Evrkl42pAr4jZnlMpqqS/f+5VEv8cMYhUP9XRPF
         /VRbOCB3xGNYB27+NBPQBjb0pYqIVt0tR0gY0szg5kSEdecdBD/xBqaLqqKqb4SnpJyV
         1vHXuWfsGrVQ9YO1uun5DU/RctrEIBrutX9uHrhq+2jpaxkvjP/Jrv1eLd13VJ4TRbsm
         n8/N124ytv0k4y8+NaqGEGnqX/a9wyq2iFv4FXjDX82KfNeB+CVvqCIXwplFxFrvO1TT
         iv3CWm8aSuYruTzTvtekMfVo17mBHo5E0GFVS/19NRPFuXag1/pD3KLoOTQlEQn1o6GC
         1Wgg==
X-Gm-Message-State: AC+VfDwqG2sft5tMrGhrYwkT98GqQMAq3CwWD/HngJhjwXnmwYt1sS0P
	zmN5Jtm/zlz8zFzNzX3VR9euz2VeZw==
X-Google-Smtp-Source: ACHHUZ4ZRg5FY7Vi8CVH4C8rJHJRPkaaws+7rQ4KaBFg+7S5T30UhlyjbKnetaTi03ifvi7ZDwqyUA==
X-Received: by 2002:a92:d0ca:0:b0:345:8abb:5b2f with SMTP id y10-20020a92d0ca000000b003458abb5b2fmr3493105ila.12.1687748863827;
        Sun, 25 Jun 2023 20:07:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.66.11])
        by smtp.gmail.com with ESMTPSA id c9-20020a02a409000000b0041e328a2084sm1445782jal.79.2023.06.25.20.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 20:07:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
References:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_scheduler=22=3A_Tests_Results?=
Message-ID: <539412bf-fcc5-a39e-4b95-d4f9895d9d7a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jun 2023 03:07:42 +0000
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
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6610932755857408
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6610932755857408/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/4781345407238144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4781345407238144/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5907245314080768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5907245314080768/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5344295360659456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5344295360659456/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d70b6a579bb6


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
