Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62A160
	for <mptcp@lists.linux.dev>; Wed,  8 Feb 2023 23:09:20 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id d8so264628qvs.4
        for <mptcp@lists.linux.dev>; Wed, 08 Feb 2023 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zmm5ubqjWjPzZvA14iH0iShTy6dRjx297EsPYcHpg0g=;
        b=i1mccQcC0GlYbzNIXza6IlZUCjOPOhK1eLNwJiY+PJLIt+TWt2chF46aFkdcmcFvRw
         upeKo01uMyq9SF4CYnGoVEDNIAMiWxyMfDEhro1Ly97dWVNU0keIU7KPIE6tcXDwK/eA
         NMJfqllwp3oYQwFm6Uu4oGcmOw/GjPY9gL+u/RZXuXu1OUQhgOb+9toPzlhO8H+7uFJr
         ArrkxLn+Ocxu6ZE8yn0FIFepoChvNK/XIb5RyO4fJqKHYXErsrU29WGu39A0lWM4u85g
         Tem/EH//L4zMOOi6DphIR/VU71VFHyN7L+LgSu6zpbLufRekt1HJAoVuZGh44G2W2oyM
         NNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zmm5ubqjWjPzZvA14iH0iShTy6dRjx297EsPYcHpg0g=;
        b=3q7OgggJt8Ddqk1SimOx3Et5TdEW5/PqTq755TbWOJqH4erLgBfrDNCslgOrlJBV0V
         ynalNU9snBRfY4lsd5fz50+VTVcv4Ytu88Pm9Oz1nssaB68gSrqJEnBtb4vV+sTPwjrk
         QKewFMAj1LJ1uoaH6CDwjkopsZM/bzoY4wfCOg9CaxQcZnkT/LwWqcooLIxnoebHBLlp
         CXOwuTm5nQin5y71eAtiBdvumn7dO+bdWvY7fR0amQZRnH2UX1RLlVp6RGtBk7L4hLU+
         A4lU0e48U5wc90reRt1EMsNTDcdjx90517qQzE6gQrNF2c8bx0o1uISX7zRxpNDBnGox
         3ViA==
X-Gm-Message-State: AO0yUKWmuGCC8Y1//8fRJD3/cexpFYXEGvST9dLu7rAim/zjhuOm7Exs
	ptZGEcP8UfahHDMKfcQygQ==
X-Google-Smtp-Source: AK7set8q14cFDjHwfgjbPMCC814PQGILdaoBpkp2kK4JXjmwOG5Oz0bXsbmuqj0VTUtMx/WO4dMqfQ==
X-Received: by 2002:ad4:4ee9:0:b0:537:6902:cddb with SMTP id dv9-20020ad44ee9000000b005376902cddbmr17167162qvb.28.1675897759557;
        Wed, 08 Feb 2023 15:09:19 -0800 (PST)
Received: from [127.0.0.1] ([52.150.24.65])
        by smtp.gmail.com with ESMTPSA id e189-20020a3769c6000000b007062139ecb3sm89502qkc.95.2023.02.08.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:09:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e65dfb17e0aeed03dbbebc4ef4559fe3ca349354.1675892307.git.pabeni@redhat.com>
References:
 <e65dfb17e0aeed03dbbebc4ef4559fe3ca349354.1675892307.git.pabeni@redhat.com>
Subject: Re: mptcp: fix UaF in listener shutdown: Tests Results
Message-ID: <4f6600ef-ab75-43b2-8af2-c28f3ad2194b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Feb 2023 23:09:18 +0000
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
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4517118641700864
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4517118641700864/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts - Critical: 1 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5080068595122176
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5080068595122176/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6205968501964800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6205968501964800/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5643018548543488
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5643018548543488/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ae7c0cbcdb5b


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
