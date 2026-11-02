Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604091;
	b=xcFxRM3Urw+eD91H9u4uAeGonECllHPquyVMifXaOUE6OIeNquWvEiKbdm/0AtpRLVBH
	 yM8641Ow7ew8DwZZjD9ClqY1qsEgL2EoS9E40UNSK+dT9nH9UKsaklQ81tq8vYPciXCx5
	 jecLgLKLQ5ezGx0WMyxDM2xpQni5dQ1GTDMXxoDeX2gWZKNjz/+C3i7rg6T9/ozaiZgww
	 2dYzPFWEInboYqNobKuxLe49meXDpXSMjvOQQHK4A+LeLX7kAFw4VqWWhDBuD+Xn/8rC4
	 4gNqxahlZK53r4X4EyxKdV5gkWXd+lOOA7XmDFm2jtYhGt3PYXOBqxp8ZW9j6P+dpdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
	b=raT7S8CWeeCq3ywoxbOCxEVDdF4c6JvzwvMzUFS5dsv1srrMhD103yCXVKJgXTbfw6I/
	 NE/58G7pbBT7a+9YyKgg7Xj/K4vK8UlZS99i/WKRfi+U/PlmgxidHLm9mrsvysCIYlmSH
	 Bnw+psCx8GhvVpU7eKyCjifs7hhZoTembry9g1BBvdJJoZ5P5nI2Z4BDFouK/f7IEMI3g
	 fI/6JT7A6k7hG7ZuPZWcKAfd+lpWuprZOESgnAMX2zxNnS/xOLbsDsVkIWdLMj74s84RK
	 wTaTLj+8AVuXkVnbJ1MhhM9RtAeyiXnHfIJBs5g07SzwDQredXdokLKf+IvV1F/wx+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NKATjFub;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E59606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E59606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NKATjFub
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1355120a91.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604090; x=1794208890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=NKATjFubBFyN/7hWIQkbnMW15vHfODdhCtSNwGEupl57OE1+CLnCJXyUs8SbMI/5NK
         sACB0H/mSO4eV42WulXt/+eVRUGTfr/1GbMek/Jib6TeOAwq6itsyJ2lNBITsUE6Ny1j
         nThKU5h9130XJOBD06np1v7L550uR6Ws8traHJ72YMIa9xnDV8JPgEw9C5IdQuQCfn4F
         Ynk1XzRbx5pDMDxAIM/EqcRfSuWzyHvpszePQ4werq+kDVPLTr8upHpTz5Ra8MN0U3SW
         jTe/ZED6yT+Ovdbc38St+Qu1XaSAKbzWmGLmTPh0rzL33PdLetALfXhF57V9QfhxYHoe
         OO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604090; x=1794208890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=PEamM4MREa/BdlQ+T1ezUB2859bhUUIPqBY8LAtDZNi/z73+y2XjoZ8VqM+XBdAvjH
         ZQmn2s3BgQ2CJptYamGb091aNB3ROvvD1ZHUx93C+RJZLcyc26yghvZYgUigR3kwNT32
         u6Vf4fFQrb01YGMEd0wD9JhlpKsaAOjemgpZD+IGplFYRhzXu/OYOEvY3F6SpQHaNBdj
         ezZ1UFElE1qL7TaarssM8kGOnJxtlW8hgw5BZJXGg135gHsfUEGXLYBOloxYV9ZdnBQ1
         q8Y9aJC+M9cgAAgnUmDZjKg3m6uXHrTBgnCiOzWuBoutl/QXx/NljO7WzXHc7FgLCB9R
         XuiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZydbsjzI6YNanTHro/g2+fbwOa/PtR8TtleQgpyAKeUZCKUyD/bPHrudLse829CnKDGjyvg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/lMHOCM3QtNQhPUYYc7u5IaPVLXvWaf5IEiVyqR0sqWWAUwbPJ
	mX3m6cyJLT1Iz7m91v0+LPEK7wEIjOY0HAR1PtPXGTMSSq6VaaokbFmB
X-Gm-Gg: AYBFou2FQkcq2rRjhaZlN14YaU0orxupFhRXlGgyHT1grzOiBNSbzijO8EibpgYS496
	hlYTlQH/1w/Ng/BfqItkA8hHZGBZX0mEvZ24qTFw6vJc7c2s7UCsPQd8I0vOg8mcsedjioatEOJ
	fupLnU9PwxhupRxxP9WlvDR6MEytcZ6QmBHH0YVb26SWzwOssdnCdMDGsfo4AVUrKaH+HH+jEsk
	xHJ5bOzR04KBDYeuUnZMuhGDHdNhrgiRAFFD7DpsxvGq6Bxgy4eoqZ+O0wcsKQ/whsdnnLBuvri
	JrIQui950yc2nbQqCmp+BH8E4pyoOO0akTq4hwU3/2iu9aHDkrHh9AXvPgryWZG8BNNpWHr43WC
	Wo6ONDzBfCMXz+aETZCZ/mHvH02eiGkdD3cdegIr8Gs368n1O/6iV2YopMVIRnIW8V9XE0NkJuL
	QGD6G3CQ91QB8oM6eGcU1NMmUHBM75RaFj/YhVOGtFPEc0K0dPsInX5e5e5qFo6HADHXkMUMyj6
	ltNiw1Z+iTfuBNmal+GEILwB5yhcGiy8Ycde1TSNV8rM8eSK1nK94ygpMIgI0/8uYp4IKlbfqww
	UlbCT8yt9jp+iURFLbFby9dnEGssxavKBazvgdOpXodNUGcwaG1JmV+pDevGQs2TjI16lO5RBkN
	b3DU8pEZyHeLjO1KeFKDr2AI8yeDRVsLk3fVyLxDw/rieaYUvFuXfijvOVZwqVCb1lkUZL/HOpA
	ET
X-Received: by 2002:a17:90b:4b8a:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3ae8974656dmr6955366a91.27.1793604090070;
        Sun, 01 Nov 2026 23:21:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm18000578a91.1.2026.11.01.23.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:29 -0800 (PST)
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
Subject: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
Date: Mon,  2 Nov 2026 07:20:59 +0000
Message-ID: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
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

The verdict of an sk_msg prog is valid for one message, or for the bytes
that bpf_msg_apply_bytes() requests. These bytes can come from many
sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
that resets psock->eval is after the switch statement, but the __SK_DROP
branch returns before that code. Then sendmsg() drops all subsequent
messages with -EACCES and does not run the prog.

Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8cf63a9e7fed..d90bcc911b36 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	default:
 		sk_msg_free(sk, msg);
 		sk_msg_apply_bytes(psock, tosend);
+		/* The verdict holds for apply_bytes, not for ever */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
 		*copied -= (tosend + delta);
 		return -EACCES;
 	}
-- 
2.55.0

