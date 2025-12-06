Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23851397
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765040478; cv=none; b=RMpCIArkhRblKlf7k3cA0td4VZZ5UN2GFfEYP/uGeKElnh+dtCTNuEp8p8USWD+ZmHPxKEuxsnHGTfaiH5tJn5Va4QAVtXF+wXkyMvNb9IL6F8cJ1p06AqHI/31GMTsNFsQdGzX+gmJGLUfrjI47IRD7wf6MFRxWfYAz0kZ+3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765040478; c=relaxed/simple;
	bh=X/kHNXLljVznYoOvCkviTCUNJPq3eCdwTXNmYMvEAVg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jWew4l3LCDkFl7uAAAsjBJRP+D4GnaZoRqoHa5XGLahmYqCKPI4+2mBYO9PPjUyEkE0s0iB1Knh5jQaKPO2yudmbv1wJgp9qNi7k2Lxjmv2QhWbrD0ItXcjXxbzA+hg5e/uUUUhrwAnHDxzT30DIR8qP07WFeP5CE+fibIdzcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHsVkuwv; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHsVkuwv"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-11b6bc976d6so5219439c88.0
        for <mptcp@lists.linux.dev>; Sat, 06 Dec 2025 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765040476; x=1765645276; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tpooFqF1g5FzHEmMxj2ZI4iwMI4HSU9S+HnwpzPdJs=;
        b=kHsVkuwv7OcbigLDUvHPSaJMn4Yu0tox64HO3LqFk7Lxit3Beacz8ANhGv2TcnX6KL
         8k64+ipD6in044vrsHUB7C2fHBIHst/Nn3knXQ9MiO5W6Dwk/d1eo3CSzZB5ZDbmjCLc
         bJ80RzOs6/qqm+gJwHZAjW5gwVAZcno4kFQ+l4QHcW0P4uZJzwipMO5XN9If6ZwbbnQd
         qLUWB1OcQ8YhNryzMsIECDY1xxUzdT5Jae3rojMCGiVsLo6F93DtI+/iyBoUyXMUKAAE
         mZSGQ5FQ7Zl10vp2xjGdq/7IHei811JLASOA5V1G5aXMDL1TqWfyxzbAx/wenYbCaJ06
         +ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765040476; x=1765645276;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tpooFqF1g5FzHEmMxj2ZI4iwMI4HSU9S+HnwpzPdJs=;
        b=t7hrMHmW2UJGHqVnuOYXhFd4mW61NEt9Ro4LLU/jrAIzQg67D/pbSCp2VjhX25xnkx
         LtvhE13cALqaRCK6CSpkoX8tHN6rWGScmQqLj4MUse2dXcWqWbB2Ld4NSeyM6Tf1zumC
         AcQ1ZDQj3JGUAiTskWqKLLnk1q9Wv1WBpLJfApw8/6PHKwiDa5/DD0K5xUWXdoDYHsGu
         NGuuqCNh9gubbTGY8xmXbkcZw7oGMWxOM0RiKjpajlZlY8orPi4moACJ1pVoeJpWRDMf
         dHpZeWcsqWN+ZbrbvcCeil7rexjByzYSJ5DZ0roWsUOmPwMBqrsdUcJggHmo6RbJyrvW
         UQyg==
X-Gm-Message-State: AOJu0Yyfrgb5fLUUTgqA4bKG7cldy5kv8iH1wk/iDIy8sfx2A2npYb0W
	MSwnZU0BhtDLQamOEHIYHvVstpEvUSOJDmN4awe+pbhIaR5vmrxsWo5X+ekkKoE=
X-Gm-Gg: ASbGncvCJytGcdVBnlTxLsG9hU0+Z0h8sp/6I6t9EsulZUUp0gqBZT2RX7BOUjECEJN
	3UD+9tYVDzH1F2QO49Cwtdi1ofDLLWcuW6sQuYtTq7fb18tLqIjcM4sE99aKPpRJ+EmAv1hcVB3
	TVxIVPfPLHuMLH5J7428WMHEHbfb3cMaumbXP3GfMERitfu7WYnY5X7Btj4atut0OJDMzocz8J7
	tGUBb+IM6+4A1k81PaBWnV8Y4LXo3GFtEeGYI+j6SNUV+3BoA41BC+aGwQKszKgiMDtk52sgPjZ
	HihdLtIPJp2kA6PSARnDnPhqeuB0PFnqvWO9dzCPgQ41dIX1Gki76RZYcTvA/+Jf2i6sQArrqRr
	/BfV9eVh8YuIUYOiBvuK32YjORTfLCbAtBj/JZPks04wc5xs1y6kZwojZsahzjjpVdnhkuEb28c
	xpTL3fufj1l5q5sKV+grkiQma6CZk0uybd
X-Google-Smtp-Source: AGHT+IE915KK5WNf/01Kx+qQd5e2jP2pjOdsLfHJvxm/TADgRasvwcmM2wHIXFZV5XZkN+72xFTRmQ==
X-Received: by 2002:a05:7022:b9d:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-11e02f551c9mr1675372c88.19.1765040475422;
        Sat, 06 Dec 2025 09:01:15 -0800 (PST)
Received: from [127.0.0.1] ([13.83.233.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm31867086c88.2.2025.12.06.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 09:01:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1765023923.git.tanggeliang@kylinos.cn>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v15 0/6] implement mptcp read_sock
Message-ID: <602b946c-afcb-0994-5d37-baddec07a5fc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Dec 2025 17:01:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19988767626

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4bf455dd3ee0
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1031070


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
