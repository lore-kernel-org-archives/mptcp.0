Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1C239E9E
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196448; cv=none; b=L5hV85SdjIYaHTp23SfrR3q1uD3fO+oGpVc1ASQmSGAwHjj8dvsqaUowHd60RdRUrV72Vm1xXMAnH8UnmyiCdpJC2ABioB47P4A/MOcxosBqAqJyY+vubuURafa4vyqwu1zvAOFacAAJD2/1sPoa7CoDycw7vwIyLEHSrS6lGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196448; c=relaxed/simple;
	bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiT/Q24MoraWjU5Ay5oJIFLEfskL07b5yJxFW3+JKWuDp/0uzUkfQwPMnmjEDhwfuab2yQkDP3NXNk53VnPg32Yb0Piu6XT5dJPJYSfK2njIpL3N2DCeZxTp35e5KBV8d+2ER5IfyEmNP32T6Ql8OivufVGQZ74vJNkySKzebzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMtqm6C6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMtqm6C6"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab81d016c8so77587281cf.1
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196445; x=1753801245; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
        b=eMtqm6C60aktfidId0LQb46dKF/fk6R3DKJcXc2YG6RiHDCm0e6kgZTltgQ08HLkt+
         gPdqwlQktnoKDTapo5B0jjMtePIq8/tH2vLzl3eSyWpCCAONqRIiNLTQ+KwcmcZ/3Y00
         qeVA+xBmuEq5X2zR7Z9L0fU/1sjZFKHSqcir5J+XuQBWmKNAPyiBVNlsUn1a4SyMdULX
         V7ATyl4gkSHBgdLbsDUcrMBrBgkXYwayuaaQK2h+uLwc371H40Q5KaaU7V8pUOPImJqv
         lcwUwNx7Z9W5ldbRFIzQxY62Tuxe7pyKoAp1vkEMJlBUySb3k7P7LHbkcDLd5KIF80+e
         K80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196445; x=1753801245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
        b=Arsf1IrmryvBQuPyCetXmw86G1S6ZsU6fgbvmIjzT8BVba9zFj2G/i2vdnDoIasyKf
         ev4TtAPgDijTMjZIto0Dbo5rJwbI5mVjRgMY5SNDGs8ScVEWrRdqV3KRp7NHCnynFvyY
         KcNLld36dZhx6yHtLem93UDUTJVQVGfw8tMz+xIXGJXT8+kbhXHUz+vvuJEls0nENSEY
         GY6uHvNIz2u0/OOG51wWau8q9WsxicQ6g7hlqmy3nNOCJ2OuCNUu6jVe47SW7KFs7S1O
         UaW0Pupm1R/hdf3wn6bqxQ19DADDaYUaNfU7p7E0i0+MHo250IFe25qpDR/jCUhNmchK
         8SjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcw5MDjVKQRVQOpIkwfHMgiJcIE06Jcm7mF5ZYqQ1+tOBpYNSNDt+67Io1IbR4KFqCLIXOQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPUdMR6Av1RpsTA7gJKhBsYsHom9mso2eXWZPwwyHjBAmXH5ZT
	Cr0295o+94oUFVOF3daiVWlsez5hiSV2qG1w1KXhCny33g0/gt5/MGIdVZf4oXjctK4RoWeGBmJ
	P1W9outsmi5gpXYy0Xicgx6ChXrY77HcT6Hk5uv3z
X-Gm-Gg: ASbGncvjucPk+/K4kmaeWBMUhOiQIW80zDKYuuGnpIDPCIY7QPvfUTvrgYvSEeb4oT1
	7WV378P/9VaH2auJmozdDfg6Bmfg6oGzwg0fRITQHXi3gL1yEPNbDKtF1iZqJ3wwS6UEsXiethq
	TbuESH8YnHNn4f0RUUZq11gehP5GyI8FtKptScIeLQSazML7ThXsQH8QgLkpP3F7Ip/9kQVbQLb
	kdyEw==
X-Google-Smtp-Source: AGHT+IEAwdtOOJZle/vAWN8RPtXy4MisNzaqxiiiStWuk5ZuXoX4lqwhlAmVuPypXJlxrGh34p2aRu8UWxGzVff9IMU=
X-Received: by 2002:ac8:5d4c:0:b0:49b:eb1d:18ad with SMTP id
 d75a77b69052e-4ab93dbed7cmr385323141cf.41.1753196444364; Tue, 22 Jul 2025
 08:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-12-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-12-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:00:31 -0700
X-Gm-Features: Ac12FXxzCSficlnnF49FJ-AwqyidP1dhOSx-V9OvnBpoHWZaDg3cQQfRkuFyMag
Message-ID: <CANn89i+mvoZ4rqtow2SRR0ZRB9gS4an9syCLuXyqcW=4-8Ek4g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated knob.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Some networking protocols have their own global memory accounting,
> and such memory is also charged to memcg as sock in memory.stat.
>
> Such sockets are subject to the global limit, thus affected by a
> noisy neighbour outside the cgroup.
>
> We will decouple the global memory accounting if configured.
>
> Let's add a per-memcg knob to control that.
>
> The value will be saved in each socket when created and will
> persist through the socket's lifetime.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
