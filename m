Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589174;
	b=X7VKTA3+jsfDtaJjvGjhfJVvXuMQwd0Ydyyj/n41Lkx2hsySLGUkKshgDe+6PIt5ox4J
	 UYMWzgkTFrZnkiCj27UfktoQjviZDU//FT4zAHJzJ0m+bFrUhbwhyePVVlFvxfEFriP8q
	 3RpDtpIjTi8IzBfUTFh0uC9/HeAAgaKI14StthlzqjAb5f30itxLg4aC6hmtEv5OwGf2N
	 5G6R/b0EmOZ+iADhzu8pC1JzyjLTUKPpyxlAi1YpxC+gK0DTVPglxSeZg0F9uI3CvLcbT
	 jMBh2UkOExgCLswmGiRxfyA7MULZHVTPmTGAx9ccOKbYdIL1Y7lVZ2KHLCZxduSeB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=9Ul1u89f2Me/tawqCnw/0U4IgI4PH9koOFwF9pcob28=;
	b=TIYIcVouirAEXLVADPjw/5RXZQac5x9+dRf1iEq0yCzPY4IYagfpxoGP8JfQb7FEKTM5
	 RYmW15/SZvgrwEkaTBjcwT1OWYkG/rWOvbCCZUGdoF/w/cgybQL9L1v9SCoWoWdVvZOkQ
	 SLv4DFYT9O9MOnVy5xXtWjRiEyMFAoTCaindiiJ8EdKrdv/letlwJ5poJ1tEOIFzZ6zD/
	 op0MCOp20NATu9alJ/SwaCBgqNHYMANlRWkcy3So97nzWN+jOT4ZgYf4Bjyj6V4Xw6yTj
	 ludce3Gd5exMYLDwiFeQHyBzU9uvxG64dKIVHHKUSGsTn2rqaDSZmk2/NOl1/YuwnaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MXtIhwZz;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23B606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 13:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A23B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MXtIhwZz
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso1080621a12.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792589172; x=1793193972; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Ul1u89f2Me/tawqCnw/0U4IgI4PH9koOFwF9pcob28=;
        b=MXtIhwZz0YOrh7OtD1TWkYoNBQoJdAh+mygNm6p+wM8+KYsGVBb+s/5P81lr7Aof/G
         i7EgUgZEPGXDKwuCTq+lnbTgdbRQkE8P5PFNrKZfUs2P9QfpRzdHToQRjJ5DlhQiYmuL
         0jS7s99YeALUZjHPVpKvbZA6woyc7oFr+5KjQ9rxSIC2AKHryF5hRBCd2kHLJGvj+cxL
         1L0aVXuqkEX9IGSr6u1jTS8u4y6CkF7lQlLeYjCCnyJe8NFZ7IWeSqlEeUtWVHoEgi37
         qaK50kyw6FOhudprvwS4cgqI3xl2SsGyxLwWw7RzUn8k6sELXR/cYZUwteaKfPnejhkO
         M16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589172; x=1793193972;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ul1u89f2Me/tawqCnw/0U4IgI4PH9koOFwF9pcob28=;
        b=kwkpiz/A5bML0oZvVqYgUoyClvHuyadY0Tf8yQ1LzPlarXc3uSs+tNwJRBJ4JbkWPr
         nLVicOueU39XL9aCG9mfaMFcpZC5ep7CKZi6YziNGxoG/hZzBcehAkEXq0RVyZsr+RLh
         rYPulDcwkIpzELjk+qme7B2Wug7aD5L9zxvNEA/Yi+tr84kcXyigkVWByyK/0Y82LVe2
         BKDKmtyDCpile6qbzJm/dLlCkvFnTmrK0KVzLlDvfANUNV31bwWUWKVnL1F/SsrfKUQB
         iY6yLOI5He43BPaphJvcQr72RbQ4ISBAd6NetPEnn7TEXug1HrAeo++adwdpyJ97MGdM
         PEjQ==
X-Gm-Message-State: AFq9FYJlTPRbn48MQ8sxwslCwXWGcbXKGPe4ZWmxadnbve4OtaxOdG2Y
	x4ifHv+LfPdU6P9sUzufCckXBz4OxHQwFNSMPRtKiHhSSrcforO2X0+uI+7P
X-Gm-Gg: AYBFou20B32fvmnd5EKvuDwagJtCa/BKxfFiKcnosteVuij2CVp0MpIxDSREcJaM7It
	5OkHRzPwer+EjAlVOvy6L7YLfb8bVJZqeB3lb7poXFUTn+4ahQ+srtVCdihwGEDN42qAIv8fTxK
	GKZfE5A6rY6vwkYfFMvj4dxY7oifBmJ83vpbAnFa/eM7BhUy9wfn5+RSNJz8nV+pZwjjWTr3f9p
	x7um4qEJ0Tat95dDf9g+YRhGJlJ7QEZtGiVOoHn/9Xr6xQecuY+RLbmy4dyguu+147Tf8S6UByy
	bVKx5sgDK5mbj/g2K+uPhhg6DJtoLFgIMhaC6le6ggDz4E0KzBsMGG2x5RlJ4PWQFXCcZucyphu
	OsZpIWKv8KAcBRvYfzKJvtxiArN1HOzqw+2Tw/0jJg60Uu3bH0Ft9cJ57oE2LrYGja5mEtcxu5t
	mKnDoIKXVGp4l6oCGahXz8cIRSCWDhT6c1Rmw7l+UoL4gQ5wNCB5wc3GoGpQCoKZM0S6ZzFGi9q
	SR49ef1OnqNXUjCeBelm8rD7S5NWu0e2Oknut9R3sQM0f6aqye0/ib+EJK3F1exQm8J
X-Received: by 2002:a05:6402:5023:b0:6b3:d0a0:3a2d with SMTP id 4fb4d7f45d1cf-6b408dc358dmr1673143a12.1.1792589171998;
        Wed, 21 Oct 2026 06:26:11 -0700 (PDT)
Received: from github.com ([172.190.85.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b402f2c658sm876759a12.5.2026.10.21.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:26:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792470313.git.tanggeliang@kylinos.cn>
References: <cover.1792470313.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/3] add distinct lockdep class for MPTCP
 sockets
Message-ID: <8482124d-530f-5272-4b48-70d3712aa1e4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:26:08 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39580425199

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f0bcad9487e3
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1189426


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
