Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D91876
	for <mptcp@lists.linux.dev>; Sun,  9 Oct 2022 17:24:33 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id r18so8574316pgr.12
        for <mptcp@lists.linux.dev>; Sun, 09 Oct 2022 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE3H59KzGOOkkxT2hH48nHZfTo6ZKYb/gHrkhkw2a90=;
        b=PvoBi7fm6gX0pwcQzin/EN7vpO1L5OEEGzxbE1lI9C6LwfvHTGeH+D3TuJnuW1/3x8
         VsGW/3L8TQrB+8z68tjjz98fulfd4w69emrN+AcU8brhAjIumEVICiak9Wo+MmoXS0jD
         DTgOMHrPLY2xboSWMANlvq1YZv2jQnKFZBGC/pVjD60RbYxEH3YECIA+kM0EhcPZ1GR0
         kqY0t5VKdzfoX0Kc94eLIemnsMCtXaKDUylbLzYM46WGwAlPmeZAC1/3sQfEoXOvExjU
         fTcuiAfu84pwoxSPFtpr7yRGD1ofTCxzDJAcIJ7MHPx8GLxwFq6WJYh4ToCjUGzWDvSK
         pe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QE3H59KzGOOkkxT2hH48nHZfTo6ZKYb/gHrkhkw2a90=;
        b=Uwro2gAczruzzX7HyzsqsImT4UWwlCnaSTdh2U7IJHDggmYdkBHjtTRArjvIrP1OdP
         gXKH5NhYF4A8wbXhuWW+5Outvf/Cd0Ez02Wo/Nkdjre5hnSWv9R43dGe/c2YeWJu063o
         qtg9wBOZfNvboNrIuM4nub2+esrweuYk/U/jfCrjZGTiTjQRaOboW/d4K4pNIqH6lsCV
         l2DQtf2K48/I/G/1odmsMnFIg9I1QuxJx326Y/joUvXp/sAwnUtTOaTjnDfGqrtXvE/O
         hNUJ0/IhA4LpGtyeeb3ds67pNSEIimxnSOfC51GUtgPfJtJcsRkeDh8Lbae9YCVQXHBW
         sUhg==
X-Gm-Message-State: ACrzQf1sGT/9boRUePT0zcfa14SqHMeeiW7bDuS+hewg6tUGmeo/7V+M
	2LjXCYVWNqunhDgFJ5H3JtrRlu/2yA==
X-Google-Smtp-Source: AMsMyM5bUji/YBOaSkNCOVEpNuAlUeZrZZocVQ/1c/bjey/WiNb36CWCNOwvmqTyJLwcdZyrZ1o/0A==
X-Received: by 2002:a63:8bc8:0:b0:461:ff70:7546 with SMTP id j191-20020a638bc8000000b00461ff707546mr2293266pge.70.1665336272949;
        Sun, 09 Oct 2022 10:24:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.196.69])
        by smtp.gmail.com with ESMTPSA id q13-20020a63504d000000b0042fe1914e26sm4909377pgl.37.2022.10.09.10.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 10:24:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221009154531.11543-1-geliang.tang@suse.com>
References: <20221009154531.11543-1-geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Tests_Results?=
Message-ID: <e5c4cb5d-6d6c-d297-cf87-1317dd621d47@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Oct 2022 17:24:31 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6426348104187904
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6426348104187904/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5018973220634624
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5018973220634624/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/76b10c873f3d


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
