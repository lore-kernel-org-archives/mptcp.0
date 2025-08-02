Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61515853B
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754177284; cv=none; b=IZLHo5765KDE5yq0iuDStwHdHcfQ2nOt6ixGxMvsaYNU1D0MMQSiAvCUkCl2qMzBh2VnQ9a+f0adnJSbo3dqwvZ5dkS/NIdylHz3OFXsoyCvsuq1B4cZkmK5jHIvM10UkyatX7bX/bRb+D0Sz9Mb3lneVd3CBjyOuh8+iFyfKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754177284; c=relaxed/simple;
	bh=KUXfBjjn1jIZ5UVA+yPK8aZJ9rTG+sUqQhSlvUgmpIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7Ofuie5LSQ0jOJQvfP7J4HzFAW5X1EbTSxKYVEHshCMxoSLOi4R3wt3xEA+4bQ11hcvmYD1GQGfDdJVLwlwsh1rbhSJDAKGAsiHh/szi/fa1xT+ajXOcYZKeV3JcYbH9BKOVGX3MbhmmWxh5vjctBwcqaoUmy23IQMOEup7VEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Ilkd/hqA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Ilkd/hqA"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so20809541fa.0
        for <mptcp@lists.linux.dev>; Sat, 02 Aug 2025 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754177280; x=1754782080; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6olMFL9Ou85FIabjDt4N0E9Yvq2EKBLDWt9dRDCtEI=;
        b=Ilkd/hqAgCJbaLzjK4O8WBVH6jOBpVN00HWiA5+h/OkBizWKwxcDen+isHXrAlj8R0
         dziJhFnMAp8EW/gUMENyn9DMNi/DUzKrPUII0ZaX7UBSMI4d7GN+HgKhhAbcZqBJze/G
         D56hoUz/XUSuCg62zrHuZ49W1PULr6xP3TELw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754177280; x=1754782080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6olMFL9Ou85FIabjDt4N0E9Yvq2EKBLDWt9dRDCtEI=;
        b=J9ShjswcO6Blx+LrHrINLZxoaOaoUY8shib75rrZHXSRDBz15gwT3h5Mg4u7BKkT3T
         xupFIj9l90HUQhF+JgYgNFyexEBPtoX+EfSgdRKeN2KEZ7hrGj65oRC365lsjuhxuqI1
         aZNCtZ5BCPt5Xpu9urWMMKOK7VmLq9xTlEfMi5qrt3czG4UdsPb/anJu2EzyWi3TLQ/r
         /qoKrMs2POvVx6KDMPHd2Eyojxjz/gYZR+MB1iaE7uNVqhwc2+I0+zTTG04FO5xASv26
         ii2G2xg6/Q0Xpi86qU/5Ac6lNcI29zR0CuCw3vOiFg5SpiSBcdUAA2e3O0BQZeo4uw58
         qPhA==
X-Gm-Message-State: AOJu0YySZiE4ZZxr9v/TV1xumEE8IPIidacEd09P8Ica7L2a7ciYOUl1
	CEjsi6zcV0GCmFAusqmzas3z3U8IHeLSz/BQxCflqLruKFaaydhooBwPHfU/ttoAvKM2E77i1Zs
	7IlKMlWo36LxGNOMX98e7/JCy8ZGybYLQpmW1QIc9hw==
X-Gm-Gg: ASbGncspv7pNoBwrIpEJweHZXBI1hv3zQ2q3EI4FmJTVI6w6MPyFckNjLrCGOFyz1u1
	qcbzvtH+0lv6eYaJswFws140XfL/ruuBmQJTabi3VIDLgSJ2fprub9DbAb69k5hlwdw8oRz6fQD
	goqRsxHoe8WN5ulDV+eE9p9Rr9UKXW2y3eqTW08sfTqHGWKRTe5EbAXW7d2MwBA2TE4lYbAzx/c
	zvYAQ==
X-Google-Smtp-Source: AGHT+IHt9vawUAV3aexaEygmJFB3JaMnKJZUu4CpXtu6d5HMrWeZ7XMb5Tk+7gStvwBcOnD+yMc5xkoDo9JEXryW+WE=
X-Received: by 2002:a2e:a58d:0:b0:32b:9c54:4ca1 with SMTP id
 38308e7fff4ca-3325682a36bmr10361221fa.39.1754177279987; Sat, 02 Aug 2025
 16:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1754135958.git.tanggeliang@kylinos.cn>
From: Christoph Paasch <cpaasch@openai.com>
Date: Sat, 2 Aug 2025 16:27:48 -0700
X-Gm-Features: Ac12FXyGAVMJ45_OebPzMvjngYmm4revEdLVx9qY66d7DZtGDAU6j24G2N1HP4s
Message-ID: <CADg4-L_VUj4xXLWiUAVF0pGvguwTHPbrh4ixFanaqkWJqOfvkg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: TCP_MD5SIG support
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 5:01=E2=80=AFAM Geliang Tang <geliang@kernel.org> wr=
ote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v4:
>  - drop CONFIG_TCP_MD5SIG check.
>  - drop sk_state check.
>  - use WARN_ON_ONCE for __mptcp_try_fallback().
>
> v3:
>  - limit the use of these options for listened and closed state.
>  - check the return value of __mptcp_try_fallback().
>
> v2:
>  - trigger fallback to TCP.
>  - check CONFIG_TCP_MD5SIG.
>  - update MD5 comment.
>  - drop selftests, packetdrill tests will be added later.
>
> This series introduces support for TCP_MD5SIG socket options in MPTCP alo=
ng
> with code improvements:
>
> Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
> consistency
> Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT (first
> subflow only)
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
>
> Geliang Tang (2):
>   mptcp: Handle TCP_MAXSEG getsockopt in common case
>   mptcp: setsockopt support for TCP_MD5SIG
>
>  net/mptcp/sockopt.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

When I run these 2 patches, I get a reset from the server :

23:24:48.285068 enP22p3s0f0np0 Out IP 10.221.81.117.35206 >
10.221.81.118.1234: Flags [S], seq 314447609, win 64240, options
[nop,nop,md5 shared secret not supplied with -M, can't check -
bab9b1ba60e4d55efb3d475ee4222311,mss 1460,nop,nop,sackOK,nop,wscale
0], length 0
23:24:48.285172 enP22p3s0f0np0 In  IP 10.221.81.118.1234 >
10.221.81.117.35206: Flags [R.], seq 0, ack 314447610, win 0, options
[nop,nop,md5 shared secret not supplied with -M, can't check -
c3bb41109aead9863e97f9cc4e12e7d2], length 0

My test program simply creates a socket (IPPROTO_MPTCP), sets
TCP_MD5SIG and connects.

When I use IPPROTO_TCP, everything works.

I haven't even tried removing wscale,... to make space in the
TCP-options to try combining both TCP_MD5 and MPTCP.


Christoph
