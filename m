Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243E134AC
	for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480048; cv=none; b=nGN3QO3wYG8BhZkAEYOV3L0USQDDRCd/dRl3XSQS1uAyf4WzYoyaMOSdOvCnLKa/E0uh92vInhr/KckAb251wWAF1CuJ6bWTG1q/cwE6ZzdQJ6umQ8sDZDtFUQpYeUFRm0G5UQGNGh0/2Mt1DsS8+fp9dvVXpF1FigAP53Ip1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480048; c=relaxed/simple;
	bh=aV4gnAU1b5iignG6ZkALm8IMpr+hKkA5rR3kv/8Ug6A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EOgkh//9W/wBjRxBHq8c4D1mXYcdc2qkS2uBJ+6K4OUaGQCNgkSVSMTyWKSZ1rGjmwlCUv4+/T/+VNFO8Q8DmKHyPOo/yEOivwPA91kpDkcHGAW+W4y0JX7dVjW7RXNu4WlFPNNZH5Kt2J1jI7cIAixmBmo1+/UQ8X5fGvvRg5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9LgJqiZ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9LgJqiZ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70942ebcc29so3144576a34.0
        for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723480046; x=1724084846; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAK2Pbid4JT/uoftcv10fjrTuG/BhEIxj0pa22f44J8=;
        b=N9LgJqiZFSF0tHhrsw0sMwnCEA18ahwT/vetL/oSEq9p+msZ5235YFmL9xVOXA1+VB
         wRDdDUIFIZEiCrCge+4OBWHVGBS+2JEMjuP3g+WLCR5f2KiU1GVbgXtKzHxnND34PDNj
         Ie35zOLSEYq980X6jyQyYBQPgFwoRcTZfQBPfMyBlaZuTMcoPWyViq3X8tKJKjjKGKr7
         MkpTi6o5GIvJKZCwx+C4V3uED5agLdenChwsqGWpllGdw9GQVq6KK+noa/KhqY4fmgXB
         2iQJDnRsAwCfwm/VJQX11/K+Ty+Z5mIA9z8Fy2/AvEGUe/ybQl0mEf86zbu7lnT5aYYE
         IGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480046; x=1724084846;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAK2Pbid4JT/uoftcv10fjrTuG/BhEIxj0pa22f44J8=;
        b=XnVs9W9VC3Y6qIp3iD9l6U7dMNM/Bznk54+jsiyzIlBdiQdsnFNygn3pTzZplvTKCU
         QNdpIAMSUaTHpmrJEKyH2+5eZ6b3IHCUMF3EHJyKVc+J6+CLhSDfcRyL+rShsfUDln40
         pcTkCiL/NxgdYgZHmO1Vn02ZVeWdltWoAR8qSej0YLmkv1aM1Ob8cmXClG/ZwgsaiHMX
         KXE6QSKSxTJZuGRe3YN8PNld1+z7tk2pgok27cZxNknscwECu4THTlLmk3mzNKy5sz0p
         a1cttXaKgdxDgW3+F/KRyyJDljlr3nwczoE0uo1q0QwPUc1rKg08A/6Rkt8JdMABNvm8
         d6ag==
X-Gm-Message-State: AOJu0YzKUIbFlFMp4aNoaORUPkCTQjYWtxZdnY+qIDsl9T2PuV7XkbLn
	qIssh7s7V72X0B7aFjIAW6OFMWRRb6zW0IxDsvg8qqjGPw7xurk=
X-Google-Smtp-Source: AGHT+IGsbFQqk5ptZ5Oiz3Mi/NPLPWH3sXZ6CTDUlMERnmQixtmn8e20aHOYkzVakIMy4JfyClDk+A==
X-Received: by 2002:a05:6358:591f:b0:1aa:a01a:23dc with SMTP id e5c5f4694b2df-1b19d2cb5b6mr112487355d.15.1723480046374;
        Mon, 12 Aug 2024 09:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1d1437sm24523351cf.38.2024.08.12.09.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:27:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240812153133.574382-2-matttbe@kernel.org>
References: <20240812153133.574382-2-matttbe@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_6=2E6=2Ey=5D_Revert_=22se?=
 =?UTF-8?Q?lftests=3A_mptcp=3A_simult_flows=3A_mark?=
 =?UTF-8?Q?_=27unbalanced=27_tests_as_flaky=22?=
Message-ID: <3581e591-caab-1915-fabf-698c94baf297@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Aug 2024 16:27:25 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/103551=
34055

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cd7038c3ea89
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D878858


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
