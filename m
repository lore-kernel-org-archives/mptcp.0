Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679973;
	b=gIbvEVKEJSAUnHQJ1c+oVGKZPaWZ0gsDnqgrva5oRf3PChVWd5m4C8N+rnjwenXpJ7AN
	 KWFZpcDlXUl+Du+59J4wBmctAzkiql7OPvgOvE4Hy3GEeht+tJIbCZ9x0ITubPCmjdaxT
	 KentdetPpCDxIthwzajROar5INAd3YZ+7vBrcQW6gxNsOIXaqzF0ltVF3cst/yx82J3Eq
	 e6Th6ZUwT3t2kxQqJxkQBZV+Wkih9cP0syYp0vwVEeVdILRdRQOZ3R2th33+NiZhX7wqe
	 IWeBEz7LCsf7KKFL+wEzdBM0nwYLLewsLO5JrHQooYVllF5nlyOJBhz2vVI80wtncVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=7neruVWH4NBP3bNvXHr9emd+yb+iYdG3/fhvwuRatkw=;
	b=NGSBVhJtuvXXm6pZlw6NdR3PXBbFx6W/rmWFWhP4n7s7uDeJKkYAFPzEYH0k2o7pmTn5
	 Z0uRyImprC6Ls32WWGnkw2UnsndS8Mmzj5GiTVu8BjIeH0PkCq+aErEHrJmf+y4tzSRSr
	 DTxqUQQHTnQVUXnXYZhi3fpS7TB+sET801TSit0G0+l31l9rzL4y8iOM0Yh9yFHigdJCg
	 tmR0LlPm+uQ3iAznMiacB6rwXOaxteEZ3hZGUaeWnTHg3P8mEMUOqDMjAd9Ps57y1RogP
	 AyppwabrPozHTY+ujmtQ3YAU+uFjZTitDtoF7E/kLyN+hmk7+HgebuQXHgLVGnT8m2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RqFg6wPq;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0635606A323
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 18:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0635606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RqFg6wPq
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-823e4047037so2168657a34.2
        for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 10:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794679971; x=1795284771; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7neruVWH4NBP3bNvXHr9emd+yb+iYdG3/fhvwuRatkw=;
        b=RqFg6wPqmcGsGRby3INdjI3HPF/eMjSvkf2oaAoK9MH5twh5n9UI/JhSOl0IYLAQxg
         vjIU+goR2VhAWjRZex4QU8c8nNbaz27Aj2PoJy0OtItde5KKssQn4WMimlXGGCHaefhP
         X3nZrQoXqVui9oUZsByWnqHCTZLZgXQo/00dLnI5b5IWLX9C/fdCvZqKrO7/jfpZXX5k
         pXO7jClDtQQj1UA1+LF1j6nUzoC1rjvMAU97/5B33LLBJt9Jd7ZKQzBx7wIE944xQe15
         hCF6lL1DQskjj3ksG69c7QhQsCw2AUUijXnW6oXKADMG/9nRs8ddzEzDpEiEmSVaTZKd
         /hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679971; x=1795284771;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7neruVWH4NBP3bNvXHr9emd+yb+iYdG3/fhvwuRatkw=;
        b=yoLPo2GDVKzhLKSSY4gFC1/tsh1thZqDZxvVxo2NnO/DPPWg5kR3f2DWgCfPWVbjEE
         g/bzxRzI1RlFD2lWPskEZNQS3ShwF8lR4IK2AAkhKF/+pxVOr404rFuKLsMn2yAc4/L6
         FEsJtHnU27FpxyO/qB2majBDD+wcfsdNasJxHrQIeLtfitoyJY4LyZ4iByhSl8A9em7h
         8347pZ5x+1SAidM0s9UmfEd2z5T93JI3vC3rUQT0UNQoWuXd8ZngJYKowx5UYPLkWgAw
         p+RUH5gh43/g0Z2WWUr9FCUMxwwk1pbNByzWHNC7oMeuNnMRuZtIcGHeZ5tAIzqqI1gI
         CZ6g==
X-Gm-Message-State: APuU4Z//edsN6RiEEPTBGtGh9RC9/yEztjfPlFTC9h/n54QSsvnoyynx
	JX71YLpvrl/x8k8XspQJNClRGiOGGZniZBsBKwiBcKahNJENYV0O5yDfbx5xjFs=
X-Gm-Gg: AYBFou1//NtmuT4AcVU3d5ZsfuKVFexncdRfcaKeu7PUpC52tm6BxWkEmc5E4NMaES+
	BvhTdPH/Wj9wQzY6W8Z2vf9yRvLNvHeWcslyqDglwWqby8U8gu0GRdyohbz6FPug1VpZjyojFVA
	CNHSBlqh1c5EAmbBDWw0NcPmW1ATqI7OLDh0IFwcmIVCdRfAXFZIi6CDZwkpfSZaIzwOYsaBG1/
	c8AuOoUnkFdzUWELIvqkpbtS5SSSFwz7YXsPMSDeh6md1y46nq7ttwqcSQLiOc8jS90fRytfhV1
	Y9qpPEzr9kcHTDqb0P3NFZeDpNb7wNv9VRGxQ/8FsMGRf29sXV6sXbM4uu8XqWeRBjccqSg5wMm
	WaB9HQMQlDOzDsqdFuGGR1NeJa7fsq4TqP//GKksr8FlsbwswzMvCDE92m36neFxhKSgrDjg77Y
	UX7ugjxk0mmrMWaqwYRurxpMZRSlJ3fRn2+h1rrdr4z4NRM6AeEG950hhxNnDh1rj3tbjpYWkrD
	SIZwZ6dgoGvd3QYv9rKM5z1vsSIaljDx6wdAh3qiT1rosl5fQY2ePbF8ySXqDZYESYPBGdNC3Qi
	h8W0Fg1XH9JGkFejhy4/ZeGtiUOZfbUpyJV378lb2w==
X-Received: by 2002:a05:6830:718c:b0:862:88c6:1843 with SMTP id 46e09a7af769-862898b6f9cmr5311046a34.19.1794679971451;
        Sat, 14 Nov 2026 10:12:51 -0800 (PST)
Received: from github.com ([20.59.219.34])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862880a52basm6329797a34.4.2026.11.14.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:12:50 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794672619.git.x-professor@outlook.com>
References: <cover.1794672619.git.x-professor@outlook.com>
Subject: Re: [PATCH net v2 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Message-ID: <7cc39fd2-2f23-1c19-af0d-8b1b23bdaeff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:12:49 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yingjie,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/43616523087

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/64364d4b6c=
68
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1211446


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
