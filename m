Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470110F1
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587716; cv=none; b=h4lo8c/Vq3tB/NUjJ87HDaMa7xaXnawZIR6CEUjnE9283hWNGUq322tXlraxfdYa7deHK1PZ0Z8QBZAao7yF43Ua53StfCAosfTjqkMRFb6Ca7nTcKWFgWDjcYJNGXidE4qWko+M5+6W93wQSfa/IX2zwcfTyZAynmSfBiTsFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587716; c=relaxed/simple;
	bh=OVd3ccRRjSS02LwNaHgCfZgft0/Z3cxj2pi99iPumfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJuwGwRPox/L5owBjz25mo3jU5iMJxHyWYiLNPpPIDWLvTme+AFuPNY/n9sLfgwdtJsgRDpU17Akxw0qtHAMd6LIiSD4U4vVAVs+qtW1B0TOhaUX+17nBtXv56lMiJ5v43iHDgAyJOPtRg1rz1aXD8N/9X1FviNanq/8Ic/sQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LApCeUmw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LApCeUmw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so13832275e9.3
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748587713; x=1749192513; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXeEHdd/ecLGSL1wJsbS0R4oTX9iPXHDhaZvp+4M3y8=;
        b=LApCeUmwXRHojcybKW45QoKQ34p18hBkVVR/GQeEj62WAd9BsXLQE6de4sf6DDQe2b
         zEeIyq4f5ynrbN8BrVSR4Q9v9Fku8dWqvSRq3Yd65drCejV+lK0DvanyCUMxn6mIao4Q
         Jd7FvSiOQz3EZ7PXdtuVXpQmH0XXwevmnFlOxkLQQTt3vIDaT1AP9CNYr+rTJgwhUtQX
         AW0sZgQ8HzOkmYMf2bhK4oGK0o3NoJ8j3O5/JQRtRNjPIL5mZ4J1YXudFHhv7HrBYxxp
         qlvnruuUQrPd05czKXvSuZbvRTn2kHXcfcb9DQNkybj2FattfVZSnAKXIjJ6zRw2LsUq
         rIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748587713; x=1749192513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXeEHdd/ecLGSL1wJsbS0R4oTX9iPXHDhaZvp+4M3y8=;
        b=MN2hAaGHy4l9JirElRwaiF1KZFKWJp6Z7qjC/srGEIszav/z4129ShzGZAH4u2/iGr
         t7m6P9LFLB69KVk1/4sZtDa51moprmJwy4MK6/85fzqtcihAGIxivQYXWfk4UgrAhZWl
         h/SRdHMEuNegk5VYAY8gb4ClDRi9fr4idfb2sAieYXBbPtkeUCPfwD8D1BThhnNIg/M8
         dyix++LHAK9kiuY5bkALMfAVNcu/9e899/P1VyunAADSDfY8OW5bYhBMDKPApbedBpYz
         TFcdnTVMYvRpHyLT8kXk2Jyr5mrg94EZlPFzzvq/mZJdswvUvnOjO/IgDrj9si1pwnU9
         cJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCX8IdPpRir1nlUrAhdQ4zrOfiEgk+WswHgNNohqELJY3glq+oClQtuztFD6jT5Wl1BjirHtrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMwDqJTgVMZ4E9glpH8OBB9LBprIps7iEC1g+87KZjj84sMt1L
	2xaJPI8nbvd8d9tIoT5MT9Obnv8RLbn9elkZAgUHylY/sbJkMhnsqfXK
X-Gm-Gg: ASbGncuZWhDR7pvHsja4qrBcTh83lLNUgPGyKDL1tj/G4HHgJBiW7Wt9q6D0C8IhDQp
	2j1hTSGu8rLZCH4tozztE120OruINp7bPsiHWUglRJj45tLCrrf31OGmUW9EwxWZEYCyUq7XFTV
	nAktQ3Q7Tu911F1zsQCz1eZhN0iPn1mRSMwA018Vhku6zIEHciyKU+PPWSdvhPS/asjiysMpVGI
	0N05VrKNPwVZLBkdT5MnbU0gNKV416f5ipUnVjeAj30j952Y+O7uHPCrOGy7D324Bc9uE+IGT4l
	A4SQ9LYOqvxH01aIvDaFIUtnFDw+PbW2Tr8oakAGw2bGqJTcAzbtdlp9nOa+C79ApvNGcqjP+G1
	eVnKuQvb1arNiCw==
X-Google-Smtp-Source: AGHT+IEaRQdrIbq47i1uTvqrOh3GYrjs1EZb1ZDSE8bNiRbo3NGeAP5Bc1VED5/Muuf7IvDxzlUr8A==
X-Received: by 2002:a05:600c:6219:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-450d64e0553mr19893275e9.11.1748587712835;
        Thu, 29 May 2025 23:48:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edf9sm9120305e9.3.2025.05.29.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 23:48:32 -0700 (PDT)
Date: Fri, 30 May 2025 07:48:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: axboe@kernel.dk, chuck.lever@oracle.com, davem@davemloft.net,
 edumazet@google.com, hch@lst.de, horms@kernel.org, jaka@linux.ibm.com,
 jlayton@kernel.org, kbusch@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, sfrench@samba.org,
 wenjia@linux.ibm.com, willemb@google.com
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250530074831.76fd3931@pumpkin>
In-Reply-To: <20250530030547.3218450-1-kuni1840@gmail.com>
References: <20250529222911.37dc04f3@pumpkin>
	<20250530030547.3218450-1-kuni1840@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 20:05:32 -0700
Kuniyuki Iwashima <kuni1840@gmail.com> wrote:

> From: David Laight <david.laight.linux@gmail.com>
> Date: Thu, 29 May 2025 22:29:11 +0100
> > On Mon, 26 May 2025 07:30:13 +0200
> > Christoph Hellwig <hch@lst.de> wrote:
> >   
> > > On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:  
> > > > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > > > API and add a fat documentation.
> > > > 
> > > > The next patch will add sock_create_kern() that holds netns refcnt.    
> > > 
> > > Maybe do this before patch 1 to reduce the churn of just touching a
> > > lot of the same callers again?  
> > 
> > You also really want untouched source files to fail to compile.
> > If nothing else it'll stop backports going badly awry.  
> 
> I didn't get what you wanted to say, but I remember the series
> passed make all{yes,mod}config.

One effect of the series seems to be changing sock_create_kern()
so that it 'holds' the network namespace.

Now if I backport one of the changed files to an old kernel version
it will still compile but won't work properly.
(Maybe you've removed the call where it acquired the 'hold'.)

So while the patch series bisects (assuming it all goes through
one tree - and it really needs to go through several) you are
relying on any backports picking up the changes.
(And also the changes to sock_create_kern() not being picked up
without all the other changes.)

Now backports ought to pick up the required dependant patches,
but it is much better to generate compile fails when patches
are missing.
Obscure run-time backport issues are annoying.

	David
