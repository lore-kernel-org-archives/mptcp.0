Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746A2E92C7
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194886; cv=none; b=I0i0kH7VWt+wEiFc3sxuVZw13mm4KUC6ZhZq+vckvL3ZCSdBtvb6Ttmup6qhMKGKwOMnYx6KKiRw8AC08AMoGX0uto6G7vuOY5mB4NvIwSGYaH+SHb26ErlIw6IIeYKuPmD8n/hap9FeAD+nWa22WDvHBvvEz3O2eftghhsGW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194886; c=relaxed/simple;
	bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym/LZSrAgT5LIxdXMpba264LBXGwt/xLXNHFtkGKMmmj0LfJdf4Qr+o1tD6BlVu0xXGXLz+cx3wBK+An82z+PX9Pnj6KKiIFrhJao+UplODRg6DV2lWuIErZZIFjzd2tdeopaN+Ho1i4bh+MgxEw9/C7la02AaYZni/8bWDV4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvPiYgKc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvPiYgKc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e050bd078cso510233685a.3
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194883; x=1753799683; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
        b=KvPiYgKcgsZJpfGkr/Gq4jImDdnOaP8JCsZxw+ORTBR8tKDVIsKcrONLxoiSw3qvL/
         FUPCAGVqT1d2soqoyffRcEQQx4vAXFprvzPkwrpjs32Qm+rd/U5ku2hpLBv6aLfxMicY
         ztKHEiP6eUYDTraHgH2Q9iZ+NeltOGvcJe8Y8hA5rpIy9Yr56K2GT2cfFXd3yJJQnlDC
         kHkxt/S6vHDPbrazdKszHgQtdEodJvPho9IxEx/MJJbHISue8nIq4pR5eIhhIfjBTaO4
         o6e4VVkE9Mg3ohI9pg89Pby/Lt669iVDu32XypRPDorNEfTAqOX3zISL01eApQjbA/ZO
         Icpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194883; x=1753799683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
        b=qP8bzEJKYp6/05ABieK7K4xw3Rij2gNJhcZIQYFc/0Tm6zq3nMbkVLmP1PAropBxJM
         13TdsPgbJZVXs+VjDc3HjiaXhAAEpN03R2lE1WIRuHhd32YSntbqAPnX/3MN4Lup5Iqh
         ZfKN0OrKFmal487cmtyG0DUdf4hyi3NG12GjVC1qj0EBVNqyY2l2OZ9KA5gY4E4VRDTY
         c25YhqCzHVZreX4K5pwAH5vA9FHWa1IsMkZm1/6NVTXU19Fx7gxDBXshhEk+kqG7s3GJ
         QJsgw+19boHz/Y24w8reIJx7Y4hPDpHsYUm6CKVHMq0PTYAiIFmgKG5dzni4xJzLPtb7
         VGng==
X-Forwarded-Encrypted: i=1; AJvYcCVq9rY1sIhKRLZORUeE1gMW9+9kuk7O4DjhMc/EE3yzRDrkZ5qamB7mWqZ+1ctJxajn4d8M4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqSYH++SJqsY0BIGc8uVwZo7JUt3D14ocGY2LODMRJGrXSTBSp
	OmidNhtLApuPL7uhoKaVZsb7PhLriQJofzNTU11SbYMBen3mvc/TgFOVHm3aiwU3Cz8WkipaJDI
	K6T6hW/G0f/C5uHYZeac8Hi1BJxFPhoHPWcy6lBJ+
X-Gm-Gg: ASbGncskm7VZF0rSul5BK5iVFJJJf1JNtuNQzhZJo+BJTBbQGW3PXQ7EsoDoWA/kRza
	Ii2ACfcI9epsiQOMZEkCImlxL8BQKFSYOrKxoU+UoDOrmlt52NaMReEOkK6MzqFqBfACJvyKN0X
	SMFMMsKOFVwFE4VOqi6qlkFuC9eLV67ElGUhP5gFu3wk2CjGz47yGNDCfCS7Vs9mzH2849hzYBM
	ID3ew==
X-Google-Smtp-Source: AGHT+IFiji1w7r7AjCXlHaxfMjOrdW8jkVVGDDlvc9QhWhAg0vDKfADaHSk4qJ9skd7E3tmPFXgzgJZBnGJrSQTiafg=
X-Received: by 2002:a05:620a:28c4:b0:7e3:3ba7:f072 with SMTP id
 af79cd13be357-7e34356b85bmr3408946185a.13.1753194882975; Tue, 22 Jul 2025
 07:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-4-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:34:32 -0700
X-Gm-Features: Ac12FXzGLru6M1-g50J2KyQVjtZB32-ZEYTqBFpNaueaVx_KJKwNZF50EJpN3Ps
Message-ID: <CANn89iJkNYHLGqXCTFgG2rEp3S05VVkWi9=2HedGqqfw6YF+uQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/13] tcp: Simplify error path in inet_csk_accept().
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
> When an error occurs in inet_csk_accept(), what we should do is
> only call release_sock() and set the errno to arg->err.
>
> But the path jumps to another label, which introduces unnecessary
> initialisation and tests for newsk.
>
> Let's simplify the error path and remove the redundant NULL
> checks for newsk.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
