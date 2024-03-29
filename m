Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3928563D
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729586; cv=none; b=p4zNFFukAf6tDA4pxd+NQUp3jMMc1llmYBVo0dBjmh9Aag/Y2Y70gF0fQNfVKSlsIyUZwwS2O3ed4sgudkaXsZ45dWPJ73f23I+LZMVfTi/HZ6AAYlEBo2mcd1gGjNnKNZ8X9KPkdWIcaKFUwfMfjszWg6CQaI1ucsNKNsP+uTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729586; c=relaxed/simple;
	bh=ZfdeSDZyUoyVGZhWFDNiSHorbeTndK4UK53Mvf7uFo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etPLJxxWPjghCSQUnFLE6qkpx7JQx38e7ijSjWYzdp+Aezz10Rrlp4XG7cache3BWv3Lq3K2Qz82ezWyScXDkWxw0pqJSX8W5U0uXjfUhLMfjolKKElb7OO6urPvmEJyn4EPIGX9hBUtyDjRLVHhv1uyA1WUgFkLAOoYQMyz9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGfVp/fS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGfVp/fS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341d730bdfcso1886362f8f.1
        for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711729583; x=1712334383; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfdeSDZyUoyVGZhWFDNiSHorbeTndK4UK53Mvf7uFo8=;
        b=FGfVp/fSlOvsfzva1WjgYnVMmY12H+NigF3eA3FVAI9Xs0ipZu62EcN3C+i5EaSPYI
         TgDCoZP/hWXiIZGoqALecE7BULBeJ0v1uy5CUt+PKcRGGlsEpC8JpwHWRRCTvSsxzEdH
         U5xp8oo05V26rRauGPiqrKs6VOyxj/Z0WNSzX6xxZOz4HAgNUZBCQL4LoNYSEDbObpvP
         GECe1CIHpfWXsDdtyNguVA8TFwpWRVus/rD2ZEqCEgS2rWUhRWGXi7pBA6xGM1iSLZLk
         53MSAdSOx7BEd5Y/PViTKMYsLsY1IDP+cdnZQUeIzmQeNH6IncKbAUFaM8cZfm5Zt8GJ
         0mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729583; x=1712334383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfdeSDZyUoyVGZhWFDNiSHorbeTndK4UK53Mvf7uFo8=;
        b=NfrAu/bhdTzsFBU9zrYdfHB6TDY6AGX6P/OtwIrYHRxYwk2KGyW0VYdfYjXtBS0X65
         jaWUCuRygrZ9/9dvDmj0Hy04348i/soTfTqlnLOMzjdGdhWVzKIjNvTClBrJ+OOl/WQR
         1xOkcH14JqM/ArvUWcVUzjygclatgRCsvL496DpVz37PCSreS+07cAfzF8x1Xb/9E+RN
         W00U3BpZVEVEz+xY/HiIBISs1s2fPTMyWkXN7JRBmslb3apSlrIdWkXA/K3dSybss8lF
         Wuiv4cPOS4S9N2ELXL/eTMHIYN45/Hqyy/O3vhEdJZUH/QOmv0DSo/cyuWF9bJLEwmUG
         qGVA==
X-Forwarded-Encrypted: i=1; AJvYcCU3LNfVUf0XXQB252x872UGvzuVs/QLpdN+kN2eYpxFhE3sxpXbUgtH1FAMdI1p4LVFhrBw20G9n259vgwwfAC/yXgi0bo=
X-Gm-Message-State: AOJu0Yxt4aRePIeYP/SofVn3BkgjlYeqH7Ax87W99wmLknp99+2MzaPT
	k7kjnQHOQH0gbYULBGUNekiPgUM/OukxL/B3sc2X9KplKnHY/lX3gR7RHpTiV6ZKMjIkux2rnzc
	lM31zP5/PoyumsKnNjXdk8ni0YnQIAkoE
X-Google-Smtp-Source: AGHT+IETtvjx4NNWC3qw2df5n/klO6jKAlk9IS4rH7gLZXioeVYAxV8gaTkFtOQqbzf3O+r41Bw026nYdblS12KIRAY=
X-Received: by 2002:adf:fe12:0:b0:33e:7065:78f2 with SMTP id
 n18-20020adffe12000000b0033e706578f2mr2039828wrr.40.1711729582785; Fri, 29
 Mar 2024 09:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
 <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
 <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
 <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
 <CAADnVQKXcEhL680E85=rrYuu4eVvVTH60kYRY_VnAKzZo1qKYg@mail.gmail.com>
 <649dc1dc-ca80-4686-ae37-62d7c81dde8b@linux.dev> <5fe3398c-0ed6-48b8-a5b4-2cc7329b554a@kernel.org>
In-Reply-To: <5fe3398c-0ed6-48b8-a5b4-2cc7329b554a@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 09:26:11 -0700
Message-ID: <CAADnVQJxsqbJgu9K-ML2-1tRcgEmHY-UuQOCDxqv8_6iVkW7Tg@mail.gmail.com>
Subject: Re: mptcp splat
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:35=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Martin,
>
> On 27/03/2024 23:16, Martin KaFai Lau wrote:
>
> (...)
>
> > Unrelated, is there a way to tell if a tcp_sock is a subflow?
>
> Yes, you can use "sk_is_mptcp(sk)". Please note that this 'sk' *has* to
> be a tcp_sock, this is not checked by the helper.
>
> That's what is used with bpf_mptcp_sock_from_subflow()
>
> https://elixir.bootlin.com/linux/latest/source/net/mptcp/bpf.c#L15
>
> > bpf prog
> > can use it to decide if it wants to setsockopt on a subflow or not.
> I think it is important to keep the possibility to set socket options
> per subflow. If the original issue discussed here is limited to
> set_rcvlowat(), best to address it there.


All makes sense to me.

Paolo,
could you send an official patch?
