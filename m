Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017C3A7826
	for <mptcp@lists.linux.dev>; Wed, 18 Mar 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831354; cv=none; b=R1S/v3QN85UUEp0H/83IGgT+XDVQ6Nke973pJ1fDCnNUbOZo5zDtzVOZUsoQDlKVcGGP2G3az3xZy6/bdZ5WfypbJEfIvO7J3/l5tetP+bW0YJjgT0iFXI/LZMSj7HBV7KO8iScj67GGYdRxXRgSFkMG9kyCQR6MGfj5Kh+loBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831354; c=relaxed/simple;
	bh=zIu4E1j7icQ/ZZadMjozZVj4+1L+2ciYJgQn4tDu5CY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IPLLc7gFdWlHx2kzfeBDyVtvgmgUs0KKWOAYKFw22Epb8pthAkNjX3WvgkrFxgrKwxNBRXZNbbmodkIIj7TkCnL/Ggiea2mq4e/qTZTqNetIVgDNQKQN7lQn0JkhqmvWKkep2kmfEYlpdMdaZ5ufoZGq1Ix3sC9CWS/yR8Wrgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KykD/lfM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KykD/lfM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89c5340fed0so8825256d6.0
        for <mptcp@lists.linux.dev>; Wed, 18 Mar 2026 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773831351; x=1774436151; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pULUzrGHu9UFdZKvERFQnVJaZPELCXmGnI8TAxhQfZg=;
        b=KykD/lfMNgiEv0XorzV3ya68CYOkdSGTujSHFDUBZtvEYnBQoWCNCFXKvREQL7IxTV
         x7AUlu/ucvkeqspxixWPv74Yh8Sk+Cjz2F84ku+RmWWK7eiWzovQplcstXEq6oXCLlTt
         JNhCkBjTa1q8fBTy1+qVcrfzumuWi5uaRwhJEKBtwR1yfhtSX+gwCf5AHkrXCiPR/bY3
         eNzXGW7PpF//rKFflzSfFOfgk38sT7V0c+KpLIZbCj13aMW1nd5mbJhM2Kc9XZ2liwbP
         MFzdvi+ckEqidPSeye4VAQGL7phnJ1LALV+Z18FqkUr01TjPXUzMP70Ydoyey8kry/vZ
         Pscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773831351; x=1774436151;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pULUzrGHu9UFdZKvERFQnVJaZPELCXmGnI8TAxhQfZg=;
        b=XvTG2JnmJnlcqIl4miOSsjBjV/sn6KqTbNV/1ddh2sjp9yXO7ZwZLX6OmAZRt27+//
         0YrlGy+0nOqNsRHSVzEUfT4+dfRVN2UCUPG2grVxvzG7bJpZ0+9T54aZX+zlP5zTjjUi
         hz+b9gAkgLEtZJwvlZUnnVvWSgBPSosR7yPr+zJDJgCeapps31v+DJziDe/H1Rm+FDbL
         O3nHmGiLIKbzdT3ys5ZD+WR390RziIYuHY4MTtgSzyOUHIO9osL/QyLHMAugI1g7zdeX
         oopLu6TkgCxCWuOX+e3K2m2mgbaCt3KNwig8pGAVNGFCPvjVMSZ2u5c4UXKtkdGQZ7TY
         7N6A==
X-Gm-Message-State: AOJu0Yy2fDMxQo/lMAtel+QXW5cdlrTUAa2G3gQwwhH2Ic7tbckn6I1C
	rpM3KCHKyUoX2FbIufJdMkyjGjC0ceFurZPxnnJbHZWgsQoGMhdqbEQuxUBT
X-Gm-Gg: ATEYQzxmaveyZRfJo0VoN5IW3ZWrLI8iW52CBP+uYWSCy9tAZYET3EYDW/caYCYT2/l
	WNh9SZm9iLbASuTCfj34AnsiFiB6OejZ9PN9dalg+En3hLlNfOBhFQ5j4AI1+zIowzGM+blFsmf
	OmQFJi9oEYpih43BnVsqmhXTBRO1PisIDprVySWSDB+pvrxIRzqYYuWDwQk3KWbzWP/wErHHGtF
	q+LY/jP+BdHsBEqKliTdVxb0Et6hKTFOhsNXMp0084+mMEnBCRvvMvLDhgSDpyrBTNJF21RJoC6
	8OK6QRhq5fUrbkslera0QV6irSQwkqWd9h6pika0yl0fFsePyzMRVMmI47wsLjwuS5cF76AmGYm
	vt8ueJMFaIqtIg/OtR53PcFYHRvTEJnnPfXaaFUoIajmiozYpbhd9Q7qm/Mro5lyq9CXsJA6e00
	I/bqSRYld9WAIS5UgqV7bGwrfIboIIYwTv7i8=
X-Received: by 2002:ad4:5d64:0:b0:899:f22a:7d79 with SMTP id 6a1803df08f44-89c5e2e2326mr93376356d6.16.1773831350886;
        Wed, 18 Mar 2026 03:55:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.47.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6ba0272bsm17629156d6.45.2026.03.18.03.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:55:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773826662.git.tanggeliang@kylinos.cn>
References: <cover.1773826662.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] implement psock_update_sk_prot
Message-ID: <a1de095a-35d8-98ee-3c14-4e948c2ff507@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2026 10:55:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/232392=
00117

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aee7a7eb8008
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1068551


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
