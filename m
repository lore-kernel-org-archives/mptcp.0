Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C81F4281
	for <mptcp@lists.linux.dev>; Wed,  4 Jun 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061225; cv=none; b=mfpJbYTEyxd/FPy6FJst1pbnUI5SL+JS/OE0cOTqnYHheex9oiw65166V9/7u/KDhsv+SJnj/vTR/h54+2oPVqF2KXfTNuN9AHg1gFwBGgfxqFTrlWR0uDS8yjbfzYbKyjJYDWhvXyU7A01WtRzK3SEMssKfk4mxmVDMqbsORZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061225; c=relaxed/simple;
	bh=xq8Pfxlh3I4akIPbWg6cSsZWuj6UwsxawCqEy+t4kCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxi5wMyGozXdAV0vNQ2VW5gSCtUbcQDFMtIaLXweaFKyvDxlojSLzZSFHUmGKpEO7afBrVwFROePVY34+euq0TfO8AlpqSFVp2w53XDtmSOdf/cNIWunvhqDnirai+bVGFNDlIRA0WMwnRcBKZYxGB9UqzvbnMbBSpknAvZwEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB+7DZdX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB+7DZdX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2351227b098so1311815ad.2
        for <mptcp@lists.linux.dev>; Wed, 04 Jun 2025 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749061223; x=1749666023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=;
        b=dB+7DZdXTMrISV2wV5zU4nrdyuGlrCgJS+A/58+Kljp34yc2omgca10qZwFkYqnqBw
         kiFWC/XyqsJ0a/uk8PU7t2ZDbRd4v3JxRpEaQHjcg3k26gLJnxB3rdPbnev8TdTjsdg6
         fWyeWhZ4Ec3uSe39Hh5yFRbZcucGwzVRjze0TM4IP94EsMgH68K55Q613P3Ud/2NWjt8
         8c841dAQNSdxpjgYYTeDPEYc6UHs9BPhZpdeN2gKSsf7aDKzpOCEHsZsTJhXZPSO24gM
         pTJHL+vHrVPZQfs2xPWm8gi7V5vikIewu0jCtq0UY0NssOE8ngRNEh209dc/hCJ/1ovM
         tzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749061223; x=1749666023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=;
        b=Yfn4Zsf/kw47SsQ1Hzb6bqwiRUi8km9+qdCyRaIytjmI4VbYaTDXmQ2Rfl+4Z9ogaB
         8M5A/VbIW6/p/giNdxYn2tUP4xNH1y6TVtjbQLuBq34rxZQ0ZYkyWeM8F56/JD7AEnFa
         cRtJviqk8iaFvIbJDC8QWFZbMAIMGWmCaaRVipRiKmXd3jwJfEX6t7ZwQYRODAAYHR9E
         Jqz4CQC+XaYsIkdzAe48ui4HSCGhF6rMBHxCndQvodcPxc3mMHAvql7Oz/3qW4mj+luV
         jHIBR0JxvK3upVnU64WzzHqagw/Jwn57laRvu3thnuusoiupM8k99AhPUDuYZBW3a14k
         V4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUs2j1T1uf1jyanPV2lbe9bE2c0iCvffPXkPqR7tadNEy6jQo7pVkgWcR+S8K0JU+otNwzjEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8kzK5tsiy7hqvfOTXVYPT4S/6NyBNZ1xznOfMIuGuu1KMHvnE
	diymVAx+m3X5pJg7RNtFh6R2i0KIN9ScRx2+7CG+SrvB9Xahe32Mb5M=
X-Gm-Gg: ASbGncsI7/XRqOfKtbM43ZGGGTVJ4UX99g0pyrOltdQ5yO7FS5lyjfo44SXh2MMUtRl
	vNmfq0awzu6wRM+VoouP9+I5qiQQdz+n3/feisQWq/RH/itNDcbP6Sb3u01lOaptJFeVxMTRZkr
	WJ305CB8ilzex5ULgWNRZHRKGrHAkpfJtOHRzAQ1AqtXZPQMTKv+OFdIaRzxUqebF1HIZE7jJby
	bgp5uY4BX8GY0ZFLWlE2/fVKrP7LD8IFw0sdcCeiWGWJAUwJtClc3zPwcARZ43PkNYsK7N3sSo6
	YYs4Z43oy0eelQGOHHTXh9gmswU5ZcGYMWPY9r4=
X-Google-Smtp-Source: AGHT+IGIouN/nMiCxvNDy5Ikm1iFDpXIIVrGTTraPYBI83jtD4OKXOtjOvlar8/eWBmagZfZh4sDMA==
X-Received: by 2002:a17:902:e74c:b0:235:225d:3098 with SMTP id d9443c01a7336-235e11fef9amr54068335ad.46.1749061222816;
        Wed, 04 Jun 2025 11:20:22 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb9a5eesm7841454a12.53.2025.06.04.11.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:20:22 -0700 (PDT)
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
Date: Wed,  4 Jun 2025 11:20:17 -0700
Message-ID: <20250604182020.126258-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603045021.GA8367@lst.de>
References: <20250603045021.GA8367@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 3 Jun 2025 06:50:21 +0200
> On Mon, Jun 02, 2025 at 02:52:47PM -0700, Kuniyuki Iwashima wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Mon, 2 Jun 2025 07:09:49 +0200
> > > On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > > > I actually tried to to do so as sock_create_user() in the
> > > > previous series but was advised to avoid rename as the benefit
> > > > against LoC was low.
> > > 
> > > I can't really parse this.  What is the 'benefit against LoC'?
> > 
> > It was a kind of subjective opinion whether the amount of changes
> > was worth or not.
> 
> So the simple scripted renaming was not worth it.  Maybe I misunderstand,
> but based on the reading we should basically have about a handful
> callers of the non-__kern variant left.  Or is it a lot more?

Yes, after this series, only 2 sock_create() left, one in sctp and
another in core.
