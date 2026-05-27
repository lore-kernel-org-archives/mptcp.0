Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D9428462
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894898; cv=none; b=tJ9aBQjo8+Ez9bp6KqUSbjHDJy6u95Ra6lbPB0jsUV+BRnk99lBm8uHUiMPIQym2V3ykpGraIjMLKCPAzOV8lae6Guj4aFt5uZuhnKF4RHwRGWI4qYmrTZy2Q1fkU8lwgEQ/C9mD7x9yBqnVrqKjXtVW/qyw1yhJ0EOAhlfhLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894898; c=relaxed/simple;
	bh=os52CiJ/qnfnhO8crAswrjOTsEXmQ2oXbNzrIcQl56I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=oe+uXVN4lnCTQ4ad5z6qIrXdeQB6wYmyjj5S93H/3HYHuunnDvSzQiJvK1PvyK4Rh1cNmty2j25zTbkG6Pwwz80M2sATxjrIvJx3t/N1veI/ASemO3eh/gZ7CdOOMMPmo9lndksgaXEn1NFnPphI1MiVjp8dTxaueFnrU2ZOZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZkjexMI; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZkjexMI"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-961780b0b98so4569390241.0
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779894893; x=1780499693; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHWzklS0AdpY8OeBWhrB7uoVU0QLtxTIcOHIFNjtfO4=;
        b=DZkjexMINrUVwD9KapeAnM/ALqpkvsRYl+oyi/uWBllUk+Xaei3JLf15OCpG6j4Nt9
         4/nUlebyCujQjNaXf1baQ8XHFCpV+AJp2vz+/f2AFyWa5qPCwuj1mIYbOnp2ynzbuMCa
         p4AbmQ8DxhU3nkAmcYBtQ9mpbuI8JH03SChpRvKdaPYZcCjDPQDQDBz7vupW5FukQ46R
         AqdbGWLcW6Bl0CmZCkT45GFWaSceLDMUcRwsbeayzNA4QERg5AQyVmeXJV6YzZ7Iz11+
         iZEUN9zgPVOE3pdM8yUCDFeOtdMudZZ3H1F+1XhzncHJNA/3mPYoaYJw5i+1GYXu9SV/
         8GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894893; x=1780499693;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHWzklS0AdpY8OeBWhrB7uoVU0QLtxTIcOHIFNjtfO4=;
        b=kU3i3pXIxRY+K03DnrKG2P9CBs6hBPcgxmjdKwnN7FU4sqvA0R3p9Vbsw4G8SnM0Lk
         ZOLvRIuBUazLsDi37LmbYZDXzyuwG1v1Cz25Dx+JG3GKDdXu5xk3xWUVN4ZTW+o8M4PE
         W8Xxo7OiebwpkVpTCln2QHFBYWU84LvhI5LrmFNj7fmSBJoYh/rTf4koJQfnUbOFRJFq
         57NN3+xuI2vBTxCk0QAHsaDn9VGYAluD+ilMQOlTpeZ8NF2fltLr3JDjODgs2eUMnRbG
         VDMKXV/FjvsWS8MfZnh2u5H/PfsgIQ/zff0WYweOjpYwtRsP4Vfi1BUZKGAwom175dKv
         50EQ==
X-Gm-Message-State: AOJu0Yx57WAX4Jw7/zWRMYYWdMkNPY8ROd/kK0hqIHI+8ij0X+P0S1po
	ICsL5fjTLWwkoeN32hzDkqbDM65C+JAO8+GSD2bJX3qYwFDzPQ56dj8=
X-Gm-Gg: Acq92OFBr6/yqQs+89StoHdOJKkMAN0ulD3LC5/6U3x2qWasCjaKp2t0OX1PNEYnugS
	tYEpIYzgaq22YHOBwBPRJqhqkaRySwPay4rhEfWZLMe/tqUZUmIkPi0vbqa2ZdASzPi615Ds0pN
	w9+kE5yY68gCsIMs4CDau4vMd/xeFELlxE/CKc5C7NkJbio+QyQMxMGJ+QOM8LIQoIU6l9bcWFk
	zr7J3ZpAwTBu7QyNtdUXKL6le7se4tKaIFl7qbOScSB/0kwGAH9VjwgkeANRyo/EGWrox23ilVD
	2rWe3FXy6hMCcS3CRw43an40sqfasrCPKvMMwL7E8YRove0buMZYmtf/VaHE2OUzXmnA78cTZkC
	dNWmB/AnlxPuvyKAkBeOTio4FtO1BPylDF5r7O1jcFQ665igawduvHyND8WAfJuQgW2Ebme5KA4
	N93NpL5u1zdZoSvYPQ1nc0SLHBviZKCMZW+vagNBHZ4A8X1uA=
X-Received: by 2002:a05:6102:3faa:b0:633:4d1a:65e4 with SMTP id ada2fe7eead31-67c80b74b45mr13689855137.12.1779894892903;
        Wed, 27 May 2026 08:14:52 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cca4705c62sm83458746d6.27.2026.05.27.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:14:52 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779890764.git.devnexen@gmail.com>
References: <cover.1779890764.git.devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v8 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <b0c79201-2571-2ed8-9541-7f16cf13b581@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:14:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/265172=
37171

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/38eae23373f9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1101682


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
