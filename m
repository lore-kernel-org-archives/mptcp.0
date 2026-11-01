Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560868;
	b=4D0EnNO5dhaFFkWJNBthInrt8fU7YD6dKvP2gzuaGiYMpDOoWQm0bbfQRX1iULluiqLX
	 12CcZODp4mxpbn5ESPRdMIeHBWTj1hZbVcpLmRFA3cd9qf2wFpaG4EXv0GOFAjq9u0Vjc
	 8p2eLoDtUuPpJFYxrlxAukhx6t3wzTXVMHHKW/yKwdusmQd49BOlfQ8ymExjJKRvJ2/SY
	 yoclNVNWeHtgXgnaZpZ1X/gUchAtjXGWv5oJpOdmjoy0hN4gpoevveKuMLWY6OVsg3xTG
	 SYtKGhtkIcvE9AftEZV/AZBl0iVVgH0z48ooBZs8ThIQsKgIhsRBhs9niw2aNpCuPng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
	b=bE4XyXXE0ELLTCoO3hLFbrIU6OWhV8wbsCB27mpvMBNLfEFSkDmBsCnvGbNLbG3IenAA
	 zB58Ozec5huIbw2Bk9rG4uRyyuGmz0Z/iO86F8TBnVxmVR9w/ILUUZhKVPMQlgj6efAAD
	 SU0ytWfwvy7gZbhHkQMYCHKZf0RAHgaBOZ7zR1kvEkt/RFj9R5/7dA7BeWsojxtfJ2Ef5
	 oqK6IIDxWe/LxknojFhv5ND0m2Dzrse1VSn1TZ4sd2G6jw2kIu9fhJz4PxYr5P/Q6+YXg
	 8DYUGXmS/qy54SWMimgI45Rc21kSWmNpFOa+i7S5fWJlCE7Jr27nf+Ev+IGJq6Pz8Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sllsnT2d;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE9606A326
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2FE9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sllsnT2d
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so657129a12.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560867; x=1794165667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=sllsnT2d1js8Ufshg7OE9+Mn2UoeFf8stp8zP0BYHTroYSLf2lj3sZVPgdMzVcxJb2
         QY5g2cK1j7WV93dfzMUDBCNAz4ZqtFKBvnwM123VDmo4XZOjbRQxEwMLzoOfjKGNEXrV
         YCJM3an8dSrTgLeOt0A4NpyqlHTc7ZLS550qjaCrgIyWchSf7/EK4SjVy8D3KTyUuLeh
         dQhp0f2NsXTkALt2wMm8tDJUmB2HXk4I1MDnf6u1GSWNsrqAGwYDLQrQ0lc2OFVVFed/
         s6gLxRtAj/HSwxsep62r5gI30r2ZA+l8o2Z04kyKwOZ+I9gVVIC4TeTuVmVa1jjYzafE
         bIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560867; x=1794165667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=PS81IISVRB4couChm8Ms7yE3otjeKeTGWpG+MGc232Y+aJ25clatzIM6+5QTBK4M6i
         dlvHjW3IoK+Xb2cHfh7FNWJJh/gzU1ozvhbNh7UrOp6Cd56DYEQkAXoQpIYD/g/oLRAb
         TBYYllB786rOJIgjDlQcNcdLJHXZ7pVOpTJJKyYL122lQ+BlqTofrfQniRTRxFh+lhku
         8xHa2eYJykdhTKOZB43xygLnX/kUFRYdmhU0qOhAnH034V+OACB1QLCxYRpqJjvFe+wc
         kH+2CujnXQQPm+9RB6NGcylP4NlPyfIuKDwS4Fa7GII6Gqf1pfxNgKaWYAJOfjijnfR+
         e5bw==
X-Forwarded-Encrypted: i=1; AKwUvByJ8xa2g8sPCLogDHwAazjQ72yZ+oVUzWq4WORS5aTV+w27ygUH+DB2YjD5Gv5hTi0YIYA+8w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yPYxqLIoVJeHNrZNBNxkOpH+F+YdLlgVfuCTRfiRsPW+hiVUE
	h9E3Xt6ZHrqXz0Avy6koK8OqGAieR3qyVas8MWiKELqeZZvhRWi5SlKg
X-Gm-Gg: AYBFou0aL5QyiuACEkTK0CRFGMI4o9zLREOZSrOxHhzixsigBViNXKYGmii8MdbQ5H6
	sUDgsG6545b63cDu2jWlgU4UnpC/9+NWT5c9EbNOeIYzPYZJ7ZPx5BQ05KQt31fnb/gd35h7RWQ
	oeB2m/yR/0ZykH0DJk22CbGQZmSUXjHneo3B+EadRTS5uUtT75FNaa4i3J0jHchzAW5lGy4SqTH
	ezTvbErpLzwEx5qYsPk5TT7upB2NkdE9x2GJ39RPlxeRWKt08EwqByoxijx2ylNKhF0chr7TZ+n
	XLs8lu85qOo8qFLUTgeZyyBREWOA+EAMRxbkrgoJf2JHuSacdpHkG2GOrZsHc8YUUTSg9h2r9Si
	qM6Og0c6uPSg621VkwqvrrTYfgBT32XeeVfMLiIq9QjkvDx28aUN0h+qCKNRrlcbxBqxwVQxqv5
	qraCzo/48XeQIxDAA56qMZ3hH0q8PScOkLvrybTjjCdNIyoelhmoifQqF5UJ8hgsh96PrDEab5e
	e3/dBQZfE8H+wjg30hhIQ4fLT3yRiJBJ0l32Z5mq4gM3Q53FzXH5BoMGSTYxcb2ggt9z8oMH5fz
	e54Donr3U9kVJJdflD7ViUnfNjgSvlhbl7eaQjkK+B8SxW6OxRS3/R99HNq7o3h5nOIT2TwngdY
	SpY7bh3CHts1BSBN+xjna+RK4Xi3sc7gIJbhePgDu7RRuPEkgs3HyJ98bdAIOJ1m9ZDN/e/EOhg
	==
X-Received: by 2002:a17:90b:28c7:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ae897ee62amr6770112a91.25.1793560866933;
        Sun, 01 Nov 2026 11:21:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm11157931a91.10.2026.11.01.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 01/15] bpf, sockmap: Write sg.start when recvmsg() faults
Date: Sun,  1 Nov 2026 19:20:43 +0000
Message-ID: <20261101192057.2296489-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

__sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
sg.start. After a full copy of an element it calls put_page(), unless an
skb owns the page. It handles 0 copied bytes as a fault. It writes the new
sg.start after the loop, but not when copy_page_to_iter() faults.

  element    0: length 0, put_page()   1: fault here   2: not copied
  sg.start   ^ today                   ^ this patch

Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
user cannot read the rest of the data. sk_msg_free() starts at sg.start
too. It calls put_page() for element 0 again and can free a page in use.

Write sg.start in the fault path too. The commit in the Fixes tag removed
this write. Do not write it for MSG_PEEK, which changes no element.

Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..f03519468ad1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -443,6 +443,9 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 			if (copy)
 				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
+				/* The elements in front of i are used up */
+				if (!peek)
+					msg_rx->sg.start = i;
 				copied = copied ? copied : -EFAULT;
 				goto out;
 			}
-- 
2.55.0

