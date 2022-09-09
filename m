Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC434C62
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 17:21:35 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id g14so1780249qto.11
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=lKLkd3BZGncRXVlfKHqZ9Bz6Lxpqdb618Pw/UotoZDU=;
        b=qthh8z+fkq9H5xoTGappQ57ze0sMSHSNYArvqyFZrmF613izd2BFGeNpj34/pGl21m
         bSRt3ITWOaB6DQ21yGgOTIShN8k1UGGFcfXLXjj/P1Zlgj1FPepYmgmfrCRvwg5VV/nu
         2l4uGMq4IXFNHSUgmuqOw8WeRW4TFSIUJXHyotOffLLibtq4dEom1zWoiKNku5e5fyOC
         L1t5P+XzmTXdenUBPJ0a0CLnniFfx5NbG/kQtcf9sFFrQPlrmSq4b7jnwyRvhmqt9tua
         hxRSMiIC2wTVGedhMi1tXbS/aZhHJx569PyYKh7OXxfC17CkZfIBGWjO8gwpKvnQT6iO
         Q0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=lKLkd3BZGncRXVlfKHqZ9Bz6Lxpqdb618Pw/UotoZDU=;
        b=PdQ/Ohu5oYdZVHZXf5Ix+hxrYmelG/qEvrtT+ldtURYZJ5YFYcMAGGNHGehCIHm4VN
         RXgi+kCkzvQACxGuOhokCOjWZ42oCrxLbtQE8KJSeaa929iflynMtmwzM1zEU108Y4Tl
         4u2t6fznL7XVT5sp1j1lFpfnpEZtjBDtMldKSTiq6J+2eSvMn9+S3H+U5vvAJ5s3CAob
         7P85DR452wWYfWWSY1TgFPmFeOffwp74BRr4uzye+WzMG+oRNhJPkoNyiNAQ7vugEMCH
         sVONRsFZGKlUMarWhH3GtnHqzMua1JvlRnr+GwB3KU16PnbCNInkNg4P59otIx5bvmBy
         Qa2g==
X-Gm-Message-State: ACgBeo3P0NsMu+1BKJkFDWoLYHSKJ/JI27NyDV6RL/eh4KTSQ65bbcHq
	3OPjKXzshPBo4+l96wu8YQ==
X-Google-Smtp-Source: AA6agR4KmZ1Wc13h+QzcBNMflbZ5gX6sUXQtgjrv2PeoeliJ4eDas14T4j4sw8EKTCTwlLaZyDQqKA==
X-Received: by 2002:a05:622a:1907:b0:35b:a085:691e with SMTP id w7-20020a05622a190700b0035ba085691emr3169876qtc.65.1662744094475;
        Fri, 09 Sep 2022 10:21:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.25.219])
        by smtp.gmail.com with ESMTPSA id cj5-20020a05622a258500b00344883d3ef8sm751546qtb.84.2022.09.09.10.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:21:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
References:
 <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: update and extend fastclose test-cases:
 Tests Results
Message-ID: <216e1bc7-5222-b203-22b8-2b688ab3edd1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Sep 2022 17:21:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr packetdrill_dss packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6641808041050112
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6641808041050112/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 4 failed test(s):=
 packetdrill_add_addr packetdrill_dss packetdrill_mp_join =
packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5448921920045056
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5448921920045056/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/08b11cf56895


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
