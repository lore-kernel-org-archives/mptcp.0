Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6077E
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 00:38:41 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-130af056397so15445286fac.2
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 17:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=5SaXbysHRvuQdxFvbY6GW8mxeGN07FNiC7cxhCy7jok=;
        b=Ta0VvxFrLdqmL5V7TmG+xNcVqseUeyDkzOl5Mdwk7DbczTR/RAyIANLXciZWfIJzAR
         lzS7Kwq8NgsCsJiwAaY5aCK/t8NT1/fENWi1VZCZaG4W0TMQXpMNdXgTPEuPBL6Pghtl
         SYzMFFlNzbz8ohnv5SIWwZEtWLu8LOtXuIgbIuCHda4vXWs4nmMPq8b1mACrcwfc4n69
         cAyoRmzsu4MpubjsjsYcNRXtKNEeWRvkoQsufOXsNz36QTE1t8h4+LEiZq2Qs/Os15Fp
         Ry446a+8imRKZS2jJf0U7a0GDJzLZl35nd3fIg9Aw/L89DaMAdzlStOxOSvMQvvQ19qL
         eOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=5SaXbysHRvuQdxFvbY6GW8mxeGN07FNiC7cxhCy7jok=;
        b=WsSwDZkcti6pzqOwfH8UwbiYFq4HLdqyaIJ5g3Bn3bUC2CVQ47nyvOUIV2qj+6zRKN
         MuoNVCqZRqJh6+nbw1pZrazRgwvg2MpDt3owqkg6R2rWacwstkZ/fkM+Tyr8sUTtFWcX
         QZixTUJLPi1QoupohOC0x5UJLLQz9QqyQA9KaE85bs4cEvwSUVmvlqsh6ipySEhL6Zgr
         8uwTGRpfED7+hSkOcXSvuPsZB0Cl9bmuHhZZNsgfdnLkXJWOVzC3OuynNozlWNQ+qkaK
         ygVpHiqVkJVhFefftV7tqNwQITYMO4luMXE98tYkstC7uZ9h4WDlSa2+UwvVpZKWzuLa
         GiDg==
X-Gm-Message-State: ACrzQf3I/2Duwc3e/JdEphdUF99DS/Q/AyobLoVHJ0QL/hPqpNeArI+9
	elkInB1HPIoqKgs+MrTODw==
X-Google-Smtp-Source: AMsMyM5j8J0z5RjwyyGc2tfkZDK0BCG3ceoVryRuBCKZ3O7Jeh+7EcjX1TZWENp8xDoeL3UbpHB2BA==
X-Received: by 2002:a05:6870:e88d:b0:131:87ed:c3c9 with SMTP id q13-20020a056870e88d00b0013187edc3c9mr2885216oan.181.1664325520744;
        Tue, 27 Sep 2022 17:38:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.219.75])
        by smtp.gmail.com with ESMTPSA id p12-20020a056870a54c00b0010830c24aaasm1611487oal.56.2022.09.27.17.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:38:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220927225341.14165-8-dmytro@shytyi.net>
References: <20220927225341.14165-8-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Tests Results
Message-ID: <696e8277-fe05-88c2-b619-e4025366f55c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Sep 2022 00:38:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 8 failed test(s): =
packetdrill_fastopen packetdrill_mp_join packetdrill_mp_prio =
packetdrill_sockopts packetdrill_syscalls selftest_mptcp_join =
selftest_mptfo selftest_simult_flows =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/4810967652499456
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4810967652499456/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 8 failed test(s): =
packetdrill_fastopen packetdrill_mp_join packetdrill_mp_prio =
packetdrill_sockopts packetdrill_syscalls selftest_mptcp_join =
selftest_mptfo selftest_simult_flows =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5936867559342080
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5936867559342080/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4285eae5e20b


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
