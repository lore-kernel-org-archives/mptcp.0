Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FE1E7C2E
	for <mptcp@lists.linux.dev>; Tue,  7 Apr 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525636; cv=pass; b=CDZDFn58sBtX55NQRtDBDRAg5krLQspSRdUTwlhBqtCDWDNUQUDVFVX2nfZhVvDDzTFKRrEa1kWELtLcnX9+s0iKlxc0k6ifIyywvXTytXXYBnGWOknCcoWgX0gol41Pb6GPpze6YsFXgQ9AXb3bSc4n1c2//2Q9xLsC9hGaUfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525636; c=relaxed/simple;
	bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6hmKEvaA/SWVhbsTOee6MDcnIYrdjLcBnfLo26aRbgFMYbdsrKGhajA2243W4MTiEzEJVjzAHQQvuED4e5WYhW7YurQNpVcDFbtBDaVskR7NTBrlUgBf2E98be4dCZK7JqdfAz80XRILlfB479n6mI2jh8b0DGJtLlExKeJPP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcSd7AZF; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcSd7AZF"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89cc71f4311so62221116d6.3
        for <mptcp@lists.linux.dev>; Mon, 06 Apr 2026 18:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775525633; cv=none;
        d=google.com; s=arc-20240605;
        b=Mt3pogEl69Uv6l3kVVllojlrMXeNSE/laEMsM7FSWjjA5fPkGmp0Oej7TtGnS2Pu/n
         FsZA9gHBegksHoFYc20kqRt5jnASaK0NR9ntEajlWnrCNa01YCMLJJX9lwWOGuvqDNiv
         bQE/nfKax6L2JKcl0OxI+RpaO8T+RIvR8JmTuIZBijfE+0aA5fa0azd2buh8Bq+1q/4s
         LEP+ZV8pzjs4EwlpxKtILQS/tXCnJg58tFvpLDBGZMbaKDVT1Vm4E/HBKm19YlKrqbwF
         zWNGSg8bhOLqh5sUywos8pcq1hgxi2zJreP7BCXjW/hKd46T/pylK6Bm0NXQBgNQ3Q2B
         bNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        fh=3lGDbZBC1snjmbJRQbqbHTLfxTZH0rXajjPBfxMmP20=;
        b=OUI9j4SVl7isHblZ//tQLLQMDmyFMrDxzpIatZbZoJCA3ExQZ08MNRHH99EJPZllQH
         6QA8VT2z66QuL8RA5SQq7JL4ZVDNHZFDITGI/o3hiYmRbBlmlNxjtY9StEeugWEY/Ww8
         cbmYHwaK8F17B1nt18lP1X4gimKBMMEmZCUQ4QjEurHQ7MeodI1kZjQ3aXauPlGkpzuS
         cGcB3nSc1z5wlYRSeNTLFh384VXeAmEvULYflqOrqjEPqN4tuqwi8EJK8i5hLtk9BNHP
         pp0GC3ZOxh/lAMBzj2Hitxpmqr0A0uXquBVPO/P4d+7BDUrvM3FhzYJPpCSVPU5AJ6JV
         +5pw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775525633; x=1776130433; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=XcSd7AZFmk7PQLEObvJ3ItQ146MHTaBJuf1tHjlyCz9wIHuVngpVncdau6Qj55DPtV
         ffnBBIdRheLn++WzmyIW+PV7k8wrRC9isD5jJ1jh70Qvdcy4PdXng+AeYWy+riu+QbHn
         pLzcVasOZM9fAce2YofiKB+Iay/w9t3MrH7hRdoJY/0Eo+bQBOTmrstZUmJcHMhdvWsV
         7dLWuTYmFYNuLpe7WDA8ayFk8opNxhnsBxQZISDBXZYb5QU6SXJ/FMIwya+ZT/7C6iJ3
         FkcOke7vGy9hsRvajepqVGATsCEZCR3Wz994xCGAdJ+vbVErZc7yS5tUwe92Ytf36U3H
         Cseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525633; x=1776130433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=NgtVOdKZKdYEyBupjMYlhjHQJ6GAFjpK+5Wa6kz7Yenr2yjdMKgCKbe54hrayu5Gba
         572qmKiy14Ai0JnAaYsngN7rG7He2QjjwC66TeCB1Nj6gEmnlylxp1OGOQN7VWBnnwd6
         ISA1Esl1cnehHGVcUd5iF6DWVisZ3cFfufUzgnwqhBhvwmXztuGTeAbz3l/WwMUvTnyo
         vN9qkXnnfDNl0jJzMpPZn+cO4FfwuYrSg8U6Yuv2lcvmfoyA/bJpGDsvz0GLpIgkHU6v
         8O7+E2LO64iK1QO/otdclrQ9duxbgfw1pZXq/Tx1rRFnvv1ESquisYf733qxThMUIRjV
         Gfgg==
X-Forwarded-Encrypted: i=1; AJvYcCVpjmtCJdT+Ml30F2g5zdbT9PKnnIK6AQKqD9ZoaTR0VXiwgZzJ4PEFVJPHjda5+61T0tH9dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJxTjmo0wRfXro9oo3Ufbt2NOLd70frmw08Mt7EdIcERzY8VAw
	X57dhyZhuIoaaBCEfEFJwYTS1z56H5qrOmrsaqLqgfOOEpxxNiXeHDtd+++cAKo6m+qYNtTEjlE
	5FUCpxal5ufNDLBNcHD6HWXcpQn2O3Xc=
X-Gm-Gg: AeBDiesRBYTJ7Phsk7UeYnRciNzmkd2IAXwV3lZ/9/0rQQ7fP0d4Zq6+pAZlc1/B3Ft
	2Eke1ovDzfDtXPYu2SG21GmLdZ60J9Y3c7ofmFxto5UMC1Lq87GRfano681T+UoxCWBZClPv+u1
	GIRX4cKC1ZfF7AeXX8T9K05qNMvDjyP7C6tWAYt+HoRw+iwnBIKaGXe8uBdPD+n6YyMV4fk/ldD
	Jvr2pqLymTlADBabNOGgZ15uNXdBtFKwgfma2Z6s7ZJyal6bPIuoQ/5hW57/x7nFj0hsCqnT24j
	Sq+FsV9r5b5FefZmtzws
X-Received: by 2002:a05:6214:212b:b0:89c:5110:751a with SMTP id
 6a1803df08f44-8a704ac00f3mr250748606d6.44.1775525633467; Mon, 06 Apr 2026
 18:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com>
In-Reply-To: <20260405154816.4774-1-devnexen@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 7 Apr 2026 11:33:40 +1000
X-Gm-Features: AQROBzCkX2gE2vUcwz9Vh41Dy86vV6V6vedD5cjTTBBq9Q2y1TRb7sq-3zFQtYQ
Message-ID: <CAGRGNgUpknQi6PzBWQXeAP0Vh7XjntD_-O4QyjU5tAn8_71=eQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Apr 6, 2026 at 1:50=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 fields (netdevsim) where
> a direct assignment would trigger sparse endianness warnings.

I don't believe that endian swapping significantly affects the
randomness of the data returned, so either:

1. Do something to silence sparse (casts?)
2. Live with the endian swap overhead if they're not in the hot path.

Other than that,

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
