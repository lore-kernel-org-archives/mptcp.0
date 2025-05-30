Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D018DB1A
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574193; cv=none; b=MDuaa6jbrWPXMJGvhxi30Ve3QJENP/SqGCKTbSQ94SDv+eTrHEFPu0pMc4TyLEvGCnIxOo2OqGQ00E2nqmhYmet6MAK5FgA1ZK8ORaHSWkwDmJcC1ncrB9WNraLWU2OL2kXEcscCxbKi7EmRQrupPieA0Z/Rp9oZjQV2aJgD+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574193; c=relaxed/simple;
	bh=fY2UoOoy29T8fOuG69Jaaa5QTGzSPBb8NXLKa12HEWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nqb4TgJWapMpRWTxx5XCtZYoOa8+Ul+1EB+RQU5lj5glN0Yh+0eMsplLa7I5vXIPbEjfI2cMfMqecc/bBh+Bo0m1WUyIqSd91nS14fUxoA8oYmzq7qG5hz5k4ozcITgipy/iWkgIbeJQTsXdwzVTj9yC+0EWjXudj6hXetZiAmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFxLunTb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFxLunTb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22d95f0dda4so19513165ad.2
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748574191; x=1749178991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byg1If193eSOY1N2Dud2MuR4SUJwfFVbrArGBlUduVk=;
        b=HFxLunTbUJpav59EJXgNG/NDKZP5lC1FcD+Z6cIAssdtugllw42Pw/PUafB3KUZhln
         T1/PLh4D7+G8WRBOK762FuO2O6gGQIwX1P27ZY8Pnu1a2qlWsMvD9fIlGrfnxFDzv+e9
         lg/sih9XcKa3vXiXGpMiAsOYwTEa9rZAYpjeGBD9JOOK0NhK5QTKh0yJ8W1OxUY9Ya1g
         TZvAatVwKIiqs1fERPnjv6QcwntH1ZcJHJ/ZVoNLnynaL2aTO2tRdHABT0JkJECDyp2S
         cs9EC7YRj33TooFKQ3J2ygYCp2h8t1cQREt+8vB18LzUdoycBW+JKeJW2AszPqvdj2Da
         O3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574191; x=1749178991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byg1If193eSOY1N2Dud2MuR4SUJwfFVbrArGBlUduVk=;
        b=cv56hpknXmF0kC9dh2wAauX4sejlKVCbu/8HKAqJV0dZY1nzcTRuqMUl4E2VGiQOD4
         CIaGLe+fl2aGSshITflouIasu+gUIxbZlJSLwoJ0ghFDHKwjAx5ivUNbsBqrFeELZL1e
         tV8N9cEL+diQHBqYLybuOh0iBOLKk7V+K5AYb6e0IZQhzz/LzHqaJgyBECbT63axeSIN
         noDjZYJxet2je/Ci0kyHT5qqQLsr4X15mgS27RcbxjNr/F9uT8QGNv/5VRLVv9Fb1eoZ
         epg7Th1MXOYOAbEUoCHrzYFEyxXTfbO7ktjXJc7lI7E2K6bxqfBx9w7Lda4q7WYPIdqa
         OlSA==
X-Forwarded-Encrypted: i=1; AJvYcCX5GXkKCzLekrzVhhBUEcLTsdYV/fRUNCpuPOBbGvFI1hGnQvY7MHecX5E5hD8N8QHsa0QoFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxao/CJmD8Ckf1TTFnyM+g2pCTZaOb9EcVwRUL9mRCEBs1rF4vv
	AbZBTu9phTAZR2ha1+4dQnWpTJr4YgOn14GCVjoFpZGSUBGaUqgfjuA=
X-Gm-Gg: ASbGnctpYwI++Oia87obGEfdXdO/GlyMnTlXlBAVFPDWDm3Mw17GDZi04T6mNyJTuBE
	BMAL/pIG/BsHnyRnW/P6vrAEclhsoTfbDm3SmB5xyC7Tj41iegSTMCbtLRW5OFuczEfhXEKrR/+
	KSutvWeMqCNcpQtxP4fdPiI3FA7ShH7y7NZL/5pjlbTZmS2MJsqiiuAK9BtkfdK3/2B4dnzVlSb
	I2xBsiN7HhMFN1Uh9iaU54ZsdpMme8D2jILfFqddsKFCz3+cWmOW90jkzG+xGydshCT/wbhwe2V
	Fuz91/w3ptqHxtYzKUl0woY+MhhrRKtIzy0WN78=
X-Google-Smtp-Source: AGHT+IH5+ZA6UonngWZ7LBmNIn34EiLQrTu0vlE4C8gBCmZnRcJjAS0SauUD8I/Jj4mLKSLrtUkOQg==
X-Received: by 2002:a17:902:ecd0:b0:235:5a9:976f with SMTP id d9443c01a7336-235291efe5fmr28715135ad.24.1748574190723;
        Thu, 29 May 2025 20:03:10 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdc5f2sm18964755ad.96.2025.05.29.20.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:03:10 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create() calls with sock_create_kern().
Date: Thu, 29 May 2025 20:03:06 -0700
Message-ID: <20250530030308.3216933-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053555.GG11639@lst.de>
References: <20250526053555.GG11639@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:35:55 +0200
> On Fri, May 23, 2025 at 11:21:12AM -0700, Kuniyuki Iwashima wrote:
> > Except for only one user, sctp_do_peeloff(), all sockets created
> > by drivers and fs are not tied to userspace processes nor exposed
> > via file descriptors.
> > 
> > Let's use sock_create_kern() for such in-kernel use cases as CIFS
> > client and NFS.
> 
> So if sock_create is now almost unused and the special case, should
> it also be renamed to make that explicit and make people not accidentally
> use it by default?

I actually tried to to do so as sock_create_user() in the
previous series but was advised to avoid rename as the benefit
against LoC was low.
