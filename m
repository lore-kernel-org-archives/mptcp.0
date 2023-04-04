Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925D28F3
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 17:12:13 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id ja10so31953781plb.5
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680628333;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu8Chv+kbITs+cT4VM0H7VBkAQ5Otc5ZnieSP/XwoA8=;
        b=MzEObXm3cRZFE8yKaO4bdfsjAohAfmOuWh6Bb7eHgy2swytrCpEJPM0zN3OGXZPMG/
         ZrOuwuYXMECMRfF/LFe8U92Yb5xevwt2nY/8uasNwKQ5UeQUauBBsOvR75APnu9eFpTb
         5RibE+GTe5B7tvPGCw6OEbH3MuI/FifdLM+GRP2cgWClFdBa2foToYTrLc4lqj7IKUvf
         YCDdCZM5tzB7B/QPn9ABRfjiaBTe7XYeGBRy3zozXsfdk9Y0hmvbC140yxzgcFR0c0X7
         zB4SV5qhBrfRAMIHCI/L4unaEr/SAUSsT7dgEeMV+rabFyKq1WZf5xYMpOcYI0C17WjB
         +PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628333;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tu8Chv+kbITs+cT4VM0H7VBkAQ5Otc5ZnieSP/XwoA8=;
        b=ktA4hFU1xZ+jPemVrjL9gdskPk269/j0W0o87SGQhNVYktEQ9viUGrInNBv99toqty
         KDFUnuh+g1vqJU+wh9ulOy0QH6vAJCySwIL5RrSlBTmwAoaEFrFOVtvJMOll8BT1DIMl
         hdI5Ex9qf0FH/3orK61tTHuyQlTlTRblbjvk8Wvdv+O2KFfVXdEgTT68XYW/nlldmb+6
         TewiXAkbYAaU9fEJYIRw1JASocSwh7hJU4btjKzP1BNdDHI1Lj6Ie1Inb2xm88zXWdaR
         J1x+prg958gaxvp8EIpG+f1OSs61pl6sA394y2/hWLFKBhZc1fvkewBVesan4oPGJ9ck
         bjuw==
X-Gm-Message-State: AAQBX9c0G5JadqkdNHhASD7vQa7ABuR4f+ZLDp3w49J7bLTJ53IQGM2K
	xcKgGqtc1afFMSUHiknMAu+8UX/ncaIp
X-Google-Smtp-Source: AKy350Yr5g9mUL/jSuHeq00NxWzQR2IqQ0kHVH604iYkC71hZMlHtaSXx/TRnaQzzETVbzJ+yrXWIw==
X-Received: by 2002:a17:903:1389:b0:1a1:c792:8e73 with SMTP id jx9-20020a170903138900b001a1c7928e73mr2941136plb.60.1680628332804;
        Tue, 04 Apr 2023 10:12:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.11.215])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902934500b001994fc55998sm8568475plp.217.2023.04.04.10.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:12:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230404-mptcp-selftests-join-busybox-shellcheck-v2-2-9113fa4d2ce2@tessares.net>
References:
 <20230404-mptcp-selftests-join-busybox-shellcheck-v2-2-9113fa4d2ce2@tessares.net>
Subject: Re: selftests: mptcp: join: fix ShellCheck warnings: Tests Results
Message-ID: <07bd27de-1256-57cf-f84a-79b310253fd6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Apr 2023 17:12:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4580960226770944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4580960226770944/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5706860133613568
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5706860133613568/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5143910180192256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5143910180192256/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6269810087034880
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6269810087034880/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/24b94f9b39c0


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
