Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB975801
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720048; cv=none; b=aaYMj9MPc/uYISJV4r+icCvVz5CqTswX5Wcy+loXroSfQ6OKnIvX0IZkL4Fdk6ThEfAzlGYqHANwUzQGPpfPWddiFQMBHw11H1FFbaYMLhKolTXPcjp8v1hiLf9m68WPadgF6nkd78+R2ugRdus3qrJ5E//mK46+wh7IcLwhhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720048; c=relaxed/simple;
	bh=1JOvtflTHBoJZdnqyAZX9pbvfJN4jVjbUIK2s0+7uhk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=EL9oL8E2oTsdCh9JPsjxGomN0DxavTRvU5OyOftKV1j2WfW9zzS0yRAu1rjpbkxE0Q3WB9vu891vE7F7rwSngdJW2gZEI8PzJUL+DuiW+m/e6GqhnnwQqwHXDKQ9/++CIxbxD7V4oQaTJAigMi//yDqwGF8UrSlOLcjeLOTYkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elDnmfqp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elDnmfqp"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e507b079dso680409b3a.0
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720046; x=1787324846; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kr1GsTlw5voVbw3lcM+AZthBAksQMd5lT8MriGiBGZg=;
        b=elDnmfqpK21uRRwFP4jgX0m6D6/PucGu+UV4FNC/OFonIIGrde8N/lEt0Mtk7xl2rJ
         nGCKQpRUNpOnIIIOXW00rNizCh2eYLM3I2cfLrUAPp4UCJnCWl3NQ8EHrSGCk4xyP2XG
         q7WoNuF3rxFgLKkNlUM9gTVTRjgiVAySfOU5/Yb5wF59pI2kX/ETN6z480HViz1Ld3oI
         AvKG3jPCWrdrqHpCwRIGqkmZO/W9M9EOhH966DrkLYx0n/1zir8Px4YFXxKm64zSyTxI
         jwFYLmthLm+DyKazFiOgDNdhG7ktw+QgoV6ZnrWVr7ns9KAlYOCx301RGtj4td7RDX0W
         aLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720046; x=1787324846;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kr1GsTlw5voVbw3lcM+AZthBAksQMd5lT8MriGiBGZg=;
        b=jdOinOfn/ocCald+BLfGc0hZbE4vuwKjNLAnMvjuJ3Y68nVuNfxdtAFkXrU5OtgsYm
         y0bbwW8pcFJjEz1Zu0X1roKSYRo+nXO2L4oP0v3BJBibUdXzxFxdIe4nJ2Z7Xn86ZJDf
         YZ5h6KHNC8NvPgzz76UGZ3nuEKSP0BQ6IOU1FZdiqg/mYUr4plj1BuAI4DhIm3/ee+lU
         N/QLbCBckRZPJ3rn8tjnnsYyx/os6F/jFHK5kw05f+LtW2CXgIep6SfjFPX2hWVczrIv
         OQA/zDxzSsAtAvAhzTNZ0hDtcrmGyfhdBqHVcoGdk1RlzRLV37qyd6NDIj/UbpUQ0+YK
         KM7g==
X-Gm-Message-State: AOJu0Yy4XcxomrVn6AYzNxtzEtk3IZKlCeQTt8CwMBeGgTIY5e1YLOkm
	E+SUqLOEgka0IZQmKJ9z0cuY/Y1UZgeSAO0yRXgsRNTBMZpH//MipQ4=
X-Gm-Gg: AR+sD123vbI1zZU3i/SAmjEgQV/SJHrkC06F2mFnu3Y3UF4DXnlx+/j6POzBfbU6DbA
	79EAYvinYrvm2gcJZnN0nT0mrq49qPrbgRtS9V41xGSGS5sWx2Q07yogQG2MIIkVC5LlcCHn2UV
	wZz8EZCQoJaNFjM9fHxMq6LKsNcu8bMkFWpuSgi0xjAmYGfopO66nrHlEN4Fr5chXCD19lbD61D
	EBUa+TG0IJkw1YfdNsOByVe+8QVUM+3O+xFcazvj1uZCXMmzNCBNbQMNitforDgrC+gAcq7pAJN
	dbi9fb7SROaPcU7HYsIKCOvEdHGnYXH6EbXCDnIpoJjNlTFLHqNsoPbkRHHOnygYO0duV/KhaG8
	x9gVrV+Qb/MKorNWceWaYcHDH78Ul/nCcrFNRktKsAlEqWDsDVjFqFY6YIj0D7xcIj3eBZpMU8f
	z9a09BkZQFcJVbjJ4AWdhl9FdJupRX5ktU3KsCRRuhh2uvtFGNdq7LKyPVdoFcqczX7rjgfuXDB
	vtCOxflqLx/
X-Received: by 2002:a05:6a00:4299:b0:847:93f3:a4b6 with SMTP id d2e1a72fcca58-84fde24b8f1mr7277134b3a.17.1786720046012;
        Fri, 14 Aug 2026 08:07:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d22a341sm604248b3a.36.2026.08.14.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:07:25 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
References:
 <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: print stats before socket
 closure
Message-ID: <7bd686e3-a24f-b856-bcde-f5afb9427f86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:07:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/318094=
26881

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/47284683c1d2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146126


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
