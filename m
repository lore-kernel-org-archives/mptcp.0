Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B51653
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 02:39:16 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 20so10313213pgc.5
        for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P35Q/eVljBnYCjxkH5pSW+XU8JqFHC5IrU0mcobds38=;
        b=MgcVGCOTScLesiaZPR9SSpBt0waU4aLHDDISEMTV2E85eqvwzIzqS1cwG3Js648dUG
         HU5TMXHWwSvEnuD5+cGqCR+wD2DCB9HXrUsuJ3tZdTQB0gQUkr6oCBYDdwZHqAZaScdY
         a29+14PZLYISFTvLEV4jFbTlqq0V3Z2rIEGfx1DOcwTCQLbjtt96QpFPMX3xW7Us0QIH
         fyXYwsbGaEp/MetxgPaZoD+T1nEwLkxOREuLZnS0lS2OsiKcMgsRrrxmXhM9GmcDntWk
         wifOGqMJbtCbD89qELCAuTpwRSjCxyWextCH7Am2yYeqob4jWqmHzpC8OZ5tPzynfmo4
         czoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P35Q/eVljBnYCjxkH5pSW+XU8JqFHC5IrU0mcobds38=;
        b=gv5tWBZkIie82KO3gCFrNZw7oUCUFv1OHbjr6Wrxnbso7pbZz+UAvTBJ5qIAlIoTG1
         k2C6SH/SmKC4pcHsew6N4EBqKozoTCcevjuAY4HWnLZ15jsZ9DxH8lHCg4xLOs9Ajj1N
         nPluwB7Qci+tTxHzQOJRFs3LJVc5O+n0BtQSBsy7voGzKexbSZSE8mNXQbhrl//Bdrb2
         bZ7jhBkNGsqZZUoCuxNzPWRtg6AHkXs4DqL9NEYc3WFTdSRyPwqqIpQn2sYrLr9H1xDY
         PRSLmjEPZYfO7mC4lyZURzv4d4mAkk8oao38ldGRZlmqSxCuSLAlV5m3xMF4j5sM7Kc/
         gQzw==
X-Gm-Message-State: ACrzQf2u9sVmAmlUe1rFHzTO/Cv4Q/EQyhfPQ2xFHkdSbilxNk1/2KR5
	FaRuRbU+5NlDnmPhAY3Fkg==
X-Google-Smtp-Source: AMsMyM7vSRRsf9AE+m0ENdeDHHdRZEA7WfXjRPQXM9PSzYYncYD7FdWm3Yhx/8HyIV7PLSGfxhwWtg==
X-Received: by 2002:a63:5d5e:0:b0:46e:e85e:f369 with SMTP id o30-20020a635d5e000000b0046ee85ef369mr11729668pgm.619.1666665556094;
        Mon, 24 Oct 2022 19:39:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.246.93])
        by smtp.gmail.com with ESMTPSA id p4-20020a625b04000000b0056b9ec7e2desm443078pfb.125.2022.10.24.19.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 19:39:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
References:
 <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: gives slow test-case more time: Tests
 Results
Message-ID: <002999bb-2af3-1332-584a-90c32c9cb329@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Oct 2022 02:39:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5863926364635136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5863926364635136/summary/summary.txt

- KVM Validation: debug:
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4839132940730368
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4839132940730368/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/337ba64c69c2


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
