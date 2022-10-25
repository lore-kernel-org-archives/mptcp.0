Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFC7E6
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 05:32:42 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id w3so6917106qtv.9
        for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 22:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcVwkn8srxPPBd1zanuTcqb48/jcGdqFLV/RNoBr3DE=;
        b=esBwDEnDZPC2UHKfHsg4P2DJqy2s80SgDCPscdNHkgKihTVgtCFuQp3YPBV3/+9d/x
         eId89j0u00kmw7PpmFahBCx9NNtNMvRqj2mvYdTfam9fX21nWBwvpFFrGpgJG72av1u2
         ih6k8BqUFPC4zyON9EfMZC1uIdfLWj0cHTYr0SGMByndAqYLJsYLpv1JOWsevKWlYlYY
         asbQ7HdSrAVKsIeC9mnftsSG1ilvcVUmGpbubHkUkABlUyGAB6E9ahD70UjO5twDrr9N
         PKeSH1uP1u9uhPjhbfPZ7yR1dUDjRObuxN3n7B752LMk7oCX51LN+5hT71ek15pAk5c0
         UwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LcVwkn8srxPPBd1zanuTcqb48/jcGdqFLV/RNoBr3DE=;
        b=0Xgybr1VU/TJUhB7xcdU/Gh1Cv39+uZb/hAN3YAcMgQYwo+gg0n4FS9MvpRZl/17pc
         W0n4fPC0p9DVbAR498RMUZXkZEt88Me/trvcnqobg0maQoBOyJuIE7pIwjvgj6i5gdsv
         YJbdQq9ZBdWrPsAeF6bvoY8rx8o20EJ0wpolJ2/C18m9fVoj2ZihofFJJXVWnDm/ZdoJ
         Y3Ml5eWQfwYoAzd9I3u4Gb/GjspAz9HZXAQdhXcEr+DthTBJCwojXMsK5ZJivDw0ffa6
         SaaZ4B4PyQKa9OCgZ3520j9DBaC3YNVwvgJqwc8+dmr04L9WS3UEf/oCe3GfGFXR9bOA
         PdVA==
X-Gm-Message-State: ACrzQf3CE1X7G8/gM93b2ZElEOqvIzgIXiX5Tw4LS3VhezrTsTdk2TId
	FFzkrNY6gnEEICdV2Fpra/0oURGacrfB
X-Google-Smtp-Source: AMsMyM7o2kcfysZoqYUMgMaqdJfCAkd4VWU9NSOvUCWpe2Bc+CFhMGINqn3/Z/SsyEBzocFaY/5yNg==
X-Received: by 2002:ac8:5cd0:0:b0:39c:f33b:d01b with SMTP id s16-20020ac85cd0000000b0039cf33bd01bmr30164483qta.502.1666675961059;
        Mon, 24 Oct 2022 22:32:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.1.152.114])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a0f0e00b006cfc1d827cbsm1474432qkl.9.2022.10.24.22.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:32:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221025032610.17496-1-geliang.tang@suse.com>
References: <20221025032610.17496-1-geliang.tang@suse.com>
Subject: Re: mptcp: get sk from msk directly: Tests Results
Message-ID: <0570286c-b565-eb27-56e5-303d27f3de2c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Oct 2022 05:32:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5498513902534656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5498513902534656/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6624413809377280
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6624413809377280/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dbb957ed5d08


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
