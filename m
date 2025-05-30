Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C66C147
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748572962; cv=none; b=N4goHFE0Z/S+SlnQuCUPNpFVILuCcCbFbm1TkB7WzZApPOboi2KyJVmV4xJigqjOZC/9YoPRKxgeOS/I9Avf1g0qziQyvl6cguQggG2/zDbv5MkBZPAjUiU1sBkmn3YqKRAk7yxcN8VrEGqKrpag3QN81izeAcNvCaQFel0z7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748572962; c=relaxed/simple;
	bh=ucWRPuZCVVXkBVEMMoVPY9Ji8+XQrgpQRlTZCU6HR9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFHzAleEAuI6TsHNh9PbE8+aQvs7J3egE5n7Y/SVEGKzVSWmTrEQWZxPNrW3d7EffmnKh72NTCiT09k9VjUTHZNZZbVVhtEUXUeoPrIk/effO441WaG+iTNCCgUpspPCkorGaRLOT4X5RsMBscWipdYlkoX+/I5+XILG2dus6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvvxwF9u; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvvxwF9u"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742af84818cso1019846b3a.1
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748572960; x=1749177760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EClwhMe2iqOJ1ZDRb/9izffcTJfL5lARyZSrEoMKU5k=;
        b=JvvxwF9u1hh7ci2nHtE7zEzA167NBdChbgYsqHudKnolzKYECq6me4leXkfHvUFP0r
         6lS5IsP+hh84X02BtHE9FRwal16ug8d1XMMbLXXGWXe+wpQamyjrhKUXTVRpP2neABxf
         1ePNN3ttbs0u+6VMg+91CgscMH2zshjL0F28Jy0Xe7N1tSBv/6UzMpP3qX9myfuBF1GC
         U/23sooL8izcZ7DRYpD6AWFCSLZczDUsBbXpeI0MnMSljfYO6hRz7jJ55JcEee6TzF7Q
         o6kQeptaFXJTYFWQ8eIBHktaVlylayaSFQ2daUv4I5Vb4iuTL8f4HUNqBz5lzwfpFHQB
         8m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748572960; x=1749177760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EClwhMe2iqOJ1ZDRb/9izffcTJfL5lARyZSrEoMKU5k=;
        b=Tloc4rF/1cEZ0sB+HsjApdW1ts1y93SHIYZ4ynGA3vl73PHadYWvr7Nro7C+yi64Ig
         Nu8PR+yNHuVHnVBL/xaUP03h7Ev7Y5az5RLT9ZL+0KFuESeZXE9WSlqrjtfbqp4/mns6
         nJhfLSYTQywQCy8f3R8kZSDSWzmybUr2GrW2pJq2+YisLeE9FDGxESvtZDB7EU6OfjyW
         DwNSUD6uXoJswt76OBJlaxw01g/hD4OC81VkuCfLena1KeEn2xRodht9apAy4ed/gPRI
         IEHkh6G06GBwltiMzHUkRyrJOUL0rzKTAsQIQkkUMiAftzl4/PFjokIF2hLevKmaWQdZ
         g3rw==
X-Forwarded-Encrypted: i=1; AJvYcCVTR9TXcCqROe9NSwwx1SYNYc/UzDhBC2KFrDwvEOQL0zvZHafuqk8tEEyLdoYZNpNQJuH3Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1+Xfu8NrPrzLLFEfy5FaV7LmH76s9L8Rkbertl5UrDC3qBXFI
	F40BDQdAaCzNJU2QFvjxKN7OjRl2DGEGrI+Hujw08CN42xT8Mazkp5Q=
X-Gm-Gg: ASbGnctOxlwYODX9iJFnmlnp9uj7xZK0vsJOlhxRiF1uRweb0kzQKVtjTUXjMd7EyeI
	v9Imer9EeM1o1ACPYWMfFZe7NDW5z4G07okHq3F9gUIyFqqYHDXuO9OAOYeGXmBUPrmDeIkwn8b
	5BQQmm6wbKTnLvqgNQr5gfHobNYpGGF15gG9rrAZfwt9UpxKv2kgrgPkhmFPF9kHHAzWwzN+/Gs
	GQfnN1i8nFmDzl8jnMQ7oywyz8pXjUaeCdchwWyWafbsFDKmbeit9Z3JPOforBZIVooCFvxmsQu
	WLxYPLMpqFZXJGNyEh5wMPiWiJgmwHfEmHXcjLU=
X-Google-Smtp-Source: AGHT+IFkZ59DZl7jNU5F1Sz5H/4ysdqwbjBZOu4yMdNd5hJYzri98sUVF1rBQfHwd3ScQ9DgsM8UVQ==
X-Received: by 2002:a05:6a00:4fcd:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-747bd94deb2mr2658447b3a.3.1748572960442;
        Thu, 29 May 2025 19:42:40 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab0c4sm2019092b3a.48.2025.05.29.19.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:42:39 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Date: Thu, 29 May 2025 19:42:36 -0700
Message-ID: <20250530024238.3205130-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526052907.GB11639@lst.de>
References: <20250526052907.GB11639@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:29:07 +0200
> On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> > Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> > sock_create_kern"), we no longer need to export __sock_create()
> > and can replace all non-core users with sock_create_kern().
> > 
> > Let's convert them and un-export __sock_create().
> 
> The changes looks good, but the commit log including subject line
> is rather confusing.  What you do is to replace all uses of
> __sock_create with sock_create_kern, which works because
> sock_create_kern just calls __sock_create with the last argument set
> to 1 as those callers do it.  This then allows marking __sock_create
> static because all outside users are gone.
> 
> Please state that, i.e.

Will do so.

Thanks!

> 
> Subect: use sock_create_kern insteadf of opencoding it
> 
> Replace all callers of __sock_create that set the kernel argument to 1
> with sock_create_kern, which is the improve interface for that.
> Mark __sock_create static now that all users outside of socket.c
> are gone.
