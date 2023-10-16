Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C5381B5
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lol26KKt"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3af609b9264so3273069b6e.2
        for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697492758; x=1698097558; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4fs2j83SIjzhehD02aQldYDl9+GoIqWWTg96IfOL7I=;
        b=Lol26KKtBPITqd//Rxr6Hq/ZBRARl+31wklums5GI9mNtOWgGYuNI9IaSuugRgFZfs
         9wBeJVqpVxfBmUx2CfSt8KoPU5nmDoRDEJcAsshp49Nve9WFcAWQ9CE9eYdA/1TqjcGv
         94Ybw8a+t6eJMVQUBU3K59an1koQn+EFlT3EjhrdQuQ3CtOfw9Y9gl3WMZZKOWTRr+mc
         2hwISeXRjOKIyaoP92IzFscGD0wZ79TihEOwjlLXEW7tc14cP7YSbK/u3nafdxV8T2bQ
         qmL6A69x43zB2zDDFyLe9xU7BKVryBAM1nuUH9YAo8YJk5ioMvU/TqVdCsFLmoIsaYC9
         IjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492758; x=1698097558;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4fs2j83SIjzhehD02aQldYDl9+GoIqWWTg96IfOL7I=;
        b=o1CYUJsbYa1IY+mDPfWB6EQ2O8nBS/VFJum/VYKRTt4LEbiyiGgAlVHassHmPA8aWn
         WtjDngQ61hmmrSl5VOX0Wy27BZ8/IbzUJr2i4WeK5HqwjS7Vgy0K+7X1MlFlU8pSD3zu
         l/zh9erQJ9fgKsOTsJ0xIgT+4rXtkT7OchZKn8GxEAMp3trii9yNfvnAbx1Umg0mTbas
         XWuHFKvfXUQqN701RiUvKemeWIzQOnUVt+tVD2xxfDUifSP8FlJPToScDQgssmr7mYoh
         ++NvuD5W5rZOcrvqRxgqppoRZZ2h4GB3okf38ccpdvrZw23RWnvhDIIanNiF3PVS7fV1
         IUDg==
X-Gm-Message-State: AOJu0YyU93jvbi+Qn5o5Ep+IKoMF5FoeuErlXiWMXrSkHAYbHlAHv8jp
	NvINDyQW4dwL9qZtm7AoenM+n6m/uA==
X-Google-Smtp-Source: AGHT+IF8iLDUhhrrzF7Zxe/EGnlPjoNFkKD/Yv4gEGpDu0+CzJGi8NXl/B/0rRADUReJqzAxCKjsww==
X-Received: by 2002:a05:6808:148d:b0:3af:7de8:ca90 with SMTP id e13-20020a056808148d00b003af7de8ca90mr564690oiw.56.1697492758198;
        Mon, 16 Oct 2023 14:45:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.72.158])
        by smtp.gmail.com with ESMTPSA id es21-20020a056808279500b003afe5617691sm32508oib.12.2023.10.16.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:45:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dd36724a428132078fc63edf48af1a14eb095299.1697463031.git.dcaratti@redhat.com>
References:
 <dd36724a428132078fc63edf48af1a14eb095299.1697463031.git.dcaratti@redhat.com>
Subject: Re: tools: ynl-gen: add support for exact-len validation: Tests
 Results
Message-ID: <872df50c-28de-a913-844c-c5ff77435ba3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Oct 2023 21:45:57 +0000
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
com/task/5917958434717696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5917958434717696/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5309085919215616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5309085919215616/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5378729350791168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5378729350791168/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5962237232283648
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5962237232283648/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/da604a436c74


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
