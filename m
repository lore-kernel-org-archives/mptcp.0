Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBD37A85C
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765519; cv=pass; b=G7HW1GaEgfWg1HVOVWmD3epVMey8Q5WE/iD5F4pIrUNh699jsMnN9GwsBvlCnIq/o6mUSsB7Q9SPRlS1oXkJ7BL3lpe7i+wig21fdaqwxc+cQ1kShtFjA1Y4zKU1XgCxXtGr169XgGfke3EPCMUUG4qYmPU6Gh2qYgJgpgfz3fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765519; c=relaxed/simple;
	bh=xvQlLrP9VZeFA4X51ntM8S07ewhUqvCn5cruzlZ0VS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uChP9MRbyehFuqiK9bQdTQ9Gm/kGe6MhWNvkAazdfy4wO7h3HrgAEEPQDp+h41jKtEUJ9JffjHYGWwJ64LGld+KxziDie/84OZ5AP2CdLltvl9mu4/I845NzyVIvSXA573GviKmDqnuc+JxQ2E6Gnrtoht9J2MKg6j5uqyEd+qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMkMtcf3; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMkMtcf3"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52e1f9da948so6357921cf.2
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765497; cv=none;
        d=google.com; s=arc-20260327;
        b=o84CmejMK6rqgN0lRYDYAm77WOmblUNAgUbqBJL6Ordjn9MDa9SDGuIxUmlwPFaDpg
         mXOZJW6BzAqlcow7r+ALSgp7Oi+rCM/iZH/CHrEKQhL1DCpLBengdKO1LM+3CzB96OXy
         FgrD9XInjMdJrXqgVH2GUtgRMzO29djBe1koLyGt3BIYXxftGDJu7RTxvhZ5T2VTZt1Z
         TmEZEkHTcOAg6p8eeVtYVS4wmsBC1TjD+4vyci0gacc5/Fz3DKthCH0Fu5YcLryA6ZBR
         ivSrH8a4sOkVuiytwPPcNnw78o6lOhxe7ySC20e5C8hv/N5/wJoFsWrOVcbnKabfDIkE
         9m4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        fh=pMwvTSIqHaOpW0bOmwUIHJXUJbcTgMJWgHf/wJg3Bz4=;
        b=lgV4NaJmkXzQlhFTBQKnayBrWbrmL5K+bhchXnN8b8YabUa1erBxyFehGQEhDAQFn/
         MKlBAok9EhXfjfRoQerADnsuqUbcQQlN9W8ImYyTxoQW4PE+gHdO4Gha8ba0dW/KtXAt
         WaRV9pkjAH/x7XLprDx1W9DTxe1/v3sAp69z9nJp2rLXBCEHHHMSjxReNzzU3nezProZ
         ArnyeMYM4vFTXTaY0ep4aZppUyrVKfjmo0Znq62dlT73ADUVi2ZG4q0mCfT5dgGE/Ys8
         nDRsTFcXjnQTkKVfkZciAYRIPgyDOLX4pqfa1FZeGyU/PrsNQGgi/nD32lgPomUIp0in
         3WxA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765497; x=1788370297; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=fMkMtcf3KO4ZuAhbWSSN68E83ByVOTXE8T8ribwTXgBX7VjZt3SFtiTrvcYCngMx6/
         qyXF7xPJ3BGV+OQhWxwOZOzFN7zv9ScbYNpRYcmTLg+0b1ws0Wvv1geMywFKb0iUTykG
         JDKfyzKAvG71/9UaeIT31G5z82/xQBaeReoWPFyiCRsqL2rEZLiXJIWNBvA7+pfeD3KB
         oEulllj6rzfXZm+wq6vPU1dbSyiWr2yI3orhICRajQyg8vnjnkosPOVgJWH9MrfSetjo
         +83EDCaYQU0vmzHz6/AwZQk6a7R7JEGigZmu/FONg79JkZ2pJ2BAbh3OOMDiITa3ZzN1
         /Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765497; x=1788370297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=RsvFndMfxN9158rq8oLjZgFGH143YcyZFh1J1s3zb+uLS2WdsSAd7xvkPR6zUZN9t7
         IMuD9b2NA0nCPl9YGqVowmqDFvIJ1p9eQPeoj5oHFud8Y7WZIPKc+1JyY/vTyMIyRMAa
         disVu9LzM7iwR9nF0l5M9GnprWPwExukntWVdQx6Oybf53VyfWeuV9YF2qfEtBPTDrBp
         2LskywbR+gr4eZngZUnubhq/V/Q8HOpx2wQs6ib1qchUlwP+O+OElvrLreB2+ylT81O9
         yr2dRHDkAzIBKm4Kxm7F1gekFL24yPNd8LNOvhyKybaka5YV1GWk3cEkiHroIkFmO/k2
         I2Ng==
X-Forwarded-Encrypted: i=1; AHgh+Ro4OoqvSB0gVoHJCIX1drTqVN7cUwfnATHN/8jx+vsI2zCWYE+fYfrLG6t2K9+365GpQpq2Gg==@lists.linux.dev
X-Gm-Message-State: AFuF++kieGhlkIZNtl3tbhCvjX9tw6XcUje8gRc00wV9brpX+36fFLji
	+Yz9e+OfD87DV6iTbIeR3+aza2MJzdnc5UajYzvBSoGSTM8k9rZrvqY55/t9qS5fqjoDrV6AnKJ
	5SrmmroG8z++UzQPaMpnsxTov8B4lShQTScwTy7qi
X-Gm-Gg: AR+sD110jPKHkkN+D9BjWDEA9RyNLjVC4JGW89uhugoFAAR2qJ21ugsA1J80P8Yf2Yt
	+5XdZssMEfm0DFWQZFiTlpD17tf4EfoYvLoOfW9YolGNrI2cuxPp0d3IOQBDlv/N7tRkmmIU0/C
	BceWjJosKY9hzC1JQPjMtsW68Kq5cbQP33k1oDyvpgNk85/A1OQ72yttD1Un08ImHMy1IiUkBg6
	IXMlwrJHxRFXGvewLZ3lU9/01uggEKDMYBKt4fWHrKpRNk0GjaBrhimKQLNOCpVXzOXLnc4I0JS
	wW4KgC5NyHQ7ekTyj1af6INkoISxnAp/STypyyvE4aqnk4YjAzaRmZ+bUjXk9GXa2cr+4fFJjx8
	F7g3jJhYjddurSzFw2z/LvtvnpwAX0xbzJeeSDdJOAa1ZSSkLymqhc1Tc5xU=
X-Received: by 2002:a05:620a:2584:b0:934:9639:3a4 with SMTP id
 af79cd13be357-93780439e3fmr788607485a.41.1787765495949; Wed, 26 Aug 2026
 10:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-3-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-3-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:31:24 +0200
X-Gm-Features: AcwNN1W2Vlibp4Upi6ckUE2YnF-7NI1e62marZLJ6U_CKljSBV7tC__IgHY39vw
Message-ID: <CANn89iK9NyWmpuE8QM5W_t3MK30GZf_Wgbr+JsUVARnXZBgN6Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
> get_info function pointer without rcu_read_lock(). With BPF struct_ops
> congestion control, ca_ops can point to dynamically allocated memory
> that is freed concurrently, resulting in a use-after-free when the
> kernel dereferences or calls through the stale pointer.
>
>   BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
>   Read of size 8 at addr ffff888013701258 by task exploit/149
>    do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by wrapping the ca_ops load and get_info call within
> rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
> the icsk_ca_ops pointer.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
