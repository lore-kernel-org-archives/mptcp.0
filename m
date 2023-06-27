Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740A805
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:29:32 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1b060bce5b0so129369fac.3
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 18:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687829371; x=1690421371;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UytgptjBeH8+UsZor5HVkiNEPDlvOkRGfvo157vZcs=;
        b=OgjFk6roYcPgX7Pfat7MxPu9VkavvhbosRH8rgG6paRr5a+1ohkXCQcyWPlYf07i3o
         v/3F/bPE8R2qHa+6Se+VeNI04A4BGYt4kpogGCUtbuWE7PrUR+YEY/LfDAwz0uXRTWOA
         OGy06MiRbbsKgAsKrqqB4acRfvxbRrsrt+qjUnNzIrjNFy4vbW1UFjFIxcx5vi2UrK7k
         lCsybkbY9OFXK0VuANyFa/fjRMoe2ilA4bzVQW0vd92PlVITRwpN1smJCteRALKH4BUT
         6cE7bYQnOhsNoS7yZ3bzyynogpNiSCnkgcDkDvPP53HYvhNpoxGaFzAymsmekCXY3wZB
         A/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687829371; x=1690421371;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UytgptjBeH8+UsZor5HVkiNEPDlvOkRGfvo157vZcs=;
        b=McS8sKpc+C7x4aj52jbvS46efzARjREtb6okSIreBE9AxxxgYy1zl98j/yY4Vw+Lf+
         ys3nQEM5i8nihb3fyh8561+o2tTFN107M2DjiQBcoYHqOAi5xTgYDPmFm3UQ0Z6UGxvO
         uiY29OJrO/nGfr4R2TTdRBmcxrhUN9xAwdEa8Brei8Cfq36SiDeX3oPc9RvG55IOyZMG
         YYQgdHEOW86pSpBJI2zVWbiw6odNX0bqicd4RzMjsv1vP2qmO96zVd6ziWBauiI7LxrB
         IFxsWOEKMCNj9hLUlIcMgK4CPznCmLU4GZeIpQhAPtUt5AJmhFzs9MHgNUC3MxrSsMpr
         1fTA==
X-Gm-Message-State: AC+VfDxOTd4qkpiQbEVFhp1IrjAiaPEC/Yz14/4zZNP76qZb3g9IVhsD
	oqxfSB0s53+QarvhJri6YjD+wi2IZA==
X-Google-Smtp-Source: ACHHUZ4Iygo67Aa9tNJY3cQvt+CQRcOfn6LsToHcJUJ7cNNqWvA/TrHKF8dlqoHScidgMMUir1/gvA==
X-Received: by 2002:a05:6870:5aad:b0:1b0:37cf:5af9 with SMTP id dt45-20020a0568705aad00b001b037cf5af9mr4450221oab.2.1687829371539;
        Mon, 26 Jun 2023 18:29:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.84.8.159])
        by smtp.gmail.com with ESMTPSA id do8-20020a0568300e0800b006adda5cddb7sm3114462otb.62.2023.06.26.18.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 18:29:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5631a5c3aafc101f6ba7a6caba9599bf982979df.1687827857.git.geliang.tang@suse.com>
References:
 <5631a5c3aafc101f6ba7a6caba9599bf982979df.1687827857.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_scheduler=22=3A_Tests_Results?=
Message-ID: <b711381d-86ab-e718-f4fb-24bc3843f438@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jun 2023 01:29:30 +0000
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
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5556020068483072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5556020068483072/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6681919975325696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6681919975325696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/4641226394173440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4641226394173440/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5767126301016064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5767126301016064/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cddbb44a0799


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
