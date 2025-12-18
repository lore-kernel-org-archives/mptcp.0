Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47641243376
	for <mptcp@lists.linux.dev>; Thu, 18 Dec 2025 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095067; cv=none; b=Q3CK+UIVNRRSHIDdOK1s/+xhiMvvGbT/4QZw1KHeWlFmnaOlytHuNjsLsJbCWyZ0FbXugbOrgWluHakeKjnua1JuF60BFNEeW8Lvmg0dxEV/CtXRfZ8ECGfr0rkChnr+D7/El7HkCf3wc56ItiQwWqPzPAPpr0loOMuxnW/jxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095067; c=relaxed/simple;
	bh=XKkT2tZz7eWrLkWjuPs0kYDLhUmTVv+sxfAAI2qI3aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZkp9LveGTLp8v9VczrJfn0JdufjX+ihMEQ64x/52aG/zetoAh05SqAoupxlLguP38fYFmdGFff6gqLg3GcHiGaXyR+fw4PelmjWFXpKtGIhejwnx/WGqbdqeXJiRjCXo4eUnBJKyN88q6B01eF+RNKK/lN8UJ/jCxqdfb4peNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyARMYCX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyARMYCX"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a34702a20so7372651fa.3
        for <mptcp@lists.linux.dev>; Thu, 18 Dec 2025 13:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766095063; x=1766699863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/sjp0jU275es5lIyrSH+clAsUhfyndmb5HbMmt8PNE=;
        b=dyARMYCX14KY0dzjN+eFHyZGerIhoiGSdkFWKdbBTzsbnnwrtuis08hldJIIuBiGqD
         Bg9UScnP6eI8cZxEuvIpBsvPHm6grKznTS60XZMtmOuJnNGSQuotzHnDY7nR7war6s/A
         bB2IIeo+vqccaOd+67Qf4DcZWL17rK3SHc/WqlyiujqX1ThZdzUJtuI9GlnaTfuP/Hm9
         sCiGCa+02qj4QwG3c9dmSiFXLBpCBK5kuVEO0Xd443qxbgAqhejSxBhRhCvf4U2X5IJi
         y/U3uIDVHSZeRz54gqkoARPduQNhMXYF7LG94UmSfoNyUiDY0GjPtaHrcktMZbsa7Mw+
         hp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766095063; x=1766699863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/sjp0jU275es5lIyrSH+clAsUhfyndmb5HbMmt8PNE=;
        b=D6mi48jdFDIoJi1qbMoVW9YUvJJ5MgCI6Pm2hfgqCWMzzIvHqFdp9E1jMQxySAACde
         d8/I8KP9l0H9sB1QCQY4/wJXrf32vcpQAxyoDNBbnu62uk9C58x6vAROKEROl+rQZ1Ni
         +4cbrrSdoqW7UIJahHHD2tNKIGWiNTCY6kyrEz4IY1Kfa5QWYLaJr8JxF6o0j65dlc3S
         QbrznmdTiPQalFhWlb78e7IW+zJB1OKXWQFTLN8EnHG1qf0FTWog+K/SA4flnfyvyLP9
         4W2lQLlZU/Mp7nb7b/tgSb8XNC8iDV2tUqpuLkVXrYKz5Bj9adVejcED+FO76xomPJKi
         MFqA==
X-Forwarded-Encrypted: i=1; AJvYcCV6HVy4Yx9FZYCGN9Gz5WseE3PwonK4kDjUsJJNKKBskUuWsBtOSRVEalZsKo3/RvMF7RWI4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOPXra2ncI0MLyYIuLwQm3BX4EcCLxfndlh0P/irkR9LTy9DjV
	VMECAvUHB/KR4pUi/DtwewD2hJXRKieM0WxX4RZunA5/vuNum8kl6eK6rrYbDw==
