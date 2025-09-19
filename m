Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951D26C3AE
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307022; cv=none; b=eGEIjwDH57R57pBOSpLK/6qJSwq3PQqWAAYntoRHx1EzI58posJUikxaHCU7Hle+Hb4dP8LUCtTROG+8XmQ5vZk1snwTt4vrVuvBOVBzkB9nboHmbtQnJ5chhIyflcz8wfLVW5eJlzIo6IJOEAXEidwR5eK+gwo8u7rmY9z+has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307022; c=relaxed/simple;
	bh=u7NzKOxAVoaTsyI+zO7a92pFjZoMm3HquMbPV8Aqd84=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dCg7BRkQjXoh/DrEAAPltbuh4gFpINOsLo45AHQvGmXtSX5z1ljw7Gztwgs0VHazYJuXiC0poC5fb51QMcTEkPVi769Pq/R2mDS7/jUtF9fw0ljG1j06Kh8NzXffxld78Dq5czewxcGVT3oAcQ+1BBXKmf8t4l5T4JLhnwvl76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smr0jNjw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smr0jNjw"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-79390b83c7dso20254616d6.1
        for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758307020; x=1758911820; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNcZ78Jt7AgS7y+ugiEu5iG2T26mG/pgsuXtquDoWdE=;
        b=Smr0jNjwxxW3blsEXl+SU95X/nC51ipePrHYOw2wWCpf7ksAC3IGXOIk8W51z4lgCA
         JfmKhP3sKIiPQHNRlDJXHnncV/j5CFvPt3Nwt/t9ncmf93JS5rUAa74xj2KIe53Av0Z5
         czmf1YBGnV0WmGP8Grb3gGlmby5/rMc5UA1hgCm65f30reDfVzJXyRWNdjvMRN7LJcOS
         D3kK7H8UCt6wUqgXFiNBDIpEUZGeyQRIZeYXuTOXDJPVkCZQX31T+kUR3AT73yIT/0na
         4Cpapq1mO2J1a+HdNR429tJ1cSv+dfV5r/T7mj7g0T0H1RTLt/E0E+PxRaRLt58IylVC
         CLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307020; x=1758911820;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNcZ78Jt7AgS7y+ugiEu5iG2T26mG/pgsuXtquDoWdE=;
        b=QrEhd3NSwew+HzjE2BIcW1OV3zarhj7nHaYdBevtWIYNuFzedMUjGyzAG/Hl1XEoj1
         2k1AKusnEZB0FHpaYQ5pVjS7CeY9N84h+1+xlBAEZT5+yezrTKTTKlNSaYD6aO1WQS+9
         Cj/rT1bUHIwASUjlVXTGamqnd2nSu6H2DV4mBmYgDBZswz10eCagfrliUFzHneDFk39l
         uHQzl1JgHfZbtG6DkfGsYfdv8szDYjKNC2Y0A69/xtLBofO1mul46Gutx06kKFGBdDML
         SqDHsoyqE3rUU1h5k8NRn3hoSImQEiItxpWAEk9EPF3zbAbipW85K1HOJWMJCUNoFtGZ
         HVkA==
X-Gm-Message-State: AOJu0Yz5EqnfGz/3JIuAbMen5ga1kcgO+vwa6FdaKLCRWa0JpC3u9Efk
	f9nHl9j+DaSc3GmnmSgIPZwhGbJPvXV5vvvZH/diL2T3gcGg82L+YdM=
X-Gm-Gg: ASbGncs5HCf7OCFsSuZc/YzGBfMxnkdefzrStvBI1UNwjCiznhbXZszS/xZuR233l3h
	eiKgPxle+tjWe5pArE6vD0n3yAoTzecq8B00pFo8nWUWotZ9O7vGy+8lkAguqgrvkx6jENjBBI7
	3tdS8Xnwgw4KhRjqOyhz2htbAYgqpMuUySZ89t9KzadNrbuE0AXkVNvmb3G2DIsQcb6IdGVWdib
	RhuDldGnrRB5kKO8mBBmbXX4oARBCKGUQJVhRGfom3nt+94Eq96q489xFSmcThAL6SyyDK0rfZJ
	10IXbTAT1rE5Q/S6tpWy0w3HG5NhY1Zv5y43EobnSW4iQTuIeSfdk7A2nkQv26s/Bi9rlO3PzF3
	ntIpdYZqXZTfmOXMTK9X0f8SAI1stzdMuXKQ=
X-Google-Smtp-Source: AGHT+IGe+olIJJVVMjwBCSXQZaQD8UiWNLndIc7wtJxa1mno1uJaiw1lvrehrA4UcYxFI6G4K2it7A==
X-Received: by 2002:ad4:5fca:0:b0:714:19c0:623 with SMTP id 6a1803df08f44-79911836c82mr45833116d6.11.1758307019656;
        Fri, 19 Sep 2025 11:36:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793543ffae5sm33106016d6.53.2025.09.19.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:36:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Subject: Re: [MPTCP next v3 00/12] mptcp: receive path improvement
Message-ID: <766266a0-1f28-16fe-886c-03979e46410b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 18:36:58 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/178638=
51247

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fe9e565e924a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1004322


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
