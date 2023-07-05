Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46E1C28
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 08:15:31 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1b0605d4d11so5563979fac.1
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688544930; x=1691136930;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecAlVZ9CxDT+6AC68Mv2xUworiD+X8IANh/Lk3YH704=;
        b=AvTmYU3ZyCduxrnI+Z2YMe8gyn/+c210wpT01vNtq222L6Gf0m9w7GVwKyl1qq4+1a
         y3rd4OE8zmf1A2JsqVQzz3M2ga3uVoOYShRDxD1oxMlPbVv9Qrpni+Hh1J9vXczvIkSW
         zjr3TNFoygrp/d9jZq781CHNmGgy1AVTN2i7Dn0r8/lAdBJK30wEPH/yGPoTiuwihsbJ
         UkkrC/vnBAxb2YeLGOkGSgzFGiaAzqZ/8/ftFVk0wnx5GzkcMgUoA8wXbbSRVMUxEfnN
         N0IYHYwP5AFFqopIduyhoMmskw07I0nTNptyWwFPzkA2LqeK+tZe0HFbbfPuSdjOzfPg
         T8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688544930; x=1691136930;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecAlVZ9CxDT+6AC68Mv2xUworiD+X8IANh/Lk3YH704=;
        b=LmMofIC3c/RRUtCr1PKzZiNC+MkNSRO0Wl4vzPs9z1pEy5TWdHw7EJMjLYeNqWPqHq
         BFV/xHZNwjJERjWB7DC1XinQGkAP3mRTMuhvwwOsrNpV1KvHH9RLdKuyF27x+OK2ZET+
         H3mt5+Aoj10KGz9qQx4d+Ew35VbbtQh7czxcLrRZomoUdgUAXFbFY4eVLADscqFnTHYx
         HH4dFeEBEhH2aYfNVaBGcvsOLamp+T0d2oajTg10eyK65IiX2jtiCkQFnNe3xSepst0X
         A7CO/AGcS5qRpjipNDxGfc972Vg+/jXudNEiOjclQNq+DJX/jw9DDA7NzLSRm0LhvLmy
         6QdA==
X-Gm-Message-State: AC+VfDzUyTzl8m4WXR+MKqSIZyMMr7YqX1jJ07tqvbIYOx5wa/amgp/A
	6CkylVo0NKG8tckhsZJf/w==
X-Google-Smtp-Source: ACHHUZ77Wukk4cmy1TZjsgw0t2bnsW88SjZfQysI8S3XQ9wP/TIkJvoVHTM7uMvMotxsDi452KPU6w==
X-Received: by 2002:a05:6871:e89:b0:1a9:8484:40d with SMTP id vl9-20020a0568710e8900b001a98484040dmr12589011oab.23.1688544930238;
        Wed, 05 Jul 2023 01:15:30 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.138.101])
        by smtp.gmail.com with ESMTPSA id y4-20020a4ab404000000b005660b585a00sm3117537oon.22.2023.07.05.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:15:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9f92e80f8366da93a7a00930620a0ea47777c0b0.1688540074.git.geliang.tang@suse.com>
References:
 <9f92e80f8366da93a7a00930620a0ea47777c0b0.1688540074.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add mptcpify selftest: Tests Results
Message-ID: <9de32fbd-446c-4647-02e4-3636ee351e36@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Jul 2023 08:15:29 +0000
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
com/task/5087982516961280
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5087982516961280/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5932407447093248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5932407447093248/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6213882423803904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6213882423803904/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4806507540250624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4806507540250624/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ba6544f98bca


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
