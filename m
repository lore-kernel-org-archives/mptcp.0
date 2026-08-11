Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E442123D
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485110; cv=none; b=Pp3VCWo4GyTqMlHHV8s6+3ejki892FxPSmOkKO2GxKDZS53roDpKDs8Nn+u06ew79dPIUU10m8OIZEl83eXJ0IXLi2quLxhNNZqa3JlUbI7rwMKOFpOzqz0bSFGinTUklf0odtSwN6bCvzhIsvsCbbZwwwqXTnmyhV9IJQoVE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485110; c=relaxed/simple;
	bh=Azo2sCiZllD4H75gWaBzm5I3JqLlnW6xlX7nRXQnSss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwLjkwyMfyNWPkc9Cp3aJEU0Fx3xkuvrbLG6gFH4k1MQ0zI+SIqFRycgAp/hcY/eFAEOaOafLpbvXFr6+o89ISqpEeKw7OdNjW1uKNkofPuLYUdHLoGIwTCwSwfFCPF2WoA5XOcimg3rXqrDMbL5FlzqqImpBkI+2JP0W7RXg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYv8XvE3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYv8XvE3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso392577a91.1
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786485108; x=1787089908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=sYv8XvE3brRwH5VsJNpXp9hzEbY0+zFhA6d7U4nyqH95uSZ8aQTYpzJwCcH/P5d4AF
         biPmuGWKODzJ5+5SlKkf9EBd3/VuSMytdBIqYgRpZmTMmPQy9LriRgVFkaweM0TZCmOs
         LBo263TYDmwofb0e/LXJbwVn3o7zjimM8W7zqzZK4JmR8Ghz0YVXciecnYX1+UI3YpDg
         3OfvC18Pf3um89TcVkodNMsGHEIwkOEbtYeEQMyaftB59/ibv9f9/TqyZD/bkB73pcZU
         xF90k9hfrvzXnDeiduGrIBXX4Cnnfcz2A8pAh/bun9sJwByamsNS6XcVtWq2NMm+9WTP
         UYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485108; x=1787089908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKboDhjvAevX2LxnuClRbMjZPu76/sbW2vcejkifeck=;
        b=WcZCFE8QqzeTePy67jxODg0usjyhhRX0eKEo6oJ/aK0hZKGxHw726g+GbdsiNgV87z
         GAela0eg4BEdNB5DPahowi/on27Ae9OkHO1VwS2av6L+QfQhBMqpnv6u5ddWZnJNzrkT
         xeur3MzAzPJkt0KM6kKxPkhF9qXPlfiu1/L6FuUnNbtITGbXjeufAqSnvlW4GBjcQF7z
         l09Zy7GzftaajRSTflRuxoF866+29ltndI1tXRNQeWBJCTX9eImFJk7FW9xl91qfKkw8
         tgqma/899bO2Np7m8P7zzCeyzY8ru7EYw3trNvWf6wd89K6hnq8GCXiOKc8Od83fM1zU
         gZBA==
X-Gm-Message-State: AOJu0Yz7yiW0xEsxksbuquS8yL0HWlgR29OiLz7F/DYmkzOaS1bUjWjA
	MLx5JAqCIjxqRY/wuSW/MQ/E9+0wZKOFW7+H7/VJh6rmmUxNYHhBGH7F
X-Gm-Gg: AR+sD11neDvlQ+e+yguycj31XZK3ErVnHxAGS/TtkhAQ9lC9dZrifoufkXzKkLp6UbU
	3N5JnR4HtYzvnVtFVUoz2BJxqtaQTFiic6tMYGb6hM7xIzbwnPCvt+vV5aMq54nL/HHDmX/aF+s
	s/hpI74S0CMny9MlQlQVozhHzTDP+EvukK+2IeF8Mk2qfvPGInImkC2ODYkLDgB32t0gV7AkNEX
	4a+XjEdjK13aHLpO/7nt2SlDBe8ynsRLp/o1TokiYyN1+uv53bpteujHCm+fUVq8Xk7lIeA1G6Y
	FL9lF0COJK+/q/814d34GTZX+CZy/LHEp88OrQIC9DT+6ty1v53sIe+pibtdQZCjR9/CcCHcr96
	SQJ1bcWb11q2Iu9eXkSLM7gq4o98IjI1oaxtYy7Ptb9pRt7vgxR558ZoQYGH5eTqq9UGQ/HPrbl
	OYvlKAYbR73NPy9rrL87PBbhRlwZn0+Fy32AXe/Ll9YXX8VNvu4megDmGufJTzZXpZ0qxgH4Pnq
	CwenbT+vJAHxN5ntllMCfNtlIlSa94FmZVV5+d4DtMAioY=
X-Received: by 2002:a17:90b:3810:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-392f3f7b5e3mr1932237a91.9.1786485107720;
        Tue, 11 Aug 2026 14:51:47 -0700 (PDT)
Received: from LAPTOP-N5EO9J2L.localdomain ([106.202.115.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141245a9f70sm3672334c88.15.2026.08.11.14.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:51:47 -0700 (PDT)
From: Harshit Varu <harshitvaru666@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	security@kernel.org,
	Harshit Varu <harshitvaru666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp] mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction
Date: Wed, 12 Aug 2026 03:21:35 +0530
Message-ID: <20260811215135.87756-1-harshitvaru666@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_join_cookie_init_state() restores remote_nonce, local_nonce,
backup, join_id, token and msk from the saved cookie entry when rebuilding
the request socket for a MP_JOIN 4th-ACK handled under SYN cookies, but it
does not restore local_id, even though the SYN path saved it.
subflow_ulp_clone() then reads that uninitialized field and stores it as
the joined subflow's address-ID. Because the request-sock slab is
SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the value is the stale
byte of a previously freed request socket, which an off-path peer can
influence by sending concurrent MP_JOIN SYNs. This corrupts the path
manager's id-based subflow bookkeeping for the connection.

Restore subflow_req->local_id from the cookie entry, as done for the other
fields.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Assisted-by: opencode:deepseek-v4-flash
Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
---
 net/mptcp/syncookies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index 7f2252634..b5cac5701 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -118,6 +118,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
 	subflow_req->remote_id = e->join_id;
+	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
 	subflow_req->msk = msk;
 	spin_unlock_bh(&join_entry_locks[i]);
-- 
2.53.0

