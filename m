Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642B2BE7CB
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171857; cv=none; b=ZqcNatOCGPgJimxsoBiZPsbMBXC92jiaNPbs4AlYQC85NQ8FUvUtI2z6no08wiu5c1zq8RmhwzoNhF8UTsSfZa+f0Fr5YKHnxA1qJKSA+fdSv0Sb1+4WPyzELQzCnQf/GScZ1GclkNsBaaLqTylzrywyqP1cgur4FzoX6FtUQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171857; c=relaxed/simple;
	bh=cXQHCrKg9LtXIHj/BRYdbojfDbw/TXVlf78azb0D7R0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=flcnFoEvT+vpdmXDYpm7RlNIKS74kH+c9/sQQTA44RdGFmneF0an6kDVsguR6pa8A3A4r7GIJnFvmJTdV/KeA3DPfEcUVMU4o67+c47XscUfi+HMmijhVJtI6iGj+q/0XPrLBU2ALBZoRmq9ZJmYRJdHHTW2se3MyrPNvi8NeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKBpZEGz; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKBpZEGz"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4332ae0635fso10736965ab.2
        for <mptcp@lists.linux.dev>; Mon, 03 Nov 2025 04:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762171854; x=1762776654; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GZG2gWBvDPowWnL4rAvUw0WlC/zoHisq45jLW3jS2Y=;
        b=NKBpZEGzinpqh78GIAjLE/M7jVE9J1293KsFAKYLCNzQS5lukJvjvhkvhhCVJYZCaK
         5ecjT6mUAGx1V8O8cKPGgQ2USeNbu46nWUOiN9hX5g/cARFHXCutml9T+T8Q9RBEqkZt
         Bj0ogM4fdy8QatkgYsWNSM5jHlEr+jy8cUOYuQ/Ukm6H3h7kOsjUUSpvIV47Uv5KbWV1
         n7X07qO0lLPlkuQQrUSDQNTOU65gZNPcx7EdNRGMmMVZxQ01LWWrhgXEwExsLYGQN0pb
         T9DaA22Vw4qYhH/fwD4oFO50UA1aLT4JmTypdHe7aHkB0hHPJ9FQTajCKrW8rWxjKBzW
         yHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762171854; x=1762776654;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GZG2gWBvDPowWnL4rAvUw0WlC/zoHisq45jLW3jS2Y=;
        b=eim/zEw3rxyNL0dkaJlG0wjBUIPFKHh4OXzUy/idQbgcwIQwjQ95kOpvH40OCmlu0u
         pCvAFbc81P7ZPf90cYRaBRhSX9kMpDOr2mkoL13GunsWtVHc6LOKQrzKqR8GLtYwvtwz
         GMa51vkb1Yc3R/8aWZ+N7Jdsjp8LUdM3t11PZ5KyzpimNS847LBwmgU9sr3s1yYcLbe6
         5A72PAIa+MnrAIC8VYq4QcYuGojNFZ+WEXBSC5RUraS4gYlfpOq7+dzl5pOdHhXSKIFU
         PHaNjcE0QMbYbQpktjjQm631RZgvLXEexN4TbG1GwTwja5+C5EH8xOL6vQvnpjXqXScX
         VZHQ==
X-Gm-Message-State: AOJu0Yy6enQmIFWedUjxgETfOFwlRM5seME5yfjgzo7YGgrkpG4NdIBD
	m7c9y2ZRh+dPIaVAoTA4AvDsMqDMemi/JWnoH4doz06svjo7N0DdOUy+K1r6
X-Gm-Gg: ASbGncut3yn5+OYiyb4Lh6jS2vF9OyVNQ4Fonhbyyrq6QowwEnpnOBCZ2+AzKXXEjay
	fFa6e9KbqQyPazrpuw0+u4Novo5E0ZNBP5gL4ZlXFAXhINDTLoEJnzRnlS/nhz8vVAVdtVtlaQv
	5cFoBO801tpRUCzajhkFt3VoypzpSiSAuIHucNHAoN2+kFvL99Qt+MZqYoQMF+q1PFuUX7Hpayp
	EQhLki7Ww25RDri373x8gSoF02UmGFSqtRSebS0kRqKaFM/wwnB7irZ08vefxXR5LgYvOgIPH9C
	1urDNgooDT48x8GGN27C+nPm8bTeLU7T67LJdGYWQ1O++zrs09Gm7hcDK6wuIppjur7qixBAEqG
	U5a6wrr1LsdgvUdnw7PlU6GQwpRtVRpANY0CKrN/y2nl8qX+WMWV2NWJ1FqiXH2K/aVYEUyOEbT
	8h5R8GmD5NJSJUeN6ZtdQpUzYN/4ndfhG/OQ==
X-Google-Smtp-Source: AGHT+IGDkEVuhb+FmwzAhxnB6icBAbOERXeujtyf2AjgzMAkaHICPzwpv82IX5SraKihMJyd/bv1Yg==
X-Received: by 2002:a05:6e02:1a89:b0:433:34b5:37a5 with SMTP id e9e14a558f8ab-43334b5398bmr4735755ab.16.1762171853960;
        Mon, 03 Nov 2025 04:10:53 -0800 (PST)
Received: from [127.0.0.1] ([64.236.144.97])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d074sm90524173.1.2025.11.03.04.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:10:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
References: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
Subject: Re: [PATCH mptcp-net 0/6] selftests: mptcp: join: fix flaky tests
Message-ID: <e03802fa-bd0c-4901-5fe5-049c4751a584@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Nov 2025 12:10:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19031599358

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dccecb55467d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1018473


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
