Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4325778
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705348; cv=none; b=C2Qj7C9k1zCl9ATDFL0v7FmQ8iP48alH98M8c8WzEUML2w5rB6znt1SC2PoJybTzFa0fOFxypECIu5oDeuT/EJQHh25HSFGQXNTFEgeOs6sj8N8xhDK3jnr/V8zNcFU0UdqdBxZyLJGh+n5ltZGCMSrL+2xGg8HSef2ohOa6J60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705348; c=relaxed/simple;
	bh=9qNNMAnaGDoHyW1HZgQoK9McqbHkDDNpeCATG4/7Jl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwp9Tx0gm9tWZxjpexSRG2Zd8CMfnWC9HQtOqhGQYJ0Qn2yXtBf4mwK5RcaLWwox46Jn2gkziaX0b3cNuf1WyU7xMJGMSEoyt9/CUr8yZcZeleNUAr3BLCssFa7lZTSkMpnZVBT8av4A/bg9i86MEzjWKWbcGaMUKQAGrLHEOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqznmJgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqznmJgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1845C433C7;
	Fri, 29 Mar 2024 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711705347;
	bh=9qNNMAnaGDoHyW1HZgQoK9McqbHkDDNpeCATG4/7Jl8=;
	h=From:To:Cc:Subject:Date:From;
	b=NqznmJgxOS2NtYe4W8EN32nwjw3EJjkHD0rSiamZjcvsf3QoSkn7pbNmVwIBw643l
	 IiJGCm9oboD8m690tm54TNnPfC+QNUJuVc2AdYnakBQ6OIvMjKAqlAiXwVjNw3ZnrG
	 hwwLYF8YVvXRVxAhggaH4TuIIMRgXHqmjURgjRZzuXoX4AFq/fdUKi0aFBMnPylAcX
	 AMA9TpXr+hfbZ4z3rqKZMXBJy0yPQHJfEyzlrEpOECsaVCcIEJODWvSTrO7I/Xuac9
	 wL/IFlvvYZX9t4KTIZP+x5w2KXafDakmf6o5wd+xHmUZQwRKV12SWZ1XX3gjfwV1w8
	 Hxx5mYhFg9+6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH iproute2-next] ss: mptcp: print out last time counters
Date: Fri, 29 Mar 2024 17:42:22 +0800
Message-Id: <fd9e850f1e00691204f1dfebc63c01c6a4318c10.1711705327.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There new last time counters have been added in struct mptcp_info named
last_data_sent, last_data_recv and last_ack_recv into kernel in the commit
"mptcp: add last time fields in mptcp_info".

This patch prints out these counters into mptcp_stats output.

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 include/uapi/linux/mptcp.h | 4 ++++
 misc/ss.c                  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index c2e6f3be..a0da2632 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -56,6 +56,10 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
+	__u8	reserved[3];
+	__u32	mptcpi_last_data_sent;
+	__u32	mptcpi_last_data_recv;
+	__u32	mptcpi_last_ack_recv;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
diff --git a/misc/ss.c b/misc/ss.c
index 87008d7c..81b813c1 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3279,6 +3279,12 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
 	if (s->mptcpi_subflows_total)
 		out(" subflows_total:%u", s->mptcpi_subflows_total);
+	if (s->mptcpi_last_data_sent)
+		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
+	if (s->mptcpi_last_data_recv)
+		out(" last_data_recv:%u", s->mptcpi_last_data_recv);
+	if (s->mptcpi_last_ack_recv)
+		out(" last_ack_recv:%u", s->mptcpi_last_ack_recv);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
-- 
2.40.1

