Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601778F4F
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618974; cv=none; b=LBSMT4NOToqV1NLXgScj/II/Au0ZczxAdrHc0ybP1x3bFeOiydhp9+EklPQnx/VqaSH+T+LzbebVUpa96cdfEUwmbaVXzqxGUflXkOWU7IK0vLRcP0nVUHI54+SZfkBW3WSFpU0mPWOdDvA1xkq7Lv0cPMIK0KN5vO69EcM4BsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618974; c=relaxed/simple;
	bh=p3wxTE7wgh5gDevdinRXyvOOSjIoctb7rHJqR9qGi2c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=edraVGHrUlc0Xq0k7Vs1uoo4eEACWcQL+B7rrFIpBdTHvQAOycm+4xRFds4HPHbBdM5/4ofQ1JmmWahoOus9AJTgQUMJs/NvlL0JT8Nhs0f8IYWkwYF5Fi9KAl+lRep3ypY7C+EjK9LySDEJTPXjIoXZ9fgKc1LETQRn8fPnDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBnGnkmo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBnGnkmo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7810289cd4bso1720680b3a.2
        for <mptcp@lists.linux.dev>; Sat, 08 Nov 2025 08:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762618971; x=1763223771; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZFbNgxc2+u/b23uDvYWuasmyuDyIhVvBPBa6Tm4ffY=;
        b=mBnGnkmoiypd/dFX1Aei4VtL6hZYvp5j/CJxEUZCvfsHh4zq2Lhmz9np0JEZcKZ9iL
         VkpC3AybntKaR0A6o+6ta4Yhw0BvVodmWxOYyG6NbwyQkxxM8NbKbiC6QicRr6T1FEp8
         hEpFmaJLxJJqTiuyyp7ECIp3wWCtWLZW8EpUzNYIxv5EWENoB25Y172XzWK4GgB+MTWk
         TNNXFKrNYcDegGqIEHwHbllnY76gTuOFFePOCjWx+MJHjd4m1SPdEMicSEPmpukC57dX
         hGvrFXdDHTE1pQNFHtz07jQ+2N+r+2w3NvY3MJoKdvnKsw4Eygydw0eftFRFncjFYiQb
         lFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762618971; x=1763223771;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZFbNgxc2+u/b23uDvYWuasmyuDyIhVvBPBa6Tm4ffY=;
        b=mTyy/11dxapBvrkhzxOLc1g+4xgMWcEaLWaxuqDwncSd71k0jbSFUdAh3gHdE1qnw0
         4Zvko56xMdn0Cb33EFnptAxPXtJUpK5sVxA9yfWuagiKuVEwRdRJSkTuETirAMdCHZkA
         FY8Gl5yMKff5WVtXuY1zqfuYsennMv0yL2YtPkTAoQ8XfNIlIhU4V9TiCjG63+t6Wblx
         fkKm6Pd3NXojrwRIRlJZi0YL2twav5YsJf+hwTbW50Y0ixiONF5aKclgGJ08Z5+xo5fd
         uc/l3pLf8ySStIiXs4RJQHtijdTkN8PJ1MOTQvPwelGDPc9dZgliHT65Ml0lLjgkzavi
         uveg==
X-Gm-Message-State: AOJu0YzKbBuUHOOfpqv2MGXYZqRhyWJnOz3t6YoARUOkJ4BU3xzdinMM
	ROqew/Oj8gq0/GaBD5HqEaoiPNJ2eamQbZjE5qOa/Nc6uSkYdNuGmgZPZk1C
X-Gm-Gg: ASbGncsWZXb4WvWhSPpX2DWR+GMAKOm0S50OZUmknjzqRAs8TY8+hgMj/BM3/uyiHzJ
	g0VEiOzdEiRqS/1G069yi7vpErx3SofZIJBtL9JIGNeOiHPJG2cc2f+tjkeQqYaWVwsQpUn9YSF
	yeMmRB3NwERjkOnV/71TrfvkAq51zvu27OHARWc7UsphnPYWjHM1d6wQLn2UX95S77ctW+MMbcu
	VaKsVFTXNrWxh6DCiMiPEcYJsMWEAkfsyc/yHWDygjIAnt1XSNIpvYj5ZKqRbgtsV73LGfYM0D6
	t0hiOb8Y5/kuZL3ljdlYme+uN+wIpTdQ3GvmhVFWkPPubM9YXu0FPVdj7ED/lzS8KxsMSeTZ1X8
	ZC8GVy2g7Um1m0nnGLhYMfG3D96jX3i66eT6/3hZy0yNgzvwTDLE3fwEMdYLmjg2TU89JjLm9c/
	QR7bcCbmoJzBu0FUsfl/yoUpU=
X-Google-Smtp-Source: AGHT+IF60M45uOj/0sXGrod7fVzPA1kMOvq8U9XBqymMY4VEu2phkn+BSeblKfiRcjqy2FSizkOONg==
X-Received: by 2002:a05:6a00:2d8c:b0:7aa:1e36:204 with SMTP id d2e1a72fcca58-7b225b8dfc4mr3882518b3a.14.1762618971634;
        Sat, 08 Nov 2025 08:22:51 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e7595sm6374864b3a.33.2025.11.08.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:22:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f9ee505fd5da965ab78beb4d51e6f479ad8fe4f7.1762553784.git.pabeni@redhat.com>
References:
 <f9ee505fd5da965ab78beb4d51e6f479ad8fe4f7.1762553784.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash-to?=
 =?UTF-8?Q?=3A_=22mptcp=3A_leverage_the_backlog_for?=
 =?UTF-8?Q?_RX_packet_processing=22?=
Message-ID: <622f9b1e-3009-125a-8bc6-201577da2c6b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Nov 2025 16:22:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: 5 Call =
Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: normal =
(only selftest_mptcp_join): Critical: 5 Call Trace(s) - Critical: =
Unexpected stop of the VM =E2=9D=8C
- KVM Validation: debug (except =
selftest_mptcp_join): Critical: 5 Call Trace(s) - Critical: Global Timeout =
=E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Critical: 6 =
Call Trace(s) - Critical: Unexpected stop of the VM =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Critical: 4 Call Trace(s) =
- Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-debug (only =
bpftest_all): Critical: 6 Call Trace(s) - Critical: Unexpected stop of the =
VM =E2=9D=8C
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/19194275866

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/83be86fded=
a7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1021097


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
