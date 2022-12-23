Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E648476
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 13:58:36 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id j16so3730874qtv.4
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 05:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BgF09a1Y0kGplcpuhoyrsw45MdTQ0fe+sLGjh0wZoE=;
        b=gQIJIVOr0thCPl8kRJA3K6uHIYJIwhqwOtnJPeRUCxztjklJSZwlB/YCIK0fXkqEkL
         YLacOulK4BGcw8wASq75iME7SX+L+OzgA9LMogLKjACcqJCL5733f15maGDAe/gdetEl
         vQbeETCG2F0IiTLSmdSLM/DRcD+f9DQ2+UKv1dRJv1WooyXzihYPEfxtbbhbWdP42L2O
         EbtiZXrRB4J2naD5FvyetwUmK0XPb1hB0++SYNccXkNTZBevMCMaQwmiFEJmSnvIZ4jQ
         nmOODRu7tJC///CTYLzAQX//D7/gQk9ok4CqZz8SQmKFVdA4CAWB5zn4qLnqZlx+r9X3
         ukgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BgF09a1Y0kGplcpuhoyrsw45MdTQ0fe+sLGjh0wZoE=;
        b=NNsm3pWuDqIsQZkGQSlMn3cw5tmh2DpVMKyAFHxZBLdUEkwgo3NSHZ9ATH30OKv25F
         G3cN8fcNDLyUZc4p7abzHPaYetcWOyzMHW7KQAzCqRwJorSZHc7W2prsm/ZudC5SOjDK
         I71VOniFIGEpV6EwWsi0b5DYs85mHHD0ymnhJ9kamBwOmBv9Ad3m2khyec84PuyQbz2c
         C3CnE40hMUEu/bRs0OKRwLykSkhv0kQa89+MYMlSxUlQZGzmWwHTlV/hBf5d1TzSAnjY
         RpgWwLC5PjmH+Wnl035L9+Ci26Cvc/qnuHUbBkmv97YjYm/9tKr5STB2Xg3gTHoDckj7
         ny3w==
X-Gm-Message-State: AFqh2kprcEnab/QtVjZdIZhgcFQIrjUo/Mz11Kofw5pVbfIyOe3chndH
	e2Bqeg+Ij1NMHU9UbzdI3eAdZ/pO4BK5
X-Google-Smtp-Source: AMrXdXsh3V3C6aAjvrx8Wx9vBvRHKnIqnjeFsV4GbmERgRYkY7DaMYo6Ynli2sdHs9cUVCyrifPiUA==
X-Received: by 2002:ac8:1085:0:b0:3a8:11ab:c537 with SMTP id a5-20020ac81085000000b003a811abc537mr12439552qtj.63.1671803915797;
        Fri, 23 Dec 2022 05:58:35 -0800 (PST)
Received: from [127.0.0.1] ([104.45.203.193])
        by smtp.gmail.com with ESMTPSA id w13-20020ac8718d000000b003a7f9b48e35sm1962487qto.29.2022.12.23.05.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:58:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
References:
 <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add test-cases for mixed v4/v6 subflows:
 Tests Results
Message-ID: <2cdb8605-6f9d-2298-bbe4-c55afe2cabdb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Dec 2022 13:58:34 +0000
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
com/task/4957635586293760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4957635586293760/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6083535493136384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6083535493136384/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6646485446557696
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6646485446557696/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5520585539715072
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5520585539715072/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5c7340e80289


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
