Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5739D3D2
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470896; cv=none; b=L8mLmOsYctRRO93q1igb47SFPBDTtCuWuQxY2eCF+glwJVOTKcnuBW6XIoscZkI7s5AQR3+V4sAZ/ZKpfj8ih+3xBbUrOBX5bBVPjJlpRy/5kMAspbzLKYGCADfyqTtfNN9qY07Tcvikm+7L+9RjxmcrcD6Pnv6m1LTAp0GBG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470896; c=relaxed/simple;
	bh=ffpjW/1ao5uOfJL2caeXtOfOe3lCo6EDWnFNXRPH3TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VoBJkxeC6imFPSfTOz6rN0fRKjKzfIc7T6TGy6CNGL/74fzqn0e1ku7jvFiq9PNZRWqYu81/mBGIJcAwZRhbzDbbpcq7TcxeYgI+e6V/b1COQEUGXg1VPRVccT0+69Dd9IkbfraCu1repsXy6gdyIbqHkRSW0o4O/q9c5ZeFGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OerXnFJA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OerXnFJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780470894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSAUuZaeAONur/qKXUZlk29/oCwJLGm7HRbFOQzMJDw=;
	b=OerXnFJAxYppeCqjK2tzzCQtfT6IbheF+BekkqlXa6s+oY6BQX5wT58nKSn7sIUGmhOmOk
	j39FuTKD6vXoN5Vr0EhgNsunODJ8j3szg2+Z0DtBZyds4HC/IJK+rCrP3Pnd2Amcvo9Fwr
	JMSZbBMnDAslv4fgjAz62APCie0RD2Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-JT4iQfhnNXyNLAtS8D5hkQ-1; Wed, 03 Jun 2026 03:14:52 -0400
X-MC-Unique: JT4iQfhnNXyNLAtS8D5hkQ-1
X-Mimecast-MFC-AGG-ID: JT4iQfhnNXyNLAtS8D5hkQ_1780470892
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b71db390so2749645e9.2
        for <mptcp@lists.linux.dev>; Wed, 03 Jun 2026 00:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470892; x=1781075692;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSAUuZaeAONur/qKXUZlk29/oCwJLGm7HRbFOQzMJDw=;
        b=ITVmf8LCxDYSAi052aQdY1bvLyC1/UT/yFQrqmGi5Fi44ptujihRTLs/NFWxGcoDt3
         Ia5duu2boxfaNO1eC4iTEeHlPWixdP9cbWdflFQ4xWXRaP8TDByyryA93PHUElr75e+i
         EyH2u4XNKCnSKg9y9ECFz7mUc1cXL1hPDGhRoWR4ucGyHME/aZnQleBjrZUPzw5dk6MY
         HS7b8dItdGmH33sAGwfgjp2zU+gg2LJVzhwQ6k3q0BeJbR9nm7/GVL3XpKwH727osf9F
         R7kn6kdoW94LrjUoCJIC4KLpKJ7PcfrevFcPGao5RD4meFytfmwrst/qI9KHh5bZOyq9
         XOrg==
X-Forwarded-Encrypted: i=1; AFNElJ9cf/PucPQHX/PDI6FRPPMEDTdRjQ7GOrQdF57/wG93CAOjBazPHiwh2EHW6ffANesC5bgLCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ5MpiH3pHlYW1ZnUbRiLMDxXBPJ8QdKDIJA3PK1zprCZj+GCS
	iyqsj6PLCgxpvWOLS5mJCwJZ1N3NULxG8U3v4f2vKzzNxXsaoPBJDkSk1a7bPWrq3nlzWD8R2p/
	fI0v8jcnWlXDHhA47e29vsUoH8ustr0UjgsM+AxzihgCIuhLZetGXZiQqMLFRYlvq
X-Gm-Gg: Acq92OHH3nBWpI73Zc26XGCJWmDC+pwtCJIjdY7BHHI4DOq4UNiLqbDX+oUBhAxvLc2
	lODyY0iiLifq08rJjJkqsoYoELH4nm254JRRRI27lVp+GQ0gHi/jbgXIbKuPjF9R6k5F41nqvHo
	7jr5I8V4xOu7BZkTaVER2eq0yMY1bUqDMDSA3ODEUWmOQJ/PQC742y5k1U2wg0j6x9wa86dCt/v
	wNBlcL/+RshHZN1rFvxPx2poI4cBMV6ChiuVjy6jfG6MqC7BcJwGnOycfi8cQykXYk5byZODtjK
	LyIgdX1Z6p/hfqKdlmJRChGdsKzaj2q2Zqir9XlPL/7V/c0R2BM+4CfoYz0/207Rv8QmNq6mu4p
	4+nyDb3ShN+j2m36HeN+aYMZR4gTHV6Ge4hqWkwALdSngEv3zs3buaO28V7bz8laXm3I=
X-Received: by 2002:a05:600c:4fcb:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-490b60ff366mr30274685e9.31.1780470891574;
        Wed, 03 Jun 2026 00:14:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcb:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-490b60ff366mr30271475e9.31.1780470887829;
        Wed, 03 Jun 2026 00:14:47 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e76153sm124279015e9.11.2026.06.03.00.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:14:47 -0700 (PDT)
Message-ID: <c6d3caeb-ebfe-4acf-9482-41f7309a86a8@redhat.com>
Date: Wed, 3 Jun 2026 09:14:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: implemented OoO queue
 pruning"
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
 <94176982-9a7c-472e-9328-3e95fc586e73@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <94176982-9a7c-472e-9328-3e95fc586e73@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GqG10V4m2aP6kv_auevOotKssTgX6SUpiPt5h_xn8rY_1780470892
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 1:21 PM, Matthieu Baerts wrote:
> On 31/05/2026 01:08, Paolo Abeni wrote:
>> Sashiko noted that mptcp_prune_ofo_queue() is 1 byte too restrictive with
>> the bound check compared to the pre-existing code.
> 
> The CI is reporting that mptcp_connect.sh is now flaky:
> 
>  - normal:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26704613812/attempts/1#summary-78703396420
> 
>   - debug:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26706355990/attempts/1#summary-78708269694
> 
> When it happens, MPTcpExtRcvPruned is not 0.
> 
> I can reproduce the issue locally (~5% of the time), so I started a
> quick bisect running mptcp_connect.sh, but only MPTFO and disconnect
> subtests, in a loop, 25 times (maybe that was not enough). Apparently,
> the issue seems to come from:
> 
>   mptcp: implemented OoO queue pruning

Of course :(

> I didn't check the intermediate versions without the squash-to patches,
> but I can run more tests if that helps. Do you have a rough idea what
> can cause this?

Pruning drops OoO packets and relies on good mptcp-level retrans to make
forward progresses. In the to samples above I see quite a lot of
NoDSSInWindow events - presumably happening _after_ the prune event.

My wild guess is that MPTCP-level is not yet good enough/trip into some
corner cases. Possibly paired with pruning being too aggressive.

I'll try to investigate this.

/P

