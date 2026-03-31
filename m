Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8A397E9D
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948133; cv=none; b=VjLisi7D+e6VRMYPXhGRExQZPcl0mcbf3z3xzTM85KA0kRWPpNx6GmTaryF/oMYelc0ltx/YjAehmHAa2xox3ECwvVis6btJjDXN8FjTX6TuEm/XANomEuudV6Kow6vsyJL9B5pHQ7dHELHGxNg4CBQoMCOE4kxVr5vz4Qni9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948133; c=relaxed/simple;
	bh=elMmdLOrpTKl4qBuCEJAl0CE3HIKPSe6Ubuw1f/aaFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYw7CzKKV0t4No8R/2XF/o4apacJSP7KHBVpke8OYt8cL2Gt88F641+Qt+bfz71qtosGaKBakhrEIJyo7+0e769LW2LImrRCfzEBdMUD4P0yzs68CTk2vYbZklRLGQgnkjgvh9r9R80yCdOAOEPi0NRY7SnEiPpyEhqZl620O64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TarAf+Z3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TarAf+Z3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774948129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcYDBZs3rhWln/EMaIzHIR9xKBxU+t4O+m7ah8aEOyU=;
	b=TarAf+Z33/u4rrsoAOJ1qVJmTTf3HG6n2kNxoYi9xgUswu3KwE/NtE7A/O1x4/9FV7Jfs9
	QHeR4OJoNJ8yGNya7mx6IdUm3Pf3miJIkIKPE8DWbAshrfZYL+OBovc7zjpjv7d5HjepIc
	efBoXMpZDKkogQpZLCH2EWMu/b9pQHc=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] mptcp: reduce 'overhead' from u16 to u8
Date: Tue, 31 Mar 2026 17:08:08 +0800
Message-ID: <f6126a1dea5263fd2e934a0bb135755215e0fd7c.1774947296.git.yangang@kylinos.cn>
In-Reply-To: <cover.1774947296.git.yangang@kylinos.cn>
References: <cover.1774947296.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

The 'overhead' in struct mptcp_data_frag can safely use u8, as it
represents 'alignment + sizeof(mptcp_data_frag)'. With a maximum
alignment of 7('ALIGN(1, sizeof(long)) - 1'), the overhead is at most
47, well below U8_MAX and validated with BUILD_BUG_ON().

This patch also adds a field named 'unused' for further extensions.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 4 ++++
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 46fedfa05a54..01690a84ea6d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4624,6 +4624,10 @@ void __init mptcp_proto_init(void)
 	inet_register_protosw(&mptcp_protosw);
 
 	BUILD_BUG_ON(sizeof(struct mptcp_skb_cb) > sizeof_field(struct sk_buff, cb));
+	/* ensure 'overhead' (alignment + sizeof(struct mptcp_data_frag)) fits in u8.
+	 * 'ALIGN(1, sizeof(long)) - 1' represents the maximum of alignment.
+	 */
+	BUILD_BUG_ON(ALIGN(1, sizeof(long)) - 1 + sizeof(struct mptcp_data_frag) > U8_MAX);
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5d4d7d030f2..afdead91a4d7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -264,7 +264,8 @@ struct mptcp_data_frag {
 	u64 data_seq;
 	u16 data_len;
 	u16 offset;
-	u16 overhead;
+	u8 overhead;
+	u8 __unused;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.43.0

