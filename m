Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FF26AE3
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115562; cv=none; b=cKFS7BqYPzKFLYTM+S/LpZsPhXz0HE0Mm8k29dHNaIuLdmfX5kQuZtIK5zs5ughyCMn3s8LPGMqfvD95zo0sr4cGZcNoql98axlZ4fnA6ql76Zn19DhdTZgvPidglfOYWuqJrZ/xgaAL/l8o5nxn1+izAgKwJVoeEpMF2+Am290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115562; c=relaxed/simple;
	bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLXLbJ8R2qtSlRCSuF0YEXLEgOjNH/6WTG6NplSFAZ4atmAMi9QKmftkyr06TrUDzH5pM+fWy92Y0FUDrdOkctlg9KXc/bWCibfUqbjpCKPmqlqSYqeiPNlr+1F2Ps/W8ASiLLyV3uwYniLZzIsrYsVVRF4REL1G4WJ4GuTtOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJwHCyUa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJwHCyUa"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso5002a12.1
        for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115559; x=1714720359; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
        b=kJwHCyUaWAeuMb727FArRvtGaMtGqb4vobAPlZt21M3lV2PVRdShYBEXtsH1P21ZSq
         M3eBDQxxPUEAyq5uFWcO8M2oaBJGNF5JgjUtZ8XaNtr7PASkjPkb7JaRWJfHISH0Quro
         wlPNq+1tkPcNHRYot+pHvPyjD/1kN8kCVzWy2mVGvn+mbVePJhXk07TmwmN8DMfldnna
         a4FF5pXGaI/bRLhQDzS4agf25JtH9Gg0xyUHmUF5Xms7SJTggidJnHL/QHKlpEJ8VB2X
         mnRHRWsncFvBOPZ7m2hw6QG14QbcG0FcAFykiLwhuXCidfvSBqFa2FT8m8/IRExDExIp
         ti8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115559; x=1714720359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
        b=pZKqQL5+F03NJ4v6sbMIVJPJz+GFoTt4NK1DOK1z9XMcCFuty+uUtPt5cjuzmVA76v
         iTD1maodIbrxIRXSVYaMkhwIgXZvdcNP5V+bVmLPjLwq3swpt0Iz2IgkQHu/hBq+xlg6
         caTq8UIJowYEGLESF2EXeLhBfjCK9wCIafW8rIEZNHYOVLODnRQjCSnK1SnPYlcYYuMq
         LOSKizOUEwB7XJFko3kP0WktE9EYk8yFUfX/AGBixatBaM0AjsAN7m8V9Dwu9wgW9lR8
         PFIGSXxpfm1GJF9zvbXcU23uaMkCiFjAVhQ4HvGfoAYp4Z5u/A/ioZmBaupEVtT338Zl
         o/vg==
X-Forwarded-Encrypted: i=1; AJvYcCUP1ycXzYqypovHLGPQZUDoDLrAgW4fDrfiLX4BJ6OedvpAjDpDr25DsJYetr7/X7SbcnW2W5S0vBUnaTwXwoxXnKC642k=
X-Gm-Message-State: AOJu0YzpmsfFyNI6fImDOSXmGjf0UE5wX3ytZGGkIU2Y2xrJGI/vd/z/
	zVlCaSQiKP6GmTASjELyqqxbfVdaT3hTpa0nn5E8r4+IJBriGIL/0CzDNA+UKHpge71OUEaeVob
	i2q6XMNu3ZzjD93L/CqFelh+QVF0Yu7Bcv/oB
X-Google-Smtp-Source: AGHT+IExI6r1PzLpwM+kdZrqejtoIV/lrdCRc9hPnUboYdDZk61WahQ3oh9IdCqM9A4jm4HWv8p1C4wk/G0gLyWVjh0=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr44282edd.2.1714115558737; Fri, 26 Apr
 2024 00:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-8-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-8-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:12:27 +0200
Message-ID: <CANn89i+oyLS8goc0oVEpDW+PR35q+BcSph0s31q3Lj-RwSRFVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/7] rstreason: make it work in trace world
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> At last, we should let it work by introducing this reset reason in
> trace world.
>
> One of the possible expected outputs is:
> ... tcp_send_reset: skbaddr=3Dxxx skaddr=3Dxxx src=3Dxxx dest=3Dxxx
> state=3DTCP_ESTABLISHED reason=3DNOT_SPECIFIED
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
