Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C8A35
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 04:05:37 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id kj8so11315248qvb.6
        for <mptcp@lists.linux.dev>; Sun, 15 May 2022 21:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=AUcbmr3vNjQgx++R/qHv6hDQn0YSt9Kh69HKzHtARFY=;
        b=Y4Jon24+D4V35btE3HQj2OngDHNYr6Pm6GvFsb9Lk9yvpsha3VnbXEJf/bf9begTb5
         mP//HHWXbXQuyTq1uAYJczI8lAJoRWrcmBxmYCxp62Ck3TeNtlwJnIzJqHJ501GhpeOp
         EOxwAhI8Y9owczjawkWGoZsQ8oXbksIiUT61HW9WVygKUIexUBltqlB8cvgiPKC5/SjV
         8h5x1BEQLcz74TNnFAL2LdDyTyE9/+HsXjzbvPZypugWYSycF8IiP/PX3y2WVUgAjYRq
         NhXCgJIGEW2zHaJmG7jNtPoTPBiCYdP9wpdfAVKKESnjS+OT2It+7IWLvQZBUHM33gvp
         d1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=AUcbmr3vNjQgx++R/qHv6hDQn0YSt9Kh69HKzHtARFY=;
        b=y++WWaiw4ZGatXuFOmSkz7LVba1YxhK2WgXGMb4dJrfQybxHFAx2R2VwuRvSzI060r
         lc4jtSZladMZFi1SJ14VlfFKmXZQISZsgpXRJfl/xKG4z14d+/4s61O+BqipWJApe4be
         9moLjnd6LTubGxXIKZ5BXcEAEyK9yLhn15nXGcy0+gozZ5dbmrXR597u4U2KYJVerfsp
         LaP6phSGCqSqysKNErhNbtbgaK2Vst6MBVpU8slbK5kFrHsPVFkOu1+JKg2j2y0ukcKJ
         YaJddDeD2PODwYkYjTle/NKj51DsPMDsmpfxxk/pxKZ0YB8VbEcZgjtm7sIYNtKpPg4+
         Oyug==
X-Gm-Message-State: AOAM530xTZgExN8lSafcqz1SdaaDzHCHu97IGgo0uKDn0YoOnCnCMIDV
	fE1j1FUQBmky8V87E5TnWe3nVAypFg==
X-Google-Smtp-Source: ABdhPJyi6p3gnV6YEzYO+yzn5TX6pNtE1MiT2Koe6Ns4gElApIS8BhnL6xI1ZX9Q+PUcD4X/U0jR2g==
X-Received: by 2002:a05:6214:509c:b0:45a:7c96:d603 with SMTP id kk28-20020a056214509c00b0045a7c96d603mr13905289qvb.86.1652673936892;
        Sun, 15 May 2022 21:05:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.58.220])
        by smtp.gmail.com with ESMTPSA id 12-20020a37060c000000b0069fc13ce216sm5059638qkg.71.2022.05.15.21.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 21:05:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <550c72ef0be9d4c25874c997370dbe541d2b28fd.1652667282.git.geliang.tang@suse.com>
References:
 <550c72ef0be9d4c25874c997370dbe541d2b28fd.1652667282.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_add_sched_in?=
 =?UTF-8?Q?_mptcp=5Fsock=22=3A_Tests_Results?=
Message-ID: <3d138936-5b99-5794-782e-bf1bc42b3861@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 May 2022 04:05:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5942261262319616
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5942261262319616/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5379311308898304
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5379311308898304/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/089c6d64a118


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
