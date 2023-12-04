Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92D28684
	for <mptcp@lists.linux.dev>; Mon,  4 Dec 2023 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcjX7tv/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4254f973685so12841691cf.3
        for <mptcp@lists.linux.dev>; Mon, 04 Dec 2023 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701715316; x=1702320116; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns8wsWj1Li9pYMGYwGJJlx51vA2pZt4MbdWlLDhdWRA=;
        b=AcjX7tv/jtMozygz2/P/sP+4T2Y9FlSZY+09TaMUQWKqAkw7bTNINnjZezWu2jWauJ
         p0Ho/4fNTmC8SWXyxh6DTzV+bBnkrsP6hB77CIrU1zJA2HSZtufPRfcNc6cgEinDOx8E
         yewEvgjvnyi/svbOPMCIGIiwRO3DuCTXeleHcUJzUP0F6YkQvc7vniRTGbHhKxWWhxig
         1qyzHMwgA6lEQADqUHuqZ4YmgRiEOAmdCK2hm5JIGkgDticRhn1rORqdnQLvS6LsYt/m
         tFNNIxeVInXDXs7hFj88k2b7Sj/Qhw3UP9trmXmn9+OZI5bRiZq1wZts/sfiPKIOOZkl
         20cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715316; x=1702320116;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ns8wsWj1Li9pYMGYwGJJlx51vA2pZt4MbdWlLDhdWRA=;
        b=RMI8jinpfBib0islmpcVC7FzA3UwQesyuS685gXL1ZmDW7E67OSJrmeTqs4FJ+HaE7
         YynVjVKM3jqy3IeQyR6R9uOFpAlOQMaD6uSmWHOmhWqmpREWUjm9YkmtWSMzvWm4zDr0
         fmxYF7xefEvn2eKZraYuRc0O0OGYwQ0RuHscfWj7ZPCha4Kg9s6IN7RZQBe247dl5VcJ
         F+PBiGLbSEKtjr8nRMqylx4ntJXRI+Cc6ohCT/gCrA7b8muNtVnbM2bXQ/W3n18xubKS
         f4YXZe7toyDc0Wx0qeqTXK3TMXdSm1uUxj+EsAJsNny2awLUki1HwTcjJOrTFkGzfjHV
         iY/Q==
X-Gm-Message-State: AOJu0Yzp3qzsh2H8WtOVJx/+qpozbEBtgKGFHxFhw9PY+F4huNJfu3WN
	gYKn0GZvX6Qe5zhBpIfhag==
X-Google-Smtp-Source: AGHT+IFKL5yEiCE57aIog+PAYzR8n9ose/85vz71rZg0ih6A2rJ9svTnQmtNjbhK+cHFHi534G3erQ==
X-Received: by 2002:ac8:5784:0:b0:425:4043:1d82 with SMTP id v4-20020ac85784000000b0042540431d82mr969qta.85.1701715316290;
        Mon, 04 Dec 2023 10:41:56 -0800 (PST)
Received: from [127.0.0.1] ([40.76.106.50])
        by smtp.gmail.com with ESMTPSA id w3-20020ac86b03000000b003f6ac526568sm4505634qts.39.2023.12.04.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:41:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ec671764e010ca002224c611aae89d829f205166.1701256112.git.geliang.tang@suse.com>
References:
 <ec671764e010ca002224c611aae89d829f205166.1701256112.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: check CURRESTAB counters: Tests
 Results
Message-ID: <d614c3e8-3532-e832-a39f-9dc28d614ef3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Dec 2023 18:41:55 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5025343417876480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5025343417876480/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6151243324719104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6151243324719104/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6714193278140416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6714193278140416/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5588293371297792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5588293371297792/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/31a63b62ef12


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
Bot operated by Matthieu Baerts (NGI0 Core)
