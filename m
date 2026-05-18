Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A315665C
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779084242; cv=none; b=TfN+Zu6BLPXb9Whak7mmZvjvfoYjk5xDXbUzUCB3qj6zGTder2S9+z2aYN3t/tmZpL/aUBCanYy4SH1B5kftYjNbaS/5TGnOoLrasaRCjXrx6MGUfB/I639bgVjuWYJKWFoLAKsy9o8UgFFgpLYlT0ycWn5PWguSq/kXWIo3wlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779084242; c=relaxed/simple;
	bh=in3Ff33/5dgib40UA2M9aCwE+LQd955NiO7tdR0G4Ac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=NED26mpkOmXQzsfF1O4R8yNdLwuUfKxBc+VA4jdpDkxXtIIE9vGvYDmWJFRKt8NxSQJqIgqICWtKnMg8DUHYEluVSm0JIj/1yCu6A2s4rdIkNNbtIQQswnR5T/HXtKv+sipdTjOUhjXepRUoylBRxf1mSm5MQ+89ltiU1YuHFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3zP9yGT; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3zP9yGT"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b98482b253so36904576d6.1
        for <mptcp@lists.linux.dev>; Sun, 17 May 2026 23:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779084238; x=1779689038; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mIoMB6KZfnGbmK5HC23ZZCzJ14LhaGEfSqYgg0YpTE=;
        b=L3zP9yGTJbrcWec4uMrVvdfpi1SDzYgG4hnoGKrnTohD5lazR6LMoTnyOlBZcqRs9A
         zM6g9s0yctJQyNNVJ1TmgnFnnoXUG4XDruDm1/B3XzkIhq/fc7msZnTbb2MVasIEaPGB
         XIS+RCx9H4a9FI7Q40NEgJILy6aVBasNKSZn1kZRs9r1XtlnFwGbJ0UuOvZLbyiny5PC
         AlXDDJCuWX2RsgjVWIUqcLac61Ch6aVy/XMktc3AeibxeDLEq5tAY4HBhiwdi1cM2Sm7
         PNaY17iO7G9/wgDWVUjlqgkYIiS06GVX0M5Xucs72vRhMljD+tmAe6dHZjI/OmWlwPgk
         L2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779084238; x=1779689038;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mIoMB6KZfnGbmK5HC23ZZCzJ14LhaGEfSqYgg0YpTE=;
        b=oNEo+zwVv0c2bpJqbFraATkBU0hXJIqxZv6Yxu9XtYmKRZXnCHxqzy+YdAO/qJ3itR
         Vy/LFd647GV4MZGqUPzo93DUQR5GvmB5CPf3U0UMvUIo80TQJnqakpnKlO0F73j85Opt
         B1c6pG2WyRgcvgpWiKVVa2zKM4StJaTmrbxGrvqw67vJUbJAY+RHxyVBILzyv/Da6T5j
         clYtLkljrOe/WqSuCMqWIvf1iEiMglI12K44RIix87cfug9oXxZ6/B3WXtoeSIt5GPfP
         xoFh/WYgS3iLyxHNxH/rBROQXfooTp7ZGHzXxKR0p+45Q5/18NXmZ1e2v2LKJQsS3Pue
         SEXQ==
X-Gm-Message-State: AOJu0YyVqBC3sTf95se+hTu53SHITYu8O5fNINTM6RppScmGKUJktj6O
	etAZoDlTSOLX85I6ddAIgv8huZolp8XIDuzORktYZ7RnKjw8a6jIWCzXIoBv
X-Gm-Gg: Acq92OESR6AurCHZVu4zrTPSxX3ylhJ6r15eALCwT2eDR8qV+po3722yJZhnBON+wAy
	BcBJPy4Z1P3lHtr6LpRXqS+LDtK7/juA7YP1Tu+i+0DA0cUMUcr4UfAd4Rz4u+UVaX5VzBnnSMO
	HQM8fx+yPtStXAMuFWWkkCm9oT5sTFVO6KyxaTwb+qflERSfxSX8yzlMyEmIqdqTorDrLd52V3O
	5q/YUw3XwhgikXHGXy9YWNPRbc1VaKtCCCPvrNZ2j3CGYnfkaxBUfWMiyoUuJGp+5Nisfc38Dda
	VXy5o0Q+iH2rJs+YAGvVcM8G5lgprqPALxefkg3NjWUH4Uk+ootnKL0uW/BaeIOHEl31l+oKmDh
	y6CxzWXwGUWxRL7I3PZiBRSN5d1UQtLpx60tCK96TxsBXM0oidRVWM7a7PK7CCapGr5yoMqPI7a
	mx3N5RzN7ht7Jnhw6RueKRsUeRPfCtahLNc6E4UA==
X-Received: by 2002:a05:6214:468f:b0:8b1:f5da:f811 with SMTP id 6a1803df08f44-8ca0f706da0mr243599816d6.48.1779084238424;
        Sun, 17 May 2026 23:03:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.95.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361a7284sm47491096d6.40.2026.05.17.23.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 23:03:57 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260518050048.161374-1-kalpan.jani@mpiricsoftware.com>
References: <20260518050048.161374-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v2] mptcp: prevent stale backlog references to
 closing subflows
Message-ID: <5dce670a-c522-02e8-7b22-c0e77e6e6339@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 06:03:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26014931729

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4991c3565d5d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1096306


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
