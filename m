Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F8020550B
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354737; cv=none; b=ekJPPVF0QNrvPkTQa6UN1WQWPq7SX6Qev844R8LptbW7ZSwbZvRuc88BKY6vREL22S/K1UatogOyCmLhBUIdv6IgyNvagtqDrhYruihlQjNpDVpg8ETVPJiDN42BSxNR6ux1382fMtWsHZfytGmfDZwfJv9al+TW3HaViSjUdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354737; c=relaxed/simple;
	bh=juI8HfvsH1YrPqDh78vdgkoZMD6v2VNo4YwgygHYEFc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OHPJJwvfwSGDU25ZesbXhe3vjaDHihxYIJr/nkQ0zOMYi4WkDYIDDbQMWAy7n9iOiCFK9IJNlIGoUyvFqjnEO5ESw+rcNUddPXJE5hDvh4A0BbTX40Dtn81dau9dWAZdvqjDrsS2LVgJVwSOdiapVIQxJvFFRhZS8uv9DCP5rPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYsAAYs2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYsAAYs2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so35947066d6.0
        for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734354734; x=1734959534; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZkoSp2saKIXN8GFm/almqbxNFIEF2utBQnEVafl2wY=;
        b=QYsAAYs2dcUFi4ZqTLv75dGEMQF7wFbmuptADzySJydzimVW79sNXkSXApFbKOGSyc
         XtBL9iyUUafzQLVjwGgd6Aar73ofJw19J1nCYtUsMhAa6Azb4vLWKh/ko/5qn19JfcVw
         SChMG0BX/QxLFDTgm3i+1pZc8EpT5/FxHjDyTzLox4kZ6pMppGn4NEjPRT5symhhREZ+
         UGHFCYhXenUJUaTqVjbzzQtAW1V8vbFgEDYH1v+EzT6V4sIh0yI5a9wAruA4t7u1yMUr
         HRrF9dYyPVsmtyNiQaBVCyrj0/MXx7EAgyJ58AiPGD8NCbH4v61xMQ75DPRK4ta6nEqd
         RoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354734; x=1734959534;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZkoSp2saKIXN8GFm/almqbxNFIEF2utBQnEVafl2wY=;
        b=uypiQYvGZHUdrW6y5aWE3E591bHkVZMgLrlwl/j3igxr4V4zQYooQBKofn/CJmAEBl
         6X/Sxhp5Q0rqOw4VR4l5zo215FmNF0HIkbZoamsDl24Qe9PZL0wnwAJqbZPOpyxcrFvd
         ibkxnOobMbQB6XXS0tjAzPYmAVBIoReOp6ntGD3UsfRH1zPsoSQVHtYCBBAm50N5YkKB
         n32Il7H4h9IemB7QFBqCZKRXqDlXCGFUZKG4s5bfAqez3g8EokS6JHxsybxsHXWPJ5tx
         W4wRKslD+DzZxozHGaVT1r9cY3NdSF26vTmAuw6P72o2bN3OSZpV1Iae5uC310uqDItu
         0bow==
X-Gm-Message-State: AOJu0YynwAApThm7cxEoF3IBt7/E4G0JuTZC1wtJX1IN0a5YjKT7FBKh
	pEUWFRwLqUZsx6yH7DA5MLIbBiYEt1Ry7QG8pJ7BuJzeLq2WPnswWvca
X-Gm-Gg: ASbGncsHKPSmt5MkH/fTPc7upZRtLOEJrzgxb0FVu8/1naUN63YsSY7wq5Itt4s9isZ
	lh3RpilWkb8EJFQ3GR+xtg97k7xW68hzxlx4EVm6ge7uzNRxx5/S257/Qr/S88q/S758O6GIl70
	BPvg8nUOq/PjxvtRmTUV1uV01vsQfYZiVD+hLgkVIE11qd1t5JsSbeyrscxeGfF+zN/Dt5RoRA/
	0zpa7dNOIcS978h4D4S3jnWzIpdkLWXWT2imOGEUeeUcsVPIVADWGAMl4Iyq0GuhSe/jp0=
X-Google-Smtp-Source: AGHT+IEmr37qTjQXqmwgmDDcD3vFdkhHow8jF3o0k5ZKtGS03idA/AVIsBwNWeF5KXAO7wa+5RTG5g==
X-Received: by 2002:a05:6214:c28:b0:6d4:215d:91b9 with SMTP id 6a1803df08f44-6dc8ca508d7mr229880716d6.11.1734354734365;
        Mon, 16 Dec 2024 05:12:14 -0800 (PST)
Received: from [127.0.0.1] ([172.183.138.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd366238sm27000446d6.77.2024.12.16.05.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:12:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
References:
 <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/3] netlink: specs: mptcp: events:
 missing and clearer attr
Message-ID: <ed6f7545-39f3-4975-96ff-10ece7c32d16@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 13:12:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/12351088918

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0e0d28f4501a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D918161


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
