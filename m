Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604084;
	b=CKneM2iEmipVrS+WvX9QrUl2g+QA0ZtGkvBl1mXkOVPGnfMwP1wSv4tk61sNRTBr7JIR
	 zVBTtn2QYqfNNVSpKhCkT2NzR1B+OOyihtNaYZOB5Z3wm99rII61WsJFxOUjNW+WClx5H
	 6ThLHhKm1BpRpJOVvx0PVIEaD4AFyEQPjCPCYpxLewBc2Lc8Z7CPByrgt+nBYEQsmde/M
	 ZOd32HNdhSh2VfXg55RcuX+7UWNoRq2oMInKKo4NLtR/XMESCmhyGbvdcdvHwNitIJZsz
	 gPpxRji2r8hcGH6jBnuGVCqmqaexKbi9BP0a1EhwCQojLp+r7zw6Zi1tA5K/n7nsCeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
	b=EN/O2ODtCgB9DgJt4vqUyK5CZiX+/c8FMduXcTwHJl9rp7WmUtvOprf2toz9emggIaaj
	 AmerrD4gy4Q85VFjNb3NDqpKI7BXzwHa0hyxQChHzd+L+P1/Aza8nFKcRbzWlB8viTYfS
	 SU8hv4D4tM2q5o7qOOx2vDIZO1K9atOJ5+3yqig00zugpAJrjfAFXzQQ2JxOFglgyAzOV
	 pKKndRJX59HioMZHTSB3OubeAeojDOzkynJTfK8Z/JXwO5wUEPqXRJxn1xEyVoAYfEz7s
	 igZ4FTkYHv/xylSFAVFCKXPyY6TbZQRooZUh9G2zNCDKVqucdspO2JpRSXkogJg5CXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a/oGZgUD";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2C606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C2C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a/oGZgUD
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3226450a91.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604084; x=1794208884; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=a/oGZgUDDaX1vCLkex90yv6+RU3mk5w96+80wA7Az4xyW7foAZ2B/gFIhHKxEWx5zf
         tbg0BuVrOBP1U8fWIow9Zyn2E6rQdhV3kw8h2VLw1lHwG+h2ZS7x5UqCHN4++hRSK+Za
         hRwEl8oY4e3hf/tBaNszWhg5I/HKQeqpD6Srkxi4X9C63fI4Tm3ftEOuKTZ3CnL/Sghq
         Dc6mD/m/x+OV/azGISMikERWOvUbFLPZ8d9gUQHdsLsI78GDzNFj+2m29NAs0YSqKWLj
         AnGLF/To8FwtalQv7EuiROjQ7DKCu4leBwgX6AYHMeVng+G605vAq2/4hzlhD8j7ILu4
         YTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604084; x=1794208884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=vlM9MfxefDj5kg0iY0ykVx1+jA1XFWyqXf2OEFMls/Baan9zQTRdcnvohtB8dgbx8W
         zo9HbZrbWYSKIGp6MTc20fJG87ACwoBqJEdwKNJet2ZaR1wvlNZGkJxyBHQW6pCDS8/9
         O1Sp2jIQ7RzMjmT1ZRJfJhJJxgYu3aY9h0n8TidFrARzNy8Y9gfCNgJwX2BYj//L24jK
         j1PQT+dQzpFpGkRSrYZTB4X7R3Fu2rOetahKOPv4LX2lNLQb+0M0k8DMurtsqsNsxni5
         gQAW6rMLImPmiG6H85q/HhZCgXUNyHIDRBBzWdwwW+SMl+weUhBThcPiu9+iQB0P92T8
         +TnQ==
X-Forwarded-Encrypted: i=1; AKwUvByr3BP32F5GdZOTG3MgTa/EkCmVT8C9O6hDRvv3vDU8hwjwjmUBrCYpLOgxW2OZMbzZxmPPQA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9r+qQZEllVQpWEBCDGQJlh8mrP6xEBy7hukCAZj2jdyyYI+k/e
	Ey7KR1AO6AvO4olt3LAy0wtAGtrG1dVbsd4oOtadEeDptJyd20wvLc0S
X-Gm-Gg: AYBFou1TwW/aW6LAGKQWabLXqe3GfGK6JJuVy2lPjT+8VFR3SRi7HDzspUX8a6Q0WE0
	Dj2EhkxpXpHk+F4eutHdCAe1ni/163rbaETCKl8MmpyGSTJHTxjlN9aJa8a7mDCxcG0E60Oznyu
	g6t+VtXOw7ppqtvANS3NBpZis57d1DsKSnD8g1AX7RjWSGzuAkPbll3+8fey8a/dfXD4psosI8v
	K5mmwCNjYpzFVY501Ve6uHQKD5Y6CRhVRSMawGZo7utHkt3bhQbw+TID/ERe4WyL9sVGpC8bHwX
	tVfOfNgZgxkoUxAA1jbZtfD3n5dfDjxN14Fl1ak9uiTJth71bti45QKLfgy0HjFb+u79rACiuwV
	JDJDGXD25zIcM8mTCWR7KtoCv+8ijbl6Dr3shw2CsEEA8QpvT2TYc9JgppllLbLebx8w+elwSJF
	wbLKhxyU6Fns/OZeWv4hBp99agJcw1fd3xCSZkggfPHCe53QbqIntm+oxvpLp3SEo1XrztrRKFM
	aG6f1s5uYJzBH7CckfSPnbhYyq3jgTfT92PKeqmybhVctbCbtr5LLA6uKs/9bA+/newhcYQ/uZf
	qsiV3mAtCnXfR8QRZb4BTneZjgCEBao3GmWAFbQSaSvBg74AH0FYnIbJMs+M5gj3c0hEnyNfY/h
	9XJc8f+RC8SdMGPP7pm4auHbye1B28mtHbPppCsF9HgHd/CDjUKh44Sn1FvVc7epKy8d9FwdHtp
	s=
X-Received: by 2002:a17:90b:53ce:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3ae89817b01mr7725554a91.41.1793604083734;
        Sun, 01 Nov 2026 23:21:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm17877536a91.7.2026.11.01.23.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:23 -0800 (PST)
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
Subject: [PATCH bpf v2 01/15] bpf, sockmap: Write sg.start when recvmsg() faults
Date: Mon,  2 Nov 2026 07:20:58 +0000
Message-ID: <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
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

