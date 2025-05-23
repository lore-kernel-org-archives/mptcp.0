Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF492DCBE6
	for <mptcp@lists.linux.dev>; Fri, 23 May 2025 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978187; cv=none; b=tBMnqCYKX+wjPoOdQRavDeLM0MfF5pDVIO/lzE/Vjs/CFR+asLJFV8YJd88GX73X4MnE5eEIhGAQFUZEGsDPxnDp8L9JcFCC8oDO1Dmth9gYfDr1J7Kv4Qwrl8yQ2j+iDGJXkx/R1JmnPd+v+qoURH1DltaIcybRbgja5Bzg/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978187; c=relaxed/simple;
	bh=ThXkbyumlnVF+28FbFeQyQJMLnn5HG3khZT4inSmpPA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pzVSiOmxlnZBi2Sk5c+WfjRhOmQvO5Dv/X6kY7m+tj9Qdn2vjYDHtx9FFTgSzjNun436PL7chES5xj46RQU2x7vYXFvHF3UkIBeAzpJqTiNCFbRENkvRabikdz0UGFyfUFNuG0sO9+dDzxK4gaP8Z5FJrQamThgUhZP4zjmmCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4P2/lyc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4P2/lyc"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f8c53aeedbso127232376d6.2
        for <mptcp@lists.linux.dev>; Thu, 22 May 2025 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747978183; x=1748582983; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wncCI3OFeQ9A4YM3v//fHTnkyN0GTmC9/Eza3o9t6A=;
        b=Q4P2/lycSTPy2idtWdQrxv5qEp8z+PXALHzqn+6xYu9bUs4Vhq1/LmECDkcK5z3gy+
         yOXs7MgMpnNt6DVnrg3hgTh5sGRFpemWfNkUtX+vWGHzTSANuw6aBVTOYNN4aMLz7upH
         M2HhayhbJxZgXP7BrEK2A4jpuMnNiclm7T/mEsKtPVfNrIxg3dji4CC+HvHljzQfybEk
         +Han/c8I7KKdVP+HYzGSbb6gnCl+f/pEuB1MwKcn2OrxI3Mp03XERLkzdpmpFUqsEvzQ
         W/JNtSokCGC38nVKvD0Y7GVOM0JVdRDGkaIjo9v0DOmYxWMPhFjruEttZy767LBRkn+m
         U90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978183; x=1748582983;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wncCI3OFeQ9A4YM3v//fHTnkyN0GTmC9/Eza3o9t6A=;
        b=YuAd32S3qfFIrkmD2O0tTHKHIicHs70+/tNKweLGrKH5W80PBx6Bhh8Db7kkQFCBAq
         mNnEryEeGEUX4LHQagdSNKhI1or7qh6/gkBN0tiX6G9BJgqZh5Fee4VMWdUSAdO6540Z
         +GjeV8rjn+Y8EOX1fLK0mUZJ5to2sw4jNb2MKuiJRHouicBnlNlQJPIrYLq5NGgU9uXf
         FIKwHe7zNw3WGefJjOPxoTjDKOF54+P63FB+jPaZnXpj/5f3FyIFJ3ScdzojknMhRLVM
         fJJBUJL1JH5CHDcIzDxrYeGdsdAGn6ND+gh971it31DDQSgCC9vV3699DisOQPgx6/S/
         p+ng==
X-Gm-Message-State: AOJu0YxmyzYgArnKsx42Dn+w4haEl79d9FkNdgEu+eYszk1cbHUQ5Azu
	JR9MsnDdWr9LQLlaD0/z+Zb8TKk917KgSod7EZCvnIwVZBpZM5mB9nw=
X-Gm-Gg: ASbGncuzCysqurhb5HdTl2NLvCotw/ZpHlczatsn9qySLUmKmGA6x2Dbo5efTLVEceV
	YLiSHGfZThPMaxOAIhJotfoTduBBG4+lG+E3Uc+xbUFBUNwfZuZK3kjbRXa1OPOPt7bqUTV9uq1
	zLyN0glCsBedUEz/Hk7jKUTXG8m7XuDIEDUDXWNevEAIhcm052FO9h+8SeMBIj/RtZqUbyUh6nC
	bxIOgcmcdSmP98ePSYeYVhGKOH+Lxp3Kp56GttPON+37WT8rfQzzi1vBM7tC5GT43XrNs/DbT3v
	IqKQt+QFpsf68FJdib/6IAWH2sPNueLUUvmdSqJDI2fGwVHTwoQMUe/Muqonpw==
X-Google-Smtp-Source: AGHT+IEw7VESbvA9avNIKxuPm3o/7eg8zsifIodX+OBeclezwHHFPae+9n+soz8XHtHif4U6apvfmg==
X-Received: by 2002:a05:6214:ca2:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6f8b2c334ffmr443920386d6.7.1747978183455;
        Thu, 22 May 2025 22:29:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.31.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b088410esm109782466d6.2.2025.05.22.22.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:29:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250523034433.1373-1-liuhangbin@gmail.com>
References: <20250523034433.1373-1-liuhangbin@gmail.com>
Subject: Re: [PATCH net-next] selftests: net: move wait_local_port_listen
 to lib.sh
Message-ID: <d94c29b9-9b61-70e0-6252-ecff66722146@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 May 2025 05:29:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/15202060946

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6dae34f54456
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D965637


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
