Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00802361
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 04:41:16 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-75ebccc2c9bso156149785a.2
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686717675; x=1689309675;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCzCPoPOFf2+URql/LY/CZuYx35xwQ/1jdjlHWAm1mQ=;
        b=Zc1U7SUOxe+Y1GwqCiFESEP9lVbyZwsdSQlSr8LD6Fi9hJfKwBcWvPbNHgGiv0dx2D
         m0WdiPByWfhDOckRxxv3NrDAOZnP8T8g4PsF0Mxf0ES1NB6Efd+vJTQIseerILuzKdFh
         KMbAKT4TOwr2pYlqce11c58oaM9iudlZ4kOjh4F0HjAhd5FNjHARYLCH00UFwvgJHgnS
         EnpXISkpD9k3nyG/5GYQYonUn3xetKS5SN4DcjF24xqRz2LuvX5hJa0cJxENayMFBpTK
         HICCqVJHrtGsDmv8JHBQDf8PGv7BiMrmqhKxAORAoTeedc2qy/8tuIKt0JR9fbShim8+
         BxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686717675; x=1689309675;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCzCPoPOFf2+URql/LY/CZuYx35xwQ/1jdjlHWAm1mQ=;
        b=KSsev/IcVCrasdQ6dkuaja3lBQCceo5oDxYbnU2c3fnLuYtSF1sodqvBAs5gvioVZs
         y+dRIynZBq0duuz5kdw/vC3tdvHtPIjQX1tZYwlMFs+tjab0xErVBoIP7nrg8G7jPbr4
         jObjQg+em+Utfa5IhbCN/A5HnAgexDv5WCWHQgpqcRiTjO05pdqY2iVbN5mzGvNb1C5b
         3PZJF59aGvDBMA8JCGMrhGM4QNBY9qaAzG23WAKndHzgitJk0cWu4ZIEU+lGvX0PK91F
         6FVUQysG4GBaXzEuCIvqPr6qFDVJ9Z19/bIlr12fi4n84/z6o6DUet0+Dnx6qLwRz/Xi
         ngBA==
X-Gm-Message-State: AC+VfDzPWPz6/sA0Q12efglQg9ufw3eGdBsPp96dwAhgrm8VLAPAoubw
	4RFFzvOXBA4O3WzFWuqJxvCTz0Sp1I1B
X-Google-Smtp-Source: ACHHUZ6Bl9gt4+hfO5JQCmXekUgJ/NriKomTC4EzPBCZQdjaBCbnGThIUj2ELteQVtdNHQfvs0ktwA==
X-Received: by 2002:a05:620a:8808:b0:762:418:8bc2 with SMTP id qj8-20020a05620a880800b0076204188bc2mr1069660qkn.36.1686717675661;
        Tue, 13 Jun 2023 21:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.213.95])
        by smtp.gmail.com with ESMTPSA id i2-20020a05620a074200b0075f2c1afb7fsm2683241qki.57.2023.06.13.21.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:41:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116.git.geliang.tang@suse.com>
References:
 <bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <11f11ac1-c33d-0dfb-e925-61be3e1afd34@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2023 04:41:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4937696309673984
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4937696309673984/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5500646263095296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5500646263095296/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6626546169937920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6626546169937920/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6063596216516608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6063596216516608/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/45a9e0e26856


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
