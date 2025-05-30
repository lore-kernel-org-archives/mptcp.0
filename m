Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0A5674E
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574351; cv=none; b=aS3UNrXSA1SS2Gwfy2fZ+B5UYfHksfX3Nle2xijaVrqkLhsJOjvQrNMZgHrUhqKhe9MuCpYkqMr91T+7l0P88JU0UX7jnqmAjlJvqmTVIY5PX360hawst+/d8YGYmqy4YtvDggBUMYQXUksoKVaY+FHf/qFVjMzVXmSiBqngt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574351; c=relaxed/simple;
	bh=edBmpu2EbuwPVO0Ul9xbaj2VkJit3GU9D4yzE59NprM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr9KokLbA5HguEKQfyqIsdwrMGUt/TZyDvz1tfH99nu4qK8154E6omJcYv4S2I/PgPFDL1/FNihba4ks4CZZWWpsyHEf0Ojkg7o9Ojwtjkyg/Wm+4SNVCqB5NlUF4lmBWcuWG2fbn3bz2wMIUWTs3JIbwkBR0lhOoK1CSJmFyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmN8L5Mf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmN8L5Mf"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30820167b47so1348673a91.0
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748574349; x=1749179149; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmPcB9BfcVMhwEccIgDzRrLtI3gadYfq3Hb6mk/3dV0=;
        b=EmN8L5Mfbr4U2yTQhfA9Uy1djFJA+Rx1ilJqZuzfS5XzqphCZKkSJjAaBbCJGPh5Hq
         sNDqEDhuDpzmpfM5atAt3SGPCf8PWK7LuBGVuePHyrRDfWJwOvqE/i4wo1rRKhTmdrOz
         PbcX6WfoAGcg6gPaqiz+1y8JRUw/i3RlG3enc1JNsvvIG9PoNjPhEVMdUbk2poL5rOZo
         qB1PR8kkJsYKElEfkt4hybXV4fVWgbNMUn14a4dW+ySyos5D3gFiYSyjret64mnmDzZQ
         SWWSgWlv76VWcY09FUkvRS55EguK4BVdDGlgCQUFf/iXuUjxgZB/+JAzUSxEjDzdhZ5f
         HUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574349; x=1749179149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmPcB9BfcVMhwEccIgDzRrLtI3gadYfq3Hb6mk/3dV0=;
        b=bKtfMY4daIRTqyF2aNoZicgduIT80hMeI6Lb2hxFNyQ7TdLL5uMv6TboJQqwBkWVAL
         wvQe9CT1d1wmr9hyZ6rMN+4Lp1y9JkEiv87kVECbn4C3q9b/Uw4XFXRcB97//6d1SCW1
         XWWYXpkZmm3zA+S1h1xB3qlFjevsXEEvjTUGToj7WKpu4serVwXGgxRq8h8xSoZSEt7b
         zyyrUXoh/w56R3CwJOh/GoDy5eJ7b1XWmfWE1hFWK9wfGIx7fN+gz4kgypjcNq5SBWay
         bLgSh1JQdqK/iY+vnaLS5FzziXNjleBJMxp+q22dnZZrWgopYTXgBilfCE2xn226kYFx
         uYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPqpgU5/koN3B187dR/PaYeGeFYxIfCnZ8iBQhdmKwkfwa3/DUf3yEL1g/aZVOlf4ux/RgKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznho4b/Mj6fudU0vPI3HuJZrjlcPsJ7kAFxhsSJ3G1ivAKDtEY
	WnvuYbpFXDwZ0YDGap//APHLzQy1RZVno/1l7NQy78D2Zzd4eJ88jbI=
X-Gm-Gg: ASbGncuEjoTw9qUqOAS3rA6Kh0tQl36ibywpeLlWTuveQCfcfmGW8Hw7FZkj7/ZMR5j
	qyHXPAI3Nbj2RlWAZPqRPsj018ARJR3/K2nvKUHDu6bo7acWRX0FPnsjwLOD0gd998qz+20tbFx
	hePTW7kV279wH3dJt1PfkwWDynkc9R4F7IV3A2QYs06COmShj+D7Ch97STVf8ZLgnD86EOjUv5B
	ybFjd5d0FLw6rdviv6OmqoUH+iT2K1u+Y/7yM87snmpsNdsGhAw3ISXYvz1XHvq3N+tPA9nfdON
	ZhcY02qPCeNJf6D7atK2CnccnnTL
X-Google-Smtp-Source: AGHT+IEcl2OlOzz1UB82Nu7h/Z9cH4Jj1R69n+B/6JvMm9cqj47inVhScwG6zaOc33eUuhbAG+o3GA==
X-Received: by 2002:a17:90b:2f03:b0:30a:9feb:1e15 with SMTP id 98e67ed59e1d1-31214e2efabmr10028386a91.8.1748574349270;
        Thu, 29 May 2025 20:05:49 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e30c705sm244715a91.37.2025.05.29.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:05:48 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: david.laight.linux@gmail.com
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	hch@lst.de,
	horms@kernel.org,
	jaka@linux.ibm.com,
	jlayton@kernel.org,
	kbusch@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@amazon.com,
	linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sfrench@samba.org,
	wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to __sock_create_kern().
Date: Thu, 29 May 2025 20:05:32 -0700
Message-ID: <20250530030547.3218450-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529222911.37dc04f3@pumpkin>
References: <20250529222911.37dc04f3@pumpkin>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>
Date: Thu, 29 May 2025 22:29:11 +0100
> On Mon, 26 May 2025 07:30:13 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > > API and add a fat documentation.
> > > 
> > > The next patch will add sock_create_kern() that holds netns refcnt.  
> > 
> > Maybe do this before patch 1 to reduce the churn of just touching a
> > lot of the same callers again?
> 
> You also really want untouched source files to fail to compile.
> If nothing else it'll stop backports going badly awry.

I didn't get what you wanted to say, but I remember the series
passed make all{yes,mod}config.
