Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A12150985
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144816; cv=none; b=LwC5E0+tMczcVFv5zYdgiM0Ny3GMCzDFoSKfSUe3fF0t8gtVx4UPp/vEjwzHXH/d3fgXL32uyff0r44QgQxv1nKfAf3sfpoRZMzBOwzOTEoiF0T3OExdiZ65UR3Ayco64B7AoFvJ/8W9tytKCym5UaaTpR4gCu3c+XRDKLks2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144816; c=relaxed/simple;
	bh=qoYmiDVQHGoJhDIUf17rxSBZimgTo2HvSHSaaEmvtKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvVrfXzTwMb6VcVT/ltk+DVnRRJHTAh8gqy6a9rna+dZlJKmjO6URFnBM/jR1BhaHrlt4NMHBQM3vf6oEuavlEqSA2WqeV6FBlerfVNqevBRSHS/yZc8sPAeoIUf6dPpcYS9k3Cd04VowqJnd00ihSh9q+DooINuRYQFoHN6YXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z03TNi9C; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z03TNi9C"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso7327a12.1
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717144813; x=1717749613; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoYmiDVQHGoJhDIUf17rxSBZimgTo2HvSHSaaEmvtKc=;
        b=Z03TNi9C0tgKPDzOZ35gLCo27WnpehviTQoRxdGuwX00pjYKV2N8epVM2XAIK0ZCe7
         XcifTHUatmF0W2tYKyb6Gvk6xCyCMczr9OmG589u6HfcAX7l+PhD0KWdMGzcQaDRXxSn
         9ZuXfwpZGX4rkx9Foh1NlLZoq/a4+C4t8yTjLN+c6gQgYoRwqL1CvpcsVCu75+tdGGDS
         fu0hTLZmR6lCRMmBVisnPpQKnoa/QhZ9UG4noV01BROaJIFJmbVWCk73LUJ2EK/W6iw2
         0uY5hRN0dCCL1/btJwX+AWIujsqjPLiSb6BlYo5aTJUhgZn4nNJDT7M3Ul4UMRd1NLgO
         Ku6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144813; x=1717749613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoYmiDVQHGoJhDIUf17rxSBZimgTo2HvSHSaaEmvtKc=;
        b=HM5Ijh2TNfhCdBvvjbY+Tm2GT70eF5XRdjORaSBKhnS9WC18py+3bTPiBqaB0Kjpgm
         VULwE+SH6LEdslZBdmO5sNSZ4PPZc1DH6VB0zdSsc0StddfFqLaLZR9BxyEpg7oQO7RE
         2EuwnsRNejoFDiVJhwp3mzc6FnkaB8X2nTl02LSqluRkVbIfVT1f2M3tidOu9WQJRfbx
         MiSd/KzaNyI4Q0ujE3GVY+zyDphqH/OYJEUOiW5Ig+Bxgh4l0JPS7z6N0cSR/aA/wtAD
         mECX4I7lSKBdL/RMWQvqp7Eyli/+65VRzLaGIFU/e+iaro/zDizHru+3bS6uGceoYl6R
         4ZNg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6XUnbPnk1k1V9+rpa7vDfvHmGv0kVGX4cRkgGPM1LuXNblVzfj3jKQVDgkDpwZ8Vc9F+WH0Je15Z3yUOpSjBXLOqgLo=
X-Gm-Message-State: AOJu0YxN+8VYYKP51WddPN2ZUMwVcyBiBO0V/05KHgIBbqPiZzx4DWk0
	oWMJqbU5e9CXLTl4YviN+ExWPB0Ipxx1W9is1gryd9ujM4qxrustF57ATpR1+T1vNxcaF1JtYw8
	gglp3RUWjj/DP9je6/Y+EccVvD4nByJdAvW0g
X-Google-Smtp-Source: AGHT+IFGbauQlcPU+hEeKoyanfKhy4gjinVXt02F9RE1UHv+tzn11F9/2S2LUgD+Oau+MCnadvuLIZbn0Fa/zUtcMp4=
X-Received: by 2002:aa7:d04a:0:b0:57a:1a30:f5da with SMTP id
 4fb4d7f45d1cf-57a339d8ae6mr123533a12.2.1717144812810; Fri, 31 May 2024
 01:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530233616.85897-1-kuba@kernel.org> <20240530233616.85897-4-kuba@kernel.org>
In-Reply-To: <20240530233616.85897-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:40:01 +0200
Message-ID: <CANn89iLMJrnyvtT+CG635Pbv8BjLYsOEGkf1ut0nY93sUBunOg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: skb: add compatibility warnings to skb_shift()
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	borisp@nvidia.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> According to current semantics we should never try to shift data
> between skbs which differ on decrypted or pp_recycle status.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
