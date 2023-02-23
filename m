Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACB02564
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 12:13:07 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id l1so2319656pjt.2
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW8aqoP/gGrFAIOZzudt3kBJ0Bnq7pWLFzTDqKtdGU0=;
        b=NNQvwMWn3iCV901krPTJegEg9Xvv1WBtE14iIxmjjvp1WT4DSArQZIzIpqNGBIX45l
         kHbdMX8pWF1uE+/CY6fmS7valArPtF0ujVByVOkZIuQrH95MmDrVC7wcVJ/+/70Heq8N
         NGKPmW48OimGsQHB/D12JoHWwExSgVck4F91bgixicdBYkIzFAtlqe0T9m40syve7xa7
         rYap7qrl1gm/QOscZGUs32mxFqY10BXfp0Hs3wbWBvlR7W1dl0jzaicBkI3kISSeXgYM
         P7Q8xFATbz925X4Sstdjj3S2uuQFIsACeRwuxVI7YMTJJ22U0qsBsRXo+werTcqbmXWa
         4gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oW8aqoP/gGrFAIOZzudt3kBJ0Bnq7pWLFzTDqKtdGU0=;
        b=I9aa9Yb84NPLZM/EU43jBbJi2wnabQQeHOZvgH66Q+TF+94kP2ZIiKWlRPi61hMiqX
         EvZfQ/CIrrEIYuaApiD7WqOps1uTZNr7PVW4nVKdaC/GDwlm5RrMRXUcD8CcwbiBdFMI
         h/qXm91qef1ZCZWKElwmwypB1c4A4JgRDC5XJ6lKZTfb6SxihtMPnf5nEcJ7LKGIcKh9
         VG6cMFZj2Pb+vi7wt7h9oqdgW/bjUI+iIxXwRqcc0KftE8n9LkWg6l5yJ0sv/mjTn7SX
         tKV5wWY46EW7YkdxnmUsZLTQ8vHT/KGK2I5iS7r+b3iuCfZrqgUJvioX1hAjOPEY2/vk
         RRgw==
X-Gm-Message-State: AO0yUKVUZqHMPpr3kXRm4b+dnq2S+zmq4RCXFqLAxTKq2ZSDw7bk2vhm
	S2/TPHaft58Dnj63DsLhOw==
X-Google-Smtp-Source: AK7set+8VAkUdfLuvSKLRbij86kLJx3F/+nDpfZMQP8WXPvyv68vJ8lMNWYKUSrsPwOXTy+nzA/JfA==
X-Received: by 2002:a17:902:e745:b0:198:adc4:22a4 with SMTP id p5-20020a170902e74500b00198adc422a4mr13249628plf.31.1677154386934;
        Thu, 23 Feb 2023 04:13:06 -0800 (PST)
Received: from [127.0.0.1] ([20.172.4.0])
        by smtp.gmail.com with ESMTPSA id n7-20020a6543c7000000b00502ea97cbc0sm2768950pgp.40.2023.02.23.04.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:13:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net>
References:
 <20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net>
Subject: Re: mptcp: do not fill info not used by the PM in used: Tests
 Results
Message-ID: <c20bc2f7-6c4c-a46e-5aae-9f0d22fab892@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Feb 2023 12:13:05 +0000
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
com/task/6249986447376384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6249986447376384/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4842611563823104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4842611563823104/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5405561517244416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5405561517244416/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5968511470665728
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5968511470665728/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/48c8d60ff9f4


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
