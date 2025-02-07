Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614081DED6C
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926905; cv=none; b=iwu/DNETUc0xTJJufpKO0XfWPdeeehzpO9YhVcPyzbQHiY75ohHpjkTq6kFzuVaG2hUvEn7rfWR8N3632tOq9do2+1DffIbejvLnP+SQ1Lm9TMycSlOC5DHPZr69hiokfuGa3aSJnZ+YS4EY/WpPF+T+mzKBTJgjQm0q430m32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926905; c=relaxed/simple;
	bh=eymE6RKbvW8MStoaC0v6f7kkjiNVeqehh+9MrQU1N40=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sXwjaKz/P4HlQgr5FdiQDzQ1Yxeg4ShKbwncd74ygjgnlTJ55u5VeMYn7gizpElE0+VctAALFcV8d4Sf70l+FNbiTyGVQBMG8C2sfasVQBMBghZcDL2/GGdRyXjcPOa0eKQxckUuiyudlTJflatQl85HrNQqsRc0O4scyf2a+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlmekTih; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlmekTih"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6ea711805so304213585a.1
        for <mptcp@lists.linux.dev>; Fri, 07 Feb 2025 03:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738926903; x=1739531703; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4PmS20MDoyTb0kXivm2rKDFm834xUtNTHsCcNpR+DU=;
        b=mlmekTih/w68zkSouOVpoV7cxurBGJRkVbc6TkCGBYQTD2VIy99T1FFipdwjlGNGil
         BGhEJjNzAE4zR/CnQ2vHOnyabICuyQedICFWCf1GFYi9anRwScXWzJYJYvY1jtotEf7J
         qNpDNaNa6Fg46A8cjClCe6EhTq0S0jfIAZ+Lc975vmsFe7aRQ3vhbLHpZQkfhpCYHUHh
         LkYIycZO9WT4u1NQAk70GL6Cq2WuMrmYh8BUTau9z96+Rrf0A1dDIoFaFtFIQsFFD1F5
         hWHB8hSh4VqJvJYk0Uwqv+/YZtP9mpZQUHokmP8TjlwfBZm/+22xReZZsLZ3SkfPmY7/
         Pbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926903; x=1739531703;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4PmS20MDoyTb0kXivm2rKDFm834xUtNTHsCcNpR+DU=;
        b=R70nXbFhThV33eHiiImTMbaHnt7QyusvVyooEYsWByKQdUQ8EOPL+OthFRzsOG7B/i
         Mv0fXBiQ8X6ZjiICEIOe9woufq+Jvd5ymLFCnIjOwzgT9q8QVgO+39k53vFn+qCx/F3K
         lUcLJ4jsu7NkSHPLChI69nuLTT8G7TmwIrw8jEm262b5nF3BinZJcHqThGiX89AHP0HP
         uFdMXeihEiGuz2D1kW0QGQ/aoLO47Ci+gIqXRqUeAk7/b2HNbiW6tkQ0cHIjNyoV7aSH
         sBF7nlRFKTgpEkmG82qjkAau7mLSkwOXknH3l6RZkxx1Oljhgty43lilOrM2rfpLh2Af
         n7BQ==
X-Gm-Message-State: AOJu0YzaBpG59shLnGsPI7SJ/DT5L1sbpwtCX5HX+h/ttmDwNgkG5aht
	ZoJvzD7gO/RyDnS6ozmbqrTI5Ek+ny+b5B8zmqZVXB1MyW40MvAAPpYU
X-Gm-Gg: ASbGnctMhjAdGbk5a24ZSdLpsIZH3qucaHye0KOI4bx+FOR/j7JM84bYsJ4P9s5A/Sp
	zrFT4schKvS6vtPJSM7eNLwRSiz0I1akge4r3W5rxs8H7cmKXgPp2vXQa22hM5g/sMAmZGZlGBf
	AK0qz3Si5/auDQbhjcLlr2bf6ceN2vGEefTaPlvwwI43i+3q+zbsitWuP5wQmZFNKpGOWQKSOWy
	PDagodZ3CtXNht6le5cjgYM1vtsPmzwF3RihNI5UA+IsjSN7Kqr4GRY4BeRRjlhirAKaxXE4HGF
	yC89VYWqqQHFwSKn7yPBevIkYZHA
X-Google-Smtp-Source: AGHT+IGHUP88aCf0taa1sBgxOkoYmA0niu2WR7LDe4UNIrBCMdRh9Dq3fRzYtnUNDFEHCBeUc9xz0A==
X-Received: by 2002:a05:620a:318e:b0:7b6:ecbb:592 with SMTP id af79cd13be357-7c047c950dcmr426187185a.54.1738926903287;
        Fri, 07 Feb 2025 03:15:03 -0800 (PST)
Received: from [127.0.0.1] ([20.161.77.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded1c5sm176897485a.3.2025.02.07.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:15:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738924875.git.tanggeliang@kylinos.cn>
References: <cover.1738924875.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/5] BPF path manager, part 5
Message-ID: <107b1daf-5c2b-6941-199c-20124a19db89@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Feb 2025 11:15:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Script error! =E2=9D=93
- KVM Validation: debug: =
Script error! =E2=9D=93
- KVM Validation: btf-normal (only bpftest_all): =
Script error! =E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): =
Script error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-=
next/actions/runs/13198356180

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/505f7739b1=
c8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D931539


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
