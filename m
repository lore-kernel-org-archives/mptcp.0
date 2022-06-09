Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ACA7C
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 01:25:31 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 63so1204520qva.10
        for <mptcp@lists.linux.dev>; Wed, 08 Jun 2022 18:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=KnIwZJvB+G2YkJreWdBQbKnAiWWWqm5afucx9kGgCyA=;
        b=LVFa/jMiA88S+YGxI/1jg9760aEVBjJ1wqnXfVhVPpLfkqxVlpNqgYnNSdCTex8T9p
         lrqVqGTT3fwcVwvn5XW7eU4lI53fVz7JOt55ZebN3k3Uojsu20Wfceb63uVVvUu6YJT4
         Y2lf6bbD6pBBTx3xmScKEOoC6DfLFHHAPAeX1F3ayCrxOapiYBLlpBDfl/xUkzYLZgAj
         QVRcMo1b46Zc9OIRZK4ugNIQKZSQC23pXYOlX8wIxKjea4Y7q5SVC6eIpcLSYMXvMgfX
         oKSHLgw+h6vcHOyD1ejpZU0sNUZdSRAsMjLoxwAslkY25Vl7REY36V3dRIvNxenMgEIm
         3pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=KnIwZJvB+G2YkJreWdBQbKnAiWWWqm5afucx9kGgCyA=;
        b=sQAbvr67goJUu5N8YwpQ/v/CpW240XVfzf6oTEuhLyM6ZADE9WYnhA1s/drcaQA53+
         /XuNFYslN2UMK/Tl7f8TOERytDkmsvm4cm4PXbpQ2nTvNDTbYKv1BsZX5qxjVnT/171D
         dNNgM5RDmwV+g9V9mlg24vooDin6rZQHXZhXn7GuRqbxBLOok7tZvaUFOP5QFf4Ej/uy
         lmOxZB3JMUSNJB5qUWfhY4q6LZKLwfo3mwJ2m2WqC+XWZUmyEMY7HpPpCVPDdmQfqntJ
         e97VjHxKrssPSiF2qZrIfRsexpYlRTYI1/B9FnBejDVaS9kdV9QY6wa9sRqYH+ZlLEHU
         efmw==
X-Gm-Message-State: AOAM532n/Lp2/FGojbXzf9HAav2CCSXtdT8vPuJBxEzLyIZhP+AA+xR2
	RnxeGUnbGvJ5Rx2svn/35g==
X-Google-Smtp-Source: ABdhPJy7jZpaa8YReOIjwUstwv+s0VtLJ34jAx17712vM0DH4lQAqC+/9gE44Uw1q6n/gN265WSg+A==
X-Received: by 2002:a05:6214:2a89:b0:464:b97d:b686 with SMTP id jr9-20020a0562142a8900b00464b97db686mr30593961qvb.65.1654737930041;
        Wed, 08 Jun 2022 18:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.32.36])
        by smtp.gmail.com with ESMTPSA id t14-20020ac8760e000000b00304e2e4bf1esm10961234qtq.88.2022.06.08.18.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 18:25:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <005b6c1dda2ecb334cc9f6b07053aa59b69b5613.1654732564.git.geliang.tang@suse.com>
References:
 <005b6c1dda2ecb334cc9f6b07053aa59b69b5613.1654732564.git.geliang.tang@suse.com>
Subject: Re: mptcp: trace MP_FAIL subflow in mptcp_sock: Tests Results
Message-ID: <fd3f02c1-1d2c-36ef-0b96-3640411eaed8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jun 2022 01:25:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5388166994591744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5388166994591744/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6514066901434368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6514066901434368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1da22c975795


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