X-Gm-Gg: AY/fxX6hiZ2nxgpcwHnGHGhmmBBjmzaduxLkGkzIqqa95b4+cBgYLvocl53imewvNwx
	4amzX1WuwCZEXAWGsN+YRIPCs0O8dGcNuza60mvVFxg1cBMCathkvoXiKrA5JExX5V96PvuXRvy
	sel/4l4lGON4rA9zkPhTeTTZUZVI4qca2skyk2YeOleotyPqZDlWGJCCUyUY9acfFxFlHCCyWCw
	3w2jrpOQLMlyoShRGe5LwhLkiIDowW8rWj8vmAYU9lMe5ZkwfEKpp+YnZsuJ5euJRdCy695niA5
	CljF2PRwmUl858jER+qh4yxhpFFH1LKnHQUipEK3sZ9W+hO8YtGKn1sc8sC8OshJy0ZbRbefKjb
	V+jnDytMFTUuNEDP/YmeL9A1dQa/rS0a/qIUVuKSMtSV6Spm0pXjxX5aIPIEfzuODfao9D4tSaJ
	/lcmkd4vRKSh6Cj64fixmQDwbLoCAsN0e/fneKa3MH4LaI+bPHMmxy7UMaWHOnPs4=
X-Google-Smtp-Source: AGHT+IHQbU+iOqzaiFiPp8MK9D9JLLWz5I3nysW2I9Q92SyiIPFWBxMnrn97EMLGECK7bx8NAmxYpg==
X-Received: by 2002:a05:600c:4fc6:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47d1953b768mr4547825e9.6.1766088919259;
        Thu, 18 Dec 2025 12:15:19 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27c2260sm56813515e9.15.2025.12.18.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:15:18 -0800 (PST)
Date: Thu, 18 Dec 2025 20:15:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 44/44] net/mptcp: Change some dubious min_t(int, ...) to
 min()
Message-ID: <20251218201517.2f2d91d4@pumpkin>
In-Reply-To: <cd5d45f7-0d76-4f82-849e-2f2c1544d907@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-45-david.laight.linux@gmail.com>
	<cd5d45f7-0d76-4f82-849e-2f2c1544d907@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 18:33:26 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi David,
> 
> On 19/11/2025 23:41, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > There are two:
> > 	min_t(int, xxx, mptcp_wnd_end(msk) - msk->snd_nxt);
> > Both mptcp_wnd_end(msk) and msk->snd_nxt are u64, their difference
> > (aka the window size) might be limited to 32 bits - but that isn't
> > knowable from this code.
> > So checks being added to min_t() detect the potential discard of
> > significant bits.
> > 
> > Provided the 'avail_size' and return of mptcp_check_allowed_size()
> > are changed to an unsigned type (size_t matches the type the caller
> > uses) both min_t() can be changed to min().  
> 
> Thank you for the patch!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I'm not sure what the status on your side: I don't know if you still
> plan to send a specific series for all the modifications in the net, but
> just in case, I just applied your patch in the MPTCP tree. I removed the
> "net/" prefix from the subject. I will send this patch with others for
> including in the net-next tree later on if you didn't do that in between.

I'll go through them again at some point.
I'll check against 'next' (but probably not net-next).
I actually need to look at the ones that seemed like real bugs when I
did an allmodconfig build - that got to over 200 patches to get 'clean'.

It would be nice to get rid of a lot of the min_t(), but I might try
to attack the dubious ones rather than the ones that appear to make
no difference.

I might propose some extra checks in minmax.h that would break W=1 builds.
Detecting things like min_t(u8, u32_value, 0xff) where the cast makes the
comparison always succeed.
In reality any calls with casts to u8 and u16 are 'dubious'.

That and changing checkpatch.pl to not suggest min_t() at all, and
to reject the more dubious uses.
After all with:
	min(x, (int)y)
it is clear to the reader that 'y' is being possibly truncated and converted
to a signed value, but with:
	min_t(int, x, y)
you don't know which value needed the cast (and the line isn't even shorter).
But what I've found all to often is actually:
	a = min_t(typeof(a), x, y);
and the similar:
	x = min_t(typeof(x), x, y);
where the type of the result is used and high bits get discarded.

I've just been trying to build with #define clamp_val clamp.
That requires a few minor changes and I'm pretty sure shows up
a real bug.

	David

> 
> Cheers,
> Matt

