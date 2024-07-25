Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2E762EB
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938309; cv=none; b=Ig7vXrJp7gd8W7CwM6NPde3zjsPO+USq4H/t72C4MJ1CbIfokCSfvnlbRGiJelbaDAYuRHLRtCB2cpi23l37Wa0hy2/HcAyPSf3qJV1zyUhfkPVkP04qn6oMwT+eforuUwUoM1QNvXE6WSPPJYG6hoTC1m+fD5SgNDSdNhYY0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938309; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah0q5X74ivT80Je0iU+hG0U+pHzDfFkGSX10GZXWPc/PsRDdZEw6bJv1yvKlhCUl+49WPgKynDjafzydMQ5wrUDvlX1DZ+bncFI1dkRSa4u38242qOKm/ex4Mlsh8C8INJZREkLpu0zjLDlQoFPwP43gJhX4OaIQq9pRaXieH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PRK6cuu/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PRK6cuu/"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1718419a12.3
        for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938306; x=1722543106; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=PRK6cuu/BPxIyoVPUvX9aIrotuevp3o2/rsFX6NCe1quGzKNwVdv0nCSV9VODLq/rf
         7NMW35EfdvjIrbRviF7juZVyDX3z4tCqMdFgSqKDHr7qxy6U/IJGnYcHuhErPgrUIn62
         BD+XJqNTV5YuYqFqv3jj6OM1b2mHSJ0SzcLKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938306; x=1722543106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=Ijsp1peQ8Wfvg0ibLYWaEE5lIte0OZk3GzRCkEbwtR/bohzxFtohagp0jLoSIwlW7T
         cunSlR/C1eARwMv0hFMdrGMWQD1uA20cPeOKFCcQ35r+g4B6XJT7Zm+wF1M77oCM/1Ba
         FbHKzr3nSFnlhYmXYhHGmR9OE+DMP4Y2Pr9nhSbyHBEKnf6zxzBQLu4k3TucVXPrP6Sw
         suVMbT0dYqBzTmTieE6IyiPYSt5dF3ur58lOjV4LRRZ8bEY9FkCcPvpESdawEnFLCsra
         tF2YUbEHMd3TaNc6695ngPEP0PldKzJ+FyHUubCNOgseTIcxFXL4Ugg0GTdmFChGACfE
         8/pg==
X-Forwarded-Encrypted: i=1; AJvYcCXyygflgb0oI4pOau5C3QCfXxAcBKYbw4HykqKraGTpJS9reaDItX+8lIrNqs9a2GHGNAVATM5zm/c1UCEE63qUmnjKMkk=
X-Gm-Message-State: AOJu0YyrvvA3v8HEK/d2915jMSG8QDtnG2vpiCBVBP/g0pe6B9BLskL1
	PvRk8/hspL8DFpIg+G/TjKxKsXUD++yElfROVZl41uFV06F7K7jlQFjjanOP7Y8xabbMoWCZ1H+
	sGYs=
X-Google-Smtp-Source: AGHT+IGLjKLSAuwMs78P45xEb/Eo0JGK1jPcymXTObwUL/0nKlb0P1Rs61KPH1l+85sbzd+Mzaw1CQ==
X-Received: by 2002:a17:906:c145:b0:a7a:a138:dbc5 with SMTP id a640c23a62f3a-a7acb97172bmr247657666b.65.1721938306380;
        Thu, 25 Jul 2024 13:11:46 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41983sm103062266b.108.2024.07.25.13.11.44
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:11:45 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so1469909a12.0
        for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV19h2ctPBZA4Cgi4yPKw5r3vS5Dn6xhKAlKLinDFWigFxSZWS0cMjTulySIwJGxMphKMbg69Hdm/Mam486X0XBdo328LA=
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus
