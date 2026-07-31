Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB321CC5A
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785470741; cv=pass; b=MOXQjVD1jBwzWnfOuhngPjAYMoSAQg9RXRqce/8qmzQs8mba7NM8XV3TACMx40Nbz2pG/Nzn1+zfaDk7IJOv4ebknhKkVGhADGIUyTd5zjmIHvmfHIi6XyASxlsX7SIXGRTH0r+ZwSs124VgOGPFeBr+R1sEgug5k+P6jVyaLb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785470741; c=relaxed/simple;
	bh=W/DP8nyeZG2kVW7RqHDotMJPdLEgWmSBN4/pvi4zkEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG5e5bKMoyZuYmPk+wuwu7jdudXMXXzt0x8WELgfgRF5wjB7L+ujH3405/gUyFEZcXCjORbkhL/OpBuWA4UxRjTUv8gw5kcP1xiO2mNVkjUn39mepkFQzLvZrEPEP5Evi7Vma7HKSreljzm9nA510p6gX+sscr4ucMABT94Ujwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=OEWxBT1c; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="OEWxBT1c"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39f1ac13687so3925701fa.0
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 21:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785470738; cv=none;
        d=google.com; s=arc-20260327;
        b=Jqb6Z2tg13jRCCyeZw4mdjmK2rti7+z27zee+kAPNUKzS00B0IXdDNCMkpqXITOAvI
         Que/UjwXc7XDdxulXAx+NzbFHQn3ffcwnxegb7FmI795YveH08GKBHiUK7ECr15qtbn8
         wtYthgm/Z4UsXa5u0yEoPVlJFVIuVIzyO6wJfVynr6tmpcPodDKviMobIkARcHzfFaLU
         7hsX+kCA9SC4K7fYS/WV04pSH5oeI4vjCprM3YJloGdreHIwBmhDVsoj2m5THenqUDjU
         is4qgi1crexE8Ft7vK9JF9aSz+8IM/69zHDWrMKjJixQoKXL+d4H4kvtdteqw06Q9uQc
         J6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nZ7Rhqd0trlKYrhTL6fvWDdlYdGagNMQskwAf3SqK8=;
        fh=aLtN01p7hoF0lgAtw67FsZSY1LxMbX0r3dSB/egnDlc=;
        b=Y05VU1HCTGe8m5/r/zho74Bz3NfOr9+EluiLz7yj9KtmQDB41Zs6fIFCTuPrBdNTio
         rnh1rEZdOfHVM6i/HjZkJjX+xYHvQ6b7KsCMGeZlMAkPjOLNyrne+GNQBsuGOtzT1ndd
         oPtPWNxHZIvPf8ObPqp3A4K4Qr2/5y9PHFhWObu50m5+9A78sexOpvRH330nDbimSkB8
         t7YyST7MuoyjT9Zc19kX4l1AtTCiuKAm+p3PNB6GTkjEbpYaaKwS4lFMC3dkA8zncxCD
         H6sZP7kqK20VoGBxlKjZVZ4oDLQKDtFOqkbAAF8NoHM+4iu0DcF4wK6D0WalXXiRwjwx
         dw/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785470738; x=1786075538; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3nZ7Rhqd0trlKYrhTL6fvWDdlYdGagNMQskwAf3SqK8=;
        b=OEWxBT1c0COPPc2oQBXeDzkmng1p7JKJl4peW9Y/MJgfjasWj0rciC4XEyIXMv0MMk
         5EXqnu6b77dlLkMRDyDE37PUnTW9ZATra72mKXNvdpeQKHofigLYXqvZhtGDVjUKqe3/
         9gI/5aLeLF6Q5GcR2pbU9ntEmOQSjiv61M5kIpdjXiRmRkoyoJRI/KxgdGKgPPv5LV0C
         vY7h0LhRcUb2l9UBAJ8Y+KMQ/GHWOcvHyJ18JMlrSiPgXjKDc8Xz9PdnnRazQbrUgWQa
         lkzFXTs4nko0MNa570IWtf+CtglIVLKhGNUjeOFDKED3k/aSDYvbq57WnT9g8ruPY8kn
         Uh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785470738; x=1786075538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nZ7Rhqd0trlKYrhTL6fvWDdlYdGagNMQskwAf3SqK8=;
        b=DNz556fgNtysRKP/RondzsbrLpTltLbze2CcwE83lOgz4DMGuqJTHIk8vlUAU2Xks6
         GV+rZgwOMJsTNtt4OLcAb+Vup1knm1aWfhR+EWR9xYOaTVnkG9VayhzW/gzsJSFLzsTR
         jm1dkI3xkkpvVgmo6NpP4VStqCxtNMjYXcZ+ic70RFoKoxqCRktBachN35aK/O/ATyLn
         wDOQz+YBVA6fmgYpYG2LNdnOyc1roMJdcZNWGeX+uYRTGQDOlKB6lDuk4kLowiGY1xO7
         fcfEs/MzDOIeeGml1B5NtJ0hfGPx6P88Qm02Oi5IyZ3HeAMZGCkBAH7CFHx6yC65+XMD
         wnpw==
