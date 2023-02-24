Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A77C
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 08:14:18 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id r4so4180941ila.2
        for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP1HMHCM2Hz0zSgBr5+hY7VPqX08ufdrop9K3oUxnIY=;
        b=nrDgsRTR+/KxSfGUcZqF28tXtXklQVPiw7yt6CQFAe8HQtbMEbzJ6pZNJC2xmS3tOg
         DULx1Kyi1QCJimW0/56ob5489vZs+9x2NO35w4B2CD5oWngLo9RoBPOBRTM4bOB/MDmr
         LP+f1TVCT4iUhJY1mhtgAuuqbySYKJNE8U22fDUhSv8ZMKRl0WTRsIhgFnHUM+8EAkOA
         UN8te09YTHcj54YkFwCN6oPj+WBgObbBm+N9woKW6dUwrxVxVlr0z3iTv3BuSaXDyASQ
         mLWdqhmE/u47p2KTKXnY40WX1QpfTrF0yyndTRwh4oT8gBWqD8yioi3dnP/fHIVwmm0x
         aSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP1HMHCM2Hz0zSgBr5+hY7VPqX08ufdrop9K3oUxnIY=;
        b=I9YMj0tqzOgZOs1vDXT3sC5rL1mXF2dOKLCM/u6okIonX6kURv83gECCNcRJxtIFO3
         42TDv4JIFNrtrq+TeIPc10/m8J/wtipLqQRU/tv2JifOLMxSPHYR6Zzt9gUN83Iw4KsA
         6UR+n5LORAr2msHp5u4P+gQOMfzD0/vAtZGb7sahE7XODQgwc85njDX6OPcVruAgqygE
         uGzkiTQi0Q5wfhveZchiPTPPFW1NfQ/65NOe2WzQZeGlvUTFoND98rC9SP71lSgCUENa
         uJdAmij3Qzs8uZG8G5gcDUicSoPJ4rquE2n/c0Ov3zO3RT/FTsnQborOdunNNTGG8NaB
         KyeQ==
X-Gm-Message-State: AO0yUKUH7yvBaXbisyQk116hR85477CYfYe/SSaKd5SnQ/Wa5dQAbw9Z
	BmI7DASmmKXgl1J+dJ924g==
X-Google-Smtp-Source: AK7set/qtRd4rrq8oIYlGfW6axjagbDKk4MpU/on5nfj7NsT4dM6LoK8yVbm4B/QDfxJcwgMwLXGNQ==
X-Received: by 2002:a92:444e:0:b0:315:cefa:f75e with SMTP id a14-20020a92444e000000b00315cefaf75emr11040713ilm.27.1677226457585;
        Fri, 24 Feb 2023 00:14:17 -0800 (PST)
Received: from [127.0.0.1] ([13.86.66.34])
        by smtp.gmail.com with ESMTPSA id l7-20020a92d8c7000000b0031595ea003asm3276118ilo.85.2023.02.24.00.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 00:14:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230224061343.506571-3-liuhangbin@gmail.com>
References: <20230224061343.506571-3-liuhangbin@gmail.com>
Subject: Re: selftests/bpf: run mptcp in a dedicated netns: Tests Results
Message-ID: <c211d234-414a-65f2-95e6-50af0080573c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2023 08:14:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6389903999631360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6389903999631360/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6108429022920704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6108429022920704/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4982529116078080
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4982529116078080/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5545479069499392
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5545479069499392/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a2ffc9d05e68


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
