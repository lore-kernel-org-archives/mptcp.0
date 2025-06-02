Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264724BD1A
	for <mptcp@lists.linux.dev>; Mon,  2 Jun 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748901199; cv=none; b=Nj/6XSWvxRMTqJDqEtvnD2CbemVK+4MveZn4Cw4nxutqXZhMyAkKRrttfdsy1xbe2f8lwp7FyEWC6QtpfoUWk9HkAZYw0w2LfJENritat9ZmaEr9s8vhVxgUCulrIsKMkJZR3/2BrwWjEA8A9lVdW2aBq3c/dzEpW4ZRgzArvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748901199; c=relaxed/simple;
	bh=AIFKKpyKFXNqHaQaeip2wcUVUnkpbec6eRCBmD+Lb9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5iKCAk73UX+YwePDuyMSoETcZM6EU8zu0dUJXWP1BBtSyHr4Dv95YI1Tc0XtUDKJEu9f7YHVeMwHU7wmPzIKAxIf9dUZCOO7/FRdlO9znF4WPnkK9onCRMuw5OI4/EAyaV6spEdXK0qZWeGjeoMEqEI1rBk6yITVIvSZstxgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbCx2ylu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbCx2ylu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234b9dfb842so45772145ad.1
        for <mptcp@lists.linux.dev>; Mon, 02 Jun 2025 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748901197; x=1749505997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4+gh6dDpCcbatPs3U4I0oqizAhZfGMCTAgt1Y0fPDM=;
        b=JbCx2yluYt6gc9Nx/OTmgNInBZ3XXYFlbXFpxDFcm7GcEoKfPXQCkSRoX60f5q7zDf
         CGXBsVnGvfdyXNTaBEOBP/FwygufbIeqvqjXb1y00vXvSfJvODljaUpCgI5mw+aTh+hy
         VhnhkjHWjVt2oS99jpuZoLtil4NTtRWIr0rYUvbwsQW5MTk50pyh/pt7noxYdYSmbSOC
         0NdayCn/X+80QrLcnW9oe5I2mERute7SQCWeA5E3HE+Dirxw81yZWTPnHg1Ttu0xFlgh
         ScZLpmEl8DjZbN7ShYfU0bXSq3rx6yLn0pmwpCr23DRzTYLukh+FvMy41y8Odwh6aeme
         dhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748901197; x=1749505997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4+gh6dDpCcbatPs3U4I0oqizAhZfGMCTAgt1Y0fPDM=;
        b=VWZtaiTdlYEKxgSY4DllTy4hyilsTLvPCNMrg0/GwDx7xqeybyUOXjsCBfVRw5/02d
         i7SpxbNeMvV4YhYfwOb1kcoFLKajwwVm3oFMm5OV+dtCx137/F+soi7XbZf67ojkqL58
         fTKSSwIm9O6k2rf+MUpWZdlXeqOJlNibhPYNmHS13cA9h80saWscJZtVZ+UpzfWCT+YT
         lkqRDE34arm1tshRSETjVyA3eXU9Kxd3KZDMoLkIu2XJWi0iTKhB77urRBbrFR8qtLU9
         4RGhLd3qQqmdzM4BvElDJEwi1KcwyLgSC/U2/HGSMIEWj7hs+qPLaI1P2lCujsumIgyN
         uBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjmBsbymlhVFaQS8R5FhskM3tH0A4QA+qhxN6THbFHXjg1/rdTm3laFhBkD4HNmxybI9TPGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWTB6hORIS3/5EvrPRjUPrwtcxoFzrY16iu/bpsXKZcalAoowH
	hnnpiBIbdbysNt3Kq1RukP9dMvqvxIfIC2KGOtkIYEV9iwe5jJPfItc=
X-Gm-Gg: ASbGncuYVZKzQM0t2Vzauyh4wzH8W8GPBB8mGPMCiFrBPzf2W0pSiusLoPB6Nwgk6/T
	EFKQ8g6pv38cy+vV8WSwzGLiob1rcc5BIgK5syo/tXGt233TuQ+YCuyO9hwe2MpcnMKhGGN7TYR
	8FAWNHeTyG6C4YYmQOMke+09aVUG1kSHfDbEBPDC1esY5gYs6cZvGJcqb7Oj7qtfwOvzICWEHFO
	bwr2itKls4jGSnYgJ0di3SyCRymojTj6VX3i3v7GZcWt6qGb5Oy3X4ZtS90LbV9C7d2vHkNl/0Y
	314i++qjJ92sMln9uygyZvH29cv5
X-Google-Smtp-Source: AGHT+IFablHnOD0Qjkeg3PmBrfl9McO7L58/0ECQc55ZulNN/C+wNm8xqlIMyGBLFl88nguN3OKykw==
X-Received: by 2002:a17:902:ea06:b0:234:ef42:5d65 with SMTP id d9443c01a7336-2355f79fb5amr139393815ad.52.1748901197133;
        Mon, 02 Jun 2025 14:53:17 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf954esm75552875ad.210.2025.06.02.14.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 14:53:16 -0700 (PDT)
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
Date: Mon,  2 Jun 2025 14:52:47 -0700
Message-ID: <20250602215314.2531309-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602050949.GA21943@lst.de>
References: <20250602050949.GA21943@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 2 Jun 2025 07:09:49 +0200
> On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > I actually tried to to do so as sock_create_user() in the
> > previous series but was advised to avoid rename as the benefit
> > against LoC was low.
> 
> I can't really parse this.  What is the 'benefit against LoC'?

It was a kind of subjective opinion whether the amount of changes
was worth or not.
