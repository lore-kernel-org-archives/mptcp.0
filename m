Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2303DEADC
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648155; cv=pass; b=CZYmRD8P7G58PSzL4srmIWQbLNIHIaB6eGAmKdCiOwE2oIXiiUlRveLB/qg4LVZZG4DZ08Z3QNI6xg++T4aTgvu9fI8Bb2iFLq8gH9yasdPl4l1keI9tqlhOSk3dny1i/NW1EZlge5qC91TEV8y3UNZ6aOKi2NDdIyv2Dpok7VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648155; c=relaxed/simple;
	bh=9MwzP3uhQnku7obL0CECuVhwCCCsDCe3y2WbQ/ADWWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOhuBzwI23UW5jWuBmTQpEtV7Z8354j15kU1VraGLfxkml8YRmCMXDFcW0rbNHD7RAY+vjHnzxLGM9kGZbC+Gd618lAgpdke7ZsvGPbj9pCg0ICQbkC7O1fYwdJA4l6IViVYABSr6aZ499Movru0xVUrC69S1E1OaO5iDdhGzFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zILCnKlr; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zILCnKlr"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899fc9853b7so46784556d6.2
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 10:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772648151; cv=none;
        d=google.com; s=arc-20240605;
        b=cKF9puw6jnMGJpmJ3Kq83BurNe2HaBduv+cb3+11xD/hW9HRhyFjPKNEkXKAtGLOcb
         TiqDFDf0GbltfQ/BRWioU9/ni0kLGWZIlNQKJr8JtmtfSiTY+tw3PeKawrjyrJIYMRDC
         5bzWKB5zLdDGJvLGyIOBfNAW86zKef2uwhav5kHKwQBoCiJUq/OiwsLLIrcXc944QW0L
         rwDRa+m4usobQPK0FxPkTnAvuymfernkWABlive7OqdHufvz14BWhL/HDWbbnyleARoP
         pQirO0EEsheUny9J27KzmDzummJ2VTEF2EyzXXjCWCiPF3mFdhuJvcYQ+zigzTS/afvs
         amxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        fh=MRbkagjUIzhV+io5sdP4iIp77Wmsx0ncOW8vHnGLOr4=;
        b=OhvS8iCBatX4q83qECR+3kRg4lvVxBqKhJI7gYsN2Da+y5pt/GdBHdoyW9QV5X7NOq
         gBnrInl+J4BIYUGlgDI5Mcxd+4+DUepsPf8uXbxh50LvD59XNLw6n9xZG+VjPXQwMfVL
         xPUYV4oNgbZpt7cQTc0bzfK8NFt/1lBIQRxcc/MnsMNUJsQg1MuqATcxzdMCbXasGBpn
         u0hdlGbrxRXdQrG/lVdUDuj/O8n2Vf0rJ8gXdLBCbgJ9yFUvdkGBBmzTaUBbzpVmwQMU
         Y8JfE2c36RbEEXVupAG5cRroKApkIquWE7q1kvKwr+1W5STXCtq8N014+7bQZvqZHGvs
         a2ng==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772648151; x=1773252951; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        b=zILCnKlrCjxzS0ovUq2Jovc+25h7dE46Vyh8+2feLaJuuBCT32yVQwZxVv7adUDMz3
         Fbc6/dlr1Oa0hBs6+8eOO2oVBR+pHtoTPIq9WGnR4Q7yu7R7S9cymqe8N3IbXaLb4+0G
         lsWlFRub/uWBceBxDuj+znVn2nxBMJVsGEz/FXTiK9HBQbfJ4coqqTWbI7wyrU5t7b1T
         HrbGJbZST/XapCwAF35X2LnnYXMAcol7ehKyHQGXUc74i+yStHH0fYs0wEEOMfe+8UDB
         VprdyWviFPwkFpgpxgT04aZErQI0hEd3wpagP5XIt0ESg/51S2jQY18465SBcFYoHFDm
         ZYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648151; x=1773252951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        b=mve/vVFucDI7oDEYhkEUlEcCbCfGgIUUL5oxLuHrzvdvLxy18hYDJX0bJkWFttLfF/
         KWV8pMIH34JHrDVAnrrWTExlKtiu7VVn6ssBYSCe8WYHSgEz2ciQ9hVjSkG9UMrVEczt
         fZ1E9Xc4B2wvQZ84Ar8+6PJLY9axypq9vyYSOvhmb19fGcU4ELiadA+WUuSbnhotq8Er
         aMYIvc7J3sZWzHcABKfWOphozIf1p8ZDOL7K83wwJGOEayheCasp3jvKfUBL8FGVwPEF
         9gTpInDvK7RMqiysPefWy7rZ5M7FIjh9pjeeMvWy0jGxrbW+WXHshmgzPFOxcMZChtsR
         j/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgun2Ezr+4YyIT/SMc4vttSjxrT+1uiaJbHkV/ULIr5mqxyczJUdDvtZWggUjzjHdjMhssNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC8PizIdDRymGFZ6oSyri8W3aYM/vMNjyaK855i+ByXmDJLcKP
	jW/ZlzvL2qYwJMvZNO9PkaKlNeslBvcpu3tyJRmiIBEsU5s3gUZyemI84c/WF00ZcjiExDs2qK5
	XAv5Z8O7q8FHdCbTXeLH3Io6IKe+lUYMtw2uPAUce
