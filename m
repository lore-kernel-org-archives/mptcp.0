Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FC215192
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016784; cv=none; b=ClpHhSLpc8j8+G6ue9BqBQ5i5yh8om4CZ92yGtrQVp+u5dQHOVXv4p7boMd8v4T8EphKix7PrjfYCv7HCbAJMp6aRjn7S7kptHe36Yxj9laU+3nFrxNtTYOiFUJmehdZfOWhZ+i/tli633YhvGVWOoViywQAXafNB69SV8+KmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016784; c=relaxed/simple;
	bh=DOYzt4aHm8NGOdNHKUPhU/+tlthUZ31WGhnWb5c4sD4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=A0kjiL2mcyM9sivLyJXw+pBu4d6kRQzziBRqrFOimHb7CVVnc6V8y6ApMlQIO2l8IP+cfiGKlGVHLyfnBTdgGrTf3uL3/YbKxOjxFSMvnASfxvNwlJ4hB0CDhDqw7Xwg14PLl9pjcAyV6XkjAIb9T2ANzlLZ5/vCpO+x7DmBU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9rFb44v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9rFb44v"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso7507446a91.0
        for <mptcp@lists.linux.dev>; Mon, 03 Mar 2025 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016783; x=1741621583; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPeSp4e5GhSkN0AA1cF3Tv6HIFlYrvKMEKlcADReQ58=;
        b=D9rFb44vLKE2u40tw1MR/CyohxhhiDkO07V+AN4H40jqDfjvckaS+A3OVejNgn0ZJr
         zqwWgJzfXngligb+j2mPW0AEllmKbpOqS665bp2BiCQy6eVg0mx7uVo9c9vyzt09QrDr
         qN0+4gPkpem3hdLXNnQNGOC5eGDnAiBWU/XM0mtmsHh4Nz5KZypB+d5auiau632/CiBv
         AWPtRTge+z4Nf/m2UvMFECNHna+E/eHpbvw0iS1JWupOnTDFf6MYm5r7E4pM9pdo0oDz
         8tZkl4NNHRR4MFwjqrY5GOxdYlsPs7sNIqQElG7vUZ3LnZne4RQ3mJIE1qsKnqdOX2yf
         eN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016783; x=1741621583;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DPeSp4e5GhSkN0AA1cF3Tv6HIFlYrvKMEKlcADReQ58=;
        b=q/r7d+KBocbK1qaWIXCXBBYZblNZIwnNyZHj9Ur0ekEEbD2ZKPIM18A7ryp1lxjaC8
         Flgyf4BEqthaKcwVfsP0MceH+GQGwGcZqw4420FkXgoFooJZZdiMT8qeAudHhUaWRBYr
         ybjZL4FjT4EuPJxgvry91aV9KeC1oLfVh+33b93qlwwShIZpMcAOtHERl3a70Sc/z8wn
         0jdjpCEB2I/Z8F8rTKYOn5YlVxg83SqyzEtJKTE71z4t70SPLZl8J2R6SqDq1UY3I/I6
         pexjcncvk6d1TJVxwz8ILAJX0GFxcke+Oqo+pctOuNJ6iw7taMy/sZRgtWS9jRYRuUZf
         dOPQ==
X-Gm-Message-State: AOJu0YzhaOYLAoC1PQw5sWaUC2r8ucfuAZeJ6CdGODLAj1M5fYvrMxBf
	0YXSJGW1FNhCb2MU0Pl2VTLClWVyqq0KsflfwYOfWfxXqXBVP9WwKrNjQzU=
X-Gm-Gg: ASbGnct62930ro0dMU0Q7zP/f2uUh+Pyf0Rk3LhLBnpHgzxZsHndw3/zHVGzAax6FEP
	v961SutX16gDI2+uDNxp0fnngdgXUCVI6GQpgD525BLeTrTBc5f/o0Oe23QV+1rbwd5JGNseo5H
	shumPa3O1zxMl6DkPJnRbRH1NjDly0aCLHr+FCShtQEbxNTHTJ5vuXzHEyltuy00CqLBQelQe0C
	PI051ptwZx4Ps5vRMSjeAs4efPF+QUOd/jbx+lOsDQoBiqEEVNxh3oZFvxJGM55/79Dl5XFngAD
	7qpS9cUBXtbNadRTW4bjjCxMl2zcLEaqkohCctkkPOX7gaX4RbbJB5M=
X-Google-Smtp-Source: AGHT+IHpCEaqJmk5X1FvnEZpsAo1fG1wMaZyGk0yg3t0B/bWdbjHeyQOqrSZG1ic4RBWD6U66y7HXg==
X-Received: by 2002:a17:90b:1d91:b0:2f9:9ddd:689c with SMTP id 98e67ed59e1d1-2febabdee52mr20406916a91.25.1741016782607;
        Mon, 03 Mar 2025 07:46:22 -0800 (PST)
Received: from [127.0.0.1] ([20.168.85.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea69909basm9108192a91.46.2025.03.03.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:46:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250303-mptcp-pm-split-init-nl-kernel-v1-1-533c1575b5c2@kernel.org>
References:
 <20250303-mptcp-pm-split-init-nl-kernel-v1-1-533c1575b5c2@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: split netlink and in-kernel init
Message-ID: <5d910a67-a0a8-0335-fc34-809e99353165@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Mar 2025 15:46:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/13633693015

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c3fb924097a5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D939640


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
