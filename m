Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3226FC5
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 20:11:49 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id r16so10363841qtx.9
        for <mptcp@lists.linux.dev>; Mon, 06 Mar 2023 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678133508;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nnb9ICaqVNeGH6yWgpwnxP63EUXIM/0x1+GEy5lZdo=;
        b=ejCIJN235awDVAfNqVwpdvDSMmCIwRCMyS11c0l+ABSxgLY1qvGmuUDITSTZDbPNbM
         MrnY8Pc1ujm7R3F0YKU7w3qwFxv5y1lZI8jS062L4Qogw674F8oZugVoSFvyU1maSE4Y
         TmgyZthc0wJ2UNU4pfkBDlnhqVLiNUdPrq4AJfE7sS0lY6k/b19QDS1SqPwncq3VCIo7
         BBBq6pWrocakelrsONroNAJVwdIMyGt5knwIxR/pXhmRQklKQCdg4qhljI969tTlzoow
         hG+ZjWP4QqYmR3HUA8j6U2Zn6RPjSIH8UJhGFeuMWhJrHpuILRLrhBCUhKHN3BVIm6dK
         JXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678133508;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nnb9ICaqVNeGH6yWgpwnxP63EUXIM/0x1+GEy5lZdo=;
        b=ZwC7qfvIEGqql1hT2TWjZk0ZF+FxBzC0MhXEXIAmTuEp542xyUWJempmlSEUEC1V4R
         7ZnyiKvWkX3uWUOx1iH3dje3XtqPtEBzyEDLdNKoTiBZeFVb+4Q4yBUKyzkyTfjVOBAe
         oz5hvC7T3JZzY/Fk/TFlSLNj4htasViR8AasE2rbfSjI5/+LeRE1DXmiDgCOzY61l/rg
         7AsMtRHsZKcR+hoKSaAR1+KK3kHTQCBI3s18YTGx5SIxdWsJtOYEyvjSXFwkpDgfzSII
         QWdHE7cUsAaBzuwvAiav3Mq4Mg60NvYCNGY5S+dqF5dcu+dIHlt5Ia4SigZ8zT4vRcGr
         8CmQ==
X-Gm-Message-State: AO0yUKVaWXIEM/GZemmZZ6O7/VVE92LHcOVjLQxOJUC0WjYd/9k3VSmU
	5/KPIulFGNGqAvjMyL6TLTi5WDdtcQ==
X-Google-Smtp-Source: AK7set8+i7HjWnptZpQduf+3Pkj8SEbPJaYxNv5k7XM3hXmzHhYsKWAMQUI4/36BcscELSRjOWyk5w==
X-Received: by 2002:ac8:5c4a:0:b0:3bf:b950:f684 with SMTP id j10-20020ac85c4a000000b003bfb950f684mr22032488qtj.53.1678133508508;
        Mon, 06 Mar 2023 12:11:48 -0800 (PST)
Received: from [127.0.0.1] ([172.177.233.50])
        by smtp.gmail.com with ESMTPSA id t193-20020a37aaca000000b007424239e4casm8046870qke.117.2023.03.06.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 12:11:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ec8a2809ee4556d8b28efaef2aec26ce1a23ef4b.1678122760.git.pabeni@redhat.com>
References:
 <ec8a2809ee4556d8b28efaef2aec26ce1a23ef4b.1678122760.git.pabeni@redhat.com>
Subject: Re: mptcp: simplify subflow_syn_recv_sock(): Tests Results
Message-ID: <4c7b7200-8ad1-815d-fa19-e99d6efd94f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Mar 2023 20:11:47 +0000
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
com/task/6711639714562048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6711639714562048/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4565393017143296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4565393017143296/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5194737863360512
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5194737863360512/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5691292923985920
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5691292923985920/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8dce9f2e2a70


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
