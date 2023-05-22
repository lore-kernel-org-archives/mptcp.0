Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5E13AD9
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684763815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgP1ZzpiNEFBi8XhtbBvMrPWaYdsaWtddgJhNEuZcZw=;
	b=XLBHEGroJ6rNQ1D1pymKgvNTnonmyajVi1yWyTlHPLaPb1X//kcAr7aGK2VyzSze4Olrby
	WX33rAqamNEq4Zq9HEpEmyODSfXKeFF62Zwdv07s1EkzhkC6Vkq+f4PROztFYQHVVV0bGP
	g/nO8L+gAWua8GM1IPSKk/4SJFjmE0M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-APCNgOJvN-imMuw9giB6Wg-1; Mon, 22 May 2023 09:56:54 -0400
X-MC-Unique: APCNgOJvN-imMuw9giB6Wg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FDE8800159
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:56:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.191])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 989B6492B0A
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:56:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 6/6] selftests: mptcp: add MPTCP_FULL_INFO testcase
Date: Mon, 22 May 2023 15:56:32 +0200
Message-Id: <3f923bfd4a136085d4058090a3cb6a7f72cd8a2d.1684763197.git.pabeni@redhat.com>
In-Reply-To: <cover.1684763196.git.pabeni@redhat.com>
References: <cover.1684763196.git.pabeni@redhat.com>
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

Add a testcase explicitly triggering the newly introduce
MPTCP_FULL_INFO getsockopt.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 76 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 869c041c34f3..598e0f2c592c 100644
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
@@ -367,6 +383,8 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 		olen -= sizeof(struct mptcp_subflow_data);
 		assert(olen == sizeof(struct tcp_info));
 
+		s->tcp_info = ti.ti[0];
+
 		if (ti.ti[0].tcpi_bytes_sent == w &&
 		    ti.ti[0].tcpi_bytes_received == r)
 			goto done;
@@ -388,7 +406,7 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 	do_getsockopt_bogus_sf_data(fd, MPTCP_TCPINFO);
 }
 
-static void do_getsockopt_subflow_addrs(int fd)
+static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 {
 	struct sockaddr_storage remote, local;
 	socklen_t olen, rlen, llen;
@@ -435,6 +453,7 @@ static void do_getsockopt_subflow_addrs(int fd)
 
 	assert(memcmp(&local, &addrs.addr[0].ss_local, sizeof(local)) == 0);
 	assert(memcmp(&remote, &addrs.addr[0].ss_remote, sizeof(remote)) == 0);
+	s->addrs = addrs.addr[0];
 
 	memset(&addrs, 0, sizeof(addrs));
 
@@ -455,13 +474,66 @@ static void do_getsockopt_subflow_addrs(int fd)
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

