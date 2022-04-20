Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A37A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 06:17:09 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-d39f741ba0so940468fac.13
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=v0bwE4SX4i+OZ1usPYCn9lOHifQAXnZEcx//OFraoe0=;
        b=YysaiAEHGwXN6COywGsoHun85I2MyLrZcMnQxwJOv78wxHjuSWy1g1JOb6httwGLl+
         +xkLFX3mPsLtM3JvJ1NB2eQ4uxLYBUPhB1yzdBU/AqpOIbvReLRzaGdysY6psba8KSOZ
         S2TGITdD1ATDyTHQX+763vTQvgWmwGFGllInB1XHQSg+BYiH0iT2q39K6i14bKa0JNQ2
         L+gr/ByiJFiwpcQIphJkleo3T7YPAKBW/KNHczyrmDra4UlvPDi/h9Mgk0EG4QKkeb8f
         dUkdrj6YgUiDNfCqyApn56tPSIRcfoKYy8vdfbDzbRvdT37Zni1UvfzO6TOYg+46qjr4
         dATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=v0bwE4SX4i+OZ1usPYCn9lOHifQAXnZEcx//OFraoe0=;
        b=12LxZ4urStJXoCeyRsXa2CMioP1p8n+EK/rNhPSiKJKLgJu9C7WU2hdbtMS1p1ZbAT
         vaffHo+VEgzx0S6y/8nY/1NSHyFZsVg9uuIxThaLZ0eekLFPcN7rSU9TqtK02oRWJFA4
         T7qGyOfShpZXxQYfFz0uPNkoIojots4ifdNuHa2L6495tKKtcVjxVanasMPewHw9VO9/
         XGbKG7LdonY8DF47HJBTOLynm79disLZlnoxJW/VabZUkcb5LGgLYgvnuSur0iuufj61
         Sagf274mAlBD4rCiBbnHT0r0ZteoHkNH3eHIbhLbXWrIJJfv8BFDOdHswX/XFaQTBDoC
         kg5w==
X-Gm-Message-State: AOAM530Z+vt3LmV7onmdu9AVshyoRy40DhrqrYhHYUW5INXlbfjcCWv5
	nPOS7noVm8HaDVHvfW7oFA==
X-Google-Smtp-Source: ABdhPJyabbY4x5o/+VovOBBXOrV0HWHQtbPCYccxmHUS3EUcUpsXZ8wX4hJhkElIsPdvUsz+tcqosw==
X-Received: by 2002:a05:6870:a70f:b0:e2:a562:f476 with SMTP id g15-20020a056870a70f00b000e2a562f476mr943206oam.29.1650435428581;
        Tue, 19 Apr 2022 23:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.124.230])
        by smtp.gmail.com with ESMTPSA id z5-20020a0568301da500b006054fd8c847sm2394498oti.11.2022.04.19.23.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 23:17:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220420042524.2268380-4-kishen.maloor@intel.com>
References: <20220420042524.2268380-4-kishen.maloor@intel.com>
Subject: Re: Squash-to: mptcp: netlink: allow userspace-driven subflow
 establishment: Tests Results
Message-ID: <e16b039b-6a96-b76a-c495-bb4c0b436ea1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Apr 2022 06:17:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5049695033622528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5049695033622528/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_simult_flows - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6175594940465152
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6175594940465152/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/beee9dd0947d


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
