Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237221F03D2
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852156; cv=none; b=lh7ucnFzozRjNB1BZCHtsngmbrZXrDAFz5kjvnEhOCP43jA0Mj/SPUAuuRlLEQXsvHgJxuEuZjgGQ5cThdo/BNh3fZjezfqor46CRcRfXbPRZ8NJjCwKok7ns3U2cRT+zNqblW7KyVf3FMPWPLEDWqAFxVTqo7j6+kOL4L/H2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852156; c=relaxed/simple;
	bh=zMpwqZCNRdeY5l3Fzqx33Wlr4oEXjpiGi59mLSV6lrU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IU7L7Ch0FTPtJKAaIkWWGSnbJjyqixuHyZb72X/WJiKipEJPJBnwU+tSVHKNrVlgmsTGbxnK4QGO5svhxcq33qhPt1jBfnRl0pZWzjqoFA4F1oqZoDj44zA/BbFNH3kEs/4a8HtNzY77KCN+wgOItvHY5XvxEiMkbwaRagQN9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=melcz0We; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="melcz0We"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3085885a12.3
        for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 01:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762852154; x=1763456954; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFFpThtQxQYtEMJajfHurZ1wMnnYmfOB6iDBhEQ/xxo=;
        b=melcz0We7XqpZoQ5sK2qlWGysEf6A2bL4t2h4qwOFoV9+KyPdtfq7CS5YSh6zFA2Fb
         w6ASzU7aP82F9UvyfPO9E+IBdUW/30GwC2WqOcNjBu1aq0oFKARql++PegK03/IaOBN7
         7GIRVhASVwZoUCtWNwobZsqqwHm3lJWfu3rsmD6L/vxdOaXestrYJvdAUmR3JMWAa6xE
         Kgg9SeHhJMiSTa+zOCQho6O/Q2p2MHuX2Okg9FYxtfCALJp823W9ihxnICsft9Zz5VA8
         L1ye7nQp3r4Bq0f/HIRiWsmYhOPNODCOAfpeJZ0+A3A0dh1Qsj/uZ6/5L4dc6FcXrgVf
         Qerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852154; x=1763456954;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFFpThtQxQYtEMJajfHurZ1wMnnYmfOB6iDBhEQ/xxo=;
        b=vDplGyJ1s17TTSjY2n62WcHYJNDSjYpdT06XbugcXDDra0w3ZRQFwWfnxfDpcBQggx
         +oTnKzRYYE5wNeW/tkDIbUH4xc7DqBbmKqnecgsfs5XtZumO13v9WJdkJ6UIO1f4lptl
         RBPxzHKY/SLLaDFUlMgo0+L70LWb/e3jFQ13mE+l3i7bMTrD9vk67m0G8rOsFJA0SaCA
         rUQWRH6RP4uIg9Ml67fabssysBA8eFyFMhWoXctkz4K5KXPPORKNEInyuw5pvQueDIc1
         h2Dr9xrf1k5yzEsiVAdtyy/r75XovXkxwhU80IBaDEKdeC7G97nadQs6wWN+RfDFudcZ
         Zx8Q==
X-Gm-Message-State: AOJu0Yx/lRhE5TOC/+Qq6D7xQMD4ApO3EomV5Xu8cO6JQshy0wHJTgmv
	H/DB+L7P1FojCzY9nHjAUrOkqOsikg+ErQ23ZeKrghAgTOXZ/QNS4X0=
X-Gm-Gg: ASbGnctOHczOa8374Xq8XPFq/bb+yk1PjDbwvhUO46bHd4nq4qFEQAP93u6wfIuo9m4
	8a8OD/6S6zZKZQLQlbpKzcVH0gjtkBfzdcHHKOKeXF1/qXc3/g3Uacnq8Yr+ncugJwkt/tNpRlB
	lgKGJSlEh3PBuwEYtYPAXEDpgReqOW1jlLx7yrdRqTmvbIunMmgo1y8g3E6brytkTxxsshdIG7H
	i6pEj5VTnriYJY2QYJY5R5tc8dr4YV4FtNi153KqiaBm812JywzvuKKzjoAYfZAvW9+Tn4USetB
	Ma12HmCq3IdMApJB1voAk9FDBuws0aftHe70wHz1DAMd7QDWYqws2tWqYMJYicv6VurwSpuN8hs
	YWQiawKfp28o/YGBtX1s8l2RI4ixJW+lPZo1RQiH6tPlnebEc3OncBGVL4wU47JdRq1mOaI4EOg
	UJWiRWPhmrX0OdNz0+uzxCCnw=
X-Google-Smtp-Source: AGHT+IEd8wysPImCQ7SN+GUaH48ZSJGZOTUxqoYbkNWqQr2Y/6zNzSbvx6lN0hqNnf25WNVqHjBpUg==
X-Received: by 2002:a17:902:e847:b0:295:7f1d:b02d with SMTP id d9443c01a7336-297e56476f0mr164841315ad.22.1762852154277;
        Tue, 11 Nov 2025 01:09:14 -0800 (PST)
Received: from [127.0.0.1] ([52.161.75.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm173147395ad.92.2025.11.11.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:09:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762845791.git.pabeni@redhat.com>
References: <cover.1762845791.git.pabeni@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: a couple of fixes
Message-ID: <d51ef5bb-5cd4-f523-2f46-add9a7ed5d1b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Nov 2025 09:09:13 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): selftest_mptcp_connect selftest_mptcp_connect_checksum =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Unstable: =
1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Unstable: 2 failed test(s): =
bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/19258711974

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fbba16487ba0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1021913


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
