Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA820EB
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 18:45:30 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-3f52d303bcdso24716181cf.0
        for <mptcp@lists.linux.dev>; Thu, 18 May 2023 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684435529; x=1687027529;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOCCCbrgG4oW2d3aQfy0mA+k6fpX++q6U5n9QkFBUMg=;
        b=D+5ALBzKUlAxQTC9lfLw8nnGtCpLSmPACXC5RprBbq0SgHWzpzxZbFq8Fg4a2X/2m0
         2s0qhnCnc4D04JIS3uVfmJtWJxbmepG5fUH+r6csxU7plEoddh1mIq6lBvn0jpBDaQP2
         b3ww07H/br0lijoND6s53Osb7auLxybUUy4lrLwRbduTbzoWwksvya6iaux/AJLoWIMs
         LsqvGMmWD5LywX0axL/l6RSVnG2GaFS8724LgeCGT+GuR0AuTXusCemYwV8vHafNCOuG
         zBVukLILCArWbggs5bB3/8MFiMjHckmXLo99TPpVUx7/hDMl9/qUO4p4D0hNsQRzXqL7
         kORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684435529; x=1687027529;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOCCCbrgG4oW2d3aQfy0mA+k6fpX++q6U5n9QkFBUMg=;
        b=QwDAjgc/iAvO20SDSS0AW3e+k8iGLT/LVFLwwQCghWMHEjQ+fbolM2ky+h/YqQkm1p
         7LHQMoHvtnC6rPgUfTZPegg4qPcChFBceMfPxfSxU0VBV0aDSPaP1tCrWfSVpVsE3noJ
         NBFgPQ2ZnFcSudBF8g3k8DusGSPjRjCxS6wnkBky252stcTgyCWqSNMuUIWHwbI3GzAc
         RXNqsH/bDKHo2k+1v3kDbcT7ybYrgWxUoI8UEuId0PuVsNMBd36muSg7ABOrHHRbz3Ii
         qfnxeu2FlnRGoin44C4LrDq+zTZFY4lWiMetl0VlHmVnLZ6/du3WfkIk8OKO3ZwtBQNI
         G7Ng==
X-Gm-Message-State: AC+VfDxjU7A+J1h/6SmtYYYXbP6uUvaMVoBMaUU3g4qHOrRyWfitWyeh
	msVk+mjWRdEmhFlG8PvrPQ==
X-Google-Smtp-Source: ACHHUZ7tnTn6I+1ps2ZgDZC8ofov4RGJsgrWTvh4YtsB/sLJn0fJy9TX3h1SVTvlGPss/DKdNvvpEQ==
X-Received: by 2002:ac8:5c0c:0:b0:3f4:ecce:90ad with SMTP id i12-20020ac85c0c000000b003f4ecce90admr1229848qti.45.1684435529304;
        Thu, 18 May 2023 11:45:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.155.214])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b0074636e35405sm580150qkl.65.2023.05.18.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:45:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
References:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
Subject: Re: mptcp: fix active subflow finalization.: Tests Results
Message-ID: <f809f121-c949-a981-601d-aa57655fe7d2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 May 2023 18:45:28 +0000
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
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5157388886474752
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5157388886474752/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6283288793317376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6283288793317376/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_capable=
 selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4875913909764096
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4875913909764096/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6001813816606720
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6001813816606720/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/857e3bf32c8f


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