X-Gm-Gg: ATEYQzx1u4AoxHg5DNs0GyYrXQ8Pfn1fCFcCFfNP9pFE+jwDuxVvY+70v8yHcnwv9Mu
	kodZL8QABCmcXKi7tKjsyxzSKBxaEhIZRwSRWUaqealDHZz9mlBvF/xtD305P+YvHnkcPrzaKmZ
	tTJUn0v6GYSkqU6NqTXFTDjKFbfvlKR8k5NtlkBclygToBWiRjVp3yFOFPDnc6gyfwpwpPk6X0h
	XjT3LjkGRvW7pFQDNRWwlXJjpOmivIQjz3WnJRJR3JflGZZO91Q5dT5DDMBT2+VqFoY2p8GzJl+
	XvpvOkgD
X-Received: by 2002:a05:622a:1386:b0:4f1:b947:aa04 with SMTP id
 d75a77b69052e-508db2ca0bdmr38936101cf.18.1772648151053; Wed, 04 Mar 2026
 10:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260304111517.2088694-1-kmta1236@gmail.com> <072854a1-0521-40ef-b963-6e3e56084281@kernel.org>
In-Reply-To: <072854a1-0521-40ef-b963-6e3e56084281@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 19:15:40 +0100
X-Gm-Features: AaiRm504-7or6_xU6D4WOOgH2jGgHMALSXeOqt3vfn5JgtFDBEissEU0hjIFp34
Message-ID: <CANn89i+Vdj_CnnJZEwp9dfiAV-z1eSFBp+4a9z6FDS5Rw3k4EQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Keita Morisaki <kmta1236@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 7:09=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Keita,
>
> On 04/03/2026 12:15, Keita Morisaki wrote:
> > Use struct_group() to group the three fields in tcp_out_options that ar=
e
> > read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt=
()
> > (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memse=
t
> > with a targeted memset of only that group.
> >
> > struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> > CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is eith=
er
> > assigned before first use by tcp_established_options()/tcp_syn_options(=
),
> > or gated behind its OPTION_* flag in tcp_options_write(). This memset
> > runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> > bytes to 4 bytes reduces per-packet overhead on the hot path.
> >
> > Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
> >
> >   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
> >   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
> >
> > Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> > already used |=3D without a prior clear. tcp_established_options() alre=
ady
> > clears opts->options at its top.
>
> Thank you for this patch! It looks good to me:
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Apparently my Reviewed-by: tag was lost.

Reviewed-by: Eric Dumazet <edumazet@google.com>
