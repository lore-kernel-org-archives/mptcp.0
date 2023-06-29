Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D42291E
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 22:36:51 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-668730696a4so795909b3a.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688078211; x=1690670211;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuDwSj8MXg9puvmUuqYWDf9vN8K4+G7pVcdF3HIoQWg=;
        b=ZXR4K7PKnoFdcFEIsirSQtGWeBlsNcQWXAVs1UmNe59t2khz0fvpsjGNHw1XmiLwMa
         txanxvE1W+fYE1MpJ/+Z45zKwJSHWmHoAmCmseo1uFgbnDHWlcj95rPGEuqNCbWX5948
         Gpv0b4AN2SrMbt1JpollWxBW9037JwH7LoewgWYOOObrAe62Nm2QH6iHisJjkLDqm6GC
         +YVuJGIj1VzIXTQe1j+7oa8LUTq/PwkDP7n/b8XxW4JIFPTVb3YLqRaxVbhM+TlDbeEf
         T0KzvYzAiFnkxt/ffYiwSTrlFMVxsgb8dX5x+UEpfn7AJ/YIKm458c5a0YRz2Xfb2Lbc
         tIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688078211; x=1690670211;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NuDwSj8MXg9puvmUuqYWDf9vN8K4+G7pVcdF3HIoQWg=;
        b=jB12mOAZJEgEI6DS5tImaab/NTgj+5/z0FAbNYi6u/86xCBTPrlVjd8YY3Di9spnoX
         5wN3VTafaKMU6VHLYhZcsPvL3KbfqjyJ3kPVQJWNRPbJUa4rZcvGEslwIK/E6SUy0/au
         HnUJqNuMESBrszWwZTxnK38j+zgsG1KwJwYfgLeOfRi+mHFg/44R/mSajKdYmC385AEm
         HEUJ5Pg1LCMMcvN0h1OaW8P5NJySrZQLCrznRcPDf9rfQCr7yrzIGGIn4PKS4SDu/fwg
         xVK11vMLnIRhYHJ22+V34M6xPJz/8BfNztYoOR09c3UcmvKkzxyzdb83qI8FXdmmBwlI
         bD5Q==
X-Gm-Message-State: ABy/qLbursnW9mwLrXl7wgaljG0HR++G6IlTKOgX4HP4ZMCFiQr12nuQ
	uVGhve0S1LF66CmKcTb6bb3VXzg2zBbD
X-Google-Smtp-Source: APBJJlGB5ONjvrnPU6Um1paJLe9WfUYPdA38FZTOhVMtBIJgUM9QnpUtFjOMUeS/TPwS1Cak7w8pqA==
X-Received: by 2002:a05:6a00:1a0b:b0:67a:39c4:5bb5 with SMTP id g11-20020a056a001a0b00b0067a39c45bb5mr1144326pfv.6.1688078210655;
        Thu, 29 Jun 2023 15:36:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.3.167])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7851a000000b0064f708ca12asm7144936pfn.70.2023.06.29.15.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:36:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230628144927.828117-3-matthieu.baerts@tessares.net>
References: <20230628144927.828117-3-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: join: colored results: Tests Results
Message-ID: <6dc274aa-cf10-4728-e845-d49793e4949a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 22:36:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4971218193874944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4971218193874944/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6293277847060480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6293277847060480/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6511369239920640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6511369239920640/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5158516046954496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5158516046954496/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/07c93e69ca2a


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
