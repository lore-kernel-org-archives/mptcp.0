Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C2C8E5
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 18:35:47 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-78caeb69125so2656297241.3
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688582146; x=1691174146;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sev/xKPftxHj2PkM138dvD0vshoD8gZhA+H15NWarbk=;
        b=l/jsa2ZMZpXO8c3enn/YD8fqd5scJbxieFZgtTgxc7n/do/WZHb2IGFSEAodpy/f2r
         2SiEYaGjPXnLWQ3ckgkRDNpfwgW1Bi5BLYGlTjmD7EGXvg81k2sbldZRR8ye9hNWGsKN
         S79icKBYOmDXSN3OlXWyoT3iVDsnZ4SYt6D1dvoWsTpvfExgpYM3uZOBCTQDACUOVSmU
         IyGfNG9SciVXaySfZH8IRzYClWYkIIEiqXx8++R0+SGBDbViPw/dtoH3qcLZq+nS/qBx
         I3QjeERx/ZRC/Vp5DEItQqDO00QKsHkfYZO5hAIYkd/gSbFDTO/Qj6UGYE42oA9DMejq
         6QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688582146; x=1691174146;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sev/xKPftxHj2PkM138dvD0vshoD8gZhA+H15NWarbk=;
        b=XxEncoNPN1P/x5mBAi38oKhNooRrf9TSjjP6JQhKS6aSxvYJalinD2SqioE1YlmMAu
         g/tTUSvQVFun+rdO/1HJMcBCBz6LUh7mwcfn1rJDQm4/knDOAVWk9ByzaKaIOCwwUMdv
         e+M/JyV0o8b85miUNhxCU2hWVoG22BOpYZQbs5PKrCoAefqV2HdAEQbpvl80sEIqg5y3
         VJLJM9dSkftdfKO3BRBiDbSbb4/Oi1o7gnmBMXb4jg3RDa0iTaFZ0pnMGMg7l9BMSwDO
         T3R3ncAssOt/pJ/BSeDhPnIjDw+2SASdH3fGceUJqgg5RwlbcDTsb0KZz21VZf2UZ88g
         nOeA==
X-Gm-Message-State: ABy/qLYh85JylOATHm78irLTD12Tl8Y9ZiSiJrqjK4cDfbgMTpuiFDF5
	rKiv2AhWXE2aYVNxk3wK7VJwoDc1C7XH
X-Google-Smtp-Source: APBJJlFU7fFQnn2Fj1CrOb9qHycK/TCYklH+MEFsqOKAxGo/07eeVF4v8WFZOH9QhrSWqOv/3wSV0A==
X-Received: by 2002:a05:6102:3bd0:b0:443:707c:e656 with SMTP id a16-20020a0561023bd000b00443707ce656mr8448991vsv.25.1688582146087;
        Wed, 05 Jul 2023 11:35:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.158.16])
        by smtp.gmail.com with ESMTPSA id m5-20020a0ce8c5000000b00623813aa1d5sm6079249qvo.89.2023.07.05.11.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 11:35:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-2-40bcff40cb6b@tessares.net>
References:
 <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-2-40bcff40cb6b@tessares.net>
Subject: Re: selftests: mptcp: userspace_pm: unmute unexpected errors:
 Tests Results
Message-ID: <6b37a978-ddd2-12e1-dff8-abd24c7cf27a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Jul 2023 18:35:45 +0000
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
com/task/5548960819970048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5548960819970048/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6674860726812672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6674860726812672/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4634167145660416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4634167145660416/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5760067052503040
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5760067052503040/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3b8b559fa9a2


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
