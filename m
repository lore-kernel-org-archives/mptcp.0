Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4110F2
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 00:53:12 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-63b60365f53so1459826b3a.0
        for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 17:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681779192; x=1684371192;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkIiU/fq7xeN8QQjqGQlcRSrQt7X8OfhVxFqo3ZlSNs=;
        b=cWEsHyGwRIq1JRSyXXGZmVvHH0e60tzOaC6F9qYi5MmenwywbDD9RAOWsF2QxWMRVt
         3mX5v4NfBPwNSCX/CC1YM3HaZMiXuzokJ5MnAUPfO7ueIWWYvFrmiaUgLD5WDKTvyAZa
         de9XVJmfZJsJU29Dz7zLHjeIQ8ZweBpNeVdsHsIaqYcPEIhjt0Jetf8+3xQANf59cpV/
         XyVsVZnwlqx+hBzTLPxmBpM8VHGbmP/lGcqd5X/Jr8mTS8ju00tmWhGf9fqwFNCFcSRN
         GzjhJhTejJprwZ0s8zsMtjtYYIYyJayw2m9v15TcbqIAWbaTkxZJGjYtlQfRElOSpZI1
         LoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681779192; x=1684371192;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tkIiU/fq7xeN8QQjqGQlcRSrQt7X8OfhVxFqo3ZlSNs=;
        b=e91m2GG2h+immU/lI5jqTJrqUK1UF8UfDAxP6Vwxr/YBiglpuUIaDqzfJWzqJWRRO8
         fdXFmam+8hCWlsXgmRavKvSyoImpa03AmmrsxmeeG6+5XVZIlYf4rDtGVYHebQKpzeqU
         vTOrYB02UfFH6x4sIewtzcCwISbHSYw5kjTtIkiwMCZvJZqAqw2bzI7HEOJCz7ceNZXu
         hWBbabXZcwSNO5vXNKNjTpwtbulyLyrF7cVw7dngLd94jn+aAyAF9wPIgEyIPVGQ45L8
         tNFD6NScFXxTvRtN5acuZKCmLMhly3YWJl3YdXN4f+pRbu7HANTH4PF5iTTFSy40SWOu
         AJag==
X-Gm-Message-State: AAQBX9d/g7hb2De8/39X/Hhd0V+UXEMXlIy7zKO74MOJMQPMBhAqPLPZ
	Jd60+9jGeZ9T2bOQs83hnRNbn157zQ==
X-Google-Smtp-Source: AKy350bMrg4LS5k2EacbOEHQC2Ogcd2rLs5l3Q6KGV8Z91vTVPSEEB11aticPRjk492IWoYPZ9V3sw==
X-Received: by 2002:a05:6a00:1507:b0:63d:2910:5c8b with SMTP id q7-20020a056a00150700b0063d29105c8bmr4713860pfu.29.1681779192212;
        Mon, 17 Apr 2023 17:53:12 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.9.16])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7814a000000b0062607d604b2sm8154783pfn.53.2023.04.17.17.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 17:53:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
References: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
Subject: Re: mailmap: add entry for Mat Martineau: Tests Results
Message-ID: <a0c0dcea-324b-890d-7aa4-83fecaa59129@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Apr 2023 00:53:10 +0000
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
com/task/6437075239567360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6437075239567360/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6155600262856704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6155600262856704/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5592650309435392
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5592650309435392/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5029700356014080
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5029700356014080/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/140085dd99a8


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
