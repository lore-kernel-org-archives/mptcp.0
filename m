Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9613AC1
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 12:29:42 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7659db6339eso35859285a.1
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690460981; x=1691065781;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5vFrl8byplPs6QbVMHxi1gxL3IM26HH37KSZJpmEPs=;
        b=DdfxTuQxAcfH5Xh8uIypBtgfi4kk1DEyNiBNYKWY8k9pGyHKPtzl9c//KCusx1N/9f
         ArcjBAAB9zSHC929THOiz7169+xmaCkyTndGI4j93lYEC9yxUXyKubUHSeVpN5kYwE1y
         hy+Kmt9F4j4OzdwU7EG+GkK86virWN6RMQ57O+UCrA+gFu7Arl+nane0Qv+Lz/6jPvwu
         134ZiXaY14nOdwdS2eyXfL+qwnFG2x3wAqvxnvhAIQfz3Yfu3MxAMwyeEFeOHZCFiWDm
         y3xy61bh9adpGznF6t7HjgIV2ZfETl5bctMBkMWk00P0rSmSBbyTZQ6iiRZdODajXLpM
         +D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460981; x=1691065781;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5vFrl8byplPs6QbVMHxi1gxL3IM26HH37KSZJpmEPs=;
        b=gsp7WX2cEd+ewzUfvjmmJKAbHFuTqw0uOhohq/vCddlHaEZ0IqbSaG4uORUB2SUlLl
         wTL54H+jMx5eHdtOJdI/+9uBqHhz71FW87x7bx7KHgTXfUHqXhEofSP7BgLy+lE4rSIQ
         emQLQUDaV9Ay2pM+eNbKqekhNmSINb+yVSL2vlHEO+OXlwaHDmWabGQT1Jlmly9vU2bw
         Tl2AH3f7wPvoIOhrxlARPbeXUIeHbOkBaSybTtRtCp84eC1DdDNGq+6kf+VReQ0nVrUx
         51RVJwfEmqI8ZShT6ZUST8XD93j0kq8FHSy+dz3fgDpuJe62NT7SY/9SBZg6UBNma0Gg
         r61g==
X-Gm-Message-State: ABy/qLbnIFCajWbNDgm9W6IbvrNoYFb1zFq1gkv5iWVgPhV/ejasf6Q8
	m0fOPLJIPDeXRbOTNOfpRA==
X-Google-Smtp-Source: APBJJlE7lADsYUGhSCrjArYc+wqBt1wOpBlOUkwG+Wo8oJfcUPg2YGKPkuilxt8R2DumkbLSkZiCjw==
X-Received: by 2002:a05:620a:44c6:b0:765:3c4a:6237 with SMTP id y6-20020a05620a44c600b007653c4a6237mr2965677qkp.16.1690460981461;
        Thu, 27 Jul 2023 05:29:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.229.17])
        by smtp.gmail.com with ESMTPSA id h26-20020a05620a10ba00b00767ba88f0c9sm379207qkk.7.2023.07.27.05.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:29:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
References:
 <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
Subject: Re: selftests: mptcp: join: fix 'implicit EP' test: Tests Results
Message-ID: <957802f4-3c4e-1755-3f5b-2b97b2303cde@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jul 2023 12:29:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Andrea,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6266739109920768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6266739109920768/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5985264133210112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5985264133210112/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4859364226367488
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4859364226367488/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5422314179788800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5422314179788800/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2243a05ff3d4


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
