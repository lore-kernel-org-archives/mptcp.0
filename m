Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511F2F6914
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944350; cv=none; b=pm7idDBcEX6nIet9QcTeX4OtRFXySA9SrIVIL0apzhUDgBrQhCzjuHMBrzCU8XXOYA1dGBwatzwIgWAyCxhx1E6dXKWiZ+fxAKHCzHjoB/CNvJ4CtGOw/UQ/fsakw2g17S91o438yNnj8ea2PZkbmBjc2kFLrxL7AcDxe2YL2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944350; c=relaxed/simple;
	bh=UvnRFGQd+DgcprmDmeHRDLBiK/AsiyK4/CuO5dn89iA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RkF/FNvV6qMlQ1Fylg5su4CS/VgaQR5lYK68b9B5ttCrVEs4jc3mp7aMP8vHgb083xTDPKRStoTOcVKo64to2tUMlxSZmnQGZwlNRuztcipLLMFIqIuThCGwdG/XJa4gEV19+pt2kTlohoeiydq4TifPt7PkPSQwRLqeUFXRcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i04pxqfV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i04pxqfV"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88245cc8c92so4855036d6.0
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762944346; x=1763549146; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2XyCPsCjxOKtXHeT1575W5M7CImCGQtVgyMycP8yVg=;
        b=i04pxqfV4Qio09DmQXRrxspr5r40YeIU8gvRf6cdf4X65FOv9D0YY9H9JKyRHk+fqo
         P6zSUPHguBsDdvrinknykPvO8YxHHoq1RUQwQEtMHJAOzfUOfQcmVZ9wmtapD3LWLw31
         EE7Ra518GZXODjJGZ8cwySS5L+bbIHDCFBhKUidFUqQdDkKO2kLzr8eo0nTNKkP1/iz8
         NJhe1ttwDAB9+8LJbdNuoZ+BdhBcPRwZLQUSR4d8esSQNW/5o0XmpF0Of56amnOOdexo
         omvqlhQMoXgz82mFONi57la+lhT5LcC/U6IieLzQIsoBhYE1uLMOeS0V2N2fSlrpKDFE
         XSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944346; x=1763549146;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2XyCPsCjxOKtXHeT1575W5M7CImCGQtVgyMycP8yVg=;
        b=eV2/xyk+ecDR0aejBkJBHgAUCKOty54nw8PlOkMJFmxsUSv1P1aX5pJLR007K2ffiP
         3vP9E0CcY4NZEKjfvLnuYV/dDLzjAgtDVSrTi4fBfxO4ZCis4WE28zjp7g6t9H6yaUBb
         fkRXA/lPOR+K4yGZp6vls4CuFuhiO8l+Y/RzpyLUsfN0xD0SxBpYrYiIQCerB94HSeCY
         x+MdOu6WYjCUUVx3K+attQAaWfynEVjg3zGccuUPBsVFAJ/D6xxBIh8Q1P8xIGtEq/N8
         P+wIU8ZlV07NRx9iWjwy0bGZsvCJ6JmWNoPyUljnk93NTuwczFSANAxfPyevAugezD3J
         iWqA==
X-Gm-Message-State: AOJu0Ywt5z3I21Z5C8YlAQTKUsQ91BgznZYYz62oka7AioQRRP8b6fjy
	h57ejvTrBCM9djO7/uPBTct9gc96RSNl/hWzpgoBZPJJ/X/LZUzT1gU=
X-Gm-Gg: ASbGnctj2q4P1Hl16+6ARA68KoiiglIwqdf3qGr7AyH1SFoo4zg2jVfVET1PPgmq8mV
	SFSIu8Pzfp1A5/4OVDlCkYoLRks8u6jKZCJn7M59rn3GiqxjBASOQoVkxzhYv69szryBuZ870bg
	pCdOJWLTrkEqst8h8SFmsjcwyhjRVKBgJSlThoaAeXgT9MPzcDM2ESc6mgwS2mkKI28ZXK1t1Xi
	8vXUs7NRJViZQzsX6PDPhW4ZxkoE/Cilfj64i2RX7VfJAj2K7AYTiz2Yx66yNQPFdIrlntnShM6
	ZIqBO0spcqujm9jW+VzOb2G3pTgY1C4T2fEqGkiIs5pQm7SSjXBqyTr9Hy0OxPzbb6M31TFT87U
	kvD5yAHtQP3Na9uYpwbieKhFd3DADMj92Tpzk9fZVGVH0Bbu0xv1YfuGzVQiPnBWwZ2N7jCubz+
	jzIwHc3Acvouqg
X-Google-Smtp-Source: AGHT+IEF7meVayX4kQKVO1Z9gjE1TfSOIAN8jDU/ogFXxaaysadF9Q1YI7+Opl34pPmJ3195eC7bgg==
X-Received: by 2002:a05:6214:e4a:b0:880:4f55:4af5 with SMTP id 6a1803df08f44-88271a27fc7mr29916156d6.52.1762944346416;
        Wed, 12 Nov 2025 02:45:46 -0800 (PST)
Received: from [127.0.0.1] ([172.172.87.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238929abbsm88672286d6.7.2025.11.12.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:45:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762940290.git.pabeni@redhat.com>
References: <cover.1762940290.git.pabeni@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 0/6] mptcp: autotune related improvement
Message-ID: <04bb6755-cf8b-59f4-f702-dc10832d0b78@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Nov 2025 10:45:45 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/192934=
19643

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/05a5ed946f4a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1022409


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
