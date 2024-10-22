Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3C22083
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588090; cv=none; b=A2JavDWdAgXYcP6+K7ey98n8ZyVAAx854Qhy1ht26xBRmV+l9HbY6NyRLD+CjyEuX3rOzot2c0uy9tqGQwR6hfZVmKi6jF+8NKeoghVqnS5N0AgZOn2rWggNyOcuMYiav4bxPPFqjcA3s2vrJO5mhpWjAIo20MgVGR6gZkxw4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588090; c=relaxed/simple;
	bh=+4FgIF9fQaxS2aT0iU8VysyPzqYtm96+S0GwhEXK8hg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=D4qQlDMIG+bGVN4Gbx8WSvldjE+T1zhcH+Oa70ylA/dMUFNmVzt217LW3CI2LZix+QyPpyjoh2buVkB2MO68JZnLdhcvUKNS0L7O/vLVPhx5hGccQddclTJo/gtN3HgqMX7KuehS/MUArN3PjjbvORxTD1kNdCNELBIwuE0de4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5gVA1pi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5gVA1pi"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e7086c231so4065426b3a.0
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729588088; x=1730192888; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx+0/zc8QMrO+07m3y6WokCWu+9qNL78BRApSo3x+xY=;
        b=h5gVA1pizU9a9alDQmfUrHqR5iEKGDVUZVszGVjWio73loCPLpNiWzP14Bdh03Vj3H
         M335fqy3thPRzstDuKXHef5fCXnWQZEsLcMwbQ2C1dJl3PYaH7xxhCtn3qzQhHh3riBz
         aMEeYYnxHQseUJLERiupoP4HpzNzhar0fO+hS7FZfZefMaDUfG+LjHYpC3Yh3rvGUByl
         vVkL8n9IYYXTq2g3SqIUxlZWjtbKfoqrIGb9jNLRivUPbrHI07aZJOVU2as0DlXGs5AW
         lNbvOPxZzb/9cie8FysXO/IGQtuX78q7OcQKufNgBMol4qXc6Y0f/ZQ1SuaYdGKwpt55
         x+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588088; x=1730192888;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nx+0/zc8QMrO+07m3y6WokCWu+9qNL78BRApSo3x+xY=;
        b=ivuzD5zZ4UHPRclc+voLUCOB5rc/AQJkto4RNdjgFqgJfzbUUSkKRI2pQqntZ2lj2G
         RsSCUg4KTpuvEidB2F6ON+5fdZ9QUGJh53UBoW/UmS8k1Rhs0FwHuX7lFGVtmu2gydxB
         hVoi7Tg3L0JpKUHKLH5Aveh46FmA9hrDjF5LtF6YjlkgcK7GJq5EKBtyTjJjHzCglIDF
         KVlp5wTr+6Km9R3hAO+1H9L0yKIpx9EZuReOqcplRLsweelBnHjJnRqsAcSFcTK8wqvD
         e8vmxH0NgWC48xqdH6BR4Xr0fA+R/I3YoV7GMjPqo99xZI+wguFOV2eyQu/4Ey71gJWW
         shJw==
X-Gm-Message-State: AOJu0Yyaed1ArK8+Eq6kh3H4Lo1GvAHEPPIW8k7xdITmWGN4M+uBw/NY
	rCWbahBKBKAMB2ohU+mEOHUmAFRZq2gqgnY99NwTUru7MApnqR0S+6tK
X-Google-Smtp-Source: AGHT+IGmrG0966+4DDMPyKZyNz5BM18+N7UyhI9jztNjcusGv8g6CsTbApJiBzoRQbCg2S7malV/hQ==
X-Received: by 2002:a05:6a00:2441:b0:71e:7046:c0f8 with SMTP id d2e1a72fcca58-71ea3357ba4mr17871575b3a.26.1729588088248;
        Tue, 22 Oct 2024 02:08:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.38.45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafa4f0sm4629244a12.5.2024.10.22.02.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:08:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729582332.git.tanggeliang@kylinos.cn>
References: <cover.1729582332.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/5] add mptcp_address bpf_iter
Message-ID: <92f4fa9c-d425-f01f-63ad-d3ea1f598338@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 09:08:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11455981023

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d3d814a163c5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D901713


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
