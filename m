Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80AD518
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 18:14:27 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1a28de15c8aso6008fac.2
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687976066; x=1690568066;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6zG08RwgQVKXYq7N3l/sAjaY/H5OpmWbJuvREDFC7w=;
        b=p51W0DnaP8jh50X7UBxTvuw0SrH2cVamgaLg4rhh10ykKMm3ZvMbUhZMhOzZp8nZ+l
         JJ8qSSDdiTCWFLsrdDYRqZhhpGN7Ax69FNTacCEFQU3MX05jfvdTsALBdYwP/rcXpXNR
         cplxlVnvY5w0lvooyfJSUv78oaVUU4OHZHIbwf0ziCkX6cbagK15Cm8dog8QdzA+PLcO
         2S75FhRyw61PD6trhm3SjWSa+JQPvqd3jMyefZvtdfi9Qq6sYdgBq2WNk2tYlLF9dIyC
         K01abSxfPktrL077cGKgW5ErouxOVNAatb9um74Jz3n9eAw9hGsRngA0KfuArI3i8QiL
         QdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976066; x=1690568066;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d6zG08RwgQVKXYq7N3l/sAjaY/H5OpmWbJuvREDFC7w=;
        b=abhHcmR33zlGIHCNVle1Exe3wwoOYUe2H17QvjqOKhGk1HlzdAd+LKCkGg9TvmurU4
         U7E2JqbFsnuwISxkzu5gceL4vSh6s3x75rvPJg5R9LaddZDhxOhFKxEZFQaE4fv2Tzhh
         pYP8Zsp8AAX0epIeREkBkAjCoN/uI+EyG1zKGGT3KIj/L5tt/uczcZnEOJA9amUX3uHa
         nnkOOBOkxPKEbz+tMZAm5tToiBmeYv5CHfv2RdZLdSkVJju5PrPb1CGmNWP9L9glY5At
         IIUyvgvdrbXxUPqdeUCP51yRxoZwWuEhWmdkrRUXtHUed11GPZ8nHSM+UQGpm2bAg2K8
         THWg==
X-Gm-Message-State: AC+VfDw+Fm7FVaQNDMqCVkX0PKn6YZ6gGABKf4jSVAFP/LFi6jABRvFT
	zAEVKIeubPnRmLpxH7OQYQ==
X-Google-Smtp-Source: ACHHUZ4wwSRH9K0G1ic+fmzqV2FHam48yCd5VUvS19xLxzlrBE974TS0q//HG+zdhKUOEwbQoPNouw==
X-Received: by 2002:a05:6870:b7aa:b0:1b0:691a:d377 with SMTP id ed42-20020a056870b7aa00b001b0691ad377mr4444513oab.2.1687976066028;
        Wed, 28 Jun 2023 11:14:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.185.204.69])
        by smtp.gmail.com with ESMTPSA id e26-20020a4ada1a000000b0054fdb673104sm4444973oou.9.2023.06.28.11.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 11:14:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com>
References:
 <9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com>
Subject: Re: mptcp: do not rely on implicit state check in mptcp_listen():
 Tests Results
Message-ID: <5398f8a7-e218-b6e8-22d1-d38befa966db@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Jun 2023 18:14:24 +0000
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
com/task/6083175428915200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6083175428915200/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6646125382336512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6646125382336512/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5520225475493888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5520225475493888/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5286227335708672
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5286227335708672/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d8d297a10c80


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
