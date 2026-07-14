Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0E43B494
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021109; cv=none; b=F3bW2yRQvdKXp416ZBeKkVOhW1IlYa6aAfy20KxoPcdKW6whKEZsMxvR45e2poU6oTHpiTchJEGswGMEjWPwsGoaM+ZQSwtaTzvCfxQ2vWUEHxr2j6AuYKFEz2HHl2MUmI6ZKVGN1xLEalwl9UnXDYIjfN994PQbsF3/sEWBaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021109; c=relaxed/simple;
	bh=qtKSmAupiizGz+BSvfElNgttVQEukknBVTov4x6h3Pg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=asN/brwawkm0Ab3jGi6exK3RrsdUGUAIZTEe0/72WLnYAYEdKTj4/0l0XJXhJAPPji8lmVeMulG6GPEZY5U8RWAu0Z1gmNxExarRtFSrBpbIsHEjf8KpTI1puyRxVlXRyNyiWJt18QsbJQ7ISodpYK8SRDcqXS6fsWG6FI5l7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoqhQHM6; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoqhQHM6"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f23e851626so41665646d6.3
        for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784021107; x=1784625907; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7eObRB4Q0a5CnfJ7KS4L+otDGrLKz19g8pP/DSbmxsk=;
        b=FoqhQHM6WR+KWPP+3sGS1GXl7uEfAXDGUSq17CGW/OUl7/PZabXSLDU0UXEamhtFdB
         KC9wwia4muMG57Kz5Mh6jUh9BNm9Ta1n77D4auAxpmrweAOmfVbDA575dGlkNV9/7xpR
         +gVLaMAfZ5pPnO9COVrXF5PrfXZqPdJ0hM2ZsKYLnHBYtaR+zbu6G5vZ6Y/3ZC1GgTZc
         h07D98WT0hA3HvpvbLMbIM5PaPhJ2oYJKerCmAEhptPYPujSCbr2Y4H6WwJbEmVWpxBg
         2Lp0IUpOjZO+bkcbpK93sB3mkSJKJU7Eb/d/LkhBpAp6rmM9VB9oI2ijYUWb1NJt0gAk
         rqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021107; x=1784625907;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eObRB4Q0a5CnfJ7KS4L+otDGrLKz19g8pP/DSbmxsk=;
        b=Sd2f2ZwJ/lvQ7+dcUCH3CoUWFFGXGhtllVULxDOdM+nhQGE7hmHFzwoIulFJ4wDcCV
         qnAyOV0lBkjXlf71V5Z0G2fWbR/iwJn4iHkCQHUUwm2O2bOzZ7HBtnpFrWpgFSbBnRjF
         WK+96Tk87NUTSEI9YHgYRUHr0FZiZ0DS8ksDyjUhXQWLlSKN2y2/2klJYGQ8ioN27Wrv
         m339kDE0+SDWPvvHEIzD7qR8ruOB0I1GSiwVcTPWmGGyCtd+KoEhPTCjAHGiP49C1ug/
         UnT9fpQBQnyT3SmBjR10zHtISV/AYTEiDeR9S81Dj+g8qSL+w34jpI5MmTny7SpMAR5I
         fdGg==
X-Gm-Message-State: AOJu0Yymc5ZnzJpX6uK1Gc6AWnDXoFXv4u0DtXrRCs+XCqNrlvUgT/xi
	jN11yDTIbR4UjZBrQLY34duX3zCqYmqQt4z0qAYTKBDiCo+sw/nTRoEbTtYS5f0=
X-Gm-Gg: AfdE7ck2+50hqD0H8OdJzRl2QbwK6HgqL2GinZm47YxfXoLzl1U+eE3lKHPg2HVBEvI
	ZaJmIKspA3/Qlm/4p1BTrzowWvVDDfj4xksqUqHIQTW6k9LOaXKUqtdgGJFrNJ9AZf7UHvpxRzW
	XRSKcZChkJCZSLIRTLiyEDrrYysk4UhxvLPBUDcm1g28HxUkHEEfUE/UU/p0tS/D0em7ODAbclb
	Z8uoUfBsYDvYHgnOoMtrDY5xx7mASVJMU1/4MtqeRuMQLKJUKiuhdNZXnR3OBMF3Sz5CZYTk5Tl
	RTZNZ/nqPtBpQjw7+1WgWJ7xmBn3YQEIQudLfPgjPDp7OLrXJjzM04xwTRQ+IRkwWZ+CIIqsrLY
	28rKhs/U3Igb87SPo8Hj2FFELLJxlYUOi78jwUuVsrUMb2RskaZVw1NEEKCqn3U4jyz88yB83jZ
	T90lA+rNG+7nscMD3Y0PL7w9gokuw=
X-Received: by 2002:a05:620a:19a6:b0:92e:c118:18e6 with SMTP id af79cd13be357-93083dfb6afmr209861885a.93.1784021107134;
        Tue, 14 Jul 2026 02:25:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.238.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm1421059585a.42.2026.07.14.02.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:25:06 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: luoqing <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260714080356.805839-1-l1138897701@163.com>
References: <20260714080356.805839-1-l1138897701@163.com>
Subject: Re: [PATCH] mptcp: pm: Fix address ID overflow when all IDs are
 exhausted
Message-ID: <fe91b6cd-80dc-c162-0009-88fdf46cc1fb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 09:25:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi luoqing,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/29320601476

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/78=
32e6717726
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1127208

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
