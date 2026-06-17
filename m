Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EAF3783B1
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737048; cv=none; b=GAQhZu9wt5QxuijWW3cRMqK4cmyqjmTNIKHioYiXSzUhsfMW0lDDD4dS6XlfvOWaWPcN7v1uemSHCwkQxjcGmfN5alZM3fPafT6ee7dkT4SAkSbZVrQLYgxnsNrJ1kYwO70o+5/jvu67su7FrJVrB1l48r3W1U6ZvyvWdCLi46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737048; c=relaxed/simple;
	bh=pOkjgH4GBFvFZ5VCyrcUJnJcbu2/TcuIfaDvHyfJZ9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=VHvn1oe6pcEwdgLoMEzGt2SraO56Rw8nfmDsPRcD2bKI0wuZoWeLCqXJeHvn+j4xtXsAx2KZFjfiMdTVr5E5N24hRg1oHZYJy/7RymDRZ1J9CXfywpTbQAXdAITMniJEbV49clJrxQ9Tu7jrhatZRytX7ZIObllyKA8KHvtYGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuUWoAL3; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuUWoAL3"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bd7f4fdffso319978eec.1
        for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781737045; x=1782341845; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lqh6cOFYt9gnMW1NMOwfDn2m0h9+1L1EC6Rsu7XOOI=;
        b=JuUWoAL3jnX/Zs+zP2y/wao//5rl0cOcL1ijlFJKdhmLfHCgaS5vQKNpbQYPgHQSU0
         J0DfqZmjR1SAAQk78VD2UBanbsEY2CpqWv1jdg8mJBMj3CbYkcvR5pbmQfjnfckMtSM6
         WO4r1hcOPQpcfAo9Wb1rXA+JmQ3aUFKJyVNehcPREg4E9EJdgoduZApeQMpapGIgjJAi
         u0pURC5PcbY7F/0qZNX5W+XWL8euw1A8pFPBeLMzH9e1JqjaxdMUJFxROUREm8ze0Qxt
         XvDIiVCm0dumEeJXgpltAZDa/fFFLfbHRnwCjWv2i8kqbCvlSYy0bPV4lpbgWyJyaIu/
         cYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781737045; x=1782341845;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lqh6cOFYt9gnMW1NMOwfDn2m0h9+1L1EC6Rsu7XOOI=;
        b=SaqE4wmMwZaZAGiTiiZ6AKfFMmR4uzC2yoxYZj1h8B+wZOSWvaxM2JMMKHJQCVkO5Y
         cGh7xt6avwAtcKtRbNO4l/Al2bwgnHvI2OvmIyNjE9jKeVAkcvFsxH/r33tR3EUCT7u4
         t/No3YBL5Uf0jbzPtPFKL8B/ljXc5mJbMBYuq9b0LIwsKR0TBP8YG1ohsPHwQ1mle1MT
         K0y91INh5aGh5U+1GY/Cg95FLeZuz2LwmwTONupH+rDoiaWSpKvi+hauTAalQzW6moMK
         Fzo6fL+ufLC3DXfdyRCuj/95XjtG4Bv2cq1rpWSpkbWCZDeDYomG5sVeCRgitpHtwudn
         6Qrw==
X-Gm-Message-State: AOJu0YzEzA1+c1jBYKQ6O7Gxmy8JqFZsagTYiAzHPZJiqYuR7lZBWFAu
	A+y/lhUP3gUTbsamC2tzhG/VHE46iILcwidY5Dbh96uJK8vRcvCDnZc=
X-Gm-Gg: AfdE7cnFD52XxypU/H5UAFmu81ASn95H4V+s7Ffq52ialNLm42S9bC36fBKSx+l+wFK
	Ifjbp+RbCrIqbaEwOVwiM00IcTpFozLAwrHH0ONVKDpV+JSiOurL2/WvecvxdFc2uArvHSTPOPJ
	dAd9HC63cLEp4Ow0D6eZeA0O7lYLpZ5f6BfzRpPZ+Fq8kW6cNHo+5ki2LAN8iq9qSUmMugzgeBB
	ByBJUkkPjZ3a3YJjDLa3JX4LuXQP82nktsozbOwmgPY2h62UFtPEnJfxKwBaKYICQmCOyAJxDgT
	7iFQY2aoCnqfJXuCoZYZb4RM3/jx00eEx7/dNFaSKdDrWU/NdRogTDw09vfY9hMarbRPMPvVIwR
	fcnqdM09BT9X+BgGR0mz8GnX2FlJX4gu/wEQoJmezVN8o4SW4GN8CBmoGVtGqlBHUzLCYkg36px
	4vCmT+Z+MUPm7VR138e7jifkSrCy52fiUCe+iYMw==
X-Received: by 2002:a05:7301:1298:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-30bca077359mr3211207eec.22.1781737044805;
        Wed, 17 Jun 2026 15:57:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.239.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bdcba4b1bsm2917518eec.20.2026.06.17.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:57:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260617215725.1116295-1-michael.bommarito@gmail.com>
References: <20260617215725.1116295-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping
 is present
Message-ID: <42acaca1-ac8f-7038-0a68-2e81b7fb7a27@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 22:57:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Michael,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/277230=
68868

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/41f92d8643fc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1113137


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
