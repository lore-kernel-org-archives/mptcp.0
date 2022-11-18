Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E2EBE0
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 23:54:55 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id z6so4181417qtv.5
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 15:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFeBTmaBG8AU5D0UYmiYD/5t/DIVxDZIY43g8KGzbh8=;
        b=VOKmIMZ7rog4TD9m8tRx2fjfPqa6E1lWzLonJpNK/x4Jjt41JEHDPAV6EjFQNzekC2
         zhimcF+q4inThsLMq4+Zauu4nRwS18837p30IUwi20gCD2/rZtwThTEn/HxZ+Ob0GwzW
         BA/zycXGAT6Jrm61VQb04bCiOnZUIz53Rw1mVXesEN7HZDvswMJyP0U01XhVSOdDpSys
         bHMJ0x27tl4/KZK9YOwxPKd4HXcyVfaSUIHR9khyEzA8ODJIcDo47WY1+2wfypZhCYVL
         lMD8M6FxholwZRXcJoDCh02ALwI6pBUkX7OhidEWDos4TFqJ+tSSXViCFhe1BmJIHoO4
         KeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFeBTmaBG8AU5D0UYmiYD/5t/DIVxDZIY43g8KGzbh8=;
        b=rM4IdVW1bsgvBVzIKgReRDbYZSNrrwnLV7d2xdbh0bb+cWSzGnZTDz5lcuA/ARQSWI
         Xet7UcieSj5YYKUVNeIq4ItLuYKGUlxz4eARkntphapOA+BHL1LE5y959wHZTDrPidnE
         z3OdYRRZBwwF/zDEw9k28G6t0b+QSWu2VkDmLMbjKlKpyIP0jieUtfL2x3vXuwABVEEi
         Ek9YnXf9hS7wdYa1HYQkDDr+jRYi9Gvk1th553ussepdCLA1u/QI5RMB0uDx68Uwuap1
         NOpsfdKR8SYIBd50gjdMZwpqOwMFdo8NjC8IdLDi3y6iVTfWhbIdv6Nv8y8nKYkNJMtV
         kN1Q==
X-Gm-Message-State: ANoB5pnJIGktssLQKSnTTUowxor/A70zF33oJrf4zPti/DK8FlmaHvKs
	miFTSkNLOsZV2LtofhmAexC3TfD9WEfr
X-Google-Smtp-Source: AA0mqf6Ib/OSpyPi0n0u8zCYpbGbaK+TrwbxDNMU6/kdbAr++b3pYbkxl1J8n+SFZfjLv8vuYuMuQQ==
X-Received: by 2002:a05:622a:1e0c:b0:3a5:9022:f466 with SMTP id br12-20020a05622a1e0c00b003a59022f466mr8935398qtb.110.1668815694813;
        Fri, 18 Nov 2022 15:54:54 -0800 (PST)
Received: from [127.0.0.1] ([20.246.26.57])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006ec62032d3dsm3302922qkg.30.2022.11.18.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:54:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221118221251.4330-1-geliang.tang@suse.com>
References: <20221118221251.4330-1-geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_add_sched=5F?=
 =?UTF-8?Q?data=5Fset=5Fcontexts_helper=22=3A_Tests?= =?UTF-8?Q?_Results?=
Message-ID: <a4e41f3c-4562-a248-54ae-89828b0c982d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 23:54:53 +0000
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
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5674094851522560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5674094851522560/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5111144898101248
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5111144898101248/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e85f97ad01b7


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
