Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4141A08BC
	for <mptcp@lists.linux.dev>; Sun, 15 Feb 2026 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771143542; cv=pass; b=dHdusD0tDNCOKvx+v6W1JfnvUtxpYG1Ht2W46EUQiJlVlKpmdPrSdZah2yCFCPHZYkiCftVXmMS0R4jbEX2FQTL/FTN8WEX6J0XUogq3d5YOY99aOpmiKvUA8DDJxRsFiMQkQAkUGJUNePqL41OUOnPFv1fyby1tennR33C+BVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771143542; c=relaxed/simple;
	bh=G2lw/WlT9t87EZJy/y7VIZYQGtCU2fBi+OU93zM5oA0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rchiX74pAEFOezbwfVThf9M9LgfXD+GIQm3DwAfHKDp20YHlNP6D6KGCCGakiyIah1NsUZcjHJ2oI3AAgS75SHiS6vhN+xgKLCECDNJ5lMLNVsgmuK3AjSv0+f6ZOhLXTGwHydbcDw8ILPOZ1Rlwhe4e7lS7va5tUTqhorLrSsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=aOwW0nwT; arc=pass smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="aOwW0nwT"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b8fd976e90cso81900366b.0
        for <mptcp@lists.linux.dev>; Sun, 15 Feb 2026 00:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771143539; cv=none;
        d=google.com; s=arc-20240605;
        b=gOdqKZMBpOvbbnFEV8oyKiCWNvd0MFgRNeABc43w9NTAMLuQ4DEhdMI9COCn7oO+xr
         i5Jgko/VJUiijHuqsin5L/0o7MGWfk6t2eEajvJVblGw4jC99E7Ws5vVc9QfDQ8d6x+G
         Zn4nx2y4ipGN0zM/Oqd14cYdsOyZ01VVO3jgHO7UVeZN0fPqUY/1MxJQI+UJ20+N4M62
         PdbLGB1Oz2YDNr8AJhII/ugw3nlcRjIeg/2f6w/9VbDMTd+o7OKrN1LP//tMQwWZeOIO
         bKhGdemvAGvnGVywfwdjgtk+WbKj2IjtDUEZRER+1QpdVRtPh3YLfGsxF4nfTtfB92Bj
         VUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=G2lw/WlT9t87EZJy/y7VIZYQGtCU2fBi+OU93zM5oA0=;
        fh=KoOOhf6J2pokZKo/B0+oz08+WVYAFzmgcZVfHglZF2o=;
        b=L6RCJoGrzCRMp/Yqr1HKYLRE45VEU1d9HC3x+P8cF2bXJA5ramCJ5dObXQbyPwICpm
         IG1BKkU/RwL3Tsmux0SevTdQyoaAhs3bRcWAW9jjXm2jaMBySkmWY8Nlgw1DYGW97NSm
         dez2dOsFD1xD32GP+F+U9veELDMAXXtgkZB5xnc5rLolMPwepwK6MbC1f8wjze0p15DO
         TuhI/Sqpo9AJw4Q14//nqyWqqlbJzUkYJiy9VaXKZvRWd7C3ZChC1sxOtkLOTrlalQ7B
         +Al7O60va7Asg3SDBT/KwX5uL2nAWEC79JRQx2raAPOg5mo2VjR94LrrVm5lFDPWXDul
         FLTA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1771143539; x=1771748339; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2lw/WlT9t87EZJy/y7VIZYQGtCU2fBi+OU93zM5oA0=;
        b=aOwW0nwTGUBIYRdFJJGVpyKPDcZT/m4QLqCW+FyF8K/regkKZcRS3nHbxUl5As/pjM
         o5qjbgRhvXkGVg9IgsUO5Wz6Mzws8AdRypNkVbX4HLFnSQautntbrEpmzzT5rBz+jPOS
         BSp4bws/r71XONPCXgrVgoUfR+aYBV12vAz5fuEv2vGE3JlOIZZLtWwSj8QRs4Da0rrI
         m/mKgtH2sC1p1QkqWTgCGb3ANQTVfV49c546XCwf2mr+dHtiOBJO4cm2TTYZSyGtnts7
         PCom2MMqJRFpVchBMx2HB0wq7jCPFx1H59Fx0v9L0Tv9+0xJ0e37LRthHW+FUypoKgbS
         lGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771143539; x=1771748339;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2lw/WlT9t87EZJy/y7VIZYQGtCU2fBi+OU93zM5oA0=;
        b=Kg5NhwFzksvO69KiBSig0/g2O0hfgisLIMrB+CNrl3INhBbyt8zUlL75EK1HW+Poel
         wb3JuYmh7V+iPa4qFT6FCbEtBI2/DzCJ79yjDuvz4xQi48rijtna5edqbtkYS9xRlXXq
         /Gl4VV8O+58SuSM4yHcqgAu4i9k0N7j/M3tFNEs5OQe5KT4Lr1FklD6Bzn2pl2MoFNEO
         Ku0NCe4K39EyiQ2ppu36psKSasp7r7e/AAl7BsNoOrPb0LezRu4Xu6WGnUAqUSg+KHzW
         V1OBTnUSdiajC7JThR3jHsiJHzkst0bL/2Ewo6GG8W0cc0/Lp1I8dDWNDkyjaHNldNBz
         UHKg==
