Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D7BA23
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 14:28:34 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-39ec83d1702so2539867b6e.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687789713; x=1690381713;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3ehsR4pSKMCS80GhrMM6JL3NieJs+3+CcpnJntxI+4=;
        b=WHuPHxie0ROWvn+cO5h4FkUNn1pwVgcDUtTY87R0xm2waCfK4clf+AHu9TGRg4k4Pp
         jkI/c3sAdR7wuq5rTbUfrYN+tPtOveXWFb+8NDq5s6eYhK21MNVUzSfOfIsK/O7qJ2kp
         ravMLfr/Uj9GysL5TztAifEdxzu1PxYMyFyRsEFrEE16ZyyqfS13cJB9U5Uu2Z4+U9s7
         qU+rdSEN7as9NUFzy4WicpnfYmK5CEPS7+YMEi2Za/ZwWR9bTG2JRPsZ3itJ9SRV9Nx/
         Tfy3VSY+9+F5WAhoM8EX7HY/EgdBkTthQcAMGo0wmJeLW5vNORPO8zIhfPcFoDDjK6Ix
         ADPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687789713; x=1690381713;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e3ehsR4pSKMCS80GhrMM6JL3NieJs+3+CcpnJntxI+4=;
        b=eHNDAA9InbEbZ8m7nuNQezUTxcXAqE+g+7rC6XRpzTYcFesZODmSsMnb7X8NQkKoVJ
         rR9rV6NUDT/sKkkXyderzLSBkX9SGf8XfxPNRS45HRaKYLM0ikahN3R/nmnR5tN5mNt4
         kTS4pYtknwuXeCIVyErbiBPpNRKgkYuuztuJQZms1Rfnj7kJX+ifN1kTxGkVxDIlqWEH
         0xjQoM624JONjVz0YhIm4RblnqAMVhgfAx/dZglaSlKEcOdcR0c1L2VW+5TwaTYX6VU4
         aIK0i/7JPt8QTCaOUe4bKqEGt3JbrK1ZyZbGFSV2riMKj+sOH3OA1m/dx2RnXSWrOp9h
         X/pw==
X-Gm-Message-State: AC+VfDyPP52x5vGObuN4Aav6/tACSrG1L3v7yX1ZVrhUMIWSdw4Cu77e
	4rxwEK/Qodz0DJrsKJ/VSQ==
X-Google-Smtp-Source: ACHHUZ7Jp/rg1CQSDU6i7QM8Dc11ZHVlDSJnb+RpK37mNyKJZHUGCfF9J0ht1CWOPwnYU9C9AKhqeA==
X-Received: by 2002:a05:6808:2c1:b0:39e:d115:57b1 with SMTP id a1-20020a05680802c100b0039ed11557b1mr26544324oid.14.1687789712955;
        Mon, 26 Jun 2023 07:28:32 -0700 (PDT)
Received: from [127.0.0.1] ([137.135.38.224])
        by smtp.gmail.com with ESMTPSA id y17-20020a63e251000000b005501b24b1c9sm4155772pgj.62.2023.06.26.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:28:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
References:
 <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
Subject: Re: mptcp: ensure subflow is unhashed before cleaning the backlog:
 Tests Results
Message-ID: <3cb9e3aa-78e2-e384-5e21-eff2ba6243ea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jun 2023 14:28:31 +0000
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
com/task/4635897983926272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4635897983926272/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6324747844190208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6324747844190208/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5761797890768896
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5761797890768896/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5198847937347584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5198847937347584/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1dc606871ef9


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
