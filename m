Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C57B
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 11:54:47 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id cg5so4684482qtb.12
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 03:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZVoq/oqAH4KCpNou6IWQar8ZR+5Mpyz//gdca/C4eA=;
        b=TkF2ynIV1hnZQj6QNlf1vOLfmo4GYveGZ+Q5e1gpc9/0ilaZM3xAWKOqjPruY5pBoT
         xgsDn2UbXyEA8zCimZMthw6kmq8KebM/bPEIsPWVqrfUAjcA/dWPhMiGqGcwbEl7hOkp
         o6NYtCv/fCRp00EevXqw8jmanYOe1gHW9lZBUJHBcxZGihvTwAI7dj98QUXamloNOAPt
         jXu5KzddwqhylVq+ZoIMMwa1fZh7W3UV2lzrcIlCFc0PvroYA1z38xRsJaDjfiIGV6Wm
         zgW9ajVkURiecrUGpd5Mh0HLZSbwEk9RICfR02yiX7z18SWFHixUIHOKdt8hk8bsBk8W
         uu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZVoq/oqAH4KCpNou6IWQar8ZR+5Mpyz//gdca/C4eA=;
        b=j9EZpYjqdSrqlTvY4jAvDMU42wHHnIhcDDObp8of/GPeaR1SYe7RuATzvT6lZkNKOx
         sqUhaURJsOBIP4+bwsfTH415lg2CLvcl9zqu0JkWiH3hNIAgyPksDESzV1Ygnd+pjRf4
         +iK0tIXmxcmG0dK5geCTN2yPdnOziQqDCMwbE3WhZI5PC4ILup3hbxRZmmj/rXPAegrq
         u5y6EKknBXdcjEoqd3beh9BVqbii9rHWL0XTQzcaH5rD8UIbvCKkcLtnZGQBodSs9SND
         R8RoKGAG4EG/YzgK8fneeEngdWxGw+69bz8vABuZbHWGZBAovM1EfRqgcUkmroTtectF
         T6eA==
X-Gm-Message-State: ANoB5plwnt1f/vtBfyugz64KEUr2RRkHWsaJeLBMy8xj3NLtQ7PUnmFA
	MHzmSRU5DfZxIK2rWqDwmw==
X-Google-Smtp-Source: AA0mqf7qgYEcnnOLGu8YJQPkF2s0vWEdqre71gAkNYkZzR+GewmEQ4EQs94ijuvxrgE8YoVmrnz2cg==
X-Received: by 2002:a37:9383:0:b0:6fa:3fbf:6b51 with SMTP id v125-20020a379383000000b006fa3fbf6b51mr45801968qkd.519.1669982086911;
        Fri, 02 Dec 2022 03:54:46 -0800 (PST)
Received: from [127.0.0.1] ([20.65.53.133])
        by smtp.gmail.com with ESMTPSA id bj31-20020a05620a191f00b006ed61f18651sm5317459qkb.16.2022.12.02.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:54:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221202053736.2980-1-geliang.tang@suse.com>
References: <20221202053736.2980-1-geliang.tang@suse.com>
Subject: Re: mptcp: use nlmsg_free instead of kfree_skb: Tests Results
Message-ID: <4c18fd99-c880-e4db-adf8-02b4b0f0d377@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Dec 2022 11:54:45 +0000
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
com/task/4858982737641472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4858982737641472/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5421932691062784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5421932691062784/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6547832597905408
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6547832597905408/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5984882644484096
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5984882644484096/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/43fbd526856d


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
