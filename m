Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD38AD29
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:50:19 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so19787114otb.0
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680803419; x=1683395419;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz8q0TivxggDttTmLTPYD2eDYNiKJghpR3Mk9u29AXQ=;
        b=KXwskJ65ohgQoi7d5MaFWatIGpSfn3pswO30q/4mHxsVCdagK4bBxFp612T/4UMEH3
         nJMD11mTYU5Bz2/b6dqHuao6aLL9ajJB0gQvpEBJTq2AYjzHnAE3edvNJSgkopwckWZf
         ZRd9iLWR5Ui2vAoCszCGDDNoKU/bzs5lGxcTEyCKmsDbw60OYDGg5YubJryBVqwpXV62
         CsVTjRv/SsRpxLn0wtqjSftDdu1+C+/w4f7E3QAAdCjCa86vXIcrqe5fxT2E9+S4OB21
         JjMHMWXIH/W792UFuJt3+cecbd/cP+oao5dTmAsUgmSUlOhZ9K5iJEDFJNBvAHXQmCft
         Llqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803419; x=1683395419;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vz8q0TivxggDttTmLTPYD2eDYNiKJghpR3Mk9u29AXQ=;
        b=PPQe6mOjpSubwhJELHihypVeP8xa3/pBzvRcvzL/kmxO/KnxGi3MTkCbF8CFVirnbU
         ExUeWWhVrcfae/rGGO/2w8CO9M4BwjJCiuxvGWWK2g0N/Te9KNa4r9tcrbrn+PK4Jb4M
         UNxaT2Inq00JJjN9QMXuOEJZtwG5zMcFLWuwI1LIoWuppS28+vUcOjZkRr7tOzId+eFc
         s4Cjei5RbAwrSknuA4e0raf3qvxLAtpPXK7IGL2ZoB8k/BcnoI/kWh8pzMlYkyuP7Qco
         MDfUN8UGGqOatCnlpm+fJezj6CJX/P9pLPZIjfKObHtv8tvrmtoAJPeT3PANTU5+s8yI
         hfFA==
X-Gm-Message-State: AAQBX9d8iGV017M/b9j0rd9Nw9ngvEBOy4fqaJJq5466fhGw1r+QCp79
	XmegQVlC/JlLtWb/6HJfNw==
X-Google-Smtp-Source: AKy350YXs/SFVWCsEPTMdD9HC0aJOcZmKqxGmWQq7K9dg9wvQT/8Jk1Q3+bX5FNLo3bzaCASqSWYrg==
X-Received: by 2002:a9d:62cb:0:b0:6a1:4364:d624 with SMTP id z11-20020a9d62cb000000b006a14364d624mr4493982otk.37.1680803418694;
        Thu, 06 Apr 2023 10:50:18 -0700 (PDT)
Received: from [127.0.0.1] ([104.44.128.247])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d6c59000000b0069f95707335sm903322otq.69.2023.04.06.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 10:50:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230406165705.3161734-1-leitao@debian.org>
References: <20230406165705.3161734-1-leitao@debian.org>
Subject: Re: io_uring: Pass whole sqe to commands: Tests Results
Message-ID: <bb9ee45b-2e68-1ca3-f638-615f8c0ed9bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Apr 2023 17:50:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6625829522767872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6625829522767872/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5711035848458240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5711035848458240/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4585135941615616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4585135941615616/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5148085895036928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5148085895036928/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/035a67e200f0


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
