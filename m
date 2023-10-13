Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADCC125A0
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNUI7n7h"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c88b467ef8so15979375ad.0
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697195637; x=1697800437; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQyalBVkUaqcwr+nL0/QIFhb4TvEvz+JvC9FVQEsWQs=;
        b=UNUI7n7hkP2PkMIo20+uFmZ3+dKxpi8TRWgF7FNmOu7pYMQqYXKVx3N/zSuAmxxtjA
         UDrk4MkDXJOhMlSuayLTsVzAfa91HjPSfSvF07SFRnaXL898FY+ROmRIPMTzlC1eWt8e
         on0xdV0Bu262xFyK1a+gsDVL1LO8Bgb1/RDe+t8Dg/C6fjXrGandncold+sEro4zZfIX
         HJP4P+MdSJZ/txx5uzi1sxrvfPm5sCJ6KcM9y/AG2r+jzSve2uw65RDjUNIxW6XDLUk0
         aS5nIZ9aLxnL+F4X3WO0y61VBsB1V+tTVU8+tNuEcevp73vwk95WE1wGZ0Mru7TM8MgN
         ICIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697195637; x=1697800437;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQyalBVkUaqcwr+nL0/QIFhb4TvEvz+JvC9FVQEsWQs=;
        b=ajDN4J6o43uJnpJ5xnAeDhW1OMaWr8PcmI/pINyTImGIuqY7UP6otlpFQtgR+o7QfW
         eqCIK8BPGMUqY1H2XJnolhagFEPqrAwC2RIXyG9JAH3zagGxgsDiijsIvGT0YgMHXTa4
         NEKmsxzXACkiefCC3e50gIeQazf724L59RHosgih6eFWvM+PvWqPGw2WsYP/e4PF/yi0
         Ymz8cnTTSR9LLGwu9Yb4Q+rv0kzo0BdFpaBz5xTpd4mFnKQ3asa3k19UYerM4JZSZE6k
         YA5a3MXj91T75DSYDYiltkiMVFB6CVO8Rw9oZcdOS8NEbizNHg7kdw5+MtuGkMRtwvEE
         jUqA==
X-Gm-Message-State: AOJu0YwIRZ+8+S6/wB6b9QpDJYg5SLTwSR4i7OybqKGB1UhC6cjrYN/L
	umNBCSabFUZ3iwaGec1daA==
X-Google-Smtp-Source: AGHT+IHu8TPBOSqBE44N/AB+5l3VqzPmcfNWF7O0tRuAEJevaG7NMA1miCh4YydLCIyxVhbpAC2sIw==
X-Received: by 2002:a17:902:b607:b0:1bb:b74c:88f6 with SMTP id b7-20020a170902b60700b001bbb74c88f6mr21473535pls.16.1697195636810;
        Fri, 13 Oct 2023 04:13:56 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.70.1])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902a60900b001c56157f062sm3626443plq.227.2023.10.13.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:13:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <36fe14dbd444daf86a22cfa5fb50d590324e7b58.1697190267.git.dcaratti@redhat.com>
References:
 <36fe14dbd444daf86a22cfa5fb50d590324e7b58.1697190267.git.dcaratti@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to=3A_=22net=3A_mptcp=3A_us?=
 =?UTF-8?Q?e_policy_generated_by_YAML_spec=22=3A_Te?=
 =?UTF-8?Q?sts_Results?=
Message-ID: <edb395ff-39bb-6d1d-be74-5e32e366a582@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Oct 2023 11:13:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5677417939861504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5677417939861504/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5141953440907264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5141953440907264/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5194619055505408
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5194619055505408/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5743465154215936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5743465154215936/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6a5c7957b315


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
