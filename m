Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF37E7
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683218412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoaN9Co0RE1kwiNkUoLTtI8ryt+zs8qoIO+TEn4OKgw=;
	b=S3EAsS5J/dy6luUh+L3Uu3IGdb/aotBwBGEFAursTrkWADki7K8ARoDkBtiGfpVV47j3J2
	Dvm3aMqOGl93HMYPUegPJkLxmmTuWOD+9Gg+/HfyXOisxNbRRU6IwgDomcNFbkKF9Ad2Wk
	B/uiaxTXvoCWiJJpvHvDugUn591PeKA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-3zx9QauINhO5xpahCWqY-A-1; Thu, 04 May 2023 12:40:10 -0400
X-MC-Unique: 3zx9QauINhO5xpahCWqY-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 693EF299E74A
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED6501121331
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: explicitly tests aggregate countes
Date: Thu,  4 May 2023 18:40:02 +0200
Message-Id: <b616382e36ea891a36f74a7508a004593afa8a59.1683212362.git.pabeni@redhat.com>
In-Reply-To: <cover.1683212362.git.pabeni@redhat.com>
References: <cover.1683212362.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Update the existing sockopt test-case to do some some
basic checks on the newly added counters.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ae61f39556ca..0c58de3ef339 100644
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
@@ -83,6 +88,7 @@ struct mptcp_subflow_addrs {
 
 struct so_state {
 	struct mptcp_info mi;
+	struct mptcp_info last_sample;
 	uint64_t mptcpi_rcv_delta;
 	uint64_t tcpi_rcv_delta;
 };
@@ -320,6 +326,7 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
 
 	assert(olen == sizeof(i));
 
+	s->last_sample = i;
 	if (s->mi.mptcpi_write_seq == 0)
 		s->mi = i;
 
@@ -556,6 +563,19 @@ static void process_one_client(int fd, int pipefd)
 	do_getsockopts(&s, fd, ret, ret2);
 	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
+	if (s.last_sample.mptcpi_bytes_sent != ret2)
+		xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
+		       s.last_sample.mptcpi_bytes_sent, ret2,
+		       s.last_sample.mptcpi_bytes_sent - ret2);
+	if (s.last_sample.mptcpi_bytes_received != ret)
+		xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
+		       s.last_sample.mptcpi_bytes_received, ret,
+		       s.last_sample.mptcpi_bytes_received - ret);
+	if (s.last_sample.mptcpi_bytes_acked != ret)
+		xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
+		       s.last_sample.mptcpi_bytes_acked, ret2,
+		       s.last_sample.mptcpi_bytes_acked - ret2);
+
 	close(fd);
 }
 
-- 
2.40.0

