Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435324166D
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397206; cv=none; b=dilpxSkeIOIr0oF6XeJkZV9cKrcMnwfe19bQszU3B33L/RHQhysv9C8wH45/hpaJJWyfPW5nAfzhtoxWOVM/+JVDZ1ynLOapUJnMEgFEXz2d5PzRpDeDDE7C+cfZeXSHIp2/i/ZfDMNdZ3dI2X8Gx8hkCmrKJKX9xrgZL/+G9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397206; c=relaxed/simple;
	bh=Wndmiuu7rqGlnyrzJklujdi+w1nsc1H0JRVe8sWkzYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5SdTQio0bM+3qY/xbDqDoYZgYn9pVevP4k+xi3W6IQzs2Y6UuDtCJ8d0YPpRShGklBCCuL6A/mponlshg27GjtHcrFWYz7jSUPq/rvM9Lfb3QolBwiNL2bvKL7puQ0/sIygWdaeMzQ9NQKsvQrdl+gcO28e/10S3LzeX1Eh6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=JalORRiV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="JalORRiV"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336674f95e7so8424351fa.1
        for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756397203; x=1757002003; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W14VqhiTF0/pXSt3jmnac8H7Z5/6b7GEl2tf83G4UFk=;
        b=JalORRiVWn0Aqg1sb4uVtxRKx1QRRl9DMGq3o9VmQRgMamAMCAQHMPaKRwKmQN/ZLH
         SZruMBEFkQAjef44ldWo7WYuoQ5XPiwzBYPbapDNzCf9o0OQ7wpt8QSBnkyegPT1rqwK
         0R71uJc+W1L/AGjrWfSOgO6Y1DnwakdJySNmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397203; x=1757002003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W14VqhiTF0/pXSt3jmnac8H7Z5/6b7GEl2tf83G4UFk=;
        b=Tl+53ir/zs7KL0uPuRjL/hHqjZ9amix3ajgY8PPP3vVFmhDaV5zaRDMOqR6ttWwPkU
         IKKW3ENxYSsONj2j6gYqsbU4T4gyxHF+0+9ZtDBTOWhaZIToEAbX549HN8VxN/y1qN+Q
         Rwtw+Xsf+JBxo83l3gOL881lIbpH5+CTKCmSKXb7yjfeDlNeUKyJx3lQYLuSSvOKxq4k
         4V+MbLlVggrd+U26SZbNN0x1Nb/uKmYpFyad+Zub1LEPxyqF175jSo4A8MdAN1A4fupe
         sP60zmIAABHoaU0ptlAFIdYtMdMi+dJrNXuzB5GHD8In2j2WRwZaqunKN4D9eiW0Kkuz
         wDrw==
X-Gm-Message-State: AOJu0YwSh+PihbXMaW9ZMTf2Navm5le3pzC6CXVQEVoJdVciqpdjiv2S
	Fmj3+ugCkemIp/jJjCP5MuPS9QkmLS6CMpf4fBU5s3tLiE6k74k/c4ueFwzqrEX8SOpqmidhRTA
	hlYfuo6OuQQRt//40k0t26ZLRLT6CBjpBwu14Y5LjDg==
X-Gm-Gg: ASbGncuG6elxdLzSdFHjQI010eXCe4ckHXA/+45nahdXSWsBs7e7pTCFqv/t+1EcSHj
	rUrJGsHJSvKqFL0aDSjL5XhgfBNPFd+HJyLr2Y7KyoyXEEf0BnU+j4A/a8lGQwuP/UUbmvsRUD5
	DYMt8PNAeB0/YTuE2NXm/vXSaLrXTfNfhLj3d504FFoZNwNqdNeRCxizPjIc0vJ7ptSAS1lFNMF
	09nkrwD8GCtZwc7fF8CuYKuBaLb1dch9P10uINWXQVFCMDx3RMKAf4LsCW9/rw=
X-Google-Smtp-Source: AGHT+IGk58BzpKHD5ogWoPlGN/winrvs7qXnKimKjBKrbd8Ea20qqUWalldT47//Vec/WlACNBEg2+re/TuYlHfRZBc=
X-Received: by 2002:a2e:a553:0:b0:336:9cbe:3948 with SMTP id
 38308e7fff4ca-3369cbe3e5emr12348881fa.23.1756397202830; Thu, 28 Aug 2025
 09:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
 <20250825-b4-mptcp_perf-v2-1-5d2d68dfa8af@openai.com> <1d98d911-34a7-42cd-b963-26eede462547@kernel.org>
In-Reply-To: <1d98d911-34a7-42cd-b963-26eede462547@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 28 Aug 2025 09:06:31 -0700
X-Gm-Features: Ac12FXx8RnnQHmenHADLJMpdyKf4-ElopoKZLmL-ElVYclrv3x9mVtvEccEUhbk
Message-ID: <CADg4-L_UZY0rYDx4w-cX03oMhsEyCND3qc_mPxYEAquE63x_5w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 1/2] net: Add rfs_needed() helper
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resend without HTML - how do I turn on "Plain Text Mode" in the gmail app =
???]

On Thu, Aug 28, 2025 at 8:50=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Christoph,
>
> On 26/08/2025 06:30, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > Add a helper to check if RFS is needed or not. Allows to make the code =
a
> > bit cleaner and the next patch to have MPTCP use this helper to decide
> > whether or not to iterate over the subflows.
> >
> > tun_flow_update() was calling sock_rps_record_flow_hash() regardless of
> > the state of rfs_needed. This was not really a bug as sock_flow_table
> > simply ends up being NULL and thus everything will be fine.
> > This commit here thus also implicitly makes tun_flow_update() respect
> > the state of rfs_needed.
>
> Thank you for having added this new helper!
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> > Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  include/net/rps.h | 85 ++++++++++++++++++++++++++++++++++++-----------=
--------
> >  1 file changed, 56 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/net/rps.h b/include/net/rps.h
> > index d8ab3a08bcc4882e2ad9c84c22ef26b254c14680..a89d2822a257a1fcf54e972=
2fdc22d01c28cc87b 100644
> > --- a/include/net/rps.h
> > +++ b/include/net/rps.h
>
> (...)
> > @@ -144,6 +132,45 @@ static inline void sock_rps_delete_flow(const stru=
ct sock *sk)
> >                       WRITE_ONCE(table->ents[index], RPS_NO_CPU);
> >       }
> >       rcu_read_unlock();
> > +}
> > +#endif /* CONFIG_RPS */
> > +
> > +static inline bool rfs_is_needed(void)
> > +{
> > +#ifdef CONFIG_RPS
> > +     return static_branch_unlikely(&rfs_needed);
> > +#else
> > +     return false;
> > +#endif
>
> It looks strange to see all these #ifdef/#else inside the functions,
> instead of "empty" functions at the end when CONFIG_RPS is not defined
> as it is usually being done. But I see you are following what is
> currently being done in this file, so all good!

Yes, I also prefer the style with the empty function. But also yes, I
just followed the style of the file.


Christoph
