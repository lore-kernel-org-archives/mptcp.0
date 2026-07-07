Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14526AC5
	for <mptcp@lists.linux.dev>; Tue,  7 Jul 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448275; cv=none; b=MC2+cwUGWTxdHJqaWPRkG3Hkz8LA3YcDhlxN+YBsbyli/F82kFyJuu87Bm1VcWAU3JYH/K5lZQht+IaVq9a+Qzm9LuzWqHsRti86lzPxCi10RDNZLiyf7yTtR2XMU6gF2ppmqDhUkdsm+WWB/UHzx71xUdJoT6nq7sAlWhDBDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448275; c=relaxed/simple;
	bh=+HwfK2nO+O3ginpFgsjuK/Emo2EfOJruXoLITxpTXyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=uPU5UvXwrBzPWFTxgvaaXzXlIhWXzjrCpdEtE+ddkTnmCv4vJsDkVqhCpAGY2QDgK0EKnoI3dU+I7zL4oC1SOy4it17b/KM+udQk24yApEQXlRcUiP8l4zQ65HchA0/vw0m5PxJRm4h2h3NjC+8ucAZAVzYJPruc6y9kVhqWvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REfQSznG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REfQSznG"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc8bc9d222so33403525ad.1
        for <mptcp@lists.linux.dev>; Tue, 07 Jul 2026 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783448274; x=1784053074; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2tdJ3WMqyihrxKxAa7WN45UKTwTLySg83A3ibKrGrk=;
        b=REfQSznGotGxag3kKwWtFegC8UuS9m/pvcKFvyAGRVfrxXJB1sWbhU/lN8Yn5zkSRM
         gctk3L3SQu/E+IWGPgeR/jOB7ens5tGlEvGMOP6me+RCQeqw+N3f8VzhcMqC4uRrINB6
         pMZ+UoqkdbY9x4dr0vR8ghkwmk7CMMhhJIjEX1x+oBI3MNyxd6cLG6Gs2w0cgB7UtFsJ
         /MQ2ZPv+Fmj+M0dGrwcSafY1DQsvCNZwkDNvTidmZzPANOTsqsLURHw4rCooAiJMG/Sw
         L6ipOLQN/bepbLJ3s797FvID4FFcsi0RJwSgWk6P3cfNuSEntBCwQAJ5h3l2/Shb0rSx
         N3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448274; x=1784053074;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2tdJ3WMqyihrxKxAa7WN45UKTwTLySg83A3ibKrGrk=;
        b=ZXMyGUpMWgZFUpiBzD4GQkmi51ayl/AaoG9OGtPiNjy4CGYTZS4bHCTD2KxIm/UMIA
         GGT9aUe7V6cDTXj2Bj0tnVlIc+DE+LxqhXxgwXYgckXw+IcyqQjFl4sSx8R/6b1dtbL2
         ZXrmnHfEsTOy8d+ygydoEnnMW1mSnGbWV+6PCTUyJ9R0SAk9f+CLjWgvCXlrvDaHq8X2
         TcBgMuOvAiXV4/fbge0N+kCqMF9gCyGSxFlUh4M0aVjRh8bKAuQmgKqXphddyskr0kv5
         /4auliEJysae1RO4DlW7/CDF1gaPGCJd2wybRXWivHzWtlZfD6WibrzNhh4P4kg8fr6o
         crOQ==
X-Gm-Message-State: AOJu0Yy3jeMluCmcFP0ewctNmAAHg0Tl36NS7vtVoEkHtF324uu+ViHn
	/9LjWXOA6CgG+cKifRL5WkkZ7lrjozqjydDDxzRAfzR14ARtxWj+D3o=
X-Gm-Gg: AfdE7clgpGGhHCmB1uC61m6iIGpwCcWHAMjCAcKtWmzBRLlTfhWNE7laLd4MTRiqQ4x
	AnQDuTNxvyflwRVzQvtyn7MhonnX20FNcBJXC7GZv1/lng1ZpWmSYB86sh7Uxjzqs2nnsZvBK4o
	44JA/huDISJXu24YdQSrzhuJ6IGXwM/hUqi9PX7iGIvOepINa4oLab+q1Rr2YAILp3PI0ZMDRjH
	gpKWzaSddtfWHHEg87fA0JXllVQ5jQkbctljk2j6S4x00XlXJr10J1jrnY0opUj1Nvz/V/xwM2b
	9//gCIEhARPNvXwN8Nv9SyxlQTasm4J3JgGpBDo+SOwb1otfnH8F7L9p45JcnesHL/KOIPwRMQZ
	XBAjRl3njIDChSHqIhi9MfCsZ0A7ZK/ffkWMWQ3hhYTLJdWUJYxhMeg5+NsJiaSl2ZHAjFw0Bi8
	Pvzi82V+KsEBjbVi8lpWJyVBxJ
X-Received: by 2002:a05:6a21:6115:b0:3bf:6c08:fb9d with SMTP id adf61e73a8af0-3c08ef96c55mr7598216637.49.1783448274075;
        Tue, 07 Jul 2026 11:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm1386434a12.19.2026.07.07.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:17:53 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260707171730.2679013-1-michael.bommarito@gmail.com>
References: <20260707171730.2679013-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
Message-ID: <cdf03179-74e9-c6d4-4343-4d3d4f0765f9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 18:17:52 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/288860=
89429

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cdeb2105da80
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1123264


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
