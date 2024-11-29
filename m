Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09011A0724
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906335; cv=none; b=NO5L0CPonvrFQjm6dzR1FDBWdNMxiXNT9pnEn60DbqEHqEMtjP4ozdSHae6X5AMQW2qrVE5wCRrRELtBA6fW8ZixtNaVnJHpsMkgDJg4LORtJBzv2TjDl3QWNrrHmpie610RWGpMwSrel49h/pMilWD22za8pFIlcP7MwtMzX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906335; c=relaxed/simple;
	bh=xp/GKEgr/lK8wiBJK/yu1TBGaqWnQlxqYn4KN10j9sk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=naTjxGT39OmMVM6mFo1oNIG+qXa1WUhhjTOEY+F1DXSbjXjVT2LXqjG8DtvUGnxnt6uBrnUukX6Nl2JJTHr/XaWkApTXFvEt2WoWbbWAaY0qiMTHMmOEPSxEUSXDRNW3hUifF6FA4wKl9RmQ3NLXT15qYEyaBjni1+gbxk4r8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqRCxUmp; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqRCxUmp"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d87a55bc50so11527026d6.3
        for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732906332; x=1733511132; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWSVmQjxwEZGDJktp9YxRmmkXQXLj7tbR/nKt/P1CoE=;
        b=lqRCxUmpEAQ4x7QsHM/uZaYgBExECliw1oJAisZu98ZoAcISrklRV1SRDIf8x6etHa
         3a6cikTi4yQFf+9IySUca9nDR/YMoDGalrUs5qRbLelNMAnBuXGwL3agJT3nYJwZ0hY/
         xqa0a7ikKPBx2GuprVRz4YJwQvXbt+6/J0Eie1b81LY5JaOrXrATC18bglASWJkTiQuB
         Lm9OWqscg6PCmsTIa4prgsTK6bETRB8k/x3xfm4TD0u4QsjYM1L+pv0aO49hX3KGBbFF
         um1aNa301zQCRVUrh5E2s/og9MNgKo2ymhkQkXmVTc0+Hsv0XWPcKAraHd9OTojjvdKa
         polA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732906332; x=1733511132;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWSVmQjxwEZGDJktp9YxRmmkXQXLj7tbR/nKt/P1CoE=;
        b=vJzjLScFWRUEqd7ls9ozpvPr1KqOTPcwMPR7pqPmPP6tMQYA9cmkcaZpFjWgrDygDV
         s/H36wZYTKs9vyYzrKI2gxPdRU4sg1YvKgwCGMg0ko8RycSFSzx0tGmXvmO8ZVV6FMgv
         tom1bbupjl7wI+gtoc3vDk47o2I7v2Y+6jabJmxTmRs49gszp/J8r6IanP0RShxesD6B
         kdnRi/dOG13lRxYo8bbAiQg7Z547XpiDIqkl4G3JC/HWYbU0hdWgf/nZ6yXPtno0vJYq
         9tpqwLFDD16RKQp/zwWuaFD6zH6vJL9O7/9/+0O6s7FmB5Pf7wGVmZB7WG0fKNsNdIQv
         SBLw==
X-Gm-Message-State: AOJu0YxxtArrvspZ2GjxhB0AxirntAXHk2+fgLZFkaphQwoImuacQUJM
	60kuVtt8hPK1xTw9DB/POXBaJbHVcwP4sY2JihLpzxeL37ga6y8=
X-Gm-Gg: ASbGnctSmGcbbW740FrkpVv9XZoim9F9ZZVAwpOBnEe9KLwbb4UcpqTmT4IKsUpU5H6
	Am/nkTlnWmq0cWm+nlj0H5u/+T94onG5U1yfzDko2rR1r4fE5EV5aXYWLBXE9YRsPZmBgbBtRaB
	F0BPJOGN0/A+9bCKTOBg6DdkM4uecY1HHNu9S/eQOI5kHbWfVKYccU4EpDU+MwpY+ybdNKQejCa
	DyAr9RffelLZKCJmt4SSOh1q5NxG0E35x9cR4Gx5AAOykdr7bLxkuK9QspEVss=
X-Google-Smtp-Source: AGHT+IGG1Xta2b4NGlE+cnCd278Ns0K5qHmMs+kcJN6gStuQHz8URqwYXIK5W2N6clOY8dvws453XQ==
X-Received: by 2002:a0c:eac8:0:b0:6d8:7d63:f424 with SMTP id 6a1803df08f44-6d87d63f99cmr78866466d6.12.1732906332412;
        Fri, 29 Nov 2024 10:52:12 -0800 (PST)
Received: from [127.0.0.1] ([20.161.76.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8751928desm19018406d6.52.2024.11.29.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:52:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1732902181.git.pabeni@redhat.com>
References: <cover.1732902181.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next-next 0/3] mptcp: rx path refactor
Message-ID: <12d1c966-9462-72fc-8088-16d65769a81e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Nov 2024 18:52:11 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/120889=
81326

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/818e1f7b5c07
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D913372


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
