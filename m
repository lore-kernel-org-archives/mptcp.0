Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6038E119
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878923; cv=none; b=qi0+Ivrgj8eww7ghMA7V6HI8Bd6EPXaQoVvK19n6X68Hv/Lwdbmp4AduScRbgqWPofg89dGpvrgAGFsH28hSmD5qq2dMi0oNs9CTPj2bXoF6DLakdLWkZ336GXgYsCnJsT4HSCj9l9+GiydxRGsTX/oQv8NFQu/drMHmtk8d4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878923; c=relaxed/simple;
	bh=ThIuoGTx9iCpoMXViTiJ3kGBM+LY6OWAlfHy7nTPxUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=bBQGh+8nvtJjgp8dO4uNPySvOFwLfTLVKpIWrkxMvwg2gjc+yPGm0ZKxv4roGtIXoG/PuIEEdVcY2kxQFOGmc8exIeOJV5qCez6wcz8Q7HrCKWMUlYgSK9viMZMGZcbWjX2tIc6atZjP/PX6oHax9k1SDLHFaNkRAADfv93XDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUQwnHZV; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUQwnHZV"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1684713b6e.0
        for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791878921; x=1792483721; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xeJHyRsM0xq4NmJ1lqdVuWBMI6t02Fvtk5yxFTzi3XE=;
        b=kUQwnHZVnEujZ/fKgsAivLUlu5W7ltbqAiGxQYI4+ShiBHSdppkczmwD6GgzBJELWM
         jT91l7hqzq7X5djL3xciqS2bS3wY+K30oOdD2+Jmhl5xjLHBkn091HUxgIWOTkBNBMB3
         ieWPeKP6u9QpJqnbILM0axfTAwaMHhjI8KrJZxe3Q2aUg3lSkirZJAktdXnFx7LBOGom
         2LfL9FBu05qfKs9enn9MH4hwn7FtA9ClOJN9Tb5CB5VYfJlfZBx+Mco81xWUYuhhx3k2
         XXjBxb1at7/+ruAbwAs0i7+/ioRH3XhbuylR2zp3XMx2FXBLuGYEswV1qaJYtuxebqcP
         n/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791878921; x=1792483721;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeJHyRsM0xq4NmJ1lqdVuWBMI6t02Fvtk5yxFTzi3XE=;
        b=1QJPmPU5moVmEPHt548OQsgqyDHBXVegcbAcTm2YlX3ChRg+ImUweYaDHtcyPlwGRH
         1rJ5p718t/ExjEf4gy59JIdZCS9cpA3fcJ0xrZX9ynXvGlVhjInYZq/4gg2UmPT6kDmx
         W8d4T/UVbvBgPd+Gd6XbHKe9DJEcVn0Cl8iA3yW2UXBAtzUB7sUrprIIVZBk58oQ234L
         5sphNkSI/08VNyUX0jx7iymLhMjcPRPNVGYfqGjA25GMOfMWDEM8dyN7ES++t6aPcDZG
         VAGjtqvup8kvF45oNCtiKh1OY51jgsn9Qxzyo5f6v1SROrUxW3afGMukEyE/9bPVPJ/X
         FUzQ==
X-Gm-Message-State: AFq9FYI6MXRNFVMg1Yj+6mOw7awtsZI05Z0fCJ1nDBWWSK/vQCpwaD4Q
	RcTboERfsu5+LXhMx5+sVeFmOZjN9+iVFdAkx0J5fxP9wn6bpAK9BuWWbGrw
X-Gm-Gg: AYBFou1blFe3EUSIPPqZwLRAEsC/k5GFHT6i4Eq+H4ITZ2BDQJEf+fo1LnOjL+HhY1l
	dGZvr7O1pZjrSWBfzdUXd20Il7vZFFAmMbDng16uI/p9e/P5/c7cwtHtjTiOsgbA84nLPA0oFmS
	bBXVqcgqVTg+mV4QYGhvEM/urizpO7TAmcZQ1EKnsuyacJjeYYJ4ZUEBXak8n2IYL+3W9SbyEwY
	//NJeaEPid8qHS5oa8q0T61bXLHfPVviUvCGLBtPyTYWNqK7eBD9fyXB5pVkopkz1eiBdNOS8B1
	xge2uOifNMC2We/wI1R11xSlNlpCPajWFOzy2GZw5Zx4gtP9ddeXDlWvn1Ffe2tzq0eJa42PqCi
	qXaKI5rKC7u0SaVGfnKK6AW/hQf3yOb+QQs5JRB57e9ZcV3aWTA0g238IFeL0c3Xvhs7xvGDToL
	2vyFJf+9QO0S7F9W0QVyL1ff50sABkAV0jGJ/S4JZSf54zwEQI6Fxzhp7yu2zZ5lTxzWSRYoVtb
	EMkKjEHMXxL
X-Received: by 2002:a05:6808:199b:b0:4dd:18c7:5448 with SMTP id 5614622812f47-50c56de25dbmr13518053b6e.56.1791878920742;
        Tue, 13 Oct 2026 01:08:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.186.239.75])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe916sm14163034b6e.1.2026.10.13.01.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:08:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1791873760.git.tanggeliang@kylinos.cn>
References: <cover.1791873760.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] introduce msk_is_mptcp() helper
Message-ID: <260bea0e-f3f4-4a6d-138c-7d8f2381e38a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:08:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38361897543

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b39a692c5e=
0f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1184430


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
