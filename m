Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EF20E0
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 02:17:41 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id k14so84718pga.0
        for <mptcp@lists.linux.dev>; Tue, 03 May 2022 19:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Y7W2t3LtpL4ZLeydfOCeJ2XITzhNSpdg/CCupjXJQIY=;
        b=qoxzeqMjpalHJop91r3ReqHeb3bGA7Wc60CzhenTdJ+XqCJolfb01nQHWsk2TjBz7X
         RBydOlVE60y7UKbmVd1nVP1J5mcZCAZ3pWP5LUbNQqxt+aPT5mdbD95YgfzxUtNxoSG+
         8r1aBL85XCCq/cYSOZS2qu9TyvBalKQpefP9QBHb+vj+ufjrwRYMfGepXU/XAmS3T5Cm
         6HYUAiMerdsxYjooZissjYkGdJ/Ebc3y+/OKax8zLXG/FefRy4R3Mq2ugPW6UnbxfQEp
         nQghZ4qg/Ita6Bz9fq7dF9+7xSBQRcHKbREZHKXOr7keIRF3S9dZsOG7kPuIyWr5s92a
         iA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Y7W2t3LtpL4ZLeydfOCeJ2XITzhNSpdg/CCupjXJQIY=;
        b=cJ4c9F3CBVEB3IShdhz1eHGxre8xSO/lvA7kr63LOJ1ACRpq7h1NWlnPvJNV4OeUEm
         nyKXUZA5kUZDuE6PWEFByo/qJXlvwtvYJocWED6vby7I5oFPheX8iiAQmcqLmAgsFcgb
         MFQPLfap1uM7HwNjc4oO5fcRUK/JWvIQgcx3/5PHPyBB23peTjFzMA8E8rbJaRi3QIBQ
         PCwNS36A+5zSE2b0CjJZRWF/VnFNKF0L9fcLU1o7OIAvqBzly6SckFT2bwLjfjV77jJP
         FHcZ9spp5yeJFrFL/ddirMVV45/RKP6IE/3IHn8jiHYWwOHWMUZdL52Jfhmmw4wBl+yk
         nYJA==
X-Gm-Message-State: AOAM530rO9Fiaz5TzWJi5Ee0YVrZ6puldF1aqQsdB+7kacMeuM4VMg+d
	VcwLWeHSLgteBDGuJJcsfw==
X-Google-Smtp-Source: ABdhPJwnki5aMXPKEDPN8neSqOXlELEiNUjSEuMlUlzlZ6PODWkraUgToBDkMr6dQhHurdPuCvaNXA==
X-Received: by 2002:aa7:9109:0:b0:50a:78c8:8603 with SMTP id 9-20020aa79109000000b0050a78c88603mr19129652pfh.77.1651630660695;
        Tue, 03 May 2022 19:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.157.197])
        by smtp.gmail.com with ESMTPSA id z21-20020aa791d5000000b0050dc76281ddsm6965052pfa.183.2022.05.03.19.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 19:17:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3efc49e473d2fbb03c9577aea5959b35d29d2c9e.1651625191.git.geliang.tang@suse.com>
References:
 <3efc49e473d2fbb03c9577aea5959b35d29d2c9e.1651625191.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_bpf=3A_a?=
 =?UTF-8?Q?dd_bpf=5Ffirst_test=22=3A_Tests_Results?=
Message-ID: <e753830c-b32b-b412-f98d-8d56e471a481@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 May 2022 02:17:39 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6122010928480256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6122010928480256/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6215194589265920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6215194589265920/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6da540838c97


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
