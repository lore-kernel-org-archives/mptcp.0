Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8C20E0
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 13:59:49 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id i9so1225947qvu.1
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=GNbZuBNQaAyegzaUCQc5Z8xEicN9CnJpq4pHQT2Z7B8=;
        b=gt9kmjXP1cI/hglkKIHT/htFTv6gQG6Beh9bbuh7BnR1mpwOc7Xc5mSXhsmLPAyTmh
         8woWa+Q5Obi2XtFN8hZdtt7EtIFlMCjv9zXz9xvArlptoI59NNa+q7lnXrbo3wu5jF7t
         A4BBW1qx99RpeVQgJ9zfrWDW9Zqq4XwAvk1SrQHgW//uggjpMyPtB4R2eUvjtUUgpQEI
         S28gX/P745srEN/7rjNXTpeJ2vd9b4d6PHBbq7gToh0jmnfKpyhHBdrGojAsM16cvtcP
         wxXJ9EJqiA+qpc0XB/9xLLvtRgRTXHIDEH6CKUPGBKTGRcclYGrj9C4ghmRa1G7yDBqe
         3azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=GNbZuBNQaAyegzaUCQc5Z8xEicN9CnJpq4pHQT2Z7B8=;
        b=iSy8DD9oLMnAwKqNjhWotDfZBRZFYiKilRqS+3Zi3O9LiqGgmdCeNIWzfwkvNVJnOQ
         gzXuMb2EhMdjTB0FP2S5lWiT+f4wbEj9dfuxRHCEAzyjxG6oF1OZm0GNs50BgOVDiPIY
         qygzWlHRCQaYPCGTcXq5b07qe8IJzCVxa4QEbfOdSfjcUnc4Q1saJ5wQS7YePCA1UK0I
         fhOY92CJyMuc5//BI0A+21QDg+EzkjqQXEyNZBA7U2cQewQMpnNTmk78xoQnH8EanZbb
         g9SL9YCUveOsukNjG32Bwo+I+hUIEZtGazmYGJDlNMEP4fVdizlP+6uf856OGSYVoj8s
         Qgvw==
X-Gm-Message-State: ACrzQf0KZWyRRJ1img+ofng1hK+/gRaNes03a38vdlxYHNO5lTA/O95H
	pOO0ri8El/1ZBS1MHwa07uie6kBGj0221qo=
X-Google-Smtp-Source: AMsMyM6wEHJJIiMw18b1QT42ubwyxGKA7UzPb//o8qH+bq5zD5xQDnxzLTRCwHU1n8pE9HPXLZZciQ==
X-Received: by 2002:a05:6214:5198:b0:4b1:c631:2ffa with SMTP id kl24-20020a056214519800b004b1c6312ffamr4156225qvb.86.1665064788569;
        Thu, 06 Oct 2022 06:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.92.115.243])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a268800b006b5cc25535fsm20141233qkp.99.2022.10.06.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:59:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221006061123.1474224-4-imagedong@tencent.com>
References: <20221006061123.1474224-4-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <05d2e272-269a-95d5-bf8d-5d867bca44e1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 13:59:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5793338778451968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5793338778451968/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5230388825030656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5230388825030656/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/abf5029a32b9


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
