Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC913FFA
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 09:54:51 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5780040cb81so4696722a12.1
        for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695635691; x=1696240491; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuKaatZ8O9+YYZi/FQh6O42vp6K3hcgArM3SgxYPNog=;
        b=aiCJrsGQe9l/nBbr+Psvscv5H7A007mWjAEuw+R6CSgDI8VrRliWBlIQ3VHaG2V0l5
         EY2AtbyPlrEjBXTRvXM3HhzOBurth5aaPJfrbjpDBT9excMhdrdlMUOkiniUBGubCgdy
         i6RwW5RB4SMEdXWjF29maH2Rj3MncaRXO0VAq9Nf6xDha9ru/SDnaXmbq71f/CkAGuit
         tq3S7D5UQp9VQuzk+QObWkX8GmLdABvsQussJP4GfbHm1pLV9vZ2ZFaux6KT0Fyk7Yya
         1u7MCRT/zNnzbzaRk+2UvPA2ct8Ptohpn/JAFRHo7lRCipQgIleLoNcT2kcGH7COXG/k
         dR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695635691; x=1696240491;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JuKaatZ8O9+YYZi/FQh6O42vp6K3hcgArM3SgxYPNog=;
        b=EcmxtKLD/XIBcywYpIzKSQnVQMeiZnwF/6HIuJhSfUaJRquK6PoeGgGpd/EghC+756
         sxo8fJ0fTtSeNBbtP4SQQGF3F7YJ75fjI0S11jUQ9ZhgT6th0vdWJO1j1zBmeAfQT/ya
         +n8sH9hG+pC7y8t4DyFdvXHzzzvcwqQRvlRW73CzhVgscM2yjJDIU6UCYC+RvgGzRSWR
         JQJTzGunfFq3q/5oaPNmu8ccQwuw3cD+3RkeaA9ajOrJ5c+b+B7pQL81/6RJ8Z+C+BPb
         dFO/5N9uKWNbDJFR+t+qKm1vBUGc9SRxwEGaPkncr27RkLEBtVFxmTwND9LFWI39NcOL
         rAwA==
X-Gm-Message-State: AOJu0YzzlATmXusCSIMsRu6BQDrOZnp/lPRM059NNXqEpleJihbwJpOP
	agigS+nRt0gxZZbeelB46A==
X-Google-Smtp-Source: AGHT+IHTRThWGWCefcw/+lmzqhEZdi7ZQuEak6RS7e6s2O1w8OK3bjNEp5WN1Ioadqc9+ZDKmFv8ig==
X-Received: by 2002:a05:6a20:3d8b:b0:158:7fdf:66df with SMTP id s11-20020a056a203d8b00b001587fdf66dfmr8190929pzi.18.1695635691247;
        Mon, 25 Sep 2023 02:54:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.100.125])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001b890009634sm8360445plx.139.2023.09.25.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 02:54:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132.git.geliang.tang@suse.com>
References:
 <de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_lib_wait_local_port_listen: Tests
 Results
Message-ID: <bbd0e420-ee23-46fa-e8b2-35fea146b620@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Sep 2023 09:54:49 +0000
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
com/task/4696470427795456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4696470427795456/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4578235682390016
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4578235682390016/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6618929263542272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6618929263542272/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5493029356699648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5493029356699648/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/75e446fb8868


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
