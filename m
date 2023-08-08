Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84500397
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 03:07:36 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d5b4f6de9ffso23720276.3
        for <mptcp@lists.linux.dev>; Mon, 07 Aug 2023 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691464055; x=1692068855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0G2Gm44L7ws5E/quoPqMuJmdghfzOor5wGEa6AaRIig=;
        b=MIB1dRWNV6Yb3HUd1qPb/bgwaoUzAlGVu8CxiiwIDYwN4TMseNzdPMVbuAfPyciWjI
         AZzeBtiA00C4EVQ8EGlp9e8Q3pbBFc8aCRl+HJu3YtRoio8lAQY1qu2UvIE5hChxs5Q1
         PKMC/y7tlRiDWg5YOtPXbZsaYs//GKuhiSEDo5WpI7edOLzGAaAJjqvFIOQWWQAuLo7Z
         JBsPnB5UvxOuJ1p76ZyxSuA7+KQWE3J2jS89kM5pl3PIv+dMsBBD/LquAyRZomdcC7zN
         v+sSG+iPprRQeQoEH+XZP/GEzjEboCjqHBhNwHzm7vxhsHdZplrvrz31A5i2G+xxBQ4/
         u+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464055; x=1692068855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G2Gm44L7ws5E/quoPqMuJmdghfzOor5wGEa6AaRIig=;
        b=JG9wbbfDeq5EP+munpqu7HJeiXTL4NSa8W4zHL8CMSviKfh6E/b0NUo51s9/ayKHT/
         MSjeg26xAg7dljiNxu1VMCUtz634zKiVWvCD7AdZg0gsxyRMvLXqGja16gZZwRYBtwy1
         FbRxauKaq03LyIdAF6G/M6jQBVfMtxyPXCfkV5K3bBR9kxCT5A7le0GTpyEzm55Kubfm
         MRU0zt0AKtrUss8sZ7ga8GUHaROApTTcqowk7czHwRX00pHYcn2XF8JXSBzzDinJ3aJy
         4lOPf5Mr48e71WDb5aVHihF1mUg0vMhTvLByZdzz6mMrdNlTRk8ndFoPSkZQjPNl8IDy
         UCdQ==
X-Gm-Message-State: AOJu0YziMxyosE8v75XPATcvnnV+q2Ti1R2U2LpgfS4FrtlG7ywMhhpL
	oXxaMxZL5ur262iQ9TIOeIc7fC9zmrEwKmdsH8U=
X-Google-Smtp-Source: AGHT+IHQrIvich9PHSVbgRXTdmB7iIbb8QzxP6y5/ZjBG6gKIk1MkGZwx3L/64MT/J6/QOrL9i/+Y+FD0/7A7U+VjlM=
X-Received: by 2002:a0d:dd4a:0:b0:589:642d:6d84 with SMTP id
 g71-20020a0ddd4a000000b00589642d6d84mr2728002ywe.23.1691464055184; Mon, 07
 Aug 2023 20:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org> <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
 <ZNGBrkP7J2g/BAWV@bombadil.infradead.org> <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
 <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
In-Reply-To: <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
From: Chris Maness <christopher.maness@gmail.com>
Date: Mon, 7 Aug 2023 20:07:24 -0700
Message-ID: <CANnsUMGHnurbph9F7mex=1s0mxhwpNgeQbKJ6j1r37Qmd6LAMQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Florian Westphal <fw@strlen.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Iurii Zaikin <yzaikin@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>, 
	Joel Granados <joel.granados@gmail.com>, Joel Granados <j.granados@samsung.com>, 
	Joerg Reuter <jreuter@yaina.de>, Jozsef Kadlecsik <kadlec@netfilter.org>, Julian Anastasov <ja@ssi.bg>, 
	Karsten Graul <kgraul@linux.ibm.com>, Kees Cook <keescook@chromium.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Mat Martineau <martineau@kernel.org>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Roopa Prabhu <roopa@nvidia.com>, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Simon Horman <horms@verge.net.au>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Will Deacon <will@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	bridge@lists.linux-foundation.org, coreteam@netfilter.org, 
	josh@joshtriplett.org, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	rds-devel@oss.oracle.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

>
> Are you reporting a separate regression that goes all the way back to v4 kernels?
>

I am not certain what you mean by regression.

> > v2 is fine there.
>
> What does this mean?

I have to go all the way back to kernel version 2 for the serial 6PACK
driver to work.  If I try to use it in Kernel version 4, 5, or 6 the
kernel panics as soon as I attempt to connect to another station.

>
>   Luis

Chris KQ6UP


-- 
Thanks,
Chris Maness
