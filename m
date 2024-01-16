Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EC1CAB2
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427018; cv=none; b=lf7JUuQGAyibCcYynk0TLgCejceVs7tBCUn2jap/RqnMjAD0/AiuxQfMx4ZGjKNyrlX005Rn1vVV/VuagU868FhZHJ5D/P0fOrZxn1pA+7BVb+cE5hAk0Ml9bo63MBMZsbCawiIUfnLHDRGlFym1TRVrTVxnN3olFoG74YtUEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427018; c=relaxed/simple;
	bh=LcH8SpaKXSuzmvpIr5OOQ94gPXvSL776wVHpa/ElBjs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=S39+eykMox8JtUW1AuTDQ1VtArP3ykBvXm2DYgwkPaI2mrpRgqwN4AMcurfe1h87Gm/FK2NK0BNSkObea4Hn4QcL1jqsT8O61YDsfULcmMEHe2HVDJyp17AoWak1qY8HdQ5k/RJFER5KDOtiKtbrGf5fbTZ+Zr0bsGue6vmlCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=suqrtegq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="suqrtegq"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso169a12.0
        for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705427015; x=1706031815; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcH8SpaKXSuzmvpIr5OOQ94gPXvSL776wVHpa/ElBjs=;
        b=suqrtegqIKlEbukedyP2Jr2wcbdB2U908XlTWfwckZ1xEPJVn5jnknB323glxdvvAl
         yC/d5P8cAltEzhhWG92NSTq+qxEEEwVUb8PXuNtEptHHs77lg8KN/PoCkF42Ch38BB0N
         qFWGUUEPW8sEai9HPArot2E2/dZJoWykhIVdc3ZKVU5nxyfb8F4r2gIy6KruKC6JYixl
         vdPyxWuD3mp7AmHmq0cj5fNXkp+ajSCXbW/j07Tg+LP0/HsQLQbdqGz2UXpV0HG8wdRj
         BNEfmSECvylN/D7NHwseluQgJ1oA8kdXtXuXiyIAE7Gpbcvdk/HvEG1c+Mf60RIkB5Os
         FKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427015; x=1706031815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcH8SpaKXSuzmvpIr5OOQ94gPXvSL776wVHpa/ElBjs=;
        b=WHsuc8SY8F+H9Mfk68kqCQxj4gv9iUhN7sqTi/tLx1GNfcj2k29XBY4abN/pDVDIC1
         9qQHCPYC6abBzwZu6ekPlbhEvjhG3IsMhs3b6C40XR4YZx1hk87eS0iNPtAeUkFZ2nWr
         DUfvYjL44eMT3n7SlAfiSWmvsdShQi8D/3xrZa7/EjRaJWPfNt9G7FTb55hk4xU7CqMp
         D4L9FjYtAZOJMHBjchmWi07NPdZu6ZltZaikUiLSIiFTxUjBE296HF8rshkk5gcavfFB
         wadijkXkcs43Q0tDi0SZZccORwTIuRYCm3jvsz69ALbNNyRN2DvIJnkZEWydp/TQjg69
         2KEQ==
X-Gm-Message-State: AOJu0YxLFd5Zq4USvpJG9vuTdW6oiVJjGSkiat4KTgPP1imrQR9Qtdb5
	AV+bGgkgTSDFGGHkxWLKwyTn4jIxVzewY16OmM9c3EIkSV0+
X-Google-Smtp-Source: AGHT+IEqCH2+QVFUNxmp6JfimiNRnUG5eO7uirPh1kn9mq5KJ9/hSimv+N938mCVYV4dQ0aiYfzp+UCiroQPnzNfxFs=
X-Received: by 2002:a05:6402:3098:b0:559:b56a:cc6f with SMTP id
 de24-20020a056402309800b00559b56acc6fmr26446edb.4.1705427015377; Tue, 16 Jan
 2024 09:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com>
In-Reply-To: <ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jan 2024 18:43:21 +0100
Message-ID: <CANn89i+nbXMuLpB11s9rr3L0PV26UwkSPdNXDijoX89NOJ=V-w@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: relax check on MPC passive fallback
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:19=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> While testing the blamed commit below, I was able to miss (!)
> packetdrill failures in the fastopen test-cases.
>
> On passive fastopen the child socket is created by incoming TCP MPC syn,
> allow for both MPC_SYN and MPC_ACK header.
>
> Fixes: 724b00c12957 ("mptcp: refine opt_mp_capable determination")
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
