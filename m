Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560944;
	b=cbxCg9zr1WAFymdobm7lgl0NbBCTKBCHZgudtTu+QNZASf9JITDi6uIcecP7+Vv8lhIU
	 v9BHgF/jHMH0f60tDJ59CdMmi72Z4MSgD2iJNTX+43D/J1fE0JOP5BS26k3VTmFXpVImQ
	 f06x8y6AOip55X9/fIaPh54+D503o5SytmBljHGNGYDmbC1K2xiqoxSUt2/s+ExWJvTVx
	 MevmjSsqwY17/mhujJe1rb/lxuM9TZSbh5RZnRDRxZzQP7pa1j4wMKl6BOLAud1O5uKKz
	 0Bae+6mPCR85bfyFmewP49Jll+YCaqZEKmVBlgMsS+GzGhcT1KXzV4rIWAIxEex+pcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
	b=GeFF+Ny4yF5SbILCVjQRWBb9RET4iopvryhJlCy7B5SbWna+yUGBS9pvU0QJQvaP7jiI
	 udIYHvRbjolW9Fe3SeWfqtvGAiXdg9Tc841BcWBwRXfbcqNmsmDN289SbV88cTmp1m0D9
	 aACAlIlt1xvXioA+kTF6QHp7qct8Q49Hc+HL80LHAQ9UMnBmG//XfsdRsfhUU8M5dkyMK
	 /acXruspmPsQcB8Z11+cj8mSXeMzI//RMq8JnR3+w+xDG3MsVkBPlMvkr/40eGaXuA6v3
	 D1CQYCdtg/P3jy7zAI89Ev7OBP08Ykdo2DuG/+qLCljkKllRee5SwzBCyn1a6H67U0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfnQQD+b;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D8606A331
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB0D8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfnQQD+b
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1891093a91.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560940; x=1794165740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
        b=xfnQQD+bL+Kup3LvQL4hrXKPPiiAfX6IPhqu7ISlVJTpEnH04+f5qDn5piATmm3gmT
         B8+Qo5YSnsfjxEmwt9L3V40PcJkz7L+SpJRo+hEwy5xmT1ntyRHERQ9pxQUwWqgF2+Ym
         95v+u6xbkppRR2AOtjenZ08rNN6kKEwYpe2C68hmKjYAwkeCi/I/6ptgkbLS+nlMZIYV
         /rORbUmdw2OBNGrJjGdHClNy5AOWNll/eTRiDuiXjuBLxrwedoxyOWZBMORU3N0wefuC
         rkT9O11eicEj0xaXs8qKuI135hn1DPRrxGoVdUU49YaS77wV3XbxyJW6jYz3ufrzZUKQ
         os8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560940; x=1794165740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
        b=FE7QximcpKbS4uajphb7gbOU5i48B9BYojgITHups7j/F9l5ZhK8HJV70Z5LwQl1Rd
         JQq5SJfpl61gyWmkxlM+jopW/MgUfs16Ciw/XdvFzKksTFfkobHXXRN43Xoy3F9GSuqh
         Xu5KeulfFLYuyZiKO8ZgnUDRfYCTf30zeYYPkJ2RjNturrzLDY8XbdxlgM3HAAMMD9NU
         Is7xkIdDUvvTy+Z/ZgPd6i+FLpcRsg2eDKBmSNpWPD0AAGjnLVRSS1IETShpAaLS56Jh
         klm/jrdURn91fzSaj1gtKZDnPxfUESJQu5QYQBFQeU9GnuFq/U3AUNz5/1E7hpwsXCQc
         vuCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwa3QgcXvo2SK6UL0tDj87LYpPBp1KSvIWlk1Kad0hVzi0ac7vMAvLeDapoElqjDtgyDMF1wA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+wZoMRLDJ+y+XAopq3aMuqpDn9Xtif5TK1jDsdEJrLlCjrPdGy
	ueQuKe7wShxSndoPlXkj044Eye6V5253NbJEyU5SEQZnVs4vVOcP44vX
X-Gm-Gg: AYBFou1w0O4UCs5qG/ACIfQN0Z1qX3LGYy7ed1ofyXP6HaZGy4wfhHrLbatO6jSkFRd
	pKkJnDS/D86LvLVX2wOuAkwR5H4Z9Ol8F4iIrnFP4jBTuLZeBrMDVinLG2SEchvBj/O7Q3W16jQ
	kuG7sr/pVo+BjxmMu9K5rX4OFj15mhyYqjboG5UnpEmHMfHLUNtG4ta6DLp1YspeCUMJIKft224
	L98VjBPGX/k6291VRbb128sryNdneKzi51dtX5JRww/Ml/RFiBAlcJLGPfddojFTMi1DXe8wL4A
	qOWXXfz3KsIX9zZAmpGeYIds8o81PhiAjL2xbNoE2gNnHnzmwS2bmqBZV10JLadXPOfTWKNynG8
	5nImFz3Ers7N7NjlsJN0yocHp/1vkdDxlUnAnfkYR7Etr9DsymOplDXFxKLjoiwVVm+n/akfwd/
	cZHaZmZdC7fEnmcQW7+4w/468T9jeelPoidNsPq8r+EBG0lRrbUhv18sVkhj+acBOf4Uit5ZEwj
	3VtLAtr0PFmen/OJj/yNy0FMJYmUv/1iX7WTIbs8+E0NaqBqrmB9FR5iLsHQdKdLBfORbKKn+Zw
	OsZEA+ggKiT1zDXFeuJ6NoTD7Bo971Qya/gfpT+dEQ7kMelgNDK7agfbUnI27C0MEBItB51loq+
	gCa/tJAhDT9df7efk2kjf2tgMWbMZmb9ZThyDUTNSSBTEz41B5KzDe3/728YRBrMFS6ge9wquUo
	s=
X-Received: by 2002:a17:90b:5344:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3ae897eb378mr6384359a91.22.1793560940036;
        Sun, 01 Nov 2026 11:22:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm15190285a91.2.2026.11.01.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:19 -0800 (PST)
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
Subject: [PATCH bpf 13/15] bpf, sockmap: Check that the redirected message is the cork
Date: Sun,  1 Nov 2026 19:20:55 +0000
Message-ID: <20261101192057.2296489-14-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

In tcp_bpf_send_verdict(), msg is psock->cork or the sk_msg on the stack of
tcp_bpf_sendmsg(). If psock->cork is not NULL, the SK_REDIRECT branch sets
it to NULL before release_sock() and calls kfree(msg) after the redirect.
Thus the branch assumes that a cork is msg.

This is not true after release_sock(), because a second sender on the same
socket can make a cork. The first sender can run the branch again, and then
psock->cork is not its msg. Nobody sends or frees the cork of the second
sender. kfree() gets the sk_msg on the stack, and the kernel crashes.

Compare psock->cork with msg. Nothing changes for one sender, because
psock->cork is then NULL or msg. The other branches do not change, and a
cork is still not safe for two senders on one socket.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a450b1ff3cfb..9bdcbb0a5998 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,7 +509,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			psock->eval = __SK_NONE;
 			psock->sk_redir = NULL;
 		}
-		if (psock->cork) {
+		/*
+		 * Another thread can make a cork while this one sends msg
+		 * without the socket lock. Leave that cork alone.
+		 */
+		if (psock->cork == msg) {
 			cork = true;
 			psock->cork = NULL;
 		}
-- 
2.55.0

