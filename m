Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959483043DC
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880045; cv=none; b=K4vXc0xWkw+vX6MmMR/L2H834QDjP/9dUAS82BbcUgXPcHuM3QZ7VwxsLVDM60aGdW2VA6RmzTyotXagZLJTYfTuhdbzgT8/YK+42Xtdjt/Gau9vcImqwr6qA9i3ZF49D9Ej9flcJjIvhCB9s4836fn+0yf9OQBhEBV7A8WVfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880045; c=relaxed/simple;
	bh=q58EjhUvGAjSUg11zegnliGWRkHsg6SUHQhtsWZRNlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ppqH8YlM4P0l05Xp6bBjn8jut9J8zVuF+thchkPGz/2UWxDy7OoStNcJTzK4TpUO+rIMgvMSrAN7XpJcsMC3+TMTYT+V7rQuuN1dKtmkUuE5eqcaqN/aR/j3cU8tA5I8Ipwrph+1CUTu7EOYp36HTB+lB5ZUuNE7alaSeAj1QK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa9fw66d; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa9fw66d"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a74765703so54824517b3.3
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880043; x=1777484843; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKM2+JsXmdaNDxYDw5EbpvuGNviGVIy3RvVOEW9n9hM=;
        b=Qa9fw66d0soaKDh/3ArqT/KVp/gWejB310qatohM888GDGDawMYkq8dFIRertBYzTa
         Fo2aD2h/LxU2CFtbESzvxNPRDzAk+r7RwXnjvTzAXPHwqkuv0Ky+KPQkUhFKvqoYoVrg
         r3I8RUNtTOXPkAUbe+sI3KOmBIC3M/aX4PwFsrvi9V1xd3Lfyn1dI6PdHeMQoAKU/2Ln
         SUbRU0GEHaKOANxd1ji94S8E9s1mzzDX1cI84W0GwMk0hvfmIUTxm+kkbAIBRtkg8VAa
         C4tFmjZjPuYCpKO2qJD4xeQTaCLe0m9ndRcaU2KgjnDKIPqfOB4kTzBSwEVN4s1DSGli
         xG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880043; x=1777484843;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKM2+JsXmdaNDxYDw5EbpvuGNviGVIy3RvVOEW9n9hM=;
        b=sAIztCKxCBRXt/lrolDg+3gWRcBPCO+QG4ZgZWY/jZpRqzMUt7REZAIAsyXY1NnO5W
         ANiwjCeH+zZZNEB2xJ3sqqfP/aPuQJwOvKQF/8jnSvMk0o4AMO+NuFqI2xbhvjjHv3Ts
         hG9uxHt4KbWvwvY86BRcWlH5qjlkMXUUHbiDemXBCydxuA2xc9j6NpLPD8KY9bBg7NUh
         vguQHrH2zcUsKugyqes0bDI/XPzCiOYUO2R51thP2kNgUDp4e6fCJRreD1xfzW32RXjj
         8UN5ruzAqFCEAAO86V90TGZ8Txc2ogzS42HxLnUlz34jpMky83BBoabtMapEkE/dPEvJ
         iY4Q==
X-Gm-Message-State: AOJu0YzGBVhAjgjOJXw9gPmhyWfTGB7qniUFfIwCgDe3PXiONbGjC9D7
	oWmG5KtUiWOVsKxnQFF/sqicS2C1ylofYyCHbC9yvamMD5X9jgl5yFA=
X-Gm-Gg: AeBDiesKzFSj6PT6LAkcwhXFpE1elqjGFDc0GWtaFCtVh3qYy7lgIzPwT4GpXy3bOH+
	xsZDz4wSAmsO1zEoGaUJJz6yzXlmhGOfvzVHK8wFOD/8bMDgQNrsSLawVIdWEz7dVhJpbQU8Bh3
	28EDhrI2+qIF6RHphDx//Vr8678T8vDpzbRuXrCWVZIPNoJXcf8rPwTus1yiYF7AOBZ5xS+FZA/
	dgn3TF1QDgZhSabGIfONlB83K/+kxtlOgL5NZ1fzor0X19Fcx77/Xjcrd/fg7WoWdMEsiUp/v0U
	x4i+kEF8vYGTCdd3RocehTUJRTpQHLEC/Nf2jWAVM38Lp5xuuYhgWOu99/dZcc9bOF0Sne4hozr
	fo7xKIK0/6L/l1SMVHqBdDZsPqhs/U9YCFDFo3UwBBmv2pbgNeVr3FqFgOHmPsai/BKPdwORGOd
	UxjT1WHnxfucbJayv4UVpX811T1fMVgpBHzg+60BoBaYY/wXX/+TdShUoSyHZS
X-Received: by 2002:a05:690c:83:b0:7ba:ded4:df5d with SMTP id 00721157ae682-7baded4e828mr196015787b3.34.1776880043524;
        Wed, 22 Apr 2026 10:47:23 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.166])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bb09sm73716027b3.32.2026.04.22.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:47:23 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
Subject: Re: [PATCH mptcp-net v6 00/19] mptcp: pm: increase limits, and
 related fixes and cleanup
Message-ID: <6753cca6-c8de-bdcc-001b-41c3ffb8d9b2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 17:47:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_fastopen packetdrill_mp_capable =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/247912=
73302

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5f1ff4c3eff3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1084373


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
