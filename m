Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA891360
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 11:20:25 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id m16so3325189qka.12
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=JNN2QE7AM/1q+TDRCVUNnolZpAEWxsVHryX8G2zWhbo=;
        b=bpnKCuPpCYElRsYvAdE7CuDGN5UJWjRkGiD2bLeK1HNV92RrsqbggnQ76uPaYZzSBe
         96CQ2WZtgqHuyRv1YmI+YTWN73uQdznFPFV/I8XeV+ZUqvTpj0cqf+bqgTxI+rKHko+M
         sOfgaKijlXE6t4jgUvvKtG1VmX3d94JkIT7S33SBS+dEWdNaV6JFhNEVvQbU+He96xPz
         kLoFc1dIo79O4fqLavw4mk78z3qURyBNU1RggDpK+/zxae2JE+iafViOVrv2fs4WR/mf
         egieTqupA/BSuysrMMKPO6+safU3ErwQi7LVjYKz4OijlUSGtViJeWkunf+liBYc5p7q
         76Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=JNN2QE7AM/1q+TDRCVUNnolZpAEWxsVHryX8G2zWhbo=;
        b=PD6179DXGgh1eEw70HZ9BoKb7knM/YOJRKr1pH23GoSNcRR6m0PqWJGS0JDK2hGWZN
         NHqKlDhIzPVP2qT2CCNl7O+t2HWKBd7CF1E5pvxsz2NN90/3h6SVXPptMtRuNyOeDPT8
         7YxLVict3/5XO2slYTSMi9Z7tfhYCPwXPubphIJDA7C7vv1qQSzcq04F5B09hS2MONuU
         i9Qm3MpoagIhPVbFMvTi3ZD4hzTbT4YQnj2MqnYxUWNKzaArQ1QqD8LihrPzi8im3hIz
         0cXO+nSM7kDxlMRCppDEWNvZkeJoZSJ0pXFIBx2DF6hzNecvPkjTYZgX/lWnSSzZBKIO
         Gxwg==
X-Gm-Message-State: AJIora8zaWHq4v/feyGYxHIbh8FGQEEosPOe+Y3JKc0eYSJerB8bCWFL
	PQMtVbrocBsbvKJEp6XN92a3dWskdPIjlLw=
X-Google-Smtp-Source: AGRyM1vsMyCYLodqrEvuk/volwSZhPwuSSjza05yhRYlmrWJbsU5tUmTtjiLDzuqsAmNsrwWL5l8SQ==
X-Received: by 2002:a37:714:0:b0:6b5:c578:28ef with SMTP id 20-20020a370714000000b006b5c57828efmr2105260qkh.242.1659093624402;
        Fri, 29 Jul 2022 04:20:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.111.96])
        by smtp.gmail.com with ESMTPSA id bt8-20020ac86908000000b0031f16e7f899sm2064724qtb.45.2022.07.29.04.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 04:20:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220729095550.3040-1-fw@strlen.de>
References: <20220729095550.3040-1-fw@strlen.de>
Subject: Re: selftests: mptcp: make sendfile selftest work: Tests Results
Message-ID: <8e5a552a-669f-4a87-37c5-6d5c6a6412f5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Jul 2022 11:20:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5322407467548672
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5322407467548672/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6448307374391296
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6448307374391296/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1b04f2259a4c


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
