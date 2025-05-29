Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAB24110F
	for <mptcp@lists.linux.dev>; Thu, 29 May 2025 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748554156; cv=none; b=UxiVpn6WImxBNXg5cK7/m4rRMWVYJHnmzLh8UWwRGwWlDojyxRu6qwrl87wR8BIKsdWv1je6RDeiIam3bp2ln6ojaotOr/pzvJs3jgoFRyxpatKni/rkBHwARg4I9mQ1A3y1rLX+j9Lco8EogsGoZuFA6VRO01YXQ0XHFCFZmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748554156; c=relaxed/simple;
	bh=Z7YYvdU8l1NsqGFyiGTHFFAwNt4oUnYsGMlfLS7rMhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWtKSsuy/SuSWwW/+7qFQ6+2T5MWkZqPxk0ESKoBNSupzBvUGBWXq2cfJ+RmlaMR1PtEMgs91F9q9oiwQ2pa3R3K+QgmOxsXvLYTtMXy8pFnswx/R7zCvGR+9H8r7zLju6xhj6Evq345ShRey0lSlkoypQqyLdNTtgNhU6GxS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3JE1rgL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3JE1rgL"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4f71831abso353282f8f.3
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748554153; x=1749158953; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U85oeX4MkrW5FWx8nWXUgVEfSLqp8ilr+jmCQrjfSfs=;
        b=d3JE1rgLaLh49pyXbwtxBMTPqOt2How1ee55qmOAvmA64IOf/X3jDTm/MI5XU4BpuY
         MznkEwtq3p2qh0E3oNeYPsWrV0DlWaPDFSZYtJ8Pgk4MWltuPVKVgvrbvkGZYEe5rIzU
         5QKTBApervRIqqw2Bij0ENgq92Nz4bfzQCCV1/0JUjPGEVy2kHP38OAecIpeS18vnSTD
         BI39S2lunkQ9hrih1wuEfertbtkgpalO7u+zNLBsgHQkhb5dCPNvdbzj2/rtWgyIae3L
         cks1oBzkZDY4rKIIad2nFh7rcKx2A71DOhInXOQJ+gO5E6VbaZQaeGBSwB6Gi3x7Z+7Y
         gmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748554153; x=1749158953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U85oeX4MkrW5FWx8nWXUgVEfSLqp8ilr+jmCQrjfSfs=;
        b=aOvAPx+70SElg0J3T+GcAZI+0xfKVQt0t34ZebN8uhJ2lyJJ5WONyrKBGySM/hAn+B
         HWRrb0JKuL0AWGSzAg2pGFb9j4KCrpxs+aevgP2nitmtzsMO0ZQcA9qfcGkfOypvAmzr
         Hyob+bIrqb2FAakI0JH5/jwv6BFXdXFQGfeB18EpQpNjN6veRr1EWxxVetwO/G29Oy/k
         391CkjVBwDBNb4ZrTgeffsm/bCBhJcPkE8/48sFmeXr2Re9O8fBio23oXbg7Eftm+RmG
         DxQFVWcMsA0V8X6uDit0znfh3UVo4ljgaR7KH2S+VhZAhUsWboikXFq+6QsSA5dahHUS
         7yYA==
X-Forwarded-Encrypted: i=1; AJvYcCXxN4vudnUezr0YnAQfszrnSXGms4g9gyC5Xd6N+LxrMKO04lqzX4j89gVh4DQP+LtzWpivBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7bIrZzAighgCaqv4YNhQ12u8ZX4m1nnDmHWuawqhRdW1D9/uH
	OrAl/nsQrMMhsqbtjTAvU2TKDPkGwZiaxT0nqewr2O3uFVuS6GLRAZ+9
X-Gm-Gg: ASbGncvjtrz/YBpzmYBjoiaI1tqaEUbFiN+Y8mN+yC6IlY8I1de5AsVqbtndzyfY77z
	UitGNIA7YPxlYCjRyH7UgLri3d2N62bIjV37+aQK4uxDSa7FnoxaAYmxf/aIDPw4x5eXqQAbB4V
	G5qQ+75H74RD+Fo8mnPH4HYPEF38TNlzJ+6dVGmj8gEDU1+Y+RNcx/Buy+Y7tPpv1eFykcT2sRu
	y8KcSu+LNojV5+agPN5/PpjjggCd7vGkQZYRZVRGjD3V1vLCAkHlM+UDyfX/i5B0wkEgrhOP8S5
	FdXiWGropCtnz+HkxCVZRFwnJIxcTr4tDTEqlyEsv7kcMmw0/pD4yyuhSRkYLEjN65rSb5wkkGc
	fz92Y/EbJqokS2g==
X-Google-Smtp-Source: AGHT+IGT6Wwf7gVpUfM1Nqzr6escLgno2IMcSQrRw0Uy2H2YCSoD17fP2R1YZIFdVF1bLqkmaXgCqw==
X-Received: by 2002:a05:6000:2891:b0:3a4:e706:5326 with SMTP id ffacd0b85a97d-3a4f7a23e5cmr643811f8f.3.1748554152539;
        Thu, 29 May 2025 14:29:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972b5sm3085052f8f.76.2025.05.29.14.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:29:12 -0700 (PDT)
Date: Thu, 29 May 2025 22:29:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Steve French
 <sfrench@samba.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250529222911.37dc04f3@pumpkin>
In-Reply-To: <20250526053013.GC11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com>
	<20250523182128.59346-3-kuniyu@amazon.com>
	<20250526053013.GC11639@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 07:30:13 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > API and add a fat documentation.
> > 
> > The next patch will add sock_create_kern() that holds netns refcnt.  
> 
> Maybe do this before patch 1 to reduce the churn of just touching a
> lot of the same callers again?

You also really want untouched source files to fail to compile.
If nothing else it'll stop backports going badly awry.

	David
