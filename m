Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B8A33D4E9
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389991; cv=none; b=iBNzzb3IwA5bAuzMD0XatJToW7uDuM3devxj5/ecKEUd6VWdirkf3bZZq9VlnBnSM63AdyhIqx0SHHqh3FFURM7g99bKlT2Fgyqqr/5XrCA6W3lgJM/4dqFlOd1EklcdkTR6ldU3aFh164fG0jcULH3VOMFzfQNANlVBSdvmR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389991; c=relaxed/simple;
	bh=3w7TNsCtByETJQNCyF12AYi3FiwJNtylJVdaa9l4+Ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=fOQpL/TcH6W/Tk+DwfRpMJILDrqx0wnZRw/u3CXMurE3AN2k1d9k8H+bOCHWE/gBqzF3FYgITdL8jhuITkkPI09SiwkxO38J77TMPitRNKYmc5XSc+gbAZd6WzhdgThi6UEnWjL0nDagnfCa+k4KgjCdvuEMGlHZnPivVSM5mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p56gWoR6; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p56gWoR6"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304f590dd91so3554786eec.0
        for <mptcp@lists.linux.dev>; Tue, 02 Jun 2026 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780389990; x=1780994790; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CenaoQIYBlsDAe74jhUbAbCvhIcQBThnRuQ/i7CQSaY=;
        b=p56gWoR6YUnzK/TktUO7qIYIK869aKlOm7/P2Pedue71G1uimDP6VFCqd9n1JGXK3v
         68UXtjWrUwzpP+znOxzskXovANFh2WlbYZoR8BbJZrMRLrKsx633taiGGMlhWwUdZ8zq
         cBRkjQg1JMWotWel6D67mGcpgmdrz2LCXBZoCvYWFB3/ETfP2dkETU/wPIr8QR17pqEO
         qYliHQ0QoKM2o/qoR1KKULqpSiz8IWzMlhc7xHemxdf4tJQu/sJsc47Zr6M1qveW8pKC
         pNwMoWDHwaam42aBt0aHSx1V4A1t4t/Ldh6Kz9rn0kA1fl0pGMpexbzjJCBpCwt9v97S
         Iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780389990; x=1780994790;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CenaoQIYBlsDAe74jhUbAbCvhIcQBThnRuQ/i7CQSaY=;
        b=NnyViUS8ynVmy2hb+Vc7YUked6Qy8ipl1qsOHWzdonDDzalh6k2beqCuHWM81caqv7
         PXy0G6M6k/wjQHQ9FKevYiqYIpY4giySLLQr/Cp/Lede1SswQANLC8x6VC6Mchmo6bYp
         S70Re+dI9ELifquRP+m29C7U7yHk9D+1+CIAAs40zN7dPicW3r/qIUxRPhDQtpzHGBoN
         ZdX+GEKTD7b+kebLw/jjbrIfYp/9K7x5YXeev34HZbZYyHf8fu/aZQOA+ED1K515dAAY
         Smq5FwzzcN/SA7ld4x13iMnxLiws2WD0N+RBJeqgB8oEEcZHYCqi9GYm2EJxFFF8Wnt/
         IC1g==
X-Gm-Message-State: AOJu0YxkWVb7FZhAje87CSKm3VjczWr2aEaplIb0KqJ1/gu68RcCAZvj
	QhOjwALOW82HmK+jxhAH05mhpTNS9ipEAyr7QJUHs5e4+2earbgMU5/nLOeq
X-Gm-Gg: Acq92OGq4naPiHpkZUDXbnq4mYdDYrmi6SkUJZbteQoipmph65kXCpXU4wGM3daC33t
	qwCEulbBRxOsnIDWAvHbthLJFrK7TIKvs9bv1qUd8YCDoHOB70sbnZlQXJ2OuC1Tv1Xi/fDi5dC
	tc/2oyN65uTQm5wuD2G0rurG+tUF2IqDPe+M2v3xELRcfRmJ/d2EsQzo4hC25lLEnyG2j8joIjl
	yO65LOt+d1wZkP26V9kqZuJOo9dLSqeB7/hSQBq86luvIIscQyHgOEzyosdUTLe1PzOLv5LwtFx
	FPoCTvoxeabJunGRqmfRm76y1Rs2bgOiZnMbZyBL2+vABINKiJMDV/qFkWB7vnK3MiGXujxG2DN
	tP4doOs3J5LdpzHDWTS34OlLkIzctrc4dmr5In9QzeqwVAXFEp3xtlf/Jm7F5FPNlirdbkjlCtO
	1uIEuKktyHJyEeRpKa7zZLxmrt81/r9zaLjrhvMb+rDDajg/yZ
X-Received: by 2002:a05:7300:730f:b0:304:d75b:f5df with SMTP id 5a478bee46e88-304fa64c151mr7108542eec.19.1780389989732;
        Tue, 02 Jun 2026 01:46:29 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed578c48sm10516330eec.20.2026.06.02.01.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:46:29 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
References:
 <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: add-addr: always drop other
 suboptions + unused param
Message-ID: <bd5c9e54-95a5-9273-7fba-9adc8aa19712@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 08:46:28 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/268053=
50984

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6bf804b82108
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1104427


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
