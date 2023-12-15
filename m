Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB13FB28
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTF2cPm/"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67ac4fc7217so7541996d6.0
        for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 11:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702668064; x=1703272864; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oom/s+QTPlQKC20j9ZqsZ5RAhlYB0d9JdaWb4LdfX24=;
        b=aTF2cPm/nOLzaUA91diBF2nWhmluvQRLhN+XhLMrGWx8zUyXT8iG1FghHAiCeN8G5A
         /wLSnRHzN0cLlnSD8H+lCeD/IP9Gi658/63IKARAfyZnoOPiK68WJiobRHzlSaDGpl+G
         PJLf/j7DVlbNm0RuHcob44vohIbBbXev+WRBNpW4lm9ruCHyqkDJ/5c4fapv4mZ2sqeO
         MOX2CX+220K2kHAruSdB3bYrlXWI6ViH3/dYWCIxY5jTXmLyn9zpCbtmcr5VwzLJxwht
         5jekVewzuBu+hQvHS+vngOyoccbgfdhH7yJCb6lHRiM2MP+JXvpSMY4jVIgYmW684JWn
         u/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702668064; x=1703272864;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oom/s+QTPlQKC20j9ZqsZ5RAhlYB0d9JdaWb4LdfX24=;
        b=X3yR5too+mS95FSBhqA7zGYNo8XEwgCm9xOFOCD4RF0boYcCxJUfvg2/juawUQkz4k
         n1a0a9PxP7fu2dLHTqZEakf89qKqpMS7xtN0yNniFihZmWQWEikg6/m5pdw5jnoM7HA0
         4Dkeb5qobPHrR7Nh8+ENBTDgXA7K27NpKxpQZmgn6XmoZX+Fyx6qaDCKDWJ0RLiTLkrZ
         WzmJNU4vjwIWYmfi2h+xp7LoJ3/qRMzT0AgJnBOcW+DluqCgJnukH13eBr8WwzvdtTzX
         my69T/RdOfOLMFACi0IBoJPtqQqlyG5nxS2CFpUUUctq0CTKLqC0xM4hf6uNWatwXDhe
         cSbQ==
X-Gm-Message-State: AOJu0YyTFgr+GUYvejQJSiEx/rzmnvrh+eJJwSqjwzMD6G2eCLpYvTOu
	DT94GpeE0C7FA3A4HrxHAQ==
X-Google-Smtp-Source: AGHT+IG+UiN6bn9zlPmzTlK4y5Yi1bBECLTgK57hXVkAWvJmE+zdFWpj9ZV4mCH8JZWpPj1c8mOQUA==
X-Received: by 2002:a05:6214:27c7:b0:67f:5aa:4d26 with SMTP id ge7-20020a05621427c700b0067f05aa4d26mr4840716qvb.96.1702668063495;
        Fri, 15 Dec 2023 11:21:03 -0800 (PST)
Received: from [127.0.0.1] ([20.55.214.166])
        by smtp.gmail.com with ESMTPSA id w7-20020a056214012700b0067aab230ed9sm304444qvs.21.2023.12.15.11.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 11:21:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
References: <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
Subject: Re: MAINTAINERS: add Geliang as reviewer for MPTCP: Tests Results
Message-ID: <6e9d5fb8-c267-41aa-fead-b9027f78aa8a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2023 19:21:02 +0000
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
com/task/5636453443567616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5636453443567616/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4792028513435648
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4792028513435648/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6199403396988928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6199403396988928/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5073503490146304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5073503490146304/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/006888d29030


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
Bot operated by Matthieu Baerts (NGI0 Core)
