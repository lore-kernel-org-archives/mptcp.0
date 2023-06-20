Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE11FA1
	for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 12:59:20 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-62fe192f7d3so44763236d6.3
        for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687265960; x=1689857960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RvNVFujZzQ9FH/nRDQhxgK8HOnuVe0ilksjI7/FigQ=;
        b=V7CBqsvwa7HO9941Gx9rU48fbSNnkTARJq3hU0s4FJKqNq7uyQJvuWMi48BFYirjd9
         Z+CSYTenkWtjPExrbuK55Lr4LajYIvMVcZS1i2H4hkmnnVf92/3eU5+256AdSIU7TTh1
         xwVepNxy0+wSCXEIn2FLnq5fwolgWObqyrXGJD4a4dArZIDrRTCCQbOXeliLMdRNukOE
         bfBqEL3D5v18ty2Fda4DTUDINVko/+/f9bRuKWlc9As/MXSXKCsqRSAvjLHgGSN+PYBz
         OhKP930iRzIK8HICV0ZdtEG/GKM89Wb5av0m6K808diQPwrVMMP/ZUSrK2PjzRbzzuKs
         Xiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687265960; x=1689857960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4RvNVFujZzQ9FH/nRDQhxgK8HOnuVe0ilksjI7/FigQ=;
        b=Pxa901ebwqibixBXW/i0th/penQHT5ihvxeGuNOMMXKf3mmowasxDED2rSVO8+0gXL
         K2S6PCT6Hk7VqiBCAHfQKJyCzxIFzAQfRWaFc3VfKucDYY6woJr8hYjU/hbGtG07XNH/
         4icypK4oohiOOe9hS4SkEqSc346n+nbM+SH+sOJkIswxh/GvRzfxM9/WWdDY3ATQ3MZ7
         YBHEV3JLBBzocRRkM1bOyuO/f/VR1jPmbuC5Eew4k4teTvHDGnbtudrN98V832wTMMz8
         8gZrPOJmWTrHkCB/MpglK3WWflaZDXjVk/+ZWCAB1bqqNHeKgobIvcWuBCFF4/g11sN8
         QzkA==
X-Gm-Message-State: AC+VfDwv6V/xn1SGuVQijERorxKvkjoYFLRfCa8QxTWD7DxngzwHaPJY
	UKWUd4aN0iYck1r96N3Rmkk=
X-Google-Smtp-Source: ACHHUZ5DO7ilI0HCjRl4Lbeq4UH3F7W+AS3gn0PcL1py6Hb93MUCpM1EgmXOFtEL5TVj5cEqHyVw6w==
X-Received: by 2002:a05:6214:1306:b0:628:2e08:78b7 with SMTP id pn6-20020a056214130600b006282e0878b7mr5517848qvb.31.1687265959785;
        Tue, 20 Jun 2023 05:59:19 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id m17-20020a0cf191000000b00631ecb1052esm1216204qvl.74.2023.06.20.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:59:19 -0700 (PDT)
Date: Tue, 20 Jun 2023 08:59:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Howells <dhowells@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, 
 netdev@vger.kernel.org, 
 Alexander Duyck <alexander.duyck@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 dccp@vger.kernel.org, 
 linux-afs@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, 
 linux-can@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-hams@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 linux-sctp@vger.kernel.org, 
 linux-wpan@vger.kernel.org, 
 linux-x25@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 rds-devel@oss.oracle.com, 
 tipc-discussion@lists.sourceforge.net, 
 virtualization@lists.linux-foundation.org
Message-ID: <6491a2a6f1488_3bcfec294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <784658.1687176327@warthog.procyon.org.uk>
References: <648f36d02fe6e_33cfbc2944f@willemb.c.googlers.com.notmuch>
 <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-18-dhowells@redhat.com>
 <784658.1687176327@warthog.procyon.org.uk>
Subject: Re: [PATCH net-next v2 17/17] net: Kill MSG_SENDPAGE_NOTLAST
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

David Howells wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Is it intentional to add MSG_MORE here in this patch?
> > 
> > I do see that patch 3 removes this branch:
> 
> Yeah.  I think I may have tcp_bpf a bit wrong with regard to handling
> MSG_MORE.
> 
> How about the attached version of tcp_bpf_push()?
> 
> I wonder if it's save to move the setting of MSG_SENDPAGE_NOPOLICY out of the
> loop as I've done here.  The caller holds the socket lock.
> 
> Also, I'm not sure whether to take account of apply/apply_bytes when setting
> MSG_MORE mid-message, or whether to just go on whether we've reached
> sge->length yet.  (I'm not sure exactly how tcp_bpf works).

I'm not very familiar with it either.

Instead of inferring whether MSG_MORE is safe to set, as below, sufficient to
rely on the caller to pass it when appropriate?

size = min(apply_bytes, sge->length). I doubt that size < apply_bytes is
ever intended.

And instead of this former branch

                if (flags & MSG_SENDPAGE_NOTLAST)
                        msghdr.msg_flags |= MSG_MORE;

update any caller to pass MSG_MORE instead of MSG_SENDPAGE_NOTLAST, if not yet
done so.

> 		msghdr.msg_flags = flags;
> 
> 		/* Determine if we need to set MSG_MORE. */
> 		if (!(msghdr.msg_flags & MSG_MORE)) {
> 			if (apply && size < apply_bytes)
> 				msghdr.msg_flags |= MSG_MORE;
> 			else if (!apply && size < sge->length &&
> 				 msg->sg.start != msg->sg.end)
> 				msghdr.msg_flags |= MSG_MORE;
> 		}
