Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBF17548
	for <mptcp@lists.linux.dev>; Wed,  4 Jun 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062257; cv=none; b=cIwsGmUcaEhulk3jwuPvB5qutqvMKltKy5yFHVEXcI2VU0mpOG2CcazJY2bJRLlcKawmY7bIphp0ELOj8yKx/9dHyfOtIBt8ce7713gok6bUU2pIZCONtuIdYcAm3Zc51aLJiH7V0ajT030nCIvJRcVjA3EcTeJcuiyy/Zp4lok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062257; c=relaxed/simple;
	bh=kMacitpLXMv1GwpjR46stCcXET1RA/LYFLgeKG2ri0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NufkR24cZ5svXpKyzZVvxK3DEkur7RVatpHExwoCRgCiau1L1Nda70TwlLUYgPdnQSCkL1PBUw+U2eXRAH5D6eKccBR31esFmecm37coM7CLwCs+M41Lr7EgwiLQRTUqpa06lSP6If5MY1HKgbAdxi89m89tsKzt90NJ93yhxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To3aM7r6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To3aM7r6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234fcadde3eso2124335ad.0
        for <mptcp@lists.linux.dev>; Wed, 04 Jun 2025 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749062255; x=1749667055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMJKoOEyvjYK7yMgj6XYrB7SCgQJhbeYmY5wKASLWgQ=;
        b=To3aM7r6HAx5ccDpccOBBwVPeau5R7T7hD/foCY62dWRCGmKreHZIcABv/VqJKm3fA
         yCKrPKEaGrP0oKAoY7+eZ0bbaPQgqmv72JQGEjr2EwY5DIs4lj1QNs2S05FJvHHHe1E1
         I0t8wGP3FO76blzyKDOgV0iTjQ+vz3HbITrmI8Vmu2+hOnNVaXbQKcCvngfCa+c36KdX
         850DyPRowkxqRvhZZzqTq6C7jo9aUe8nBXhCM2cO/nXI2STWdIROaDr2/6DbbZLqHRx/
         6rw8fz6cM5/vaoKVTOcL+6SYq+LLFcPEU+LLDS0ANds+3zkLQdMrS3nPwW5yZnhjTfin
         w7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749062255; x=1749667055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMJKoOEyvjYK7yMgj6XYrB7SCgQJhbeYmY5wKASLWgQ=;
        b=A//ZhBHB8cXG9z2O0UrX0RKjHuUftBPKNAKE5FHMxYP7ZAcdxc9e/YJcxHKrZWERqk
         F9ehFYJpYEwKSsMBiBvjCW2P0arbViwdQAk04rQcEzIRohm4tbus7VSRizHrz+m7dVF/
         Ejj4RBweiOAEodgvb9qgOM/AUldihRgSc7ZNDcpMKzN0fXe3Fx/5xGz55amays1e4Pbj
         F45xzv/2gPmNhF+4DyUqNNi6S8DPG4rZ7fTsOkc3feHTCvNW0FR/QsgKEWqx+iipQA4W
         fMTNDSUtuPhZD2dfp1r5gb5dk6S6DJV8hHtlN94lkeaZxfSH/y+eLjBux25JDa+cpgWn
         XXiw==
X-Forwarded-Encrypted: i=1; AJvYcCXcy/s/XF1X7doplBfcmve/wtyCxFnmhJv1SZR0SFUxvsKp3wEx8qKxHp8VONoEdrpR896fYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8QDhGjUNbRHgGHGMui61TNGudAOCoD3xX5wfuj1QpimceSmPM
	BM9Y0G6s/RmD4ipn7AM3IhQiTTMGq8hKWpwOIngV+0+mE26XqfLsi3A=
X-Gm-Gg: ASbGncvWqbpXYQ+FpC+FyAKMVXJhVD6utuGnnYsYybX9Mxs/MsUSYo89vw8dvBFVl7l
	F4vr155XHIRuD9pv1DhCvI9ccyTs8i0AJZpjoJQGbuoHUQIoXw9okBZjRbmNHoLivJC1JjIPGzf
	9yMMXGTdjMhg3UEoYl14s7+qUvZcZ1Vi+54KTjgerL/EpkYHSHsmdMdY4ubJPz1DLVbg/eXPGrl
	Hw1AmY2QUdIaGm1t2WAh7RacVEa6Z82KMznNHl/DyM69re3ltGnG8SGvg7AXJpDgExdW6Izjh9V
	jCvzx8+r6bPx64LjjGYhaGImpMNs
X-Google-Smtp-Source: AGHT+IHzeMlOG8WaEKyWojPC70HY/eTfvQSuJDc6Tquqle6do5jo7DuCE23TvCyOkWhB0uyKaHd7DQ==
X-Received: by 2002:a17:903:3d0b:b0:234:a033:b6f6 with SMTP id d9443c01a7336-235e11cb901mr52517545ad.31.1749062255383;
        Wed, 04 Jun 2025 11:37:35 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c63sm107254965ad.241.2025.06.04.11.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:37:34 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Date: Wed,  4 Jun 2025 11:36:43 -0700
Message-ID: <20250604183733.135820-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603223020.3344d362@pumpkin>
References: <20250603223020.3344d362@pumpkin>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>
Date: Tue, 3 Jun 2025 22:30:20 +0100
> On Mon, 2 Jun 2025 07:08:17 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> > > In the old days, sock_create_kern() did take a ref to netns,
> > > but an implicit change that avoids taking the ref has caused
> > > a lot of problems for people who used to the old semantics.
> 
> That must have been a long time ago.
> Was it even long after the namespace code was added?
> (I don't have a system with the git tree up at the moment)

2007: 1b8d7ae42d02 ("[NET]: Make socket creation namespace safe.")
2015: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")

It's been long since the implicit change, but it's only _recently_ that
people started to notice the issue thanks?/due to k8s use cases, e.g.
fs mounted in netns (ef7134c7fc48, 1be52169c348 + b013b817f32f, etc).


> 
> > > 
> > > This series rather rolls back the change, so I think using
> > > the same name here is better than leaving the catchy
> > > sock_create_kern() error-prone.  
> > 
> > Ok.
> 
> Except that you are changing the semantics again.
> So you end up with the same problem the other way around.
> I can imagine code ending up with an extra reference to the ns.

I don't think so because it's rare case where we want to use
the no-refcnt version and it usually happens under net/ or
drivers/net.

Now we have SOCKET entry in MAINTAINERS so I can add sock_create
there so that we are always CCed to prevent such issues.


> 
> The obvious name a a function for general driver use would be
> kernel_socket() - matching the other functions that were added
> when set_fs(KERNEL_DS) was removed.

kernel_socket() doesn't fit here as kernel_XXX() takes struct
socket, not struct sock.


> 
> I definitely aim to end up where the existing code fails to
> compile - just to ensure all the code is found.

You can see the patch 2 renaming sock_create_kern() to __sock_create_kern()
does the job to find all users with the help of compilers.
