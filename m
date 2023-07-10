Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573465229
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 14:03:44 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-55b83ae9be2so3276825a12.2
        for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688997823; x=1691589823;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oOibthi6ibLrrGezDWhjVdnASEgajkaVH4oEjEdvOI=;
        b=KFkyBMdVFCeyEi7aHc14ZIsFXzhJuoss3onkh61prIbrWlIgKDkIx41ZpUKfO6uYKo
         LLpeK97zTJdzuzSwZn4zPjt2mBR1BojlXeX/dp7Tl/W9c0WoSh191XhHOrGi9OVZQOAw
         WYH5lcr6GGiUY5+zprbot0VGT2BiaQdcSZ0PqaTjmJcxp2d74RbrPqgUxlPQTm+ZV9Tb
         IJW56cPvMVZXbNFm10emIg1RTd02isVKYZgpU0KpFXmx3NoHLdNoa03n/T34DV4Xpn2I
         BhMK84XdPkHVMurH6om8z+T+Gcw8G4F3yLo0M6zI/B7FUTBYE3gXfWp1IhcWhThEeJvH
         ksFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688997823; x=1691589823;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oOibthi6ibLrrGezDWhjVdnASEgajkaVH4oEjEdvOI=;
        b=bbWxfttnJsYeVdmPE7PaNQTxH5pTOvRIxFFi9205mL/4OxsX+mF0wlfYiXL+iyxvd5
         W8xWRV3gXH6PKnoGfhn9OIdcV8V9amDz/KCdbFlUktB76E6bnKvOcLKgWNldJSxeayc1
         VzURjmtDsUQ0Ksd1QU+hTxZoz6ATuw3NHSPucahtnmTxmhs6wdhNPUfrsWIMhxukIk38
         3qr9rVr9zmORFImppJqLbTYIANza+69R0t/ySXPjW0fE4uNChFeawHFtTfIlTSciISD/
         2TroBf7G9kWYYeb79Q1w8HOIT9ljFmCTiWDubRKkQyQSSx76ZQtq9aDF1PZA6YTpb41d
         bqow==
X-Gm-Message-State: ABy/qLZZZGpe7qJFVi9Pgj6YTA/Z725VxwdQwWcOMxQ0xXDa22LJZNKp
	AmMNfXwPYaqeLOD3KxPaeA==
X-Google-Smtp-Source: APBJJlFIF5lyj9pz57gw+jkpSX0drfCzme4OAmgGEF9QzeRsajd0XHxCXl/sM1UfY6WnJf2ltpHf2Q==
X-Received: by 2002:a17:902:7d97:b0:1b0:f8:9b2d with SMTP id a23-20020a1709027d9700b001b000f89b2dmr13031687plm.29.1688997823386;
        Mon, 10 Jul 2023 07:03:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.59.98])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001b8a897cd26sm8323950pld.195.2023.07.10.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:03:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f994b6d9cf322414f649676bf283326658fc428d.1688993570.git.pabeni@redhat.com>
References:
 <f994b6d9cf322414f649676bf283326658fc428d.1688993570.git.pabeni@redhat.com>
Subject: Re: mptcp: get rid of msk->subflow: Tests Results
Message-ID: <8f695b99-d581-71a1-27fd-8c1d7a2f9eb5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Jul 2023 14:03:42 +0000
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
com/task/6440442267435008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6440442267435008/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6158967290724352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6158967290724352/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5596017337303040
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5596017337303040/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5033067383881728
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5033067383881728/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/917c23c6ef4f


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
