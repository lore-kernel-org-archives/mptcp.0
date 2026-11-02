Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604111;
	b=Ch9l/wy70EXFQ09eac1s3rl+xKWyXnJP+tKIEWnTL4cdMTqDk2vIH/CzJ1B9X7R6uA5g
	 PXJFtfv8NMGc8wg25b/ihoEJ2gNwNJTJp4mtj2ygi6ACKyeVe/uFS7r1/XlDFI4/Zh5RQ
	 yZFpCD7MNr47fB3l0tRpHfwGHcXsfZ4WzZEaD1DirmgI9VBg+czXcdYXadl2qpB9yXVJL
	 iRKFYFwmFabLUP0TGfkhz3mg2rzgxXDNTGHaEL7WbutkD+SjHz0phB8D/qGzksKyOxdJk
	 9BRuvG9DBjY2/BPE7fGSxClgIPScwbFuETMDBd77QDfu5Dusoc7YuvbKukBo9b9xIdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
	b=y+yH6wxWL+clOjHgtmBqOwoCz7FxQ+QJf0qri6VaIV+oirdOE2JTT98wF5rxpHstAkPT
	 NPAvwPD9c1wI042kN3kt5W6/oiZ4Sxbs711u2K2DDOGU3qj0MzUS/En289cOhhtU3GgVL
	 Ia99/BaAHfk5Ys02dPEn9zis33gmwEtLxGMnoYadzDgHNx7buB4MDXoOgE73XAPcOJUO+
	 FHT/iLtyVKOyxFAw04T1wlg8Cse+Oh279/wj5CVtbj7lgILSxpv5VA4Hy05xXg7MdlQIx
	 BdgQPeQNCLeP6QiEKvd4lRxGG9bKO/84CdiOYBw+eP6KFqAp0JSHyKgS++daqy8URiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yW+PwhyJ;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0194606A339
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0194606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yW+PwhyJ
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea7987517aso17811445ad.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604110; x=1794208910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=yW+PwhyJ2R0TcVW4owG8m1wKAFCx178GbRcK46L6rdWcVADxUVzAlFNrEM5q9TXIpQ
         1RRqTw23uaYAskykgquNcKESYhpnBObdSkBGQKepi4VeCdixyqaZJnTLhIwsiIv489ba
         8jy6JpjoAcS37EZE28ZCVcY/Nch5YMx99e/fZEiOjGYhspaWEk7IsAOGodBM6PcKOJ02
         FfhIHNzaSQ6lw45BNEFWyh2KtASZJjw+dWPF+vh0tcHvEbOs6NzvKERvdsDV7uJ3zolA
         qvyYhGLJQXNv5SYYpA0U/pP+s0QQ/E/pa5aYTIoniobkpEblzVaf0pezcT4uEKcdVjhH
         eJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604110; x=1794208910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=n37Sf32AcfrkzIrgd2/6nZ9WGALjOOji2i3417aLH+NxemitPQly+HOhyaHAObqnSN
         b+/Y9q/6B69XN6jGeCYprj0dGrA7h9rutA80+RqyKStV7nlz0qLZGkQoDY4ah8Lz0Qkf
         XqnGC/X1A/98og9YWQo7rL5hEgOFBiBk2gTgU6y/jUDoWuj4D0BqIuJtkUiKHZKDmkvq
         sAN7u6AtfeT4G4EcF4P/TXBLTBqQCxUvBcWZh0GRa7sGSeFDmuIi+vfrcI9YG4ZsRHQU
         yjYBTsNp6zrStRSZJXVxuUyRlSBM7lpo8etyee8SaDcP+s42cT85itOp89409WW8QHKM
         iOPg==
X-Forwarded-Encrypted: i=1; AKwUvBwbd8NPkqXS3JpC+Fzan4PnYlKDckeSQW6uUgFa9131Si8ZlG3znVmSs4Vt5ojANY5JgPN5OQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9r+g9RJLz7WEcywWqPFkhzX2FGmqiLcGDC/iWG8I06REiJtK/x
	hd9QMR4RAaI/jHBfYxxtJ5fpeCI6N+zpsmPaaxI0+nZXC1FB4owLgFJB
X-Gm-Gg: AYBFou3F6WfteB+b3tq+BhPxu+5yiSktKbxg6v15PSWiUyyUskcb2MELUQaqV0cyBtg
	F3Nn9wkvkzpVpeytCDJjZgCDibN+oR867GuJUhvc/v+AyDCMX6zJNduzj4Njafg1SZkZHweuo38
	Y39jTOQ3cKp/KSMkpGiP97rCLW8REgo+o2Z4KVudEAvFDn4pvgacyU3VzsvVJt4LviLX7gDVOlD
	cS7qjshPxv0WFs/kx53JZwFW5WuGaEaJPugmrJlJjwDB+YMxjf4o+RJ7+ige8ctC2AN0g9j7laU
	cGqVztuh8+qwC5ctVY3cD8gLuhLgSF2VsfNLbEpe12y5QrjPiTQI55u13BCmhqa3h014hW5noXA
	LO62dARV64mpA1OnHvx+3oN6UTRlvZL5OxNGVGGyGVQRdBriv0i/c6fQNsNrV2f8brWf7tswHZ/
	ZKOXWKT8kSnRPvWyPXooWflMPemxqHw+ZUJR1E82uBSzy31BnLbQIBYMiPvjGtRPJOW0almgnbv
	bitaV6jtnL3Y39yPYo1deO5RxvArYrfSuMJ3ALj5GnbEWWyIKMXhkq+urMy403gbMsniVWQT8+F
	M2WlhSmNS0P3zqD3fDZXr5nVg7aMExkgztm+8K57yn5Mv8NuqdGWmVR58BmPbzjyKp/gDmP4J06
	WkqFN7O9sCA+07MtsowrrSgZBVDqoWaZdpB9cjbbViyWYolZ+9YwuSnuPtg7Dy2RSjhMWxGkUhA
	==
X-Received: by 2002:a17:902:fda7:b0:2e9:c569:7050 with SMTP id d9443c01a7336-2eb365116demr91088175ad.47.1793604109917;
        Sun, 01 Nov 2026 23:21:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392ae546sm23619805ad.70.2026.11.01.23.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:48 -0800 (PST)
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
Subject: [PATCH bpf v2 05/15] bpf, sockmap: Clear the resume state of a stopped psock
Date: Mon,  2 Nov 2026 07:21:02 +0000
Message-ID: <20261102072112.4160195-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
the psock. When the socket has no room, the function saves the length and
offset of the remaining data in psock->work_state. A later run continues at
this offset and clears the state when the skb is complete.

sk_psock_skb_state() saves and clears the state, but only while
SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
each skb. If the socket closes during the loop, sk_psock_stop() clears the
flag. The loop continues, but the state of the completed skb stays. The
loop uses this state for all subsequent skbs and sends only part of their
data. A closing socket may lose the end of a stream, but not the middle.

The state belongs to the skb at the head of ingress_skb. Always clear the
state when this skb is complete. A stopped psock still saves no new state.

Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f03519468ad1..a5d498982848 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
 			       int len, int off)
 {
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
+	/* No new state once the psock is stopped, but never keep an old one */
+	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		state->len = len;
 		state->off = off;
 	}
-- 
2.55.0

