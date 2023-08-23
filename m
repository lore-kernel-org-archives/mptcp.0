Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7B1ED47
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 18:29:52 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-56c250ff3d3so88861a12.1
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692815392; x=1693420192;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfPnDKkLlrLR1ikFbiZ1XZErmz5rjou9+bP6Z9as85I=;
        b=cpwY8zGD1WPoaxUgArmD97kLzkBo4EbzmrY692RpWc3Rr3jfdMUkMRJjE4h+0rKQRT
         y2eHXkyRQ/x/Bzv64P9M4yjn3YJ2rvpfw6GlPd+rx5h9+4S6WM8ysQ1RpuKYFAQq7vp0
         LcPpjw5JO8mBqSg5XApfYK+umJMoYI19R88yjcN7LymEv5cXTpLHDLxyWkeM49G+WiBc
         Ntp5ZlsglNfqV8orpd7KQf2fki2sL3RBTq5Dtp15pcAQjmgOBntwB77tIrqKq5io+N0+
         sxh/g/3VH+tCQRLZAHKbPwd0uZeRpKBZ3Yp/3pXYS4UVKiEhFHuYMiueme9wfO5qU5hy
         xh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692815392; x=1693420192;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfPnDKkLlrLR1ikFbiZ1XZErmz5rjou9+bP6Z9as85I=;
        b=ahtn691mfrkilt9DGiEIFxdn8uEj8b7OzhbQ12PeA8nmtOrZtvRadks02gi1/f2dMg
         wE1w6ImrD6L4b9zJhvL/4tB6ky9+uoaD+/0SktBcfNEV9H1jd85M3a6gJRLJm2qrtEcg
         0hVWjkeCZITZIPeRD25G+vbNRd0Z1vOtaHhcW486G3pnLV8AJGPOcyy/7oJVxLcaUbjP
         S4ZTeiucpNk4x5gAM5Z5QrGZMmrqharqsmJ7znStqJIB200JC8iowarzdAMHwFXtpXkp
         /wtzd7tlD3beCkWRkessiDv/jRP3ImmaMGpxZnega6cL7sGYtIB3qXMHwl0QEu/7hFtp
         lVOQ==
X-Gm-Message-State: AOJu0YyBHzGbzQaAfjW480Azduh3GGl0/UMxDZJiMqLINCPb0vzaEykw
	Gnu6scVQPxncwhx/s4eyDg==
X-Google-Smtp-Source: AGHT+IHvEDcBhDut//5Z+CoXHNCoIKSN16NUvz6GNhh0KZVnWVpm46yYgO9kpJ8R/XAv0/TtKUc15A==
X-Received: by 2002:a17:90a:1fcb:b0:26b:2ba4:add8 with SMTP id z11-20020a17090a1fcb00b0026b2ba4add8mr19414362pjz.21.1692815391969;
        Wed, 23 Aug 2023 11:29:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.1.160])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090a348400b002681bda127esm122564pjb.35.2023.08.23.11.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 11:29:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fbfa573423eaf6692eaf4a14a840cc18722c7332.1692779220.git.pabeni@redhat.com>
References:
 <fbfa573423eaf6692eaf4a14a840cc18722c7332.1692779220.git.pabeni@redhat.com>
Subject: Re: mptcp: process pending subflow error on close: Tests Results
Message-ID: <90ce6faf-f81d-9f7f-d122-349476443d99@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2023 18:29:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6687372218204160
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6687372218204160/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5104075474206720
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5104075474206720/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5667025427628032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5667025427628032/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4541125520785408
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4541125520785408/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/fe4acd2e87af


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
