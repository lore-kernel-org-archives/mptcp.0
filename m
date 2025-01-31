Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFF1FAA;
	Fri, 31 Jan 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738311520; cv=none; b=Qnjxj7emNuTzCGb4Yww+BB1KRtSLh2fxlvO/56wxCIrJaVLO/FDXryfpXHCEx7YO/T/LdoumR0dcKAR22iM2gmLIlw2BF1RTg/OXcrqbQvez1zSWARirtXNgM6T4FV1C0E9/50VxCc3rk/keLmrjkTZQmpY+qzXKnHwfutKoH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738311520; c=relaxed/simple;
	bh=XQAyDEsftPjo4BUnpRrzUo4hXISSwy4f0FYmQpPlKmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+b6cXCHZMqiSfyQPCaAfcESQUz4cpGKyzT/0q3CWuQClfeami2IJJ/f51gHw9UpocPOfxxRfefPcTMxpC+QgK7gTVkMaSSOaTLa5wRqT/cY2k8fBYoc8ChsPKEsFwJMiNMzqHGhNLJIw7ovUhp/hevnyOuNyNhO6kK1ebkBjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-860af3331feso1553804241.1;
        Fri, 31 Jan 2025 00:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738311517; x=1738916317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7YJgHULp2WAjtiPEkDFTcvV/zsoNwPARiiJx2ktMxk=;
        b=dnSTZyWSk7M3k2t2WDJAaP5NMyOln3JzaUD3+DCxcJNaofkkbO/cwq1Q3cIJIVRjV9
         a96/70B3lkgI3WHRgmm7FvKEdQtDkQb1YGeykrstTmVglrDoTmP4lw4DiU0lEQLV1ut7
         Ro+xvKgRmEXacNoH6jcHT0wBaCLbd04JW8kUylRAVlDLOy7oV6bL927Fo8w/6wEk1SrV
         j9biAUNe+pfh6REYV1jIaEArzO8OjS+dJRrGkVxBMEAHXNRldwF1qTfQzjEdxIeffLut
         z4jXWLpqyJmxqPOhRFyg4pzD2wA42i2D+1hI28UzyFWZ9+cDl2+r+JF7940gUJo8c+a/
         fSSw==
X-Forwarded-Encrypted: i=1; AJvYcCVBOqSbgKcnb2VJaa0/MgKpVdhFIcRXASCepFHjCl5GYkP7ru96VlhVvyxlUGwQh8BWdXZWrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBow19nMOlX1ZkdtMghyTbtDYcEZI+W+VfmrlXu8AJfBVLLO7c
	WHKoUZTuL/P+guOUX3Eg4sqUAFJTm37X58Pb4GwyGO5+7G4t0pnFOR3UqY8TqI8=
X-Gm-Gg: ASbGncu4isrwSdu89JQSkDhCK0roh0MHkPLIo9HjTyhs+pM9VTqJ+1ld2Ja3Wter/mo
	YItxf/bafPSNRK18pi1B+8MwyBtVUJcFpEa0/r5OBq6hKEIGIubvE7toz+am9PCiA8jsQK93x9M
	1uKl2ZhdYzPxBeUhYjQWsZhym8xwIGHTTE/4c9SnL4+/nHMUe/intZOISZarIJde9QQqptDwzPU
	8zvJtSaZNMs5nPdipbGdN4t5HXfSHAd7GYbBB0aMISTwyU1bknrXd/fX1MhSpl0p/q9WxvsAzWV
	KWO/bEdl7M83O8E6stscqJslg4j57yNyNJ9+St51gqWo58tL0yLYWp0yhQ==
X-Google-Smtp-Source: AGHT+IFN/Y2xMhCjMD5Fn5xL+vl/iCo6i3YOToMvgeRmwaWHEqqybUQhjbda7kMB0QJoPwS64oyfFQ==
X-Received: by 2002:a05:6122:2104:b0:50d:39aa:7881 with SMTP id 71dfb90a1353d-51eaedbaf26mr5804058e0c.0.1738311517008;
        Fri, 31 Jan 2025 00:18:37 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1d91b6bsm463452e0c.45.2025.01.31.00.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:18:36 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-518799f2828so882341e0c.0;
        Fri, 31 Jan 2025 00:18:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiQMCQOd39ExoDiOc1Ccmlq19y9l9Z+9WEhY48/KjL+WvS4f3mPVigCzrmtt9BiIdEdbYrxQ==@lists.linux.dev
X-Received: by 2002:a05:6122:459a:b0:516:dc0f:c925 with SMTP id
 71dfb90a1353d-51ebe666828mr1912542e0c.6.1738311516552; Fri, 31 Jan 2025
 00:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <202501310132.oGDmspPN-lkp@intel.com>
In-Reply-To: <202501310132.oGDmspPN-lkp@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Jan 2025 09:18:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9=KRJ7jhzrMdnjCiTpBhqJT6fC5ZR=HKUVPzdygKBsw@mail.gmail.com>
X-Gm-Features: AWEUYZkLT5ckFgNiGcY41nm9el4Hb73i2R4W479F_ewOJKXPN37hxSWvlqWURJA
Message-ID: <CAMuHMdX9=KRJ7jhzrMdnjCiTpBhqJT6fC5ZR=HKUVPzdygKBsw@mail.gmail.com>
Subject: Re: net/ipv4/ip_gre.c:141:22: warning: variable 'data_len' set but
 not used
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, matthieu.baerts@tessares.net, 
	Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Kernel Test Roboty,

On Thu, 30 Jan 2025 at 18:55, kernel test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   72deda0abee6e705ae71a93f69f55e33be5bca5c
> commit: 010b430d5df556d5d232e3751ac691ba9e88c041 mptcp: MPTCP_IPV6 should depend on IPV6 instead of selecting it
> date:   4 years, 3 months ago
> config: csky-randconfig-p001-20220406 (https://download.01.org/0day-ci/archive/20250131/202501310132.oGDmspPN-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250131/202501310132.oGDmspPN-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501310132.oGDmspPN-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    net/ipv4/ip_gre.c: In function 'ipgre_err':
> >> net/ipv4/ip_gre.c:141:22: warning: variable 'data_len' set but not used [-Wunused-but-set-variable]
>      141 |         unsigned int data_len = 0;
>          |                      ^~~~~~~~

https://lore.kernel.org/all/67956320a8ee663f2582cc75f0e8047d69da5f6a.1737371364.git.geert@linux-m68k.org/#t
Waiting for the merge window to close to repost...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
