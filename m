Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C81607A4
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123353; cv=none; b=DkP965ylC1mlIwMd/RQ9iO0grcJ5BRg7Lh+RMqR7W23o4LVw68i6PBLLQ0V4/GwJPI5zrecaUsey6+BmcAqJK8mtjuYGyYteD5qvoLr/O2MYMTWyvR1rfBaTkowGh788bS+FVN2P3Oi8RFA25icjRSEN/cigvNkQOXgDXXrhLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123353; c=relaxed/simple;
	bh=l20IoPZEduUY9jHWFaX8+8tVHjA6qWQL+gP8FJ7N1Rs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V2PvuYUd+148tHqKMwUO+JU9AHOhxHngPhggkVKZbZLT7EO+tQ7veqBCt3B3q0Lsh2U5PGn81hn5RUsosANYaqVIZGyIVOAyuhWMI663jBO23GXy5NDgYwt2N9RjeEcKGDvl07hjyFnGdJEr8p9O7pdWRWepV9jrORL1aCaWRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6XZN4JZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6XZN4JZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2698d47e776so49059155ad.1
        for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761123352; x=1761728152; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYXtBLWU2E+8s5SP9cLIAdX5k9MskAFhZDEKxJzEe0g=;
        b=j6XZN4JZVIWmbkxTsMXtRyjtPAyZk110NTRsWu82ukPEHptjOA4hLmkSiYRRTz5PjP
         gQK7ivQtqGCwQmXYkxSVCmBUn0oOf7Af2GTS9uJ2qXSjPTHjAZzcqlmprcKn09fO1OzO
         7VdUI+2ru4BmI3jf2os9rjSCrLC+jjNNN9EruW4eLJ5GBiDbPtl7ZDEgGJcAl27v22KJ
         t8GdwpihQzu3AoF4o7aAJVrmeqcvXJgjLZ7StRLtGOb/rwOcK2AlfMtQGMbTm6jWqYm+
         eU2wk3xLr+9adczsKhrbR0UCQMJ4VhYqI05Kh3G8YJyNlp7Wab9VChIyfoUIqgy1hAJc
         qfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123352; x=1761728152;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYXtBLWU2E+8s5SP9cLIAdX5k9MskAFhZDEKxJzEe0g=;
        b=A0e4HZXl/q/XqEPTMn1ZQC0gSogDNAGTKXrVFzx3TxhPs6ey81b0hRPG5nAiaZ9kqD
         zVDDKBOSzCU9FgqE+Yn8Ayv+InNrQdPvsHJSiPa8aeBDb0gfq0at1f6xVW/pfIh2QwUU
         Z/wh1VhQbbCQpj6Mp76T0+UXT9NKNmKtjaR6YCjKcBrd3MFtguSDRuawW/AC05h4ORmP
         CGFIwLF6YzyiOG1evQL28j8hQva3bzFD7eX7sfBK+50HjhZ3G662zSHpG0PhN32GtTMH
         rflBsQq1LnclPSyERJ0Scu+1noc14w7M2MJKO0rqvu3adFeHyXX716Y4C8xdl+kt4XHB
         5n3w==
X-Gm-Message-State: AOJu0Yyn9P+DHKUQBdTG+I1xzoFjPYlUXbS59t+EarenU0NhApJBX4NE
	0Niclvw6ZG8M6JqtWvfNyicCWsN/UE+2+d9MPojoQb6HM+qeisTwMVo=
X-Gm-Gg: ASbGnctUuNkHia+2x7FOsK+cV6IGbBJW/hD9F6gmWpVENNzTFQJ1D1YBKAudunepYID
	H+olff20QlbdnEEt2uL/qQYqwvgBc478N28W4zxOCzrgucLBXmJsRMCf3VbdlTxo4Z7w5k+Lq4O
	Qu6/oIWatEX81uEIiIvtDiP1eeqQpuOQJG63llFUmonAfPkmdCkWCUY6WJbhBFJHxWg0sdj6XQX
	6b0va/7jy2WDGT6LITe/8Y9757HTMHaXYDYJebsm13Y3Hh1b3/A20QxL6pcJEC5Fa8yuquaL3Xi
	BVCDCCoTsCkpljDwTuQBzVe42dU4z5U7IHO+RRCL0kof4rBuUCixWoebaIjlMv3HWe08vW7kzLL
	BP0FEY6/FRI1v8jK4Wav48jFNgRQ3oQXfLR5SALilDfwZ83GTG93kI24cPvZt2UllMdz8xStshM
	ipVkq/e3r+ZAtOfQ==
X-Google-Smtp-Source: AGHT+IGFvyzE9Nm74/LSfpEElYBYz5TgxS5lKE9gTJmZIPsXPezsyz2dHcjiZ8TlHupcLp4SMWNzQg==
X-Received: by 2002:a17:902:d4c8:b0:293:623:324c with SMTP id d9443c01a7336-29306233739mr19604885ad.22.1761123351507;
        Wed, 22 Oct 2025 01:55:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.154.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2dasm132018375ad.94.2025.10.22.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:55:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1761118636.git.pabeni@redhat.com>
References: <cover.1761118636.git.pabeni@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: restore zero window probe
Message-ID: <7c3cd9f2-81ff-3efe-5138-8d38fb59b69f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Oct 2025 08:55:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/187094=
17366

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5d3c078227a8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1014382


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
