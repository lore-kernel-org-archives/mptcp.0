Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482051A8405
	for <mptcp@lists.linux.dev>; Tue,  3 Jun 2025 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748986233; cv=none; b=u9LQFiDXXLTdZyRlhX0xqClVsfzkDiue23VgiR35loqWxcp5W0XAweMa52ncXBDtYF2/WSzzq4yaWzwHUimrYk9IXbSAoTLLpqzWhnhpHylmiZfqesj+ZT3FSHRYif39xQShpLPxRAD2w4+NEg4FvDvN7z2QvshQVm7gkdrxRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748986233; c=relaxed/simple;
	bh=WtXvKVt8VUFg8MytFaKsTYDiNoeFxLn1B0pT71jfpH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKSBEj7j8yp4zvsyfEbe1xAPXstmbZ6W8bS0GEm85T6YFubes9LGoKAjL4xZ0adnp/dfQcVHJjq7WpwpePjcm846zzTKrhUVbboQy0mMjyYmTQmCziq6a5WBWgjJqpLmudB0mkkl+MsMab5q52iWIti8ynrybe7zfGVU2xWb41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWArUsNk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWArUsNk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so1656484f8f.2
        for <mptcp@lists.linux.dev>; Tue, 03 Jun 2025 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748986229; x=1749591029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXpXvTT+xQLNA8z5uAwvt4SF8j8NDZCMNmC9o8T6C+4=;
        b=UWArUsNkYPpLm5HQRTcEALJt1n4usCIFjwl5oXau2MEF39PWppCAbtOy/8an7Y2BcQ
         VG/H0Nw8LUlP3wUI/ZDGUDziG6S/QZsrPSV0aVwGuNu3Jml3VntfbgpD/DBl61XC+BFF
         EcP9VGbBPfV365SCrB8HVR4+SXjdsukQ0NUZchmeHgr0nEwqTbYQiZBZnJgMh/TXvs7C
         RaaHl68CShAv0B6fajm/uID8pz9oeJq0sycdC75Nel+n0gZxEx0lq/R7mPFyeS67/ZEu
         ZY0BbhZ2tVMKIO6c66wL4y8nuVUMLaNqzXw4yL2/qn0uS7KKuPutlul5O5vhc4lGkkrF
         UUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748986229; x=1749591029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXpXvTT+xQLNA8z5uAwvt4SF8j8NDZCMNmC9o8T6C+4=;
        b=TUkCUAOVkOmUHqYnTb5vbtzAKyF0kyvD3fABTdNCw5Sttn5KLymPAPnGVjv9F8sMZb
         lwvOiGvXaMMCHMwJv1Twu+gDlmE2xZrtvBXaiyxMeRcoUYwSOED+4d0volDUhhlsofMF
         lbCDkqpRGLN0fVEWPKlbAl23NPvDyQypFI4F6V4efpU/3urQ9FUf/ZZ0NbXEBXMNlrzs
         GrihmBQ/X3DYfcaBW33eav2MJZxaf/sPPQzMGc0lR7OlhdIShRxWWBO2LrZ0/oAmYSmY
         Vm7sHocemRjwb6nCL6n7poTf7Zkc/6EoDYFqiwkwPxJqE2tRxfEy5kaH+Hvir5fEdhJP
         fu+A==
X-Forwarded-Encrypted: i=1; AJvYcCVUKlgIETRNKUD6pra6LNxPnjd1ucZp6M9nokTAe+fHFw/t0hHDkg84EScz6ziCNKJ7OeaDIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwREdXhwhvT7LgDrEIOa/y8hCpbDywI/TXssGY2ecGshcEqU1mP
	d0BGA46E5MVGLOvNV4JPI8aLknH1aZTdAEhdLR8CowImKg2vmlLtA1Op
X-Gm-Gg: ASbGnctzofZG2vg9Sj/XRenn2c56z8n8OPfEK2BWH6ZBJxI3jDub8hcS3uKHyxS2qXA
	7abYhO8F8/JzuU1cqXHbuG2lEcQygAaKS0MLvfmtxmbp2XLXE4mghXHQ+OC1eShD17FHGr5S5AH
	k0yz1GvkoW7zm8O3wT6KxQBfVlE4Kh7V6gUagrrRZY65HDXnF4xn4iRNt5Zl73m00PunfYfarcl
	p+F4a1pW2d3xzEkPPid7pVDieKRs6UVZ98/6L5hT/8lR7QTzcT21eAePCMkY9HC+b6oOfn2VR53
	7t3t1+wZLf6AiFUOOwa6fvVbEgD+fyIiSRbmEgxeQfPNfEA5DXf3t0lcfKzeLkC0+bzeOsQuBV7
	iFHCHtL5ie4itdg==
X-Google-Smtp-Source: AGHT+IH1NNz0bB48MnqJxgA4wHuK4JMchNfQmyjWht3RVt89c59AQFv32k+Eyv977zem0/zoGPmy8g==
X-Received: by 2002:a05:6000:2303:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3a51d92f833mr253946f8f.24.1748986229347;
        Tue, 03 Jun 2025 14:30:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b79asm19084051f8f.2.2025.06.03.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 14:30:28 -0700 (PDT)
Date: Tue, 3 Jun 2025 22:30:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, axboe@kernel.dk,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jaka@linux.ibm.com, jlayton@kernel.org,
 kbusch@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, sfrench@samba.org,
 wenjia@linux.ibm.com, willemb@google.com
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Message-ID: <20250603223020.3344d362@pumpkin>
In-Reply-To: <20250602050817.GA21900@lst.de>
References: <20250526053227.GD11639@lst.de>
	<20250530025401.3211542-1-kuni1840@gmail.com>
	<20250602050817.GA21900@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Jun 2025 07:08:17 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> > In the old days, sock_create_kern() did take a ref to netns,
> > but an implicit change that avoids taking the ref has caused
> > a lot of problems for people who used to the old semantics.

That must have been a long time ago.
Was it even long after the namespace code was added?
(I don't have a system with the git tree up at the moment)

> > 
> > This series rather rolls back the change, so I think using
> > the same name here is better than leaving the catchy
> > sock_create_kern() error-prone.  
> 
> Ok.

Except that you are changing the semantics again.
So you end up with the same problem the other way around.
I can imagine code ending up with an extra reference to the ns.

The obvious name a a function for general driver use would be
kernel_socket() - matching the other functions that were added
when set_fs(KERNEL_DS) was removed.

I definitely aim to end up where the existing code fails to
compile - just to ensure all the code is found.

	David