X-Forwarded-Encrypted: i=1; AHgh+Rrl3ekZwvvqk9CesteCBqpRuhARn4+VVweP+tRMMlTINrFvdis3Uh2n7mDhA/xvAa0TtqYOMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKoXUqWl+c8QdIeK/oH9SmIAkB1pfP09KLpEexKAIj7HnRILio
	pExxiUP5N+rYXRIWRT6d9gc2hTI8WsooHvNuwTre8DYN4SHKFqLrfxtCXeZlWTN/a8oEcaAbRdv
	jRXBs0FQFTQJ0C7ZjWSckYv29YRLBKSMo5dMeSviIQDI=
X-Gm-Gg: AR+sD10y78hGo7DvWnVZf4aS2YampCCTATZ6KGw4acGll4jBTk0ceA392FR369M3Bw3
	E6kSkuYC+N8jpiP+/kyJsptcqvdbd8YGH4pRAZ/OFNvS3fhO3g/plhB2cdicUrzbkE6LURi/0C8
	/n++3I9T4oFdUaAIyOPx+B0fshOAM6ZcEvlNwcFmkXoY5r0SolE4MU1lwUdjzay74MLJG7FCl4d
	HUa6yWo7p1S+yPV+5o4mmDuadyL5vp62oLsqg37Tgoqx3p5U549nECEpAC9FTJWYRkBIFqxNrld
	QsPELtoeZmZqNfvKuCiE4eAIkJIrVt9+8mtv4otOG4c=
X-Received: by 2002:a05:6512:a93:b0:5b2:991f:90d1 with SMTP id
 2adb3069b0e04-5b2e1fd958bmr105657e87.26.1785470738201; Thu, 30 Jul 2026
 21:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785307984.git.zihanx@nebusec.ai> <CAAVpQUCLAk3qwGuxg1nHeRR5XX6jFt-9PF+Qq+1TZZTEA+DTmQ@mail.gmail.com>
In-Reply-To: <CAAVpQUCLAk3qwGuxg1nHeRR5XX6jFt-9PF+Qq+1TZZTEA+DTmQ@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 31 Jul 2026 12:05:21 +0800
X-Gm-Features: AUfX_mzAcO9QUPykONdIfLhA8d9j5DrtJFIr_wKiKimWlmDmswDlCNGtOWEDsSc
Message-ID: <CAANe3eSbNtS1eGjuX4aFa_-p5FKU9esvT652g5eywKL3=Zt74w@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag
 dump paths
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, dsahern@kernel.org, kees@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, fw@strlen.de, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:58=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Jul 29, 2026 at 1:29=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrot=
e:
> >
> > Hi Linux kernel maintainers,
> >
> > We found and validated a issue in net/ipv4/tcp_diag.c and
> > net/mptcp/mptcp_diag.c. The bug is reachable by a
> > non-root user via user and net namespace.
> > We've tested it, and it should not affect any other functionality.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > inet_diag TCP dumps currently execute attacker-controlled
> > INET_DIAG_REQ_BYTECODE programs while still holding the listener,
> > bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is
> > heavily populated and the bytecode is a large reject-all filter, the
> > dump path can spend an unbounded amount of time under the same bucket
> > lock while walking attacker-arranged sockets.
> >
> > The reproduced listener case places 131072 SO_REUSEPORT listeners onto
> > one colliding listener bucket
>
> This sounds very unlikely to happen.
>
> If you cannot trust your users, you should audit them
> properly (e.g. limit # of FDs, use BPF LSM, etc).
>
>
> [...]
> > ----BEGIN crash log----
> > [   18.495442] watchdog: BUG: soft lockup - CPU#0 stuck for 3s! [poc:10=
34]
> [...]
> > [   18.495449] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS unknown 2/2/2022
>
> It seems the soft lockup timeout was deliberately set to be short to
> trigger a splat, but 3s on QEMU should be much shorter on a real
> machine and it should not be a problem.

Hi,

Thanks for the feedback.

The 131072-listener setup is only a concentrated reproducer for the lock
scope issue. It is not meant to suggest that this exact population pattern
is common in normal deployments.

The issue we are trying to fix is that time spent under the bucket lock
can be amplified by bucket population together with inet_diag bytecode
cost, because the bytecode is currently evaluated while the bucket lock is
still held.

So the concern is not tied to one specific listener count or to the exact
watchdog threshold used in our local setup. The soft lockup report was
only used to make the long bucket-locked section visible in a small QEMU
environment.

The fix targets that locking property directly: keep the bucket-locked
section limited to socket collection and taking references, and move
bytecode/filter/fill work out of the critical section. This way, the batch
limit applies to raw bucket traversal itself, instead of allowing
additional work to accumulate while the lock is held.

Best regards,
Zihan
