Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BEC3C2A
	for <mptcp@lists.linux.dev>; Sun,  2 Jul 2023 17:55:24 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c13cb2cb428so622375276.0
        for <mptcp@lists.linux.dev>; Sun, 02 Jul 2023 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688320524; x=1690912524;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B/346nUIZErMaap4Xzifysw7agxmNBKblpAJllVen+8=;
        b=HS1Xpu8RutGjzNf2cNefIvO40PuyEyyWN1lXpuUm3Zm6tYXGDXwbDrBzDuJeX7KOHr
         q1UGGgd94SVTRefQw+1rgl1gQ50uEoBHL2OdSUILUjvF+1ATH9gvheGUN++hFOwLNLid
         1XMjRZLU+9Ge2en4fJbD50bjnQdqOwyoXZfvhIPbUVY/sq6Vm6BAvUYZPRqmTRzyIG2n
         JWXOYS2flIDtpE0mu19bw1MyMQp5M6uow+iO1HWzOXqc6Z90+aO2nBs6Bf+FGR5IBS25
         laBmv/H9uClBFT1isqMjJFlPY+WcanwzxZg1N8ZxZIN6sqfmOEIBN1yT1YF0buNY5Ya/
         4xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688320524; x=1690912524;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/346nUIZErMaap4Xzifysw7agxmNBKblpAJllVen+8=;
        b=FbMvrQFkmkxsRWpn2Vk5KdbL5ZVzZmrhAPI7VaOrK0aWe2LgBB76p3SbnDCYOpVkyc
         lWwvyIN5s6yeW98hzeoAYgnBTl8g/Yelw9i+8x++FxgD9Ui/xQ3Jx04qBgId0/LBmzCX
         A5zb0fj0NZFLGXsRumpY6iyJYFWl+EffKkg509Zaqla+YXY86c3mFq1C2Rwabsx4+nnV
         3RUCgbB7G9iHi5653MDTyptQ5gNwnrZp+6H/2EANJb3p1gM9wiIH+PhuPKikyW0JmKcr
         TsMdBSGg138hWmrLBjm4xiUMUeIINkz1fmCXlj0gdwj30Mp4FYhIzwKYCZE0y+HcAn+G
         fTFg==
X-Gm-Message-State: ABy/qLZEenBC68C0pOV+hu9uaAZxSn6Y9K5PB+6OF8jIEI2meK6ofRqu
	xi3/znnoWd6HXQluIT/LEkuKrK+avCG+GNAjI34=
X-Google-Smtp-Source: APBJJlGKLhOT4Bu7qJ+9PV6J1mFibevhHpEsj9SgVNCYM6WTAos06S2LRQMzHrHXF1fE6Av0kYh7XbCZNh0JTIxm3q8=
X-Received: by 2002:a25:2b88:0:b0:bd6:6e3e:3af3 with SMTP id
 r130-20020a252b88000000b00bd66e3e3af3mr4285143ybr.3.1688320523798; Sun, 02
 Jul 2023 10:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 2 Jul 2023 20:54:47 +0300
Message-ID: <CAPnZJGB6gk47Hw-OE2_9eSKJ0DwOzEiL+tncMJyiOD6arw6xag@mail.gmail.com>
Subject: Re: [PATCH net-next v3 17/18] sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, bpf@vger.kernel.org, 
	dccp@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-wpan@vger.kernel.org, 
	linux-x25@vger.kernel.org, mptcp@lists.linux.dev, rds-devel@oss.oracle.com, 
	tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

> -/* In some cases, both sendpage() and sendmsg() could have added
> - * an skb to the write queue, but failed adding payload on it.
> - * We need to remove it to consume less memory, but more
> - * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
> - * users.
> +/* In some cases, both sendmsg() could have added an skb to the write queue,
> + * but failed adding payload on it.  We need to remove it to consume less
> + * memory, but more importantly be able to generate EPOLLOUT for Edge Trigger
> + * epoll() users.
>   */

There is a typo here. "Both" is redundant now

-- 
Askar Safin
