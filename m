Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F335AC3B
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581336; cv=pass; b=VOE60T9XAj3D06bHWj+V1iazkkuu+yIgYgH+zMPfUDpIWVrQvpwfLT+Z1EyHgeE3Tl6mKcODQ4RY6/6K1D6WHU0ZwBBlKDffCmkpfAWWZ1kgSWVLsvucCpMGi6MpRcL1gtWbWBmRwdz/6JYw/ZuFEhu++hqtDBMe0pNMM20keH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581336; c=relaxed/simple;
	bh=ANDvpIxfrHqHFRr6SwK5eAHivKDZmMQu+6Ow5bEPjY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc54paJUl37WtZDQ+/S5LJ9XNbrtYxoOylufFSiRd4bwZPZiDEXiDgNmMdcNaqIlHtqqM3gtGwizrPDCjgL4LgoDzgmCcNtTQmQ/kG3Dz6/Vp5gKuQqUCxjtqkSxpu/c9yK1enYBksP4Opy1mXS3ofmpiBdXUU4ShkidrZS6eaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkgfZmVf; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkgfZmVf"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2e221a71e19so1947769eec.0
        for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 13:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777581335; cv=none;
        d=google.com; s=arc-20240605;
        b=DOP8vY0Kr4KSWy0J98iZCkjKrah1bwk4tTI9n5caw1cbnUvVpHA3m5kIYvCAzaPbcX
         IH5UhWOz1qKc0IoatCxv6m+ystdGruBmTvWv2/8BDf3HYUb1KVpZu2TRg0mgZPsmbUwK
         WGKTKtl3N/dSRoUyY4Bib5bGa7f4Y+/iCBkgtqsiwPT5AE+2kOuT94yWHivn6kmVax7n
         9EWLIUmc9oRnaP1lMMjwNEC0LtzkXVp9MCX7LpGNvaYyJDQYcvF6jCxhvpPkLkuOyyhX
         AgMIH+sU8BzOT5Cr1i2ptZkby+KxccmaE+NkfIeMlAvC4v/W2tgpzg7rFYLkzGBZRev6
         +Rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eDT4fRO0CYsk/JV/kLnG/AoLCWH7UTDX711nZg2FgiA=;
        fh=nP910eg46cVlBNxUHlbriWBTGqShNF5/nSJNyVGu/Tc=;
        b=h1pG75GLHlKsk1o0ZcuV8B0WEcGKMRJFzXSwcA3DSkzngxQw5XXt4l23TPsXEkd1oL
         N/e8Teq2EnpQebhyH10qpMxqzXTpKySdEVsl0kwoHjBMaRrWWxSFDm7EXq33m2mg6bwr
         A17TjjfZ2M+cF1b2PyfOmyZ5urMFTRaEKST12zho4vB7s3chCUmGbOQ1qfnZzoYRgT0l
         K2rEpaTShtgLCXqAXVtSm3pnba92kpPZOfdUd9tVX0fQSluKed5IsZ1j6S90nGFH3yPp
         KSNrh+IiOyiY0PM3A0YYd5Mrr/emSBEeA7QDWx657cghT3MGtYDHpNY745hsrJ5U/kqq
         pr0A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581335; x=1778186135; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDT4fRO0CYsk/JV/kLnG/AoLCWH7UTDX711nZg2FgiA=;
        b=MkgfZmVfIeFkhuI13xHrN5DC0z1Ge9oHCDxgqYoW+qu5IDugXV17bpYLU8RD3i8pOe
         VEugoyXsFDJHaQiN2GWhrc7Aytj2muYn8aGeNUkwA0AJjwqjgNjEcpcBLbNlsiBUl7WR
         wA5n/SouP+s4Wl3f5QCrv8XPUfr7MsSpCcVo3lclp8hWz3fGcuzkW6DbI+2gQADtriGU
         AwSP2v0PE3NSa/2cTDY8bvm+lPaOSIq3Xgavg/StzZXjjPp/mUrD7+mqBr1EmhE6q27z
         pG/zu+ioKH8uCatSlGHSAq3/UFqvsVYgT1OOESYuwwVrG8TU2naVTvwjdBwZmIRU7ea4
         TCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581335; x=1778186135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDT4fRO0CYsk/JV/kLnG/AoLCWH7UTDX711nZg2FgiA=;
        b=L8LZlYPn3trgTwmbtdQ9TK1IoXbqDOMXVSPzSlJX/IFfZoaBNxIrU03NOIVSdBUP9o
         jN8T5zaiDzLQqSrkL1vthCrydWwOqwZgcgRgGqb4ANjdXbrHWPXN092nuocFc3AgNy6V
         kmZLltYyqDjXC+i492s1ArsWYyOB4mcZPLsIfn/fVmJ6luX6IaAP9+ZUws6M/rEaCCpQ
         auVS4Q9pYwa05cGDGcGxTFq/lGK5OZFCW5PIl1j1g6KierhBzmMGOu9Ii7Xe0KRIdoUF
         pbdU0VzcI4bb4GCzlfA1yRfpSH45OVuHmB9QSVCHZ1D1+M+fH4Axf+/zQ+kD9nUaeu/F
         ES0g==
