Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604104;
	b=qEhAzTz6e/Mh9tS6t8mlRFy/PAwDNmZqnJKBGoqOULnOkCQFavuqscHMxACEayajhM/7
	 laZFZzrrTqDQIs1JsTfTwZr1sMybyQ5zKusoxOTM4gUWWdG5RvD+LdYYeKrIFfwp2bfGA
	 Tclb2OEU94+t936kZm3lrC+J1jdn2bzfcP7iOROxu/Gi6tAmQX+SEwoiMkrYNyWEYFFIR
	 ArWxgZMo+ysuK7aNqagFt2cBCZw2mqCaALwHmX5IPIAQlIwcucT7SGuzIJLwOYb/mPNG5
	 zTX+Ep4GbrQvDdVfse7UMrO5PKh/bNhUOz4dCi/CaXDhNbIpb19L81bkirHAnEC3YxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
	b=MItQ9pWQlkw+N7s6OdSo2l5FvSu364hQTFyvaSXkW1E4PStQuRjo5maq64gWtqDFb/iJ
	 XrqwBr8ZvDVAaPl/BflRMYjLj7P/pB1bArY9Dnhhstaszd3cmHyBlsMR/3TlLwNH+3Cvf
	 bPxNFURBGWeYirEJJH2XyYM3/VMClcEotsJWpOMcNTEpbpshUgJ2CupItCt1WpwupyGnO
	 qEVR7aYCB3AS7SIlmo+GwTBd8KikvhuVgyqJPEZx3+6kiy/VJKVEiY/DTgRzMjpzMCQ1y
	 /TcC8VtLkIXMJMTVBfJ/tIOcWekBOkhRA+QMREqqq01cfTAk9LmnHCB9WJR+69KnrRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=luIqRAt6;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224F606A32C
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A224F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=luIqRAt6
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e987b4a710so19496315ad.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604103; x=1794208903; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
        b=luIqRAt6IQRez7+ZRL+qzBM/7jLO9IKHB8d1exKPvOEQy+IUvuI0rmj+sdgtFus40x
         oHqPYQIrkJFT0dMwpP2KYp13JO8CnmZ7SPQguvy1GmqicALV9n6Xc1x+roIC5896ngOI
         nGJwehX5VhAlyhGmRVKPnMAsBSVMiBIgR05QbdseBz3UqKc+RdHD5EzWtmIiZ49e3cyO
         JJF5cz88iB/P7NlAbSwOVp9GWhs2JfpdypZhG1CLzqWHXX8LRCicoCvTSjkp2PjnW9uM
         8APhU4LRUPz54nJAo5eqxavlSsFlrqefJDdYkDucnEdS/yVO88ej8/u6VHgn1tMQQ4D5
         i/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604103; x=1794208903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
        b=Bmgtgyw0wnSY0rmRcEx9fcgIEDNM8tAYWmuG6Iw4OZ2TncdLK8qtrWc6IYF84olGGO
         a9rXaSMkv6qub3nl2IrGnbXc2ns5Rtk0oKK5Umnr7DgQK5wmK0nD6p4e96Drbxrzr4cF
         Fv1u7L9Y+jMv4bfm6sQaMFNpIrucS8zVDQ2mMp+5qhCG3O3gT4LY3gu4srSAExCwTjK5
         jDDbKX5/Nb0hyckwpcCaX3R25QHl5eREKVXvmh0hIr1iULAMxSq9TLSl6/9wy+1KdA57
         HBuEPyPCPifYvvFc3SsFUVf4m/ZfDMisJkN1h5ifFh/wy/SQe8OqFHHPUojpB2NbPLLY
         M+ow==
X-Forwarded-Encrypted: i=1; AKwUvBxIANAD/k63MvtzdSg6YRmI7ks4BvnHCA3R+RvTZicibyIjgkUg4lGQIh17lsiL8AATLqPnwA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+oweNJK/Hw8XdNqHNiYJ/R9D5pAljaCKtNHbEn3HvfcKxISVyZ
	6MjtEVDFdSdzuwplG1HzDQdBb2X/f60I5gOMTd0NXv8gFE6jg2bVVoyM
X-Gm-Gg: AYBFou1hJbIbYgrqPmjx6lsPihlafkXZVW5ugFkKe5rq7V0MDqu61JMMQNvDVhAmvs5
	jtY6ZKWbDUiNInipAecirM7sJJcq2l1sUK2AtJx2fabPXuzGrWuVE1OdLvwHaU6rdFFYjTDurBl
	L8oJY5+W4ys3s2jvRq6YEElRO9VaH74KpgB/ERmfSelRSB61oWyoPEG9fMBwswbyYG4aK8mNHar
	0xs1p9gobJnVVc04qfjWlTxMYZy2c5rQzL7+b5ZDkkczPjfb5Cz3swenJeb9WERF95g+Ut/6uHF
	fOc6OBptaE9wvHoJh4iRoGL+biIQ0QPe2LghjQwIHlaNuCwoGbVSSdNJxwAxtDyTyzcYMCcFCS3
	nM5UK9jJ29cHB/PBwjptd4dR99c9sMk23NH4KwclLeorFLnxzQT5t4xZgXA7L3Pu0Aify7q4+43
	DqiNTjOh/bCQOAyl3cK6YLYJX6B/1TxCKtrtrVh/cXofkiE9G7iUJbWtStcaurDzcVUDxzvQ8lp
	yqPL6TtlBvb9bwQRVp3o/PFwEZkS4xzr+uvHv+SUrU58kDODFI7Ixf5HLcRPPWvzWb+UwB+YtdH
	8adCRUdRDkzIuYwGoX+qK5uke669ZZHSPx0h+GAr/pvezqNevP5FHly6HnoZ/vD2g/V8DlsFnbw
	TYSmEOvhjrBV+wQgFhHdMvsGYJBt9/Og9BLyJnNgH2lW2fJS6Ol7OPhCMonf3ANpKs/GOyo93kG
	4=
X-Received: by 2002:a17:90a:dfc7:b0:3ac:6e91:3f1f with SMTP id 98e67ed59e1d1-3ae6f00cccemr7838997a91.37.1793604103048;
        Sun, 01 Nov 2026 23:21:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm2753697a12.24.2026.11.01.23.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:42 -0800 (PST)
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
Subject: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
Date: Mon,  2 Nov 2026 07:21:01 +0000
Message-ID: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
message. It then subtracts tosend bytes from *copied, the return value of
sendmsg(). But tosend is the number of bytes that the verdict applies to.
After bpf_msg_apply_bytes() tosend can be less than the message size. Then
sendmsg() reports dropped bytes as sent.

Subtract the number of bytes that sk_msg_free() frees. After an error the
SK_PASS branch already does this. The SK_REDIRECT branch does the same if
the message is not the cork. Nothing changes when tosend is equal to the
message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.

Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b016aa419fb2..36d1bf46353a 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -521,12 +521,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_DROP:
 	default:
-		sk_msg_free(sk, msg);
+		/* All of it is thrown away, not only tosend bytes */
+		*copied -= sk_msg_free(sk, msg) + delta;
 		sk_msg_apply_bytes(psock, tosend);
 		/* The verdict holds for apply_bytes, not for ever */
 		if (!psock->apply_bytes)
 			psock->eval = __SK_NONE;
-		*copied -= (tosend + delta);
 		return -EACCES;
 	}
 
-- 
2.55.0

