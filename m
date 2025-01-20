Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EE1EF085
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402533; cv=none; b=GF1Ae5KRivnB1BRDyGysZl3bnbwT1a9fdHcTEv8lMabNRr+w6NtYfJ/KXxWuazjnv7rALpwuWZxCqb4D80yS6R5NKXOVL/MDRh0O9KUmaazkSg2bZuzHb2CZJVvPPzhcQytheGsRt5vY0DJttQok3a+LiEyOPD4TI9Mm0TLf3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402533; c=relaxed/simple;
	bh=I7LdFk0chvy69vFnwL1n2Bp8023bfSq5cYn1WFFKMPI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aTqVy907T4cvYyyf3bAEpTMGfS3uBkCew2D9EUvDmTpr8z7wqhVvXMvG20cMiT0hJBuX8i+Zggts9wZ184qhTumAVH4kV6klFjg38UT1/+aQ2caM6B+b6bXseVcbDp+chWJCAS6wv/HQ0nQ+KxZxcWklt2c4hGVGlNPyrZTAWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6pujbK4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6pujbK4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46783d44db0so45553541cf.1
        for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737402531; x=1738007331; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG2QkXa+Tm6hwYtAu5hHm7bGsaLAyCMYpIG0Ik4dNCg=;
        b=Z6pujbK4iDw4r0YFEH4z0fSaSLXFLlbWkchgg0SbK8ucs8N0+JQMJOSPQbdXVbAVNf
         S+4vwjCyzsjuKGxBBqcIjGLMS7t8yezAVzxDFaKCqq2osZIlk5npcILaYXlrYYKHwFF+
         MLvAEJYBe6BFlXm1ryI3rSJacyeqQeeWZONUO6C0a+bqgafuPc9ad86Y8VViKg9akMwh
         u57sZMWRa8qAC7bDoGIV79P+UBBsGgG3XOf8qFli6A2/TeSGQMZ0slIdQKlJreaCnBC9
         /+wsmjFhu5P+TU4yvmlHXm5O5kUTfQAyDjHhbS2amRZtPf71u3vtR0dcssJkskAfVESl
         jB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737402531; x=1738007331;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nG2QkXa+Tm6hwYtAu5hHm7bGsaLAyCMYpIG0Ik4dNCg=;
        b=wQP2XqKWcjPm90jokkDY4fbpiR+fffbS79+mM8XN77BMuWidqgfeIjH66l5ePowr3w
         olHilU4FHzpPkEKmchiQAGWyx0yby/K/Rq633JMTS9X2LqiuW/4dyWsLbopxGZeV4cB2
         ZQ+lHz1Z+is1vM7jPiL819JmDwdSYxWlf6OsDSQLrEJHQrIuYxAZiEru9x3xrn+Jrcqm
         PUZXAjLU0z5+nZsiaebT+ya8GhdKkfL03E/DmzAnSS2KATlHY7JRLbs6V22kcefoUeMV
         axFfdgYbUFshj4/Ueglc0HVJOFmTwMqnCix6VQqV/pcsGkOJWZsfFcsOneRb9qF2/Ss6
         Royw==
X-Gm-Message-State: AOJu0YwJrUksonJ+mj2H6N+GrQeSE4JV1ZtSJPrEqFtI75UMg4DFxMJh
	Wgcnu9/mWo2bAEvec/vJxNvRKlgPZqmm/B3h1gkE0Hahe+VVtDs=
X-Gm-Gg: ASbGnctcgnT71lqIWZL7Gmqx0B6d12mAibUZ0UESoJV970igtgZcGdrYGTdDzg38G7i
	nVZ16yqey500qH/QA9DeKhah7ZDqG4TvC7dfd20SLB0nvQft8R1VAFlsMgGwmsE3ClwZ8k2yLMM
	/y7SqvzM+xtyuLVmcn69e2xrVKmTH9y5cRtFT/Lp9KlxFebBFAGqyk2Solorsqf3Dv0p2u1N7/0
	xVp8sYGh12o2OpLCZIE2Zagw3ZqsrJmBAg1fn5z3jZNJBdnuWO1skPjXi3nGsA8oY5MIo+NdHV9
	xBDIddTs
X-Google-Smtp-Source: AGHT+IErlb8Uxi468tkskEQpyFWQq6g6uuB6CJAhhlOe5nAei/7Wfs5/zHDQKOHV+TPNVHi0PO4RrA==
X-Received: by 2002:a05:622a:2d5:b0:467:87df:851a with SMTP id d75a77b69052e-46e12a56380mr222132131cf.12.1737402530934;
        Mon, 20 Jan 2025 11:48:50 -0800 (PST)
Received: from [127.0.0.1] ([74.235.134.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1042efa5sm45610691cf.66.2025.01.20.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 11:48:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com>
References:
 <e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: drop
 __mptcp_fastopen_gen_msk_ackseq()
Message-ID: <3ba5aff5-87c2-25b8-31ec-e2239e107be3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jan 2025 19:48:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

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
uns/12874182997

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/edf562dce216
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D927035


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
