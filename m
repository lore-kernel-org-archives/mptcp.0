Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCC8BA35
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684999051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWH2EfHSYdsRTUncJhIKmnCKyeCK8zpc1t1M/miAwfM=;
	b=jUq9et1ALs38XIEV+84sfj4zb2LdH5HtwjP/GUuIRWqfzssCy4iHVNNKekrHgcy4BDGPvd
	RBGtCtlbyHqmMRIlCcNTZr/rsA7nfx+OwKkEv7SQ0yt0WwBPUE1R5l2omYuPn3dbfaUXQE
	Moo3LKZezi5Dc/I8GUb0NBZgbsLcvcI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-e2ZQLKH7M_uKZ39O1QRwTQ-1; Thu, 25 May 2023 03:17:29 -0400
X-MC-Unique: e2ZQLKH7M_uKZ39O1QRwTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62EDF29AA38F;
	Thu, 25 May 2023 07:17:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C1D44492B0A;
	Thu, 25 May 2023 07:17:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v6 mptcp-next 3/6] selftests: mptcp: explicitly tests aggregate counters
Date: Thu, 25 May 2023 09:17:10 +0200
Message-Id: <955947697cb63678edf9b674f95bece320056746.1684997011.git.pabeni@redhat.com>
In-Reply-To: <cover.1684997011.git.pabeni@redhat.com>
References: <cover.1684997011.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Update the existing sockopt test-case to do some basic checks
on the newly added counters.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - be more kind with older kernel (Matttbe)
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ae61f39556ca..ff8fcdfccf76 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -51,6 +51,11 @@ struct mptcp_info {
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
 	__u8	mptcpi_csum_enabled;
+	__u32	mptcpi_retransmits;
+	__u64	mptcpi_bytes_retrans;
+	__u64	mptcpi_bytes_sent;
+	__u64	mptcpi_bytes_received;
+	__u64	mptcpi_bytes_acked;
 };
 
 struct mptcp_subflow_data {
@@ -83,8 +88,10 @@ struct mptcp_subflow_addrs {
 
 struct so_state {
 	struct mptcp_info mi;
+	struct mptcp_info last_sample;
 	uint64_t mptcpi_rcv_delta;
 	uint64_t tcpi_rcv_delta;
+	bool pkt_stats_avail;
 };
 
 static void die_perror(const char *msg)
@@ -318,8 +325,9 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
 	if (ret < 0)
 		die_perror("getsockopt MPTCP_INFO");
 
-	assert(olen == sizeof(i));
+	s->pkt_stats_avail = olen >= sizeof(i);
 
+	s->last_sample = i;
 	if (s->mi.mptcpi_write_seq == 0)
 		s->mi = i;
 
@@ -556,6 +564,23 @@ static void process_one_client(int fd, int pipefd)
 	do_getsockopts(&s, fd, ret, ret2);
 	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
+
+	/* be nice when running on top of older kernel */
+	if (s.pkt_stats_avail) {
+		if (s.last_sample.mptcpi_bytes_sent != ret2)
+			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
+			       s.last_sample.mptcpi_bytes_sent, ret2,
+			       s.last_sample.mptcpi_bytes_sent - ret2);
+		if (s.last_sample.mptcpi_bytes_received != ret)
+			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
+			       s.last_sample.mptcpi_bytes_received, ret,
+			       s.last_sample.mptcpi_bytes_received - ret);
+		if (s.last_sample.mptcpi_bytes_acked != ret)
+			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
+			       s.last_sample.mptcpi_bytes_acked, ret2,
+			       s.last_sample.mptcpi_bytes_acked - ret2);
+	}
+
 	close(fd);
 }
 
-- 
2.40.1

