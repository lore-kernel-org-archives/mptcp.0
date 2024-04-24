Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8313B596
	for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926036; cv=none; b=CyJyX/o6nl6gn/GidEQgMg5Mo1SeQ/nZRtO7MgReonj+YG6c0ap8Wz/Dzh+aA7WgTTXBbE8OPp0YlA7Ebnq9NyGFZM8ATG6/Hi3/N3GqLmgwh4dDGoQNbUugIUD3x5xLw+t9Dt4CG5llJNRx4rETVbVfYw1EQyrr1s8WV4cWKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926036; c=relaxed/simple;
	bh=q7APHPZzBjFteOrwgkvLrHIzT4HTuKbCTnwB/oVvopU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=C7hvIShkYLtIGamn0j0B+BPjAKdYawRvzMrCup+Fk6hcWNL7vRydZKpjfj1x4tX1dAAMTElz6mojyyB9G380zZnqfQaVWr51K+pNabuObUE5F3A2cWlou95QuUFKe+Lt59KI2xqkIJ7nQ/8RoxqMqr/dFY2thObeaAHHcFD0Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUPpt23+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUPpt23+"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-617d25b2bc4so66396707b3.2
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926034; x=1714530834; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vefUR/8B17GIG0/f1hRhxYN2NtBMxauDMVjjko9oO5o=;
        b=OUPpt23+/q1HEs7e5aEN+9NFddmj1ko/nDbyfjzA5DGIIU5rusDeLPFWr14KPCLhId
         QmoLYndfDZMrCdjzneL97KkgCSuR+MWU7o455FnkkBIpTL4A9TlUN5OmH33nN0HlJ789
         Fs2Brxsh1dcFFh732QXGhlwVli5eF3lhtEUa2frvFmF/UOFWkOVY4ACnZif8mgPxwuBD
         ViJ8eDKo0jn941kA7lElhC4PNT4G5IcEZ9Xxss0Ixs1PEcro7XwphRPNlxtDftEB3iSy
         QdG6jDgpLG0TA6BE7mySUWfDwleJSTeWPLe+THlV9KbWKXVOqbT4kjHL6QCBZViwwC1n
         PCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926034; x=1714530834;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vefUR/8B17GIG0/f1hRhxYN2NtBMxauDMVjjko9oO5o=;
        b=Olyc2XfvmpeS9/hEJxS6X00lK4tv999CE6SfEnu42uCuNc9NaV1e9+Q4BBnW8CRSnI
         UPKFDcME6H6j8ITG6nFxQMAMx2faadumEP9t6k3RlL+aGPWNrmV0mKfu9InS/IHxPyuV
         KGTGb4HSq5Kf33IFhxhsz3UvXQPcjQ3O6l1gmekJnrCJcf/aa2JFdwhPynOafhk8s/U+
         zJlxn5Tpe0i+ekRW6Dw7/as8sDZYKbtuxyfHvVJ5r6FI838jnjVkBpawQNOGMecxm+j1
         EHB8HQEN2fXljbS9cOM1DMCEHGc0x41Q9y4V5HxNJdR93n75RgIzIvy0g4PatQoHSo/B
         ctbw==
X-Gm-Message-State: AOJu0YyqQRiQRjXoyM5k87PGMzSK6M9bJzHzdfjEsFpgvtESmSMZZzmq
	Wgn34uq5nWFzvhjRDeJdOtr0fkmmAJUQ/0PuiMzGNYCQXSrSf20dtsCg
X-Google-Smtp-Source: AGHT+IE3doxZf+hvna10nAVnYJpLQAEzFzrEL4KFDY8iOXh7WVW3Lc3IxjhCm5bTvSzr+AjHwX1zgg==
X-Received: by 2002:a05:690c:17:b0:618:8f69:df36 with SMTP id bc23-20020a05690c001700b006188f69df36mr1421585ywb.23.1713926033823;
        Tue, 23 Apr 2024 19:33:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.107.24])
        by smtp.gmail.com with ESMTPSA id kg25-20020a05622a761900b00436eacea78fsm5679368qtb.65.2024.04.23.19.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:33:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1713920939.git.tanggeliang@kylinos.cn>
References: <cover.1713920939.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/4] setsockopt per subflow: BPF
Message-ID: <2aecec3a-dded-35e8-0c9b-7cacd301ebfd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2024 02:33:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8809606528

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/23177691596c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D847234


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
