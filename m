Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4516A93F
	for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712396; cv=none; b=Z4psZyTF4vf5toZ3BSEBRoaQQRENgl9TcPzAsqZohQ6Bm00V8XgnPAhARN203LvWpVocI88MpcCmFyZ2XgxgUXERixmUusf0o9bJOsWd6EGfthvJOCdiZVLJHqz5Bm/0B3ynoXg4JEwQXZr77gbFFuxfbCQzvmkUGaXP3gCUgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712396; c=relaxed/simple;
	bh=/8hfjipBRbGO/JeaUmL3swIPSyyfYZ6/wCbBD5jA8lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZsHijeY9seDYO9q7DBJgK/mc6bBl7T2Tfl3X5STValpsEMSMEyq9TNI9Rs6kNNk9oQCwkh/yLJCAuv0cD+cRPKP9cKPalVhIplfeVzIG/3ISZhs2/aOtpUWPO4qu8bXE4GsVtlx8CbbBNza31BVlmWTO5MAfaL3EKiiWTZf1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNypbzcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNypbzcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A7AC4AF09;
	Thu, 11 Jul 2024 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712395;
	bh=/8hfjipBRbGO/JeaUmL3swIPSyyfYZ6/wCbBD5jA8lY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iNypbzcOByWlUa3Eas0X4xE7uivChc35+/TDNWOTlqsjkvRqYhnnmSWYgTccVTG2E
	 SnlTJqo6WIaChm8tH6m/YoABjGP0LOhQOc08o+87/BEFTJ6IEP31IkYTuy4tbQIeRR
	 YrCipmLrvQF5VVzxYqFtf3Cufd+uEQ/q9a5/Akff/SkYzTWWuQbT5adQfIyB+Ceuf8
	 QQOPnDbDwHU3KJlPnJlM80c+si9C6oGFh7dtS5fCkZVMjP8YMPIsu6VcT9V86/HoG1
	 1Y0LNikZonLqFHHjlJ8kUptJkcOGO7vWhk+6aVS+uLfixcapeLvMHZyYwVxQH/H794
	 EnPiARW/1Zz2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 11 Jul 2024 17:38:58 +0200
Subject: [PATCH mptcp-net 1/6] mptcp: sched: check both directions for
 backup
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mptcp-backup-mpj-v1-1-d45506182a9e@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
In-Reply-To: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/8hfjipBRbGO/JeaUmL3swIPSyyfYZ6/wCbBD5jA8lY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmj/zIvsAR31P5iK9DeRpEfHgVfIj8dqpmcsqxb
 faYLpuU5GWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZo/8yAAKCRD2t4JPQmmg
 cxjuEACqLWjn8Hjp/Nolk69MzaP3mzN/rQ9HUZJHaEFkuzhlQJXOiS+lBFWU9KwWVWT02pNS+zS
 Dn/DcEbiVcpt9zRc3lmcYy7GPmIHbfsS2OAEZDTjLECMlfO4F7qs5bAkv0ZNzC0qjVfT5kUuRew
 JBpb5FebtvyLKS8t5cWBe7ld7gDZh90DLGqvDo3//+w4V1fWjZATcClmmN0HwEad/bG0NowdKv5
 0Rk7VxV6SI0VN9TJhzw6g9rYvICCQSMbHVbqFw6zjyyR66fY6mB045mW5LjrsuCogYYg/0RoJKQ
 Zn3lcRiFDc4mP63/KfKB52sP0nknn1BZ5Z2aj4iH/BlJID/9Kupyxj+BiwJFp4KgGkLzbEo3M5M
 ZICEvZm8HFK+Ik7F8ArNKa2yx6uEG6nM6WPvNedXdMigesHrkfWiEWN8Q2j1dfgTnAc9W8mnrIi
 R7mFaujaQNo9YYS+NhlFmbE4G+8IwWIJnA+KTSwHsxvwICLkT9qAVN8nELckLIzj+dBLxz5jbTo
 yy3U7GWg8GbxEjXD5oRhr3TKILNncI0UgsKGgFnL11dmaVQlpAhJnh1IuPsdw7cv5yjsYCc7P27
 EzTTIVOd3vuPAgktPX0ar2bFfe+X/QhmBCiCRYvd2D75aXvUyy9MD6eW4CFW8PjXGIRqoh87RBj
 F/vQTC/P3D+pB1A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

- 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 09e72215b9f9..085b749cdd97 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac94225489f8..b3a48d97f009 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1422,13 +1422,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		pace = subflow->avg_pacing_rate;
 		if (unlikely(!pace)) {
 			/* init pacing rate from socket */
@@ -1439,9 +1441,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		}
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);

-- 
2.45.2

