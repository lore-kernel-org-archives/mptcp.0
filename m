Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1037DE9C
	for <mptcp@lists.linux.dev>; Tue,  7 Apr 2026 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551529; cv=none; b=S96Mm00950T3oeKdWBVl8JtXJvNj4bCcTxS8uGMer6cCqc0R1w9XSB31pbe+qt7SjYuTNygNv+dfXyo93l4YsK2CuIrGHWQ09+3JFh1fRss1aVem86CuxYSHPkys2ZwpRXgdXhSVEG9fgnVr/+Um5w2dP//1zPFhNfHzskVhRZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551529; c=relaxed/simple;
	bh=g2eW1nMdaW6VL+m0ASgXi99o9/qf9CWGwcJAU1pHkKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkCYA8bik1HcmwrJC4SQK86/B+53wpsAAjxkDTgE1U2RyNgub37XzF9Gp+JMVxr9wV4bcEXt3oy+FLq1RSEg8eVD8YRd6tVpyLLfd3q+3VSt33sap6kIXzpAroGy7i7nDjpgFZyi5/JLpKJrS7vEyQjwCqGhVhYI0t0MZbWaK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mSRMufMr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mSRMufMr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775551526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UhkCR8dMWNhP0Ox118MboKkrzRl7+ZLC3l7hzIYGbw=;
	b=mSRMufMrKD5MHwzlj0hlL3FCLwpqm0N1g+oIg8gu1rXd46hOCBjFUesnJ0enu7I29SuWes
	hSmVJYho6iRyP2aXlDg5o6UeEs7wIwl5SYNraIZamUrKl7G9m/sDq7y8CqcSIKxlUSQPmt
	bD0lTNoToyFU+UORKvBxBlzjGD5WwEU=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v3 1/2] mptcp: sync the msk->sndbuf at accept() time
Date: Tue,  7 Apr 2026 16:45:17 +0800
Message-ID: <79d5862da1c7db353e27c56a26da78e6dd548659.1775551182.git.yangang@kylinos.cn>
In-Reply-To: <cover.1775551182.git.yangang@kylinos.cn>
References: <cover.1775551182.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

After an MPTCP connection is established, the sk_sndbuf of client's msk
can be updated through 'subflow_finish_connect'. However, the newly
accepted msk on the server side has a small sk_sndbuf than
msk->first->sk_sndbuf:

'''
MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first->sndbuf:2626560
'''

This patch synchronizes the sk_sndbuf by triggering its update during
accept.

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/602
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..6f6c8cabf74f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4252,6 +4252,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
 
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
-- 
2.43.0

