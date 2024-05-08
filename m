Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010092836D
	for <mptcp@lists.linux.dev>; Wed,  8 May 2024 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164988; cv=none; b=dZKj/G/OmKYNcyZm5QQdgSpu0yXGZRcZfaRqC61GeuSFrJ4PGZHo+Chfm7nbHyQfRYf++WnPCsIXfgWpJ4ss+MgK7999ponhbngm6xYfkWGGBKvoj00c+o0Kt9/qRB6Kb0GDF4ZhaIynQSusclSaURPF+vI4hYuU5pEN1+5r5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164988; c=relaxed/simple;
	bh=gV2LOZjGOE1Na/fhLv7QHhqCc+6p2/jvYPgEAHGrypw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YAfD8kPKfe2KY5H+N5iIRBO9/17QEMHkFxu8KSlDaG1FsEw7wXBc4b293Rza6brEYx6SsFfl1/TIh92FloELN1GuytRxbXLoaXH4s/v6wtI9BFZKMiU52Xsglf2zR+LPxwC39fotqE64S+fI+QuKAx1bxKbfho52o24Wv7Aq43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr7Xugfm; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr7Xugfm"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78f043eaee9so237734985a.3
        for <mptcp@lists.linux.dev>; Wed, 08 May 2024 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715164986; x=1715769786; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w6mu4U5k11OxE/DXVypXwDEU8/upGeVDhbmjS8to8w=;
        b=Cr7XugfmE0gSYgde9tf7aDGfbrkJldfRJm0ObJJBaZR3TJn2TwH0HHfVmmeRsOCLwx
         qPyOh3odev9bvX8huZc+w924a6F+/no74Atgh5gky/8lLFBF8+VkBkioJDYiYrPOZPQz
         2yL/PzWibW2zB5U3riKAZQLO9gP8rHFzzT7G2zzjfBtFz1ytc/TUhm6oFjkLn2wx+3BG
         9UhXbvmeaxNHi+F8S8C7//nce6rzCUvCnWEVJb7eevd/bEzw5RZ38y9/dfUrmH5x5/Sq
         ffecCbhgWeJjOO1esK8MpywNw4RHsIYcjctv/vdeiiKatbLuBN0a9NuZpF0ltprQEDgZ
         qWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715164986; x=1715769786;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0w6mu4U5k11OxE/DXVypXwDEU8/upGeVDhbmjS8to8w=;
        b=Q0T6sFDL2xZDz2amwxAr7koRSuHsC7gBAxgmIpauCiNz4elzSb8MfuIGSaNVdi0KwG
         oC3Ta4Xem/Qdzo5ilJADcy2i8Fv8EfzZqHWYx4AelPQX/bl+BCC15NfERpZnfTe9O96D
         1l59REPVCHTUkINu61/hj3nZxKMeO3CWdtro/RPzx5rhFPy7D6D+5DP6NXkBZnwBpi0J
         oI4SJPdON2ps58ruNZbYBBqYy1VJnWe+2URI/6lVhjpgScakpcJ6ytHHY3RKWO7B7W7i
         anq9w2n+Xxa7+pqpbKvPgoBckCFmQj6LNBzCyvEMbeFQRmIKH1ZaKcEkctD3Kdm++1R2
         sTNQ==
X-Gm-Message-State: AOJu0Yz4DWbomAGnvYY5h4CI+gQynVjRHdD+TMQnYUm0M0BaX6SIO0Lz
	8x0exh6SMpRaqQfPOpN8KwfjjMdjKySMZ/kfdr3p92IvEEZUd0Y=
X-Google-Smtp-Source: AGHT+IGJrCHw40DuvDXBDehJVRDhrWJC5xvx/WzGHoNvtMp4LpeUPNuppuPksMXc66dgetacysO3jQ==
X-Received: by 2002:a05:620a:25ce:b0:792:b8f8:7832 with SMTP id af79cd13be357-792b8f878f3mr62743285a.5.1715164985816;
        Wed, 08 May 2024 03:43:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.206.98])
        by smtp.gmail.com with ESMTPSA id vq12-20020a05620a558c00b00792a414a2fasm2111373qkn.112.2024.05.08.03.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 03:43:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
References:
 <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: getsockopt(SO_KEEPALIVE) and
 TCP_KEEP* sockopts
Message-ID: <c4a2f59d-ef62-0bbd-44d0-5417f145f2f6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 May 2024 10:43:04 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8999961874

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/852e82e9b555
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D851490


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
