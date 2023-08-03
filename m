Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544909440
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 08:02:17 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4039a42467fso5106461cf.3
        for <mptcp@lists.linux.dev>; Thu, 03 Aug 2023 01:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691049736; x=1691654536;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1k48pIunvubbRRgKWWee7PC3DUwy1qn/9uG3bftQIE=;
        b=o8fR+XCR0UEos3tr1UXZmZcDpSj9/5oOondTaLXYN1KK4zoVo71J/cg00YjXB9AARj
         QaieR7H3w1wK5geHZtjIt+8QxdgY2RtOLND1U68ld5wMQW7MZvtvpeV9vFB3eNUxUkKj
         IWSDR9pU6czEYbaGZayu+mgUn2Z3XD+HejzQa8jU+z4GMRgryuR+OgrTYKCvkV6wvOpV
         nWYe+7NIkd8JKlETDgl34NHoIXfWOOqUIaVHJhIz2ICUR7tg6cEcBLRirpoOkHSBU3hu
         exMxUAxi1xv9AOVKpi4FXHdJOiWbZDCEWVDKw7H0in4UrdY2C09vlde1iXTJw0ETetUI
         ZIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691049736; x=1691654536;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1k48pIunvubbRRgKWWee7PC3DUwy1qn/9uG3bftQIE=;
        b=S89tL0CDpiaVia6HImAtFGvTdXNzgOX285ApSRu79NbmP2AzTAshcHcGOyeXu5abE1
         MlYZzoGlxMnZTSzdIeYeFXL4diAZAm8X6z8X8zid/0xfdGDCQt7r5+DPYAnbowIwtVFr
         xSkw9bAFZG4KNtby+sdGR1XE9e7LeZYXAG6iylhxu1KC7deqFfdJsJjsCzJIn6rILcqp
         VQR5ne9bl68dpClRhF6UV53tUpA05Sa24hXTBzzovRUUJIpIi4Bmz6EcTOcnerL3KU9w
         p1Y/zzk0FSrlnXulW8BHQc7tlkjN6LBpjP/XOU031VwkueDPvkMW7AdQfXHBz2wROc0K
         2XKQ==
X-Gm-Message-State: ABy/qLbeytLBbBShqgMs5Sn0FGQPbcJUV0wJkiyP8xCTD6RMLvI3BytF
	A6A7MqbN+fcxTtLDqCas+A==
X-Google-Smtp-Source: APBJJlFuChEsTXp21VlMHDJ/zbMne69tE3zzKKJP09vsNyZvUWymuRidnM5x0oVlT9lUwAa6YlDWag==
X-Received: by 2002:ac8:5dcb:0:b0:403:fee4:2e7f with SMTP id e11-20020ac85dcb000000b00403fee42e7fmr20136837qtx.36.1691049735960;
        Thu, 03 Aug 2023 01:02:15 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.218])
        by smtp.gmail.com with ESMTPSA id z1-20020ac83e01000000b003e3918f350dsm6054884qtf.25.2023.08.03.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:02:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c5e97a0fe0e542080eccdd4f4a1e99bddeb344d1.1691045340.git.geliang.tang@suse.com>
References:
 <c5e97a0fe0e542080eccdd4f4a1e99bddeb344d1.1691045340.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <17d62953-01b6-f084-253c-c4eeda3ffc07@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2023 08:02:15 +0000
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
com/task/5811024205447168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5811024205447168/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5248074252025856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5248074252025856/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4966599275315200
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4966599275315200/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6373974158868480
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6373974158868480/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2174a36d15db


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
