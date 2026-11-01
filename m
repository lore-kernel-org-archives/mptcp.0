Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793548798;
	b=Vf/aGRu2nkQKtn1H7hxAQ42p5T6Z/w0ygn4li3ZRiwzBH9of89otVl+tbRq0MlzN8ofI
	 hKDg/H4OcbVfnBynSZtJDfA7MSRX0r8TbA2WH6qKqwwke42DR+xAZh6D5dZRP+1LFayzL
	 fPgrYVRnvCQxwdh8DFaAv2GRU8IzWp88CUsTiGMJCwcQptJiMxQbim3Lgiw/5e06i/+0Z
	 E6frWzF5Ji0YWgGh0VY9QI7/kaBX77JM2lnclnEJ78FEfLpIEnYgA0FC7tEpPb93C5fQg
	 uLii7JykTOP1+NO2GNsbMqcBCVZElb2YLoR9QgT07V5dv3ZCdwl+5mnjVx3TT9rcG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=I/3KNWEEu6IZN+CXs23fsbkAyCG4qcqp3COErszDAAU=;
	b=ulrlviP8zOYb+mljM93zai90E/jnOQf7R7a+KSQCczTl0rIJBxSJkG51toiFOhPsPuEi
	 2I1MTVg5Ex/QlDR4+BVtMLBrykBjQ5S96kcTJvijWx2TCKeQn7KZ+RjiZf5A1s7gmiWbO
	 JB2RjmgDfibjH38dW3C2na0Dtglq+2qM2C04PJRYf4k+/ui/xkdJMF5f9DoxNtMjQ9lY8
	 5S/vRqvNIj+cXwyvy+/5/9CgM6gjd9oLgXvrILXV4HGuJwUExIzjNbH6qte/GMmo7vjEY
	 FaJwcs0xEcIbOsXbL6JQZk6eXnDFL+Am0lHNvFtViYyufTs1jXL9HYCAjfLDK90HAdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CwHpMAjz;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F38606A326
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 15:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F38606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CwHpMAjz
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd60a365440so1400423a12.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 07:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793548798; x=1794153598; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/3KNWEEu6IZN+CXs23fsbkAyCG4qcqp3COErszDAAU=;
        b=CwHpMAjzhe3K2DYUMm7ulth9K6vcC2nu2aJ1UnL8UO1wLFfU1xHEnWBdjbMR7hARUT
         mk25WU0wfwrglCA4POaEbft/r+3MIliIOEQJN2utijxT+Sm1qQMw0W8SJhoWzn3Rutpw
         RwSaGBd3yytq+XC7rxTeR3V8twhO1HP0BDUyVygo40YdXCv7PLAwCLmzjquGU3DtXWBC
         CKhxB0GJ9frmXLXNOpNKfJMJJudhA45jBEJXFAWs02Cv064slEFh0rDVmS2ei8oxsBfD
         Ic9NTEok80ZM7g36hHrjl23R1Ab6xmvGYakUFwy5P6ia5ORncZjvY4BBFWIAplZzEhwY
         JCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548798; x=1794153598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/3KNWEEu6IZN+CXs23fsbkAyCG4qcqp3COErszDAAU=;
        b=LktUfYeFT5USFLQMaMNbqj1sQSFppy8bZyB7sdvIfbExiE74p1xpnN/XbRGdoff+R0
         ORvFoGhhvdOK+74bwG1+8bioPSSSIzY/Xpr/I5inWjupqgEFynd9iH3e5P08o8egm0Tq
         O4ETLRqX6eQ1HDEPdmiuRylTUQq1uI6g6QwouQJHjs4VJ3uHeqAHEWWdLV9yXJ6n7kXh
         PT37BvG79D2uPs1YHnnwogv4q9muemtx52qpUYHXymWM+Mcre02n1B4FsHkkuLUiqrmw
         7Id7qDjUV3bR8UKLr0kV//LpJ1nbm6Hpq7seydd682ny4spRutUSXVn5LLT9xdlLc96J
         ttrA==
X-Forwarded-Encrypted: i=1; AKwUvBzjCDucu6uWYpwkWQSp78vBU/s4Zy89d+pI3faZ2BBIjBBVXvGo5LDWkhzVeKSF/KqZ0zwUPQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLWzNmqiejJ8Xih1BydIm6ajTWT6dCeb6W00LYZBHgGdN3Xpf4k
	hq3D19QFoTzKLQIY7rC4NB2oQjk9tCu+tUknjYDqZA+/sA1mmksIITZfwCVVhPrI5eLyZOSfAPi
	TQN9ndQ==
X-Received: from pgbd16-n1.prod.google.com ([2002:a05:6a02:64d0:10b0:cd8:b7a7:1171])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a96:b0:3e2:b17e:40e6
 with SMTP id adf61e73a8af0-3e928ab246cmr6424437637.4.1793548797553; Sun, 01
 Nov 2026 07:59:57 -0800 (PST)
Date: Sun, 1 Nov 2026 15:59:57 +0000
In-Reply-To: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
Message-ID: <audeGRiIR1JE1Yk_@google.com>
Subject: Re: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tong Liu <lyutoon@gmail.com>, Qi Tang <tpluszz77@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, 29 Oct 2026 23:23:14 -0400, Zhiyu Zhang wrote:
> From: Eric Dumazet <edumazet@kernel.org>
> 
> A successful connect() of an IPv6 socket to a v4-mapped address switches
> icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped variants.
> These are only restored if the connect() fails.
> 
> After connect(AF_UNSPEC), the socket can be reused for listen() or for a
> native IPv6 connect while still using the mapped handlers. IPv6 packets
> processed from the socket backlog are then handled by tcp_v4_do_rcv().
> tcp_v4_send_reset() and tcp_v4_send_ack() interpret
> TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo() can
> overflow its 40-byte destination buffer.
> 
> Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
> and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native IPv6
> connect is still allowed.
> 
> Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
> socket is disconnected, and use the same helper in the connect error path.
> 
> MPTCP subflows override sk_prot, and two teardown paths call
> tcp_disconnect() directly. Route those calls through the protocol-specific
> disconnect operation so IPv6 MPTCP subflows receive the same restoration.
> 
> Tested with TCP and MPTCP by reconnecting an AF_INET6 socket from a
> v4-mapped peer to a native IPv6 peer after connect(AF_UNSPEC).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

This is not needed when you add Co-developed-by.

> Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@gmail.com/

This link is not directly related, remove it.


> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
