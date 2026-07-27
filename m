Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A335AC16
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121957; cv=none; b=SNn6k/0jXVvjH6rCnwC/lc4GRAPvLZHdDnVuJcu0uuLgrK6iVTBKf9zlYkSCX8Bl+7R7U87gO05mcK5kfItZaf5xk8cbF6bjnQ/3QclGiGUvC6f6wzduhZq3dBblgznhyj/lIpe9yIY4VgLIoDWuaCJmJRzxPXXd0tb0l+SyNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121957; c=relaxed/simple;
	bh=lVc9j8C1Rmc4MoGygjJDwNmKPWQKQb8rbi/rh1H/124=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DAiA+k5rv7R6h194lk3G62FXWsXrVZ7J754I1jQHCY0qRhzG0JF/SpfvZPrbgpm/3pRcfYA3TmNMkVN+ZTI4HK9e0/KoFa7KON81o+YE6vDsFw8ILp0oZ9Q+91/Vd+XAU3WGU+T+HmUd+HFvGTqfu+/LTPpngaBbQmQZqAfBiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOQlOJ3f; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOQlOJ3f"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-45691990234so1450553fac.3
        for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785121954; x=1785726754; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bveUaaf9p1ColOllDPQbzQsE+Ik9DFXcZevgLWRGn5I=;
        b=kOQlOJ3fnfdk9ok9shzdyQZwsEdjCQjkMrx9DnlgC4KFYdTAGXnbAkW5L1IFbiCTPX
         CUm+URcddWee8fiBk983N8HDTJLoDrHgEF6nu0D6rObRzj6F6nRUcn43VM5hQEQrlgJC
         9sq7UeJ9N2EhZ/bYZ8XaVNmtxbWDA0TtOxi9vJWTbAQTk1r02X7kkrdyN/03pVyqbgf0
         eD4noo8vJMCKJdNjKG7kJ+fkM0aPvR78dGF1c1tcP/utu2vpqrZKBR/a5TTZLHl1JtCC
         vDFwxQdDDCwNDqiLyg8CongAzOPwgpS6BK2Pcy2B0YPuqxU9e5KHXQ3qyaWgBNVQ3MDh
         gmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785121954; x=1785726754;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bveUaaf9p1ColOllDPQbzQsE+Ik9DFXcZevgLWRGn5I=;
        b=S+ozr4tS85fLvapBO7k4ZFK80pFcZwHmQyPrXSXlrfg+rrR+o6/qDODiK3UuEQya65
         SI5VkvgbEvcm2PQxrDygdGnZgvgMBWIPSrtYX4mWiQEvEUXKyl9XqSJKIdT3bdulBbx1
         ZWSaT6FdyyuMGXEZrHEMUsNPFEQjmYwA+hn/MSVB3e/FlESKhBYlfNfrhSD6M2S7eWOT
         rgTNVncJfEyhJv4o0AchfoRD+evFFo8tATjpFRyQnz+vVgitHQ+VEo150Un30IIYwsAG
         l0d1zZyDChOF235yrzLtWBndOkTBg+NmmuZocrxGBM4jNK3RKJcDCN0agxlr3RzUrqIq
         2p3Q==
X-Gm-Message-State: AOJu0Yz+iHqlxyE5D7e3tJT5VkNurawUkOqcR3ZHhHEhjdCmOgVp4B1X
	+Xbab4Wp3tQtsB+jPdI2pdFfBehCv6OePOphBXTjLe6biTLCoet3qaS5pnbj
X-Gm-Gg: AR+sD13whdAUhBkfMv7Eo9Sbluk4hrXTczhiF4qhS6SAwek6akdodsJF8iydHn9gl3S
	6/vruLIitPvE1Kv6s2U7ggZsWVwIf8KpzOM8ptSRYJdnIeGf5vjPqsA8ZGQ6yadbugUBXJxST/0
	HKC47g2t03WfrDpfSNNIwmCmeC17Qjv9b7NV5gXjnbS4r0ZfgOsQMNAaSLdRimuX3auFhKZiwQ8
	7dN/mJwQNLY31bVwY+J6ilMHoMup+FP+ZbXktn6ByWTdPgiqDcD5btyWCncVyNgLuZskCKlIi6R
	aPYP+Zu9+WTgE/pyKPlJysoYn1/+OMlpODXZbwcEYaIuQgwruuOpVaWQo4xGezjjs0DdAmb3iwD
	DHucfe8CiHS71QUTqJEqY9/D7gTaky+i8pZGYizV4joX1QT/mdEBqoJfOQGMW86t1jdaTo7jygl
	tLnWBuoEuCTKxu/a2d
X-Received: by 2002:a05:6870:350f:b0:456:5873:3b56 with SMTP id 586e51a60fabf-457f270f3b0mr5962193fac.27.1785121954482;
        Sun, 26 Jul 2026 20:12:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.124.187])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457674879f7sm14781563fac.13.2026.07.26.20.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 20:12:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next v3 0/7] mptcp: add bpf_setsockopt support
Message-ID: <a98db90c-d2c7-abc8-4a88-83fb39d57a1e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 03:12:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Script error! =
=E2=9D=93
- KVM Validation: normal (only selftest_mptcp_join): Script error=
! =E2=9D=93
- KVM Validation: debug (except selftest_mptcp_join): Script =
error! =E2=9D=93
- KVM Validation: debug (only selftest_mptcp_join): Script=
 error! =E2=9D=93
- KVM Validation: btf-normal (only bpftest_all): Script =
error! =E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): Script =
error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/ac=
tions/runs/30233020793

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/acb09ec8b8b1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1134827


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
