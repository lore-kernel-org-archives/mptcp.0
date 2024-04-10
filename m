Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9A16E865
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771599; cv=none; b=mtC/p2OGmf8FIjpH0SGXTbtuyDBVQfT+gWMZ+d1AI5ROXkuXwNZH3eAjcPhXxTzx6QPgS6qOGPuN25yae7zy9nJmbIjH8P3pWTyKrlnscgAQ4wIeS+mQRsWoMY8WH0GAmGDgpRikD4DURTscPs7GqhsYZvUdWM1x9Iz8qnspHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771599; c=relaxed/simple;
	bh=K302FD8yLr9mZdB7O2ItQ435d4o0QXBSpEY/IQqykEc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=f0jd1QDwoplhKdw4QOrOHqi9T7bCSlqvbXihmaoQSbZrTXKlh6b5dAE92zwwITddO8QlzsOwYFQsq7FCpvzm6PTJXG/W3VYGz6BDabNwC+SJsT6bNLQrAa/x+xzYV5uSvtLekGCWRic5BoUD8W9TUhBxmY6sChsrtV/OWRNkP0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTFBSrn8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTFBSrn8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d61a6229bso222792385a.0
        for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712771597; x=1713376397; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu02+JxqzwyQM0W0ZKrxOh5vE1feD1Y4C+Ut1S/k1fM=;
        b=ZTFBSrn8auz06UxAKtJUDqMkgHfn8ONMpXYQKmC+Fp9B+lE8kyEpoDasS/4GBwncv/
         MMbOeR+be5mqDy+qwirf5obDhQikTSxq6hNXhqvFez0kclvl4IFXCLhciDQSretkdK/l
         xm8sNreLgWXxQxaO9/OPrR5KRN/8jWcTdvTLdZizBE5I2Th2G5r/AopuUlOdKBNTae7Q
         I2sSveb9go89M7SK85rHresTU8UaPY2oJx405UGkbOgfeEgVH4oCJmMWSWfnOD3tqSmB
         0c/JBMHm5Kltfo0wgNWDbAqvz2i4QgHM8QjQoC7wjgnpL3SSzImfgY+ZDskZ/BpdzobV
         rCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771597; x=1713376397;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uu02+JxqzwyQM0W0ZKrxOh5vE1feD1Y4C+Ut1S/k1fM=;
        b=jZYeMenmZwG7Z1yxnc3R+ow58xA4tNFTJ1iBT5Fi0FD9enSrjZUJaUEiXRd0H18RrR
         yLXt0fdtgggyFZPgNKOAbBWMtbcTWPKD4dNPwSnLJ+ZafnQeDhYZjyIhKouYftzHQCoz
         mcoEjH1KH0IdryLCwNRVGtekufXgsOyJ40YfNkW1TmNvtzQ2IUoLKqMXmA/xnaf2+M0Z
         9ebU80UEqsCBSjp0uUXgRUx1YYeJ2R/zDaWkqS6cguaV9jAvQ/naFv4hgtNFWLq8Icm9
         NkuUVyLRJ/VGGUsYy3ryjt0eqh3MP+cvvcNwmBZoHn6f8t5eNVuMquU5kCza3GokuqqE
         0G/A==
X-Gm-Message-State: AOJu0YwmG2rCjxmAnpD83Zu9aZhdOqFAHlOczJzHwWifDudWL+K7JVZl
	8oFqDI3c434AxHqRAeAU6ezfiRHvdxnt/Ka7v/C8iL/0vgKkuWk=
X-Google-Smtp-Source: AGHT+IH8E1tLh9Ck5quuQWJI9LEeEdVjjBYpKriSujq3l/senh8/fzeaEfNmFvV6oT9DXyIFpf7eEQ==
X-Received: by 2002:a05:620a:178c:b0:78e:be2e:b707 with SMTP id ay12-20020a05620a178c00b0078ebe2eb707mr823310qkb.8.1712771596843;
        Wed, 10 Apr 2024 10:53:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.126.47])
        by smtp.gmail.com with ESMTPSA id l1-20020ae9f001000000b0078a751b6c99sm5442744qkg.132.2024.04.10.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 10:53:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712729342.git.tanggeliang@kylinos.cn>
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v4 0/3] export send_recv_data
Message-ID: <b0fa2f6a-30d7-dd0c-bb7d-2660f61c6d71@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2024 17:53:16 +0000
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
uns/8635152681

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/544eee7fd63f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D843088


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
