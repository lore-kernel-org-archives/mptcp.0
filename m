Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE51844
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1649673626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpDc4gVMBDRc+/UUbohG0qL7+IGhwbwPzENfYTvKhmo=;
	b=PTO18LU50Jo6CKKceOLEq1K+TYKZb+qWjo/0xryr6Dwbkn7PiTdZCfqZ8KcUBioPb048aN
	MeaigL0FoyamAtzcABXKmhm0rzQLHMIfmLXM2fbsBIUcNCCw/nNdRIqRXqYhsEF4F5RLgJ
	98WGXngZJyUhrSys3aemAK0sAF+vKxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-cqfo8of6Oiipd-U1vfwPbw-1; Mon, 11 Apr 2022 06:40:26 -0400
X-MC-Unique: cqfo8of6Oiipd-U1vfwPbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5454805F7C
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5529040E80E0
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [RFC PATCH 4/4] mptcp: add more offered MIBs counter.
Date: Mon, 11 Apr 2022 12:40:05 +0200
Message-Id: <66a6c06373c3905d5b0ecf4fc082cc3750f5479b.1649672265.git.pabeni@redhat.com>
In-Reply-To: <cover.1649672265.git.pabeni@redhat.com>
References: <cover.1649672265.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Track the exceptional handling of MPTCP-level offered window
with a few more counters for observability.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/mib.c     | 3 +++
 net/mptcp/mib.h     | 5 +++++
 net/mptcp/options.c | 6 +++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 6a6f8151375a..0dac2863c6e1 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -57,6 +57,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
+	SNMP_MIB_ITEM("RcvWndShared", MPTCP_MIB_RCVWNDSHARED),
+	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
+	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2411510bef66..e05428838005 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -50,6 +50,11 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
+	MPTCP_MIB_RCVWNDSHARED,		/* Subflow rcv wnd is overridden by msk's one */
+	MPTCP_MIB_RCVWNDCONFLICTUPDATE,	/* subflow rcv wnd is overridden by msk's one due to
+					 * conflict with another subflow while updating msk rcv wnd
+					 */
+	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with another subflow while updating msk rcv wnd */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ffc0292da041..dc84f39ff9f9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1249,8 +1249,11 @@ static void mptcp_set_rwin(struct tcp_sock *tp, void *opt)
 
 			if (rcv_wnd == rcv_wnd_old)
 				break;
-			if (before64(rcv_wnd_new, rcv_wnd))
+			if (before64(rcv_wnd_new, rcv_wnd)) {
+				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICTUPDATE);
 				goto raise_win;
+			}
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 			rcv_wnd_old = rcv_wnd;
 		};
 		return;
@@ -1278,6 +1281,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, void *opt)
 		/* RFC1323 scaling applied */
 		new_win >>= tp->rx_opt.rcv_wscale;
 		th->window = htons(new_win);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
 }
 
-- 
2.35.1

