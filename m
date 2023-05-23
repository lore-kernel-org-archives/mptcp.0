Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CD21CC4
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684863458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5MZ7X8cEnhQexiz+B+zelgFndxl8TyL71FbIKlzSBE=;
	b=YBmC1cZt83z0rC95aZXc8nXxwB8XV3AKnDOQzSl3iIFMm4EB5e2w+nl1Tw7QG3vbdcpPSD
	G5dte+sTxmhADzuGGDuL6n6twNe8q+7nI7LnyVaogoK+Szs/wZ5px+w9HfklVM+mW6bzIA
	LspPJxydWPE4HmuJ2LFEB38b/a5kD6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-IH-vWssYMWmGw7LJCEeDiQ-1; Tue, 23 May 2023 13:37:37 -0400
X-MC-Unique: IH-vWssYMWmGw7LJCEeDiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60E96800B2A
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E36C6140EBB8
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 6/6] selftests: mptcp: add MPTCP_FULL_INFO testcase
Date: Tue, 23 May 2023 19:37:29 +0200
Message-Id: <85fa749d4bb3818fc92002eaf74cdfccf53fb31a.1684863309.git.pabeni@redhat.com>
In-Reply-To: <cover.1684863309.git.pabeni@redhat.com>
References: <cover.1684863309.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Add a testcase explicitly triggering the newly introduce
MPTCP_FULL_INFO getsockopt.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 76 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ff8fcdfccf76..e4cdf4af75c3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -86,9 +86,25 @@ struct mptcp_subflow_addrs {
 #define MPTCP_SUBFLOW_ADDRS	3
 #endif
 
+#ifndef MPTCP_FULL_INFO
+struct mptcp_subflow_info {
+	__u32				id;
+	struct mptcp_subflow_addrs	addrs;
+};
+
+struct mptcp_subflow_full_info {
+	struct mptcp_subflow_info	subflow_info;
+	struct tcp_info			tcp_info;
+};
+
+#define MPTCP_FULL_INFO		4
+#endif
+
 struct so_state {
 	struct mptcp_info mi;
 	struct mptcp_info last_sample;
+	struct tcp_info tcp_info;
+	struct mptcp_subflow_addrs addrs;
 	uint64_t mptcpi_rcv_delta;
 	uint64_t tcpi_rcv_delta;
 	bool pkt_stats_avail;
@@ -365,6 +381,8 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 		olen -= sizeof(struct mptcp_subflow_data);
 		assert(olen == sizeof(struct tcp_info));
 
+		s->tcp_info = ti.ti[0];
+
 		if (ti.ti[0].tcpi_bytes_sent == w &&
 		    ti.ti[0].tcpi_bytes_received == r)
 			goto done;
@@ -386,7 +404,7 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 	do_getsockopt_bogus_sf_data(fd, MPTCP_TCPINFO);
 }
 
-static void do_getsockopt_subflow_addrs(int fd)
+static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 {
 	struct sockaddr_storage remote, local;
 	socklen_t olen, rlen, llen;
@@ -433,6 +451,7 @@ static void do_getsockopt_subflow_addrs(int fd)
 
 	assert(memcmp(&local, &addrs.addr[0].ss_local, sizeof(local)) == 0);
 	assert(memcmp(&remote, &addrs.addr[0].ss_remote, sizeof(remote)) == 0);
+	s->addrs = addrs.addr[0];
 
 	memset(&addrs, 0, sizeof(addrs));
 
@@ -453,13 +472,66 @@ static void do_getsockopt_subflow_addrs(int fd)
 	do_getsockopt_bogus_sf_data(fd, MPTCP_SUBFLOW_ADDRS);
 }
 
+static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
+{
+	size_t data_size = 2 * sizeof(struct mptcp_subflow_full_info) +
+			    sizeof(struct mptcp_subflow_data) +
+			    sizeof(struct mptcp_info);
+	struct mptcp_subflow_full_info *sfi;
+	struct mptcp_subflow_data *sfd;
+	void *data = alloca(data_size);
+	struct mptcp_info *mi;
+	socklen_t olen;
+	int ret;
+
+	sfd = data;
+	memset(data, 0, data_size);
+
+	sfd->size_subflow_data = sizeof(struct mptcp_subflow_data);
+	sfd->size_user = sizeof(struct mptcp_subflow_full_info);
+	olen = data_size;
+
+	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, data, &olen);
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP) {
+			fprintf(stderr, "\tMPTCP_FULL_INFO test skipped due to lack of kernel support\n");
+			return;
+		}
+		xerror("getsockopt MPTCP_FULL_INFO");
+	}
+
+	assert(olen <= data_size);
+	assert(sfd->size_user == sfd->size_kernel);
+	assert(sfd->size_user == sizeof(struct mptcp_subflow_full_info));
+	assert(sfd->num_subflows == 1);
+
+	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
+	olen -= sizeof(struct mptcp_subflow_data);
+	assert(olen > (socklen_t)sizeof(struct mptcp_info));
+	mi = data + sizeof(struct mptcp_subflow_data);
+	assert(mi->mptcpi_subflows == 0);
+	assert(mi->mptcpi_bytes_sent == s->last_sample.mptcpi_bytes_sent);
+	assert(mi->mptcpi_bytes_received == s->last_sample.mptcpi_bytes_received);
+
+	olen -= sizeof(struct mptcp_info);
+	assert(olen == sizeof(struct mptcp_subflow_full_info));
+	sfi = data + sizeof(struct mptcp_subflow_data) + sizeof(struct mptcp_info);
+	assert(sfi->subflow_info.id == 1);
+	assert(sfi->tcp_info.tcpi_bytes_sent == s->tcp_info.tcpi_bytes_sent);
+	assert(sfi->tcp_info.tcpi_bytes_received == s->tcp_info.tcpi_bytes_received);
+	assert(!memcmp(&sfi->subflow_info.addrs, &s->addrs, sizeof(struct mptcp_subflow_addrs)));
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
 
-	do_getsockopt_subflow_addrs(fd);
+	do_getsockopt_subflow_addrs(s, fd);
+
+	if (r)
+		do_getsockopt_mptcp_full_info(s, fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
-- 
2.40.1

