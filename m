Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C558633F
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573981; cv=none; b=DeiEYh2kHyEJmZg56jEaXsaZxUHrR4gu5n8x3nfQYq0ZjKTLr3IsO8oDIcUGHoTTEkXIphULVXAktofM6KvK3Q0dKo+7I2dUqY1BaxEkjlsNRzx6513wsOEX0dj18fNBZyHTaF2KLqnPHJfIxwObkVaWSI09ZhzJqYRyIZ8TPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573981; c=relaxed/simple;
	bh=dwlSDKJOBselJa1Xc6f39rzrzCGs8bColAIVJ55Jb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q71BI09I/zXgaWMqeOaCp1sn2XdxbAPaf3LnYlbXJnfswl2tNZ3gYWSAnaOYb1D1mZNRKM0O+1aDM1XJoxO+W48nPBkDuMgNRQfqK2L2yPW4JYfejfZaSJ/5Ut8DJsiBuGscUPd0byOxFZqDHv+ZQMchvCE/mQ3HGQ5s1Fn6AWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqgC9bn8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqgC9bn8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-312150900afso1512380a91.1
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573979; x=1749178779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sVgqziKNXk1VKHFZ3xvpqcIL2UFykT0jMs8udwzfSE=;
        b=eqgC9bn8MbBQpBSVMfAbyDyro+P057EFYHTfQOFtTPdBXEJL2J2CXSiDAs5Gwank4D
         tD09vbRGmJjjcG3MeswTwuTBgJuipgL7fnnEteMnd7+Hv2Aps3YgeWZK2aClDyZ3uZds
         1pCB3YkHObg8Xu9WjNuDxyztDu8dz3Arw1EVLFgCtjDtze1Kb2pwPWiBbcrjNSZbk/Fm
         sXwnS36o+DZBLNutU8HOqniV3OuSh6FWjbSCAuoJ/0sEPMNaeV4ZvuvS38QL2RrRxKSA
         4+m98jxSg8IZgA53FXIHUGR3h8DrRmw/5Lx3Uk8IWjvZCBW2V5TMOIClxcnbimHGqbZW
         CN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573979; x=1749178779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sVgqziKNXk1VKHFZ3xvpqcIL2UFykT0jMs8udwzfSE=;
        b=JMGcfDfxxgl1Xvf69nfH3V13Ct2kdzz58rQPRj8ZWbRXViGg5mduwdYhghkyLMLevw
         IN/72+ysMveVOkE7lFDXSukP/ZOvItL9pA3OPXr8pz9kn6JgshMwDsyFwX9OjAILz2dR
         zp9ilh+1Ki5Qlv8n05pngK+lKfWxNaCpJ6WFLw1Ibc4ZWbDipZael6BXKHR5hJA+/sUj
         m8EQWUwo8R4dZOIm/MHu7GY6RFlG03d5k8RlA+VgrUALCU9Ew1fBFCtCHayVt1zxwY/0
         +hpdWWUH7JOPOLVf3uhiKS/U7wPiicIHtvFI3ABPqlegILhEl8QpypJIm7DPF/ETR6vq
         sNOg==
X-Forwarded-Encrypted: i=1; AJvYcCUb4tWfaZyzwYKJm0yLlyNuYuHwIeELJStSgAA9aeoE7Q1abQLyZkG6q/7f+1tjiyoFD40urQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSToW+E4ml1A3b3rgoMaXJhustUxEFqYWLAj5q6+IgQFUtJMxc
	U+BIuaD3oZDnK2oJrjzvQ+O6Pyd8mLfwZJJfLKHc35IVrWgoHcH9yr8=
X-Gm-Gg: ASbGnctbhty7iWvl4PPsaFCYx2Uz0F9lM2DwjVuW129ctbx6SeCAowfO6b9TrgQOFCA
	8jxr3jFv3/MNbw+fkRwE6yPj3lVyGtdkynpxHJximnvTmEYzx9IVflnsqpY4e5JG9f0a6+u+VUy
	vZXffu6bNLZnJ9pH1jwTzgPvcF+FsmtXATwHtTPtA7ZE2XPYcxsVulcBTbl7sBjrB0+RF8Odl2D
	92hVktF7/UjWmttOlJ0DYPn8JEB/zP3HvFjEWezq+qHHKaP4T0PkhfadfjDiT92q81XcOKohwH0
	GkOMZmGGngQRJTnyukle81sYf8ax
X-Google-Smtp-Source: AGHT+IHAp+B0ti+QnJpuPvLDos14gktvJbY4vx5x1X1dIQardFp/ZXV7fELwwD6fMQPTpZOdVEzadQ==
X-Received: by 2002:a17:90a:e7cc:b0:311:b0ec:1352 with SMTP id 98e67ed59e1d1-3124152772cmr2869665a91.11.1748573979187;
        Thu, 29 May 2025 19:59:39 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f8aasm280977a91.8.2025.05.29.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:59:38 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 5/7] socket: Remove kernel socket conversion except for net/rds/.
Date: Thu, 29 May 2025 19:59:33 -0700
Message-ID: <20250530025937.3214873-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053321.GE11639@lst.de>
References: <20250526053321.GE11639@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:33:21 +0200
> On Fri, May 23, 2025 at 11:21:11AM -0700, Kuniyuki Iwashima wrote:
> > Let's drop the conversion and use sock_create_kern() instead.
> 
> Please send a patch per subsystem that is converted to make the
> commit log better and help with bisectability.

Do you mean splitting this patch into per-subsystem patches
within the same series or sending non-netdev patches separately ?

The former is fine, but I think this change should be done in
the same series as the main goal of the series is the changes
in this patch, making kernel TCP sockets hold netns ref in a
single place.
