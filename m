Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064A487AC
	for <mptcp@lists.linux.dev>; Wed, 10 Jan 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgF47VDU"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3367270276.3
        for <mptcp@lists.linux.dev>; Wed, 10 Jan 2024 06:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898785; x=1705503585; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iyDPcOj/KV9OBvhp8HVHgSjwzlpzlSVFRS4llN6W10=;
        b=OgF47VDUS75cjIdl6uFXvJDeqQJbWEwQcF2AAXcnlXja8QfVTxCKBu13fdxmj3My2P
         JQG7ujWAr4RQ0ANdwvLinFHKXakjmvpyBdhJdmW4RbnuPAe0L1o3nfKtLzO59/Jt25aP
         lptmwpd9hvptSyZsYsFVSseeq0QKz/5uf8NCGsoIuxHL8sMx2HCvmeIIn2v72Ls9VfPv
         5BDwS54mhy618MVnHKFzfSHqAt9rQziLo2m/iZHkByXbIECF6IdRYTfuTiUrd+diwY+r
         shP5d4LYNoz6uhgIz/HSAJdAGCt+V7lRN68I33Kiyd+Ke24ML+8L9Ym+C/LKm61MNYf6
         470Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898785; x=1705503585;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6iyDPcOj/KV9OBvhp8HVHgSjwzlpzlSVFRS4llN6W10=;
        b=YXxXiJTGwK3/0xIaFLUuSajHA7Zbn0wZvGt+9FbAE69VwZoi5gsn4BxTIVxS8MJrb+
         f+i0X2uEdgv5jGmsaqYNapY2bhDfiRyoQFC/Ef91LdPHo2tllvXbYi8SwzBDkCeseBNu
         +HlMc72Dr2HYsJHWCv9fNdgQbKJFhx/YFTCDpZEf6ygZSCWEYIwGwiBB/kGJZxua2RBK
         12DF5JsW704jVvJqbNFqKMMUOQxuQ8ig0Ar3ssgn0zg485XlEZIiVbLoLPWFdWT7Re4w
         XwLx9lA6jxVcbsnLRZR2BYNkWdmXkC1N1oBJscMsYe0ZCMEspSVc8G7/tnk0iIfOjcm7
         L53A==
X-Gm-Message-State: AOJu0YxaETKYjR89bn4zeTP+1aqus8wtsUtXfNrcUu1mdr4RjdyQ8tRK
	No0+lDIBnMPia57/x7moTA4I4ZsMRw==
X-Google-Smtp-Source: AGHT+IGQ5ZtrUig7epkrdW5wqyVIBGzKo4NmWt1nGIOpWJtkUUegjdUwhTGv+sYiV6O/DF+yupvvKQ==
X-Received: by 2002:a05:6902:e08:b0:dbc:eeef:7982 with SMTP id df8-20020a0569020e0800b00dbceeef7982mr879299ybb.45.1704898785199;
        Wed, 10 Jan 2024 06:59:45 -0800 (PST)
Received: from [127.0.0.1] ([20.55.46.194])
        by smtp.gmail.com with ESMTPSA id bw11-20020a05622a098b00b00429940c13a8sm1836513qtb.34.2024.01.10.06.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:59:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <45d5b581a58e29f4afebf09c685623be3108524a.1704892316.git.geliang.tang@linux.dev>
References:
 <45d5b581a58e29f4afebf09c685623be3108524a.1704892316.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <80d2aed8-d830-a1fa-c3f2-05b2318b44d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2024 14:59:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5560485303549952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5560485303549952/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join - Critical: KMemLeak =
=E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4530609280778240
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4530609280778240/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e911cc5cc90


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
Bot operated by Matthieu Baerts (NGI0 =
Core)
