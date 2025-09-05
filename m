Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3B2AE8E
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105188; cv=none; b=C1YBZ2UFTR+WEvOiuSlib8WvgNfE2eOnl9ceUKBeAXvAWjA0RoyQLwWqxKRNamNifcaCca1f0ceFkqg4ahDCqEwZOdqvSY81lKbVKS0McPQrYCpSBB6bEOqrWi/JIcZQnvQGwiQ2P/i/ZuUFjntoGvU57OfqIxLS5Amsu016HaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105188; c=relaxed/simple;
	bh=6JBU3AQrIyabUfDuQyAF8hzsdAYMRrIaW9sQAY72I70=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Cj5OjBRbEDN9KYUBnxBcfaPNianvA3zX72h7LEnL8J6N9jYcZ0PJhm0Lh6N1fkds+A8EVMikwXUlSe7gYfNV4vBrinz5KV8ZLOMw+h/eLAwT+h+2UbhrNrrTgAz8xcfvRiU2Qdx5eC/gN/5I+nCMZay7sCIiHkAybACpcvZr7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsrWTk1O; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsrWTk1O"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32c54c31ed9so561532a91.3
        for <mptcp@lists.linux.dev>; Fri, 05 Sep 2025 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757105186; x=1757709986; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnrYdsy/dhQZrZTGvil+ZTCU6y0H9U7xHZdIYFJcM0g=;
        b=DsrWTk1OE0ep4aMUa0kv+rp3BlToC1QVW8zCD6kb6X3L6BfUv9PRekghQtu8FpCEjj
         SMy5v05bPGKMVAV58emzY3WqJdqBDvN1LruCKe+EU0a8qIFUiZXO5gKDH2OjvANQPvNw
         OXuZKg3f33QQvKZza19cNuJ9gazO39TSqRoWDtOH++OVBDgsPHI+JF4jb8gcLks+rlAs
         2pSbzfbrVjGl7AAhPoXDUSjw0uYenujAC/OVdydlBaq58OQUzN7CAK/1mDnkIt041vg0
         OAuqg9PAkVo2FU7EAEyXi8Vmz7OrivZ0nWrg01SErl4xRFO8c3jrp/j8XpAnq/N/Wyuo
         LZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757105186; x=1757709986;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xnrYdsy/dhQZrZTGvil+ZTCU6y0H9U7xHZdIYFJcM0g=;
        b=IojKe/MNJv6qS0VxRAai3KBG3sprei5stLMoE0Q9eh/o1WmZr/wGcgocSAWo12xzOr
         qMknvV+vLqm0rRTkzYB1ooIf1mjBTLQmg08vjZM8IITARc5rTUgzSKjG/8NVDa/CDsYX
         xCPCAimXfsb2A9rAfLiiXj9gJWmoNWkaCYLRaKfi9uxpetRCVQJ32046NZQle1laOWTQ
         vDn4f+vFtS3L0vcn/WhHO8QVd0Y4j0xCWDKxRlBZLFiXOlin2dPahJqvwxrP4GJl7nVB
         E1S4jKdTxQSL+ssF607J7eRE8TX6JMXZ5Xbzt59OsNJdFQEYtrg/EWPmUD8+pIIcr1nf
         1tKA==
X-Gm-Message-State: AOJu0Yx5sjWjvQ8pBfnfcsJknA23rPro5AveafAXpeYWm4H4zGHvAp4g
	0oWX8fJaKoXSe2gFhkT7ryL0lmZJVA5X8GCeXRF9cHPVC2gchiGJ31zyiBi9
X-Gm-Gg: ASbGncvJe7t1fHj7HKxA3A5TBbJ6rxNnfcT8xNpoAjZw7N+a2PfSd6oe6ya78/jRTqF
	o4vgUoXy42MZwQxEkHqV3Sdsr6EtLS+YtF0o+7nazP5IoFC9qcwcXzZD98cSPi8VMEYyb12ItBE
	7THw9zxTSuH/2J8pKySRS21ilwt7XYhqq6yilwL8NCOGzoSgAJ2v8bSbiWdwnF7C4mYj2B16bbR
	aia518e1sXOf1q8EANN6sP5y702H0js1PmuERboQwyrLUJ0fRyF8g6b0iVzep3HDmUddbxcm9RA
	ijBc6am3R4WzA/Szj80eKV8kUGlBjrp6y+btYbX1icDP1iTq/uT4kD15/ecndY+SQpJrxfdwY1u
	GEYBxJcEAREOiWCMQF5RR0Wl+6+z/H1T7a8r3jKwW0ZQIFA==
X-Google-Smtp-Source: AGHT+IH6VWVLPMGk7f632xX/nUQP7G9cZeb0U72H6GTOzLJfz/OCqDf3oo90gI4CQCT2yutjGItjzA==
X-Received: by 2002:a17:90b:1d4c:b0:324:e96a:2ada with SMTP id 98e67ed59e1d1-32d43f6535dmr244149a91.21.1757105186319;
        Fri, 05 Sep 2025 13:46:26 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.61.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77241f08b3asm18894820b3a.28.2025.09.05.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:46:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/5] selftests: mptcp: avoid spurious
 errors on TCP disconnect
Message-ID: <5eb648c1-4723-7f9b-ae35-5c6aeccf256a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Sep 2025 20:46:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 3 failed test(s): packetdrill_dss =
packetdrill_fastopen packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: debug: Unstable: 3 failed test(s): packetdrill_dss =
packetdrill_fastopen packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/175016=
34949

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8e609acad818
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D999479


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