X-Gm-Message-State: AOJu0YwxGPWXd+VtmfQUFXyYpeR1q1tVwFBAxkTP+C/QmNLFLzRAlvaa
	F5ZfcvxAg6H0AG9TxuhAP6/vzOzRqPsO4rKnilpt57bTaPpE7cXd9id2St1aXSx4HriiS5F1+qA
	a4CjNlHMoLgKQDHDgdeEeJ90YEsN42fzz56bCYaWaRfQAlv78FCkVrg+E
X-Gm-Gg: AeBDievfxwyV3+m4LxWiS/JXraeqX23XdpM2anuDjNOYltVwzwcU3+XvuQCzzReGK9C
	rqF640/Y0yQqTVW+nT4+rG/AzHEpup/NGm5FK1kNoyHivIJvK33dpZ6CWqDEWTbdtbXYqg/IL6A
	mfYDPpdojJ38ALB2imLwb1kM3tzAYl2l9Mw/I4Dy5Nli335ySAxHVP/MrC4hRhfzKynfsgLN34u
	Uz4+94ODLzeFV+q1CFFndIzy3SZSSXg/wGqJEbT8pMkUjNCYKrID7DEHChEEYR6829mDF/bIiPj
	Q6HZxq5L7fT44azKWVWKONji/I2ZZlB7DCApDwpPUhRMtmV+mWHKylg1t6dUeQuYWSwXsK68u8H
	vF/hURwgbbwxb2ZZGtbiP2Gx+Z+ngYelEHAVhid4j7IpRZC/Owm8qpcGGoi/OGKcxl13KJMJZSy
	/98I2wobcf
X-Received: by 2002:a05:7300:e827:b0:2da:2ec2:64e5 with SMTP id
 5a478bee46e88-2ed3dbc003dmr2476546eec.18.1777581334105; Thu, 30 Apr 2026
 13:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org>
In-Reply-To: <20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Apr 2026 13:35:22 -0700
X-Gm-Features: AVHnY4IcdeOyuD_LEFpPjKd_jc4LwcXzI_L1gVqXovQphYv-9chxWOuIxfibhbE
Message-ID: <CAAVpQUDeJRSTympB2QqQv8Ouc+WRnM_HjVyitqngQiM3Uayh4Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:27=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> bpf_mptcp_sock_from_subflow() only checks if sk->sk_protocol is
> IPPROTO_TCP, but RAW socket can bypass it:
>
>   socket(AF_INET, SOCK_RAW, IPPROTO_TCP)
>
> In this case, it would NOT be valid to call sk_is_mptcp() which will
> assume sk is a pointer to a struct tcp_sock, and wrongly checks for:
> tcp_sk(sk)->is_mptcp.
>
> This is similar to the modification done on TCP side [1], by Kuniyuki.
>
> Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
> Link: https://lore.kernel.org/20260430184405.1227386-1-kuniyu@google.com =
[1]
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
