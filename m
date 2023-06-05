Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA311C9F
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 11:28:58 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33c1fb9f2ecso17723765ab.1
        for <mptcp@lists.linux.dev>; Mon, 05 Jun 2023 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685964538; x=1688556538;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zANL0vBMGpcTr+WjMOcxSOvM3ZuODM7Crm3IGXtCCmM=;
        b=gDhNhxV4tNb5+6IeqeGKyd2Rrs7PF7C+ufX+E8vmB37fiKDoYebcp77TTa9rOnC8AM
         erTUnozhOM8ssZm993Y7DNPkqo7fALrn0sdRzfASJKipalDKg11qRlHg+dUKpNCxqUnr
         3dS8fpan1izb1Gxxag59OfmW++fLm2b61Jyh9j20N4n4l7tqRWv6rL+XYDMaEvhcMPJu
         5SCJT3NIG51TGUG0KXj/F5PrCxc4pPzrT5LqVaOjKdGIUdKwCEBIlYJ2s+vKDAdFxvEK
         ULOrzk8l+uWGdBJhscciy3tN+isLZd811+7+UPPiqR/+B+YdzuREcpixQ1dPjpZkPnsj
         funQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964538; x=1688556538;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zANL0vBMGpcTr+WjMOcxSOvM3ZuODM7Crm3IGXtCCmM=;
        b=O5Pz7mulYtDum7ZPdnBE9b83wJiPh7XWKKqIFc5BwyXCmStwnHoNBl5lXJu/d+2WGM
         F/z5gLW3vezMu/uzgRhYLZadVpfAuCa+LAmYLApuOU67hCJxgo+lLjEL3QPsldI87+pK
         ImKbVKrYgYECnKVHYJQpsan4SplbAXCVQGg0m/27P/ORkB00MuvtLh5z1njvalhFuWsA
         JEXU9Ts7i1Tnhz/AJF2HbW8WzYN5WmhOh2aZGAiHmjUE/oNZaEeAtahwWNvA/xiqhTle
         U1oJe2ZdtXBU7JrLsdLGoEa6Y/ElieuCo5Q9CtviiIC7GfitgrgH/E9u+IT4HCfXIjPp
         eWeA==
X-Gm-Message-State: AC+VfDwCJoakplS0FmfnXF2P6gQDJcvB3oTrbu+LayC0G/suxk3+OYWI
	ccExt6Hh7Dl5oZawvAxxrA==
X-Google-Smtp-Source: ACHHUZ4HcXfEFPJUA4Prz7s+HWVKy1dj3SR5SPKI+xYTVjS/B/DyuZo377+JKb1tLEeu0hNLJi5C0Q==
X-Received: by 2002:a92:b07:0:b0:33d:1223:cd70 with SMTP id b7-20020a920b07000000b0033d1223cd70mr10858262ilf.4.1685964537665;
        Mon, 05 Jun 2023 04:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.65.48])
        by smtp.gmail.com with ESMTPSA id s25-20020a02c519000000b0041d7ad74b36sm769086jam.17.2023.06.05.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:28:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cc7e5e740b2f42bd69ad219190c221cf62fb83ba.1685959315.git.geliang.tang@suse.com>
References:
 <cc7e5e740b2f42bd69ad219190c221cf62fb83ba.1685959315.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_burst test: Tests Results
Message-ID: <f945269f-9709-b4a7-1e34-9bf0e26a6135@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Jun 2023 11:28:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5686075100758016
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5686075100758016/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_fastopen =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6249025054179328
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6249025054179328/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4841650170626048
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4841650170626048/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5123125147336704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5123125147336704/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/03eb102a4f4b


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
