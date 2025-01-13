Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67924023A
	for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787043; cv=none; b=IyGQGRZi00qRpTflZ/6qw+UkkfbpjuLb6REb0LSJ5jAk8VWXscz03ZY0Y7y8h5IX9vQ9oPPrID+Sejs1IeQoE4OUKIisso4wvfq/DjyV8sadNnaY/XnJ9gyBKXmwbnonG8TR87+BNgqJG34A3sJAcmiTAWXsBu2ytE/hLZuUy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787043; c=relaxed/simple;
	bh=jDSLqUgQzPFn130zgz2nAau5ZM81Mq5wWL6Cwjelx3Q=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KWRbdLouCElJMGOd2vpjfWvzUHl2szo4bBAz4KD2GCq3G8lHd+cmprUadEN7A621BZwxLw7xnVs+KnZGOZpyW5IywWBaHIMt29K9pSMoNXmOLtutpvYNSefDkIZfZnU/L6+93iB9S4+CHHYlcBr/h5ZrCAumus5JAei+qzEhLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxM8Xh+Q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxM8Xh+Q"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21628b3fe7dso76578275ad.3
        for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736787041; x=1737391841; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv+w6QqApvwKhMEq4CEZLiyy9wqj6NQhR3AioFyvFfM=;
        b=MxM8Xh+Q6Hm/BNCLpZ9Eu59kfBA7uwZfpeB3Cd+zuO2Cgrdce8vyMYjN+rICW599Yp
         HFqHGBYfCKlFIeZBgi91b2Bho6RD2zH6FWYBbIGKjMybkBIviGOvAtIA+ve/hTg0klkT
         lXBTZ0woIlhHwJp9hlW0B8ovsqucXw5HOfTJy8Exa7UbbS/JC/YYdVqbdcz0Ad55FW6m
         vywJTkF+H3UXQd4ru/jI3Ax8Tmmk0V10kTfE2w8BE4SKv3Ed1shyjsZp+tzGaAiDZDlO
         reeG3Mt/TvRpbAunQi0Ey33NQkxFxjfE5Un1v7nBuaUSLt63i96yjs4SYkmEcYzE9Yru
         6llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736787041; x=1737391841;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uv+w6QqApvwKhMEq4CEZLiyy9wqj6NQhR3AioFyvFfM=;
        b=sXBXTQ8zka9fZS/n5JkOivxYDbrLIcvlkcpEhiU1MiOpE/b3vnfePewqgP3QhbEU31
         esLMTewAjnDMPWaU5/8AEqY+xj76ESyUu4/8P3jM69noEfneVvUvaVAWVieEk8EIIXqo
         SVv1sWMakPYNtxwDMzTC0pFMr6xu+jB2D5qFiZbNmjr+cNRVJT1kg4LmOh21WLQrg4BE
         8T8wAcj8z02wjSlILhtzt3fKQfiNZIE0oiAfYj57i8WZaBVtdQ0/8KEgbpXV6N/aRI68
         /iVI7RirvZIMnH4O2KRPlTFUMNl0pckkfIV536FlDLuvMJNVibO/D+OIszghmKKS7hlZ
         Qr9A==
X-Gm-Message-State: AOJu0YyarwIbb7CVB6J7pB7b+ulJcwjJirWEwHH8gvOjm5Hye3iXuthT
	18/pe7r6/H2yl/KU507TVAH3DplQisr8Mu9/6KiYrC5zHLkXYt3qUq2d
X-Gm-Gg: ASbGncvMwcw4WW4xPpQJSBbZV9E/XzjTjLXhhT4G6MbplGlVqvXfxa+nSoZder9Fnv+
	YgeAXYCrkAf5v7tNqXi/MARm2PRMaXYpY9z56AF9h0eOEC6BfyGekmkjj3i+K5uXWw/mx+zhiTO
	3HkSyom3PA1IxK2et4uYHcUzwa7z8xbI5rvqQX0lmMbD7Fs8BDFIakMxYWprfp9prJOHBOvbqvU
	pd4bdTIdMgIVAWdJUcWHWfJ26QhTFYU15GLHSoaQE2BGNl9VS51qFkGP/em8j+kH0jVsg==
X-Google-Smtp-Source: AGHT+IEsDoHSexFMre5+P+7gV6MCKDlcovblyLVRlPFpTSZFH/By8owkn+wz42Nz0ZzdYZEWN6x92Q==
X-Received: by 2002:a05:6a21:1506:b0:1e2:5cf:c8d6 with SMTP id adf61e73a8af0-1e88d2d5ec0mr3764678637.36.1736787041163;
        Mon, 13 Jan 2025 08:50:41 -0800 (PST)
Received: from [127.0.0.1] ([20.169.14.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31840e93absm7213121a12.20.2025.01.13.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:50:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cong Liu <liucong2@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250113085228.121778-1-liucong2@kylinos.cn>
References: <20250113085228.121778-1-liucong2@kylinos.cn>
Subject: Re: [PATCH 0/3] selftests: mptcp: Fix various issues in main_loop
Message-ID: <0302e767-517a-75c2-12d9-0173aae46893@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jan 2025 16:50:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Cong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/127509=
92738

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ae5a93603d19
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D924794


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
