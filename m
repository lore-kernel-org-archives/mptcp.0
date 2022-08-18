Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F57B
	for <mptcp@lists.linux.dev>; Thu, 18 Aug 2022 18:40:27 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id a4so1786018qto.10
        for <mptcp@lists.linux.dev>; Thu, 18 Aug 2022 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc;
        bh=jvtxPZrvx5tbNp7jVsB5gfqBHZ+KPOXWh6KW62TY2/0=;
        b=jWjNrqbAEEXs8qjGpTF3l62Sin7vaQttJ28cqL6EO0489LJlEh09PqZOdninps9nOq
         sHdHDhi59q0fdngXlG3QKpLo2TjY1JIavqFmu+dFrwwGc05kcY/wpF38GxBZYhjY4z+n
         mjtoHthgvwKNKagBvyysSEEhDo0tsFlwNRSMizs6FJnOY79xpUOeK7e6toWamkyN5kbG
         EGoNk5l/xkoaWm5jwdeia4YlzbzzJsOZvZfkzgHZ4CykOfdYtSAIQeggeydybBPjFSuo
         qvKNTp0OBWZ7tPxHnD1Rh9iAvy0jSP7vzUjaPbRFilWRjImupOhikiyuwgabeKyngf98
         4VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc;
        bh=jvtxPZrvx5tbNp7jVsB5gfqBHZ+KPOXWh6KW62TY2/0=;
        b=LPMqdvCIoChUwZUEZwwCAHwj/sLDeN2X4vjMQuPHS+5ijQ8SWXD4ghJTjdvrB5uGLM
         TrIq/sAI9qgygsNB/QnGe3xyoP0mDqEqJbgdQSD/rz1LvioynCAar8FXFkCB9YF1gu9r
         re3R6jlmta3RfAGtGSo65V9MLaQROberPqfHjKfDEPm1sy6NrxeCY0+GWhuQtyjovCil
         PxSvp9tQIJqIc290ewy5juk6p66p+onTPeuwWa79nYHe4P52ulGYkgfcjzBqkldaaJNz
         TSIQBUSpWmuxk5YYnPPkqissG9n60ALCHFCL2fPWrZzKbvApCTpGmcC5ey7sg9aB/v3o
         s0zA==
X-Gm-Message-State: ACgBeo3lK1dhLULrWencR5m0QAhjIarLSokRkJrQ+jbK/gO4rhwSVZ/F
	rLGhsl5p/H/+eGFkSuPn4q4V+b3oC7u/ckk=
X-Google-Smtp-Source: AA6agR7x4dodfA1WpzVdDxzYsuZs5/TR3R9aqvKt+m1qLtbMWTBObMwwtIe9uwiP95yTbFeeTnyXeA==
X-Received: by 2002:ac8:5c52:0:b0:343:3dc7:db0d with SMTP id j18-20020ac85c52000000b003433dc7db0dmr3962716qtj.179.1660848026339;
        Thu, 18 Aug 2022 11:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.1.196.254])
        by smtp.gmail.com with ESMTPSA id r11-20020ae9d60b000000b006af1f0af045sm1929017qkk.107.2022.08.18.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 11:40:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220818162123.30198-1-fw@strlen.de>
References: <20220818162123.30198-1-fw@strlen.de>
Subject: Re: net: tcp: prevent transition to FIN_WAIT2 when mptcp has
 unacked data_fin: Tests Results
Message-ID: <6350ccdd-0e0d-4f9d-6f2c-4c165e2d07c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Aug 2022 18:40:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5095347042123776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5095347042123776/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6221246948966400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6221246948966400/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6c09a70059d2


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
