Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009386341
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810125; cv=none; b=ugMJzJ7gyNfT7eR5H1iBZycjpfqduILa8kUI13zTEHQKGEKJrG55W+2lzJzgniwZjJN7v3Cmb80d4gUWz+kW0S/pWQP5UFqv/K2fv7VSU7VtEs9lTzyfYMAmw1Mo8G8SELpUp+FrLsdZvUZvC+HLXMX382RRnXR0vyUQFNCAWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810125; c=relaxed/simple;
	bh=vS37J0uV49Qq4oTdGKHNoEulR8qHbHEgOy3pWSTaOSs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=c8ZHNmtpJ96wtLHCHFQmov8LEuHL/LH6iqGMWojAR3MejjBIHpg5ZRawHf0ea3rQAaUnGaynb0lG4jd0xHb2Jfv6xH+JyimTtQPqs8jbbHcMZtV6Hwi6vsZOV5jgSvq9t9QjalFdW5VPd2LXn/qBWpEYojrqEBL416016t+iYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRySJyH7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRySJyH7"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eda057f3c0so24573301cf.2
        for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 03:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763810122; x=1764414922; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmhZSd+HO4wXvXJsJYJUa6yfy44u5ccGOu2kRqcoN+E=;
        b=lRySJyH7WnB4RM3GhiimzYNWGGllvLnuTUjFEdr+Dqk+HD/8lMGl3bHImWFUh2Zdgd
         DRUID2THUjnxh5Eh3wSBw7n7uvSGQgm0vBwj36crfiyODYAMndGdjumGEzr4MwEm00JH
         Ell0FWuFsnI3VOFBemuW1X/ZFYLpqWHxS6lUi/JfwzEbHAHDSLGkok808P5Vq8ZOopQ1
         yxzz7te55QMGzB7EHByZeC831gJr/2kB87KlE+Fvmw7TnDpI9brPWG2u7jJQXKE22s4h
         j8jtHHuMC/LWk9gUHZZdPXBG9RZEu9r1UWiZghIYrxYjFmIPqNxXzHavcVaVmKV/XLIY
         4ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763810122; x=1764414922;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmhZSd+HO4wXvXJsJYJUa6yfy44u5ccGOu2kRqcoN+E=;
        b=naB0/1etXvcj1mDkOEiFeCnBJvs4X7Jucu3sStejMb/n5q/ed7IbV/OYvTxNmyYxDs
         Cqg8f+w+7breK5PC6J+Z/j5279a96tl01Mv1GKduT3s5sl0hw28Yl4kbGYi/qwBogkLb
         ERmfVxbpNvzVPNuBUO1zhVJmrascvTF6QIQLO+jHH41qRn/Yx0oUjO5qpPO8kPhwPhx8
         2E95oBKKeAgFO/i9R4s3/8gIb5F7eR6I4o9+LE5Vlnkt/s3olTaVxrrBx0KO0qIrX9BH
         vUrOhoqFrj5zs5LzYdomO7gIUivUoL2BPV+jFNs/ghWsVC2Qn3MepTDpH52x6J8duyHf
         e28w==
X-Gm-Message-State: AOJu0YwC3WQoSJwmAn7L9mNrTGJJlDTjLCwmdKNuGVV9PuCH2LwEKy6/
	/N1xQz2xnp+nVCcaD7Q4pXI9TM2heXYc+lJ6/ShaSapbnoAkAurYIUfCw694g+8=
X-Gm-Gg: ASbGncuTTYtIvATEDy/WsPQWGxEz8UuSIzZMo+z0HtW0WltGFZhXuoK6lXakol+YA0a
	9xkEyMuN/l37takGEAOpQs8SYzT6GEthj2erhJ/AZ0/LhjWcO0h7BAQ+ejCFY7YBZstvNUNyiX1
	U0Cq0ujSN2eIufX4VvwULplKVIHhBXGnIoUQBS3Y9KaWacMCugPXlJw5+wHYUP4K0fquCblS8ZZ
	Ejb9xMVA3uTdawYA7zV7MJnHiBlpoT57kErCCVCcN8rJd8G30NO9taredI2yRIIXACPKaE/6S5D
	bzjIlTEjJF6KUwCznb199t9iBZQ9zJSTAW80JA9i47wYA60wl8FlR2RTV6uIlKCzAMDkyVT8LMy
	2/VV5hqC9UfsM5fHVUlxP+SqWJzF984fXKZZkMPVx+DYjKq3XlvOGz/rMcbj7fvVj8Uonuv/5sQ
	j/Ts7ozQGjOFJOzojPOP8D1F46
X-Google-Smtp-Source: AGHT+IEJCoN4ajERAeE6EG9ESowUwHeRYsEIsYy8C9Xeb4tL648V+ExAahXgBcCsHu1XA08ZWH5gsw==
X-Received: by 2002:ac8:5992:0:b0:4ee:2423:d538 with SMTP id d75a77b69052e-4ee58820e46mr76989921cf.18.1763810122071;
        Sat, 22 Nov 2025 03:15:22 -0800 (PST)
Received: from [127.0.0.1] ([48.211.212.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e45c0csm48920761cf.19.2025.11.22.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 03:15:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v3 0/8] MPTCP KTLS support
Message-ID: <a02ff6f3-7f96-58d4-91c8-438cf92996fc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Nov 2025 11:15:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19593304037

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/943bd20791d6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1026573


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
