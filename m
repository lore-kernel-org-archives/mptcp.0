Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336FAD5C
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 22:17:42 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-79834a7a5d8so10375739f.3
        for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694643461; x=1695248261; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBqZYsOHoaKN1Wn6eFpXKQ/6rYyhbK1kkk3QHiUFQ4s=;
        b=bPppIC28mO3MnlC6NIRj4UmTCjeU2QJlYJR1irIfqZqPxrJeq5m3KgfTqPSEbv+Dxv
         R5aVPm17tw0mRtyr09sI5sQnq40LzCPKFcIY4R/ogP7BBgJ+KDndTBwQKXk1PKhK0gS9
         IkfH9k7l53J58waL61QeR6iB/6+AD7bfe91eVqKImTvr6VM1EQYczSdlvcy9WrD7wcmU
         0oEF3RLO4gaPEKF8Wt2SwSQI/0u+45g9e9uZTp3n+LUC1Boflp/Pv8dzci658GEHi+Gb
         EpXSCTxdM+Rn/03U+Ot1bDQX7amofsGStddCndiQgoKzD35nAAG4nU/ypJnXHEl9T6h8
         1YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643461; x=1695248261;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBqZYsOHoaKN1Wn6eFpXKQ/6rYyhbK1kkk3QHiUFQ4s=;
        b=k7thJTx8YP0/7ytcx61DETwhosWPQHoiVNxj/77tJXrlGtQn9UVcN0Y+qiXFUv0nm3
         PskefL4RKjoE0sO44iC74UcUVFDe6+xEfyvqK2PigdZ/yFi+anF4RXJc9N0lx+3vyTsN
         ATwy374Pv1av1Tgg5lNOifpuaVkkE4dLGOR8VYFH9ECuIAqB+82X0r8yxYJ5e2ZBu+0k
         1iX7aM+9nTcsNeeThC4oiMxZVLBdtngyd8f8dZCDx07radSfDkPbRsf2zqrlt8oakjCA
         ewysspmJtHbkUTXibAGRxXKoDeRszERqfxJe2R/QkzNzCWgv7GCNzpfPoOkpHw4sooBc
         Aisg==
X-Gm-Message-State: AOJu0Yy7IWXrHU+nGACBfYbzwVRRBUMjo3QV+2LOn5Miv8Fve8R0VHCc
	3u2vmiRxTegu1ln8IN6oiA==
X-Google-Smtp-Source: AGHT+IEN+1WjSOX3bhb6G2WT9m31tFoK2iWXVhU8D80Bxh3bkjdd1co+iKq5/fWAk6Prq9szN6QeBw==
X-Received: by 2002:a05:6602:184f:b0:791:2896:8db7 with SMTP id d15-20020a056602184f00b0079128968db7mr4725638ioi.6.1694643461601;
        Wed, 13 Sep 2023 15:17:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.86.18.87])
        by smtp.gmail.com with ESMTPSA id s14-20020a5eaa0e000000b007925328d6ddsm61132ioe.20.2023.09.13.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:17:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a05184fa538535641415747b2d6bb83b5a772021.1694638162.git.pabeni@redhat.com>
References:
 <a05184fa538535641415747b2d6bb83b5a772021.1694638162.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor sndbuf auto-tuning.: Tests Results
Message-ID: <6d621555-b542-3bd1-1c22-2c55d74460bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2023 22:17:40 +0000
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
com/task/4811340401868800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4811340401868800/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen =
packetdrill_regressions packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5374290355290112
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5374290355290112/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5937240308711424
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5937240308711424/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6500190262132736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6500190262132736/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fbf3ee142d55


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
