Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D44A3E
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683109; cv=none; b=RiyJtzsxd6sTaS9d6Et7Xo2SH4Hijs0rwt6kpi5MSxw7nrW7P+1oJknngeg/sqFEJnuN1qsGx2GsyvV4GKNtui2xmLBkvllG8y5dIRHreRmfKdym3khScdnv2SpcEB68ZwjFDgzmQkjjtFtdsjrDBRXqOsdEhhoD4wrBxLBAeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683109; c=relaxed/simple;
	bh=b8b6Ttt7j9abKw38SmpvWc1U9pCJdfG2a8eLd4onvUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=dwvQMGpXbQ2qYR+oKG/q+WbzXphzQLEoVp1UG4ahpCDzN57w5ThJ0ryqBX/IpzgpWSK5oTB/LUffLZuIeWRypZe3JumLBylRnCoQLFGzhMmD/bnI/pxRVhKCcU4hxbT+EoaV2nqjHtdRPqwpw19T+EutH/ix5moKE3mCtZMJ58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg2PVzRo; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg2PVzRo"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so1949690eec.1
        for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776683108; x=1777287908; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KatFYAjL/XW+KCN5f5nJKCQsYkqfP+W1zh8h2wvNtsw=;
        b=Dg2PVzRowjSlWAJcUqy0LpedTUBwOxfkJT1JdLnDmUZcI+Dw7JS8u7A4KBjU2onUKJ
         zuCq5Dk7HWWWkCFmfMRYudEDDTgu3aHXJNW3xjQf67z3nXNsxauF9K2tcttWZ5dPMumd
         rM/LZxfUUEuH59g51usnfqnUWooNOLB/Scd0mHH2X3b4c+Y1mwmB1HI/R4PRmft5soFj
         aknbETsJ9COeDASUJwlytpuVjm+eN+ta7vgeEZKfpsL/M7L8aWMORM15vV2Gx/uwdDwP
         3BpxA+8r2oPFBAaFDfVt3hKzji7fj5np/TvoTCiwRnzCQnGWktsMlaR0q7qJwrsyI16j
         mVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683108; x=1777287908;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KatFYAjL/XW+KCN5f5nJKCQsYkqfP+W1zh8h2wvNtsw=;
        b=W6IIA2kpPQqCPgiqlikRa+VctRjb5+VNnq+/Zyy20+Ur8qgK+nWswoz3E6041ze6X7
         T2Ge6sEC5b78SAuQ6fVUpJj0tfpD87DUOMPaFyygKigCJaqdi8FNwnSdUOe71TpLu4w6
         TxIrUv8viPu0L6ETvXnul/k79Cm1lN6kWAXSTTZ5o1JJgFhdsOkmm4igumiwIYp11ZjL
         dXKEoPdz/eNPshpm43DQd+F5S2m7SYdWzHiCTtVn+UO/NqD50tNZhTq4XvlgwxShlq8O
         u6GRCh3hy6OBN903Kv73LCR062zAA7vX1j4bUL110hSQQzXQ3xe/GTtzdxClM0+le0UY
         ezCg==
X-Gm-Message-State: AOJu0YzbOJZSVrtHYQn6wcyFM5p8isYlKWGUl/1bDf6DaPIDTUmAbhwv
	pllrqDYo1Wcobap9NykGbEoqIOUX270xw9X1l2BCy8a3wARSIFb6shA4nuJZp+w=
X-Gm-Gg: AeBDieszRn91Km3Sa37DCktIT2nLVL6ArgigQ9Yyncr4mjFuOiOS9sCwdl7mazWmocZ
	MJoiHKWDvY/WyYTMtBEnCTUoEIqw8su/p8kVgatxgruODYW70IohJkeagv6ZwyxbfpXY4VfGrPR
	2NH5jrQNVSMum3I6i8m/M3RKd6tg6GkEnInhG5I2V2Gb/l4A0/XDXtigw3Mb1k6LobLDgs0WHKU
	e3lk/YyIqrg0EDJJbygkm97j1YiLSi9LBVknFw3nwgUzwkJNjZEtUuXA3k5m+Tz7x3j3fGU/076
	hRO5WM+E4A6QOeCGHRzFfIBy6cBvxxB2ofiPJllI51TY2//SNK7x3JrBUPPwhqi0N4yIPtpSJF9
	MmFhiRTFpBhTGlnpc7nt1/04BP8w4TT1vyGhzz8XXur70wVUewhiW1o7eceHNhG0ITyIYGZS+fQ
	Hc59dUf3XXGzbju98WMXIr+YiIQSp43r4jkEbpAAh1VJz9xp6Q
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr6643922eec.4.1776683107504;
        Mon, 20 Apr 2026 04:05:07 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.161.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm13762364eec.17.2026.04.20.04.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:05:07 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260420093343.16443-1-gang.yan@linux.dev>
References: <20260420093343.16443-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: set timestamp flags on
 subflow socket, not msk
Message-ID: <01e923a6-75e7-3692-c164-ccf03a2dc11d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 11:05:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/246598=
22856

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6e2320fe83ea
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083210


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
