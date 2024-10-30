Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34F2C6A3
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302683; cv=none; b=p2OYmjq3BjQBZTAD36FKuQyCGubbu3SSLVqlesKA2ukS/dQoNlBNCRlBPEAy0F/ULXoDNTkS6xvBebqHHu3k34nODhYdyknUa2RbeZbaFgb/j5axPPFLOXok56e0VOEfo9U6E/3MnKwMqKlKCFANuZdhyrLSPJv/yFb9pwdX8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302683; c=relaxed/simple;
	bh=lWLNB6NauvSC3irEBTZhZs6g8sLTn5D2zaDYEGJJkAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhc0hK8E/Xdji6TqFOAaU7kY8nrMtyhmJ/Qk1wyT1kOyxV2LTjtipSfId1DNbpun6qq8jAzrF5JrhUR5g1dKHVyQTL65vzlGxktuW+MWqUJ7xaMUkF5XRZIedvkOJL2L8gD7cWfnAI+Y+Hnv1k0DGeNFCvcKlh/oJEBOES9B54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwHrSRP4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwHrSRP4"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so67907221fa.0
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730302679; x=1730907479; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrMCWRpczwyRTmnrS6nIF4HKYVkA9torv7EN4XtnnJI=;
        b=KwHrSRP4EePe0qLCMDeP5aSBovGOqL7n27yeUGIMrRv/0cR4aS/7ng/pWpK+S4icsr
         TWHSi6m4Y5KsSor413iJaHxM5d1ZfNxzyI2/Xrq313U4hbpjnmBochNgAq391VSln9wm
         x9GIVpYGXM1It3WpVRa6T4cHEcPSX0Bmb+Ssp9elp9eOIbnD+vPXVEMXzSfRgMBAheXe
         ZkSSr3QOOKs1lpuO0+IX9OFX00Qet6hGgdJ+d0gwIjzu4B8NgvtarME+/7X6AJZhVktJ
         z2BqNlofNVn5m5Pi8WWiLgaG7hy1h/4PP0NrmcO7DYiQU86fMeSZUn+wR5MX6Dcxyzay
         SefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302679; x=1730907479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrMCWRpczwyRTmnrS6nIF4HKYVkA9torv7EN4XtnnJI=;
        b=JuQ80tykJRrxxF3oH3QJDzDbRepzojJLkXnmTeLEHNKDKkx9eYA3/b+JfiXtr9v0YP
         x1tT6WcAOW5qCAXlIo4hom9IlCV0/fCaimC/6S8vyPGxq1IavpTNr9nHukhJerwDmmOX
         atqKkZB2agtaY94gCjM/fFb43jzNadycRAyKQKrQPZ1Jbx7t35Uj+fLtZu+o6YRpxUHL
         iDCrbOEb9pPUDX07axyomnSxzjeI72i5xN8O4lPJxNb2B8RkOwdJk6jrygaNtZXI+F+C
         zygvZ7zQxTSeiwWjD2wIQtdCrwsZ+ge1YS/UdFpBvIEJML9GphssM9RdrOk2DyhmT2aj
         gyxA==
X-Forwarded-Encrypted: i=1; AJvYcCUH1idup5j/98o27MpBxTxbLXdx/pWYHrjFitkYuL6R/aN9Z43C9hrF6mrN7qdPZwhQFVy/mA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpTsbqAgJdZC42UI1+3mVm820Vf1w6L6EIRf4WReIfhOW2CmWV
	DRLWq+0b/CliY8wK7V4aDgck8q6Y0eg0m76ZaofNKIljJ6CXxxv8zElOIIARz2UAwJeYYPnIva/
	9L1QI/Xkn9IvCsh2dKTnbPrG0YwZ6DpPvym2h
X-Google-Smtp-Source: AGHT+IG7DRpQ0VVMTcG6EnMiWykyPu51ceO5M4tUaSNQltNn+7su5SexoUVL9I4k/XDx6ioEftGeQAPKiITlI5Hsoro=
X-Received: by 2002:a2e:4611:0:b0:2fb:382e:410b with SMTP id
 38308e7fff4ca-2fd059d31f3mr18514061fa.32.1730302679117; Wed, 30 Oct 2024
 08:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030140224.972565-1-leitao@debian.org> <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>
 <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
In-Reply-To: <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Oct 2024 16:37:44 +0100
Message-ID: <CANn89i+1ddxa3aQH=1ev2fX5+T=PBT2C0i0YwqQzWaJuMfVi=A@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling mptcp_sched_find()
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com, aehkn@xenhub.one, 
	stable@vger.kernel.org, 
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:

> Thanks.  I got the impression that the scheduler list was append-only,
> and the entries were never freed.

mptcp_unregister_scheduler() is there, and could be used at some point.