X-Gm-Message-State: AOJu0Yz3sqFydePHLmjrLwHKkWu9jNjwN2/x5brN3pAhPY8gQG1gY1Bt
	RUhuSfM/Oz8tkl4yfRmsnOXcaHVcdKbPSDI6e1N+7E523WKtwnx3o3waza0ppp6s4/deLCaT2vU
	kczAV+k3mpJ0cpAm00JUsApq+GGOXXuAmcPnNZ9XsSFHVcaDknPD573hI3Y2zdO4sGA==
X-Gm-Gg: AZuq6aKSfA7CMKFtiMdlVKe6fGRuirIeq5JUZYyRxrMVPdTZ22EW3nXhic0ykhRbVQX
	FVpbTYj8FFaA8sWCqA2dkMzIGiM7hFmeFHsNeARFRINWhml/Jy2Gwc4JqYgmdFSWiXo3q3+djSN
	c1Hy0cM2BmxlVrXUdx+ced0vdt8rcjUSrS5dU8inNTgp9Ic2W7sLxwsp1NNemAvLB7w7Q8YGQXz
	0aqU6YJUeeZc/vxRWxoUaNprVAGVORIQuQaXUucjXD/82AS5TTMSkwCn7i+oDgJsMlvPoUFDske
	97fgAXP/N08ZJIcVkWQVd2aXo7DbBKGAkTaTB6+iExtFWPXFKA==
X-Received: by 2002:a17:907:9409:b0:b87:3174:9bbe with SMTP id
 a640c23a62f3a-b8facf9849bmr443959166b.61.1771143539213; Sun, 15 Feb 2026
 00:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Date: Sun, 15 Feb 2026 16:18:48 +0800
X-Gm-Features: AaiRm52Djwe3mrg4LocW0PVAMXai3UkS51lVfU_zxlRTadqDrgZPG5KDCT6KcKU
Message-ID: <CACNYkD4A=omPgoK+EZGuid7=xk5WH1HS8nJja5p0N86J0j4uWQ@mail.gmail.com>
Subject: Initial work on adding MPTCP support to Firefox nightly
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I had been on sabbatical from working on anything MPTCP (after getting
disappointed by Google for Chrome) and getting my enthusiasm back,
i've started working on MPTCP support for Firefox (nightly).

https://bugzilla.mozilla.org/show_bug.cgi?id=1833182

It is still a WIP, as it seems that Firefox "hardcodes" IPPROTO_TCP
(0) in their codebase so there might be a lot of work to change the
codepath to be able to toggle MPTCP feature in the UI.

Regards,
Zaihan
