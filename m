Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B6BA3D
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 04:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359659; cv=none; b=nbRwZkSeJNl3mpqFyvQQjUCkRbS25KDnDcELLR6NUuKB+dKqq5FJK/6IEzwJCEc/U/hzDDleLlv5IqOh9OlEofn65n1ZLFeaIGsTTnp8lDmnEQw4yJkruy8gj4ezIbLLfD6F3zK/RyPuyFQXy5V1VhzeasQ8gw5xZ/F+lI7J99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359659; c=relaxed/simple;
	bh=PEnGzY4qwrAUK4f2eLS6vhKveO87U1VqfTU8oUYwh0c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V76soOZF+RAPd2vvGrOCuR5B1Nq0zXwoqy9meikUTgNl8ulISo2Kx2xqT3sNg6wHASYudG8UwqgLU2CptHGSfcLuQMYGfwLwuaopLgrToCZjHLs5uFgNnW8mGHC1twUT/KzI62M68uMHjL4j6byQOQ/LlxlWpsmEsZaUnYx8BrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrHWczFs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrHWczFs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22403cbb47fso120670345ad.0
        for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 21:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742359657; x=1742964457; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjEiTxuFRm4nrqLJ+tRvqwal1WzHm+JShaIFQ153ZiU=;
        b=hrHWczFs59/MRLcWMk6NjvIaTxESQt1rmynypAjGHmlxmWwifVUd1EXq4i801t9knT
         V+xv9obXhJr1RS0fyKRPcCuaZ4ksg+XgSg+3zkzJ3aXIr28kDCh2yKT18mO163AIkKGE
         4cqImLeffQR9DGzOcDwyFn7l4vNB8MteUymVSemjwk38TI7KokIscnAQvgH19ZoxDyfy
         XFMcd+aoNLzxoZ5igv4v/zNg/vnmTZqGT57jIJMhpBz6xP0kyGfowR+JaEisuUZgUQGz
         TJCCWUsHfm4kx1sqUmoLu4T9pA4VLYi9K2JpdujwdnpvCOHM1ECPFC2n8Q3A5w1Oody/
         i8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742359657; x=1742964457;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjEiTxuFRm4nrqLJ+tRvqwal1WzHm+JShaIFQ153ZiU=;
        b=clYEkZI1cyH1d9dsl4OOgIH5RRIP5dnd9l1bysdAai+JJ8TiWS4PDbE+zlKvgk9kMI
         XvnHJDF3XGB1g9LDd1YDI6EsE4ifepakrMdFSCk3AUY++U2s4eKfN70HeiBgT8OtIwaV
         NYWMN5GKSLgtpZCei/HNlFTVLGROCTrBkvTZtfZIRLmeF6Ia/iNe6xPqYZwaVvpKOr5q
         OnRdcJYA9WDXrnbR7YxxKk5pw5xtfvXMLT1rTc2NmYZg5nxyGWD82yOt3+KRyXAZXB4L
         H/n9P3aMXNkXx7hx4ak24+heoNLQUR5OzqTS4eu91Q22WzWmrjuKXFWPhJxYKRHaQ994
         oucA==
X-Gm-Message-State: AOJu0Ywuw12tC11tgzy8H736ALSVzkj+tGUd0labxZQD4LEfZtJnbuE7
	UckIDwsLOR2xJWAqxSOjoOr4EvFL/n7aE2f32M62VSuIYPdt5V8zePCd
X-Gm-Gg: ASbGnctGDoJxJ4OvJ+5O0vXhfzMqJK1t+oO2+hIfvw5fNIA2hPhriqSwj+T01vYvqYu
	k2XLSYVYBAiuQwXkwWZGWra2pzkk5wJ63IKLahCx9k6zAJGcVf1M6olBIjj9XcdTO8wkG83M0ss
	E3I3+CchaQr5k/idLCCcT9jwW2wVHYx59LgaTAS3Fq65sjuIIVlMwEVGQ7MfNtIxsA0nbTrllmR
	rF5bu6jZMkJmzdi8BBRT0hIUBJ9WrU5T9zB+XKKj8cKDuJ3vJmF+yta0ZnyqR2qT7ClrHhgnSVx
	tUDy8NCjFeMfRPUWQ52yQJpelJtbnVxiNAjNo41CDN4DlsHlbKvcwlAw
X-Google-Smtp-Source: AGHT+IEaqi9s6QOrO6oDT1rPjTIY3EWn3YjDHckYEeLWlB/NTTL7SCCzonGsEXrQW4qjNWm83eTY0g==
X-Received: by 2002:a05:6a00:4fca:b0:736:fff2:9ac with SMTP id d2e1a72fcca58-7376d70ee6fmr2055797b3a.23.1742359657146;
        Tue, 18 Mar 2025 21:47:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.43.247.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e018sm10879802b3a.91.2025.03.18.21.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 21:47:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1742355162.git.tanggeliang@kylinos.cn>
References: <cover.1742355162.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] cleanups for main_loop
Message-ID: <229690ef-6351-cfeb-8045-dd299c229169@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Mar 2025 04:47:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 =
failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/139385=
50896

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ee7ab4397474
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D945419


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
