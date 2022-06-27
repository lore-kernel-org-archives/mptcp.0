Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E092CA2
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 13:49:05 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id y77so12921135oia.3
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=gKXJnBusY4TjTPlltRR8l+S2yk4Hu7c+4LhWP7gXlWQ=;
        b=VtHgFOsasbCNxWO3urdL42dAM+VWp1c6haQJU44rPY7xjq3PfvsJxfyJ3SAiTFQcEY
         MgIaxN6w4oRpPfaH7TvJA5LPuo9w11jFNp5kzFuGP1kDdDU0gZ3T9Ob1FskBtP7JcOxg
         J1gLqHU+lDwmjo8ZVmlc4vkGHWSKcvd4OQ3Tj89cGjOBEBsktBE24aAZdzg9WXYltFUg
         +xnz6VqvadjmK6oJ/d1h+4eaacp+lIyAMhVqKNk5iKpQmAXZDuj5tKNfOIElQt2RfOhY
         EFG+hNAZZ8XaTeEsib5bGtNAdati1W++NZl8p0Pl+2N3e14BQczv8s7QDvqnDbPTUDb/
         TXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=gKXJnBusY4TjTPlltRR8l+S2yk4Hu7c+4LhWP7gXlWQ=;
        b=XhJgE1xU8Z/ZXzRij9GmvGMZHtWfXzVFQTldcLEzsM6Vw9Kkpl5M1/fIH5txQ6wxb5
         2W5JrT9z1yD4NDEvxO1fq5DDtsWWuS3aCvZYDvC/+24bOYwFriTZh2mABUY+gwpmxsGs
         Q0WhY94zVykaC2H1C+68kOL3dbekeVJPmEt53iame1gDQinvPxNlRfI23aCpOEvAf84P
         HZ93CZkTSXPDZfoWpDYNXPbaf9vGFzPRcD5HRtF4LxaJbsdEGBaUbn5JsGth2VTfeEFB
         T38BQ9BaZIqy9gg4Ll9a8P3ZsxZlmwBcMR9NnzPCx/ZVrN3aPjt/qTPXARmwWs1lk/vT
         uCgw==
X-Gm-Message-State: AJIora8piZdhPmAVjssc6wV59CQ/kx2gL1ad438yZa8M+7VraLry/OAs
	wGnN+EkpawsVPjwOIf5aqw==
X-Google-Smtp-Source: AGRyM1vohD3icWn/6WTYbgyMU6CumO5mDqL3aVWDxFstYayHZgZoFLdCTduzUFHJV5kktmecVCxNMg==
X-Received: by 2002:a05:6808:1153:b0:32e:b45d:bd74 with SMTP id u19-20020a056808115300b0032eb45dbd74mr8072875oiu.259.1656337744624;
        Mon, 27 Jun 2022 06:49:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.5.28])
        by smtp.gmail.com with ESMTPSA id x27-20020a9d459b000000b0060c0c6e9186sm1471442ote.15.2022.06.27.06.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:49:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220627121626.1595732-1-imagedong@tencent.com>
References: <20220627121626.1595732-1-imagedong@tencent.com>
Subject: Re: net: mptcp: fix some spelling mistake in mptcp: Tests Results
Message-ID: <bf9ef7dd-84bd-733b-11a6-abc923712dcc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jun 2022 13:49:03 +0000
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
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4864806451675136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4864806451675136/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5990706358517760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5990706358517760/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b8c9415261d9


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
