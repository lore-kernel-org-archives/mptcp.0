Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931011C8F
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Z8CARR"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1ef370c2e12so3199469fac.1
        for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 23:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699947840; x=1700552640; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXaJmjcxqgf6Nc2HsAT9EIgmzSlMdsrNE0ujtPvMnYs=;
        b=J2Z8CARRgZxyOR/rP9uDXKqnb/pBNw/aAyb5v1iI/uHgh1K59o0vdAbnonUIzjnkDC
         XCb3BtWD6C7//zI0csoj+3erOVut9qV2F1OBJBw5zpM/mm9yKdd7Zq2CHNpZtACPPk2K
         1o/SrBen/PjjExAnSXp4t0iiULiGLu7QJsAfOiSqua6tH5g3QHli3CmwQonRBmBbC0BE
         8ySCEw9fsUOo4J1zKdLZ0bM03n/bdHSSzNgPUbnDIJIVM16Y/9MB/fxdEw5hjX6Hkbpx
         2du0nlVPqXw0d83m9mOkpMrTgjOxY3KcSaVjnRLdAdLLKeWWx2Jygs5PUhPCzWbz7o1Z
         SBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699947840; x=1700552640;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXaJmjcxqgf6Nc2HsAT9EIgmzSlMdsrNE0ujtPvMnYs=;
        b=KcUehxWpoYNPjgJPxHOT5A11PoUTiFPbnn6TWqlSbuTsaRhJLsXph/e8qP3dh1EvLT
         sG5StvtSaZAdstSe8SlmYXhiN8mKz4IiXNng/6fq8gpQt54+ivSOr4O+hyA2WO+NsK9D
         ridgymg5Jm63F+FOfjU7w8wcmUdpCjEZjJeGO6hX4YhfAO6QRN5FWRfWjcP2FtbOp31k
         h7Rxp51io0TfEndWvivG8EgbgCwazk4Utmv4AwNfMSoEndkUkb1kb5G3FKDG9CJSQ02L
         pnzPGBZ+6vA46+LfWpTSAJCF9bLhWVu2c/h2taZqnZR+NO2VFaV/0TWkEvrK1hnUtqso
         RMXw==
X-Gm-Message-State: AOJu0YyufL2/bFVH6hz3PV6mkJLgbc/q6eDk+fWcExTj+Fcpbs91b1qO
	WujS39kZ7qUjC6/Yx98RjlrrmriCIA==
X-Google-Smtp-Source: AGHT+IGA9uW3ETRRkH71efBhwStjP0DZK6gyDZXEM1PzP/zhzE8LhIb4Qeuc4goYMRfi4wTSi6483A==
X-Received: by 2002:a05:6870:2890:b0:1ef:9d46:5c7a with SMTP id gy16-20020a056870289000b001ef9d465c7amr11558274oab.0.1699947839920;
        Mon, 13 Nov 2023 23:43:59 -0800 (PST)
Received: from [127.0.0.1] ([20.168.23.49])
        by smtp.gmail.com with ESMTPSA id cl21-20020a056a02099500b005b4b70738e5sm4456667pgb.8.2023.11.13.23.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 23:43:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <67568899e98f205deb8107dac5b623f68655ccdf.1699942931.git.geliang.tang@suse.com>
References:
 <67568899e98f205deb8107dac5b623f68655ccdf.1699942931.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <7d752b6d-e938-52f3-21d0-1720fe06ff1f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2023 07:43:58 +0000
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
com/task/5648668447997952
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5648668447997952/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4804243517865984
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4804243517865984/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6211618401419264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6211618401419264/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5085718494576640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5085718494576640/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f66877049fe0


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
