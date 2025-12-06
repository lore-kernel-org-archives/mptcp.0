Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81B2D8360
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029081; cv=none; b=PYjm/io5mRlD6zj8UyVFp6BgiAb3JJYLGbqUs8dJPT/aThvgmGsTed4ezZj9yJ6Y2COvhoj6Sgv6mFU9XLScFskTKi7FYIuLsK+WKQUthB4UlL8B1UzANe/ISrBvzDbdiHwQYjy0dYrCW5ZDsIA722GBG/TVqCA5fA6XgiSJTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029081; c=relaxed/simple;
	bh=MK04oDZXlfHL2Bjz4xr6dGVPg5USuUWpyIGMx9Q01K8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=buXNZtriH9bco6Vacafedmzwp0sHvSjv7ZICfJRJTms8g5eQmcoMrZnovyFPWqn/t6r5A1Sv9wDsACopGGC7F2L0EQAkSyXaalPMjjWZhFqFbeLP46WAr132OjS84SSIP0tOuilJUaQ4/Owk/YGw6gFd3gEJ9+CLS+yNWh6lhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQd2wi3B; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQd2wi3B"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4ed66b5abf7so40317741cf.1
        for <mptcp@lists.linux.dev>; Sat, 06 Dec 2025 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765029079; x=1765633879; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWoW0GlrIwTJBsH66HHNWOaOWQZitZ4KlO8DYPW8TWQ=;
        b=VQd2wi3BmzwkwYco4ZdOnv9RHuqXCTjEtf0kXS6pu6c/h+Qsjnjmm4nxWednk1Ul2r
         WPRTJBd1MC7YxEhQl7RQBjvbjT3My3aQX9Jw9Al4ixJO17KaTB0oPqFcqwH+jhjFLcMx
         6bKpfPSmSs2y5OtUHV09RiiG0ylcbi39dcNquoPWG6HulHCh/fPYW6jHpJUURQlghtDR
         TCU9+wGX9c/VVB/70CDaPJ+9+0Iwx4ITsG4X9Qqw3ZhJzCgnOSoqZ4c/kUFcbzv8U0bS
         XGSalmicSb5HY3639vBNT9cplMmizyud8L+5/a3DMUGB21uXOGgXyHQ0DYrHNqrjh+iZ
         PZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765029079; x=1765633879;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWoW0GlrIwTJBsH66HHNWOaOWQZitZ4KlO8DYPW8TWQ=;
        b=l2CxbhApPRnsUmG2WARGvbEm5EO+srBBnEspQoK9UwLtto3l01gWqPjdEPMaoXbqbV
         PFkZy9ot3eOACqEnHDSSCHmSMJrowcYyc9ZczdQ6PHmyYkEjcfTzC59qAloZbi05Y8MW
         5GAaw/CnvL6anzj2sCiWkmsT9SlLT2kqO7H8iCaZzybfoSu+DFIG1ZWHEpYXIDvlruCD
         q0PBwvwS2xZTHFCCXNfH7QqWQdIBc/mvKCs8sQLHjIBR07Jc9PII7gURirjmSRCU9eWv
         f0JLsZcakFlb2ib9wMlO8nfbOuSOH5KUT+3EaPY1HADgi2NpZs0+QjQaloQBR4jDZC9W
         MBgQ==
X-Gm-Message-State: AOJu0YxTYKNrgwAiZpsOLpSvnXv7mQRcl0jrknS2rwbVe/FzYXY087Gt
	3Mxprr2/aPeORshsJdG5g81vhMSzeykhaDHupDzLfcQ7wfVW3F0O4Nnkk/92DMc=
X-Gm-Gg: ASbGncvVuC47+MubhdnyZcStPOLDL9hJq77J6hlRkQFAFL7/xE7wEFy7zHXZa3SDUWt
	VBWYcxCIyspSEqL2eWlOEj77nr0J0Eap3wCjKigi3GobLmnipf7+1yDVLOw71cGMP3Aeefrq6nd
	LGz+/Z9fSEFfRKGReeol0qPlBib+BJY6G4vStDe6KMbTeoy5SOuHJyl+6zfdhFBWcfYqVPzgNcK
	vAxGg1YGdQjxzTWGYI4Uj2wraIohpAv3ZuxfKd4izZXQVM218CNuIaBmGn77iDheWUbLuYgoEcc
	qbUQQhmDHkNztfEMoe5vSvesE665iinVigqiFYcEWeReah56fdPRnfhKkA/NQcPtmKpEMiOpvMn
	53wOhhe/JBdOiUvd0VE+6pLr8doBRr0/xQ1H/IMtwgrdQxPReU8HwoJW6n3wTV5HA0W16Hd9zZZ
	mvGDmHurz/qtpuP1XOTbQ307dw4uJ1JsyN
X-Google-Smtp-Source: AGHT+IHo2sHIxvVbFi8gutxHF51lVaHeM/dL5HZGuVx5vpDoarUrgYsXOqx6/axQ34vRSw+vLtPb2A==
X-Received: by 2002:a05:622a:5a10:b0:4e7:4a3:ae88 with SMTP id d75a77b69052e-4f03f72b2c1mr39229421cf.7.1765029078547;
        Sat, 06 Dec 2025 05:51:18 -0800 (PST)
Received: from [127.0.0.1] ([68.154.38.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d01f8asm46311781cf.21.2025.12.06.05.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 05:51:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1765023923.git.tanggeliang@kylinos.cn>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v15 0/6] implement mptcp read_sock
Message-ID: <e62a5172-73c4-3fb9-1a28-b0326b729189@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Dec 2025 13:51:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: normal (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19988767626

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4bf455dd3ee0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1031070


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
