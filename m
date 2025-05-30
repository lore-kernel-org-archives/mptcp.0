Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD2227BA5
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573646; cv=none; b=KNK0/fBwJvx6d/rYjjljpDiy2RsyYidGMQ7R3L1CxJYYxNnu9jwx98QBO5S5WNdOAyedgnc3QoIh7N7yxUu/05zNw9PdeKBlaRhygwAJVwJ0CJro5H+v6F2vakTOeXRBV2HMqhPJbeqJdHUcbsxLvqtbL9Fo7aziTmsWEbPCQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573646; c=relaxed/simple;
	bh=ru9a6sY4ZvkfZZSCB/5pKAsVZvCUON0+3IAKLW5UIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soh74iyDsiqXtAX3ZnG2qRAMA67uh0CWj6KfV4bXxxSXLzaiim2xwfShf+cvXG5cQlIGWGLtVewQ+sBuT5xOoS7eS1OVU58AFaxuDcHL8DqqbHRAMOIhrLzg/En+Kmy8/OgTVNO5h91ApwiVYp/pvw/s0TinB2etf9MwBu7lC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjfWCOT4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjfWCOT4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350b1b9129so8050845ad.0
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573644; x=1749178444; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWyxMFb5cX5nYvnzZ8Z+1Eedymi4rZCZ/8P/Gr9oFgw=;
        b=LjfWCOT4lhmuLDbWQj5+gltKOXV3w+u/DJ6YdDFdxG67KgAOXgp16TbYqF+DVfcB1O
         tzteFmNdZrWfSBb0VHtIzOVOSYTjb4C1fuD6XgbySSgCKOFuhzrQnkK4n2O2l523Alvp
         wrgsBeOL/tH1wyF7K5EWr7hChJF+gpGGgCFMspTb/QQzHsoBxJj0TpHxg/cv9X7ebTMR
         8iIeYCTA0S6uV2pux6HW94pyN5PMMI5NtSwirVG7OYE1JBud0sUriw7MJG5hhIU+2+TO
         ZG2hZO6GdFc3L45d0L8j2RBNbpSs5DY5FGxJ899wcGwNhthojLFjceCwRPgnb0X8UjDA
         NcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573644; x=1749178444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWyxMFb5cX5nYvnzZ8Z+1Eedymi4rZCZ/8P/Gr9oFgw=;
        b=fMXleLYIdniksNjYdBNArC3C8rFKIDuBPwk12VYGaqWD4QyWjxg4ypG0BXstMEQ9N3
         W9dyldSpC+zJZDHQDbO1QfzlIbOk2wYnqCmHK5Kb4mPZZyNTgZunRz5mkVdN5nEDW4yY
         KZ2f67tXamgViv2/1TbJytFOCAfHtxIExjmn/F5E9S3JFElAlR+VVm9wi13yvkHDmKhM
         qodbWfnWvKSx6APf2eCwBFOW5sK9kAm2kENzuvieAfcnbU6mQVKC0gnGYjbCDAtb6mI3
         fXK61Jo+GZ/mypo4Ro2Bl0KkIzytTKnDYm30gVq1meH1KGS+UWKRsrJYMSrofL0C9ozF
         o3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXjz7nirJxAXqkbv8ZUvMfUj3GaEAtNqIWC9gumevL8BgXg3h8XgGJsmQgnUSbTlLjpnpt3GQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJiaFHOWKuR9USBh4vhzkqTcmiAwa9BiV3S2/5I8oInkmjnLe3
	fK/BvkygNkFoIZF+yEOJci3DOaOzRnyJMJBf6QCdvcgpAOTQCIFVj6s=
X-Gm-Gg: ASbGncvh+nrwcWnZQrKI8j6yiDfYZnYeNr6F5gXPPymqX4Mu7Yz/FxYuUWMX82TbK4I
	ZPNkXGAx+hn92xl7tRBOwKoQ/WZtElDMaZ6+QeuIzeByzJiqyRbXiBoA2E7LXdmq9eQ0fUcESUD
	LMtdT6ueCsDHKiTaBsFPY29jJwoaDjepTJhpDE5+PkYeFf+GT9STkJj6zbGBWPCWrz07k+IG01v
	XAf2JfV1GxMa/5rMdUOsRgiiHACMWBg9APdtjAeTSyObeJhxNkW3Nk21ZYmN1o7GnsfU0y1oYFz
	mgxZbEZ+FSFJJIPPbzunFy80zCmv
X-Google-Smtp-Source: AGHT+IGgDezX7cz1uOZykPYiPInz+eIk19WtpZF+nVK4hwKpEI92osR/Nx6vpb7wz1AjRVv5hZda0w==
X-Received: by 2002:a17:902:d544:b0:224:10a2:cae7 with SMTP id d9443c01a7336-235396cb241mr8527095ad.40.1748573643807;
        Thu, 29 May 2025 19:54:03 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9380sm18830305ad.203.2025.05.29.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:54:03 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Date: Thu, 29 May 2025 19:53:41 -0700
Message-ID: <20250530025401.3211542-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053227.GD11639@lst.de>
References: <20250526053227.GD11639@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:32:27 +0200
> On Fri, May 23, 2025 at 11:21:09AM -0700, Kuniyuki Iwashima wrote:
> > Let's restore sock_create_kern() that holds a netns reference.
> > 
> > Now, it's the same as the version before commit 26abe14379f8 ("net:
> > Modify sk_alloc to not reference count the netns of kernel sockets.").
> > 
> > Back then, after creating a socket in init_net, we used sk_change_net()
> > to drop the netns ref and switch to another netns, but now we can
> > simply use __sock_create_kern() instead.
> > 
> >   $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~
> > 
> > DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
> > from __net_init functions, since doing so would leak the netns as
> > __net_exit functions cannot run until the socket is removed.
> 
> Is reusing the name as the old sock_create_kern a good idea?  It can
> lead to bugs by people used to the old semantics.

In the old days, sock_create_kern() did take a ref to netns,
but an implicit change that avoids taking the ref has caused
a lot of problems for people who used to the old semantics.

This series rather rolls back the change, so I think using
the same name here is better than leaving the catchy
sock_create_kern() error-prone.


> It's also
> not really an all that descriptive name for either variant.  I'm
> not really a net stack or namespace expert, but maybe we can come
> up with more descriptive version for both this new sock_create_kern
> and the old sock_create_kern/__sock_create_kern?
