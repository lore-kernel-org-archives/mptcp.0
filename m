Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C566E8
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 16:05:54 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso2621614pjm.5
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=nEXRbg8rIASqpebx9MX/ncmeox5RhApm3rAh7AE5gmo=;
        b=IRD0PrawYpRqtmjYLXYXQ3vhpsecI/xB9Z+aI3+LMsxpDOnpEvQNNUC8bdL47MnyTm
         lz5TpPeMYNydvAXJh07sRHx6Tvpy9+utkpip7MTpR/aFfxZrxfaKATS1VWm0RXcAhmvA
         7smL0vecntPpbPpS9EkvMwlcP4GYpYrb2jCHOnyUrvm99PVDIsmsz21wtUWcusv9htdt
         HRwvnzhdgtCiU2bZxUTMZxnA79BWgtmVMeeIFGEt2++wwTrthHi79TpPAtYWZr5VwIA7
         pu7I/9FPfa/YcGSaDpfBjjWrJcSLK/kgGzf5foX8zVxDwtRfIiYjCtY9vjnNqPBkS+Cy
         SrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=nEXRbg8rIASqpebx9MX/ncmeox5RhApm3rAh7AE5gmo=;
        b=e8+a2hJ9FOXhpQ1an3w4wzP+xN8IxpkftBwGJ7oh3ZtFCyj9mCoMEBNCoyHVLr28mG
         APaVK53FWE+7XpdY+5bP18uiiwSY+LsAHkftvfRQ4Lpn9Bo9MyuNkDu1uURyyc1d000j
         Mtvv0ZNeUt2PZ9fm8PFVtcWYGDVO6rK10i0+jleeVekFyoQwX1kagA9vVUX5ZCcClEtV
         ZnCpUftISyswDDEugyS0NAFQqWxCZ60h1boZLAXHPd2He7IHgcc0A40fGnBmydZUiWjZ
         s56JZu+i7BxcH8ZQV4fE6B1WM3claiuLNLmxNWI6rEX4+xSaqnnt8wtpTgWDhafqM3zj
         Hmqg==
X-Gm-Message-State: ACrzQf2mBTnZgOC8O3eR5aVsUDEfQ+esS7khezCQfluBfLTIbHXgojze
	T2TUVD0PHVgtQYuItP3PFx5cDmLLwnzN
X-Google-Smtp-Source: AMsMyM4SA4xfAuvMUBOKo4z1epz/dQVsGMXMsv8+RnHlO9uBJK0vPqbTICltyM93f1CBY7/rD8rVIw==
X-Received: by 2002:a17:90a:203:b0:200:8df6:84c with SMTP id c3-20020a17090a020300b002008df6084cmr15714308pjc.24.1663862753622;
        Thu, 22 Sep 2022 09:05:53 -0700 (PDT)
Received: from [127.0.0.1] ([168.61.72.74])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b0017808db132bsm4410998plh.137.2022.09.22.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:05:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220922135627.2019807-5-benjamin.hesmans@tessares.net>
References: <20220922135627.2019807-5-benjamin.hesmans@tessares.net>
Subject: Re: mptcp: poll allow write call before actual connect: Tests
 Results
Message-ID: <a781e577-8e34-d64d-2bcb-1c9443fde8e4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Sep 2022 16:05:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Benjamin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4636649643573248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4636649643573248/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6450968651890688
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6450968651890688/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b2d7f1133320


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
