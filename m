Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4C4A03
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 13:37:12 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id i16so105828ilq.0
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=43wxKkIF7j2XGdkZ+nZZ2iYU4QRK/cpl+4nfsirhQ8g=;
        b=dwAtNjhxXP0G4ovw3zkjIGMhyzlVYAHLnfmxBbek/QcKCFyVDWeLOYSWTsRbmTZW5V
         Ug71TAxeIs68IHinEhYd8Pf5LE4drn9ORAxReFaZrOnDfejw5TYg/YZCyFzFiOJmOx4u
         Ql8gurd5cUrTsA+03+MlnqDbrGgFqnOzPi78QBSHuCunX/q2WtPVqZEXH5qn+CaTaRgc
         bKeZYqaUmsHkWlfSISyqpMzB5Z73x+nB3sVauGWdEC2tT+ErNwEovTmeqYo30iLQDAAh
         7gTR3SHhwmVFLRSXAa+JCFqxGaJYBkmpkrs/lkQ9UEqki6is7itYcw7M11oCQStHOak+
         5WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=43wxKkIF7j2XGdkZ+nZZ2iYU4QRK/cpl+4nfsirhQ8g=;
        b=HykjxYvbhWyloJDBV4RlPppnxly3YbUB3KTSssx+ZzJjEXJT73ozQz6VJ8sPu2k49E
         ZnJWdj1r1HJjlzcJ3Luv6Qy36ME+c9oVlUytyFimp4SGs+3RvG2UAWAzBpzoAUEizdyi
         uM92OKKlbM9XZ4bHr25q6oRMHvv7MOyGcRarKa7sNBPt2G8OgJ3qVd1wa5AfXIqrKset
         IZplFG9hmrcpc4kuvKpd0WGTCtylMpq60I8/+fxoJLmQrdEN5+eE7eho3ZiSyGk6pdNS
         ihcXUFi4X7ym44cQqstwdH0KMANYLW8U5MnZqdx7tmMwTd9bWSgG6gOWOydFuwZ7KQ/4
         SVAQ==
X-Gm-Message-State: ACrzQf3UZ5L6ppuyKFw4w5ZgSOfkw4WyZF3uHbr+H2dE0531dQ2uWGFJ
	/RCgwsw4WOwo02ShTc4Xkw==
X-Google-Smtp-Source: AMsMyM7MwjPYzqL0Y7gmOXLY2EHDadqPIeo43nbaM03adbG8qT3ezxA3d5NAtxc/d5fLjBn7XeEW2A==
X-Received: by 2002:a05:6e02:1baf:b0:2f5:a7b0:65a8 with SMTP id n15-20020a056e021baf00b002f5a7b065a8mr6744967ili.227.1663767431552;
        Wed, 21 Sep 2022 06:37:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.12.178.35])
        by smtp.gmail.com with ESMTPSA id q26-20020a05663810da00b0035a328c6ccasm1051634jad.76.2022.09.21.06.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 06:37:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220921120442.320727-3-imagedong@tencent.com>
References: <20220921120442.320727-3-imagedong@tencent.com>
Subject: Re: mptcp: add statistics for mptcp socket in use: Tests Results
Message-ID: <8e0e5850-d558-020b-c34e-346f7e2719b3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Sep 2022 13:37:09 +0000
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
com/task/4839559384006656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4839559384006656/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr packetdrill_dss =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5965459290849280
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5965459290849280/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/179389e0fe2d


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
