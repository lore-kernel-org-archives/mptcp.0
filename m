Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5515491
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKUVOfph"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-77409065623so244572085a.0
        for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697444962; x=1698049762; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DpIYK5mF0MSnRsETEFqEC2eVSBzsJx/NgGHPZWC4yY=;
        b=UKUVOfph89JWydIzGev9nIXiBOQtSthlNZ1kTrnjOiBahqsfbIzcoLE0ZVApshPj+n
         zwRwYgdGxtlZGDXdJ77GJGU9LapxxVwA+Cwbbqot3sn2AaROW1x475Xx3mDhqy4VBnPW
         rX+ggOAg3rhRf9KL43kjHaWg8Nva5cPQNjS+DCFEkbOr7N8zS4lwiJKXOydEAnhI+6cP
         p1R4mtvIbOQV9OFJFZuJlrn0xxg1cuRGbiek2U0HxIGEuaJqR3dJIoowHG65CbVmucun
         3epdYwtSUgutHNPlWQ9DqmtmH3d0XkZF6GGIhetUOe2kq4EyJGI3PKf9vUWutnTzHAfB
         tgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697444962; x=1698049762;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DpIYK5mF0MSnRsETEFqEC2eVSBzsJx/NgGHPZWC4yY=;
        b=sIl/rkGzIIv5/REviw3vcjsr2t4aJDU9Y4a6DYrYOguoyr7xXtQAThTHCu6gtYaKFW
         ov9gT8M8f9hUvQXbCTKm0uvgeNh4eHMAb96Enw+pBl8NCme+evlTfMwL2O2aEUeoDlZE
         cYnhYyg5Z95+ScfGLofJpvdzpIhG6qHNEPvDLj0ypxoYs8WK/oIKcQ9RIcJ61gFxT13y
         cOYw6hCl/GAl3muPCkwb3Vvm+JsGu+yAtTLiBLckKO8yKn9XanjeTM+EIrGLAQXyG9lU
         cC1DHiAdGrhQ/PT8uzX3kH0ABFcsukpzNGmDg3il5pBHcJ0bkJQnUCyoHsptPifdOVQN
         VI7w==
X-Gm-Message-State: AOJu0YwUiV5ZUCX0FFFl0XhJ2DayrSBxw9t4F1FSUUr2XUw91Xo5TahV
	cGC6AlkvyHzD1Cx8JnnEkA==
X-Google-Smtp-Source: AGHT+IGMhZSGRywjmbxrwL/wYQiTf+RSUr35RLzfp8HggxfAq2SAmrz9OPed+GtnPBrsY3rCNYs/+g==
X-Received: by 2002:a05:620a:a01:b0:774:19cf:f3e3 with SMTP id i1-20020a05620a0a0100b0077419cff3e3mr29064751qka.76.1697444962462;
        Mon, 16 Oct 2023 01:29:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.41.232])
        by smtp.gmail.com with ESMTPSA id ou33-20020a05620a622100b00767d572d651sm2825213qkn.87.2023.10.16.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:29:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <eecafe25f06b1ee7174d9a2b06fd6774441503ee.1697431973.git.geliang.tang@suse.com>
References:
 <eecafe25f06b1ee7174d9a2b06fd6774441503ee.1697431973.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_userspace_pm_create_id_0_subflow=22=3A_?=
 =?UTF-8?Q?Tests_Results?=
Message-ID: <a6d26a0f-9ba2-a4a0-9c21-ce36ebe8710d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Oct 2023 08:29:21 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4578649421119488
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4578649421119488/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6267499281383424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6267499281383424/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5141599374540800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5141599374540800/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5704549327962112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5704549327962112/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/73c27f3a33d9


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
