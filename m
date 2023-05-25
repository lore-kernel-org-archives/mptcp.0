Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE27BA22
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684999053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L74qtqh8bMuRnovWRiTK9aMYmptT5utFOEWeDjxrmkc=;
	b=IX2M4Sy+Kfc3qVrNWT+6ChhU3swvPAV+2fgJqIb6ZuMae0F/rOyUPt8WQif6BqzWkVi0/K
	9DP0Lz7+mKo0+BnxzcOcpuDHXtPZjjjjxc9R0BQk2oY5m0nHoFUasa/0xDG5Zu0CG92c/V
	d2gf29BKcHwZOqbbTl6Skti1l0nzxZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-x-hM45xXNz6e3nFRj0hxww-1; Thu, 25 May 2023 03:17:32 -0400
X-MC-Unique: x-hM45xXNz6e3nFRj0hxww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03050101A53B;
	Thu, 25 May 2023 07:17:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 673BA492B0A;
	Thu, 25 May 2023 07:17:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v6 mptcp-next 6/6] selftests: mptcp: add MPTCP_FULL_INFO testcase
Date: Thu, 25 May 2023 09:17:13 +0200
Message-Id: <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
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

Add a testcase explicitly triggering the newly introduce
MPTCP_FULL_INFO getsockopt.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 91 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ff8fcdfccf76..568e95599355 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -86,9 +86,38 @@ struct mptcp_subflow_addrs {
 #define MPTCP_SUBFLOW_ADDRS	3
 #endif
 
+#ifndef MPTCP_FULL_INFO
+struct mptcp_subflow_info {
+	__u32				id;
+	struct mptcp_subflow_addrs	addrs;
+};
+
+struct mptcp_full_info {
+	__u32		size_tcpinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_tcpinfo_user;
+	__u32		size_sfinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_sfinfo_user;
+	__u32		num_subflows;		/* must be 0, set by kernel (real subflow count) */
+	__u32		size_arrays_user;	/* max subflows that userspace is interested in;
+						 * the buffers at subflow_info/tcp_info
+						 * are respectively at least:
+						 *  size_arrays * size_sfinfo_user
+						 *  size_arrays * size_tcpinfo_user
+						 * bytes wide
+						 */
+	__aligned_u64		subflow_info;
+	__aligned_u64		tcp_info;
+	struct mptcp_info	mptcp_info;
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
@@ -365,6 +394,8 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 		olen -= sizeof(struct mptcp_subflow_data);
 		assert(olen == sizeof(struct tcp_info));
 
+		s->tcp_info = ti.ti[0];
+
 		if (ti.ti[0].tcpi_bytes_sent == w &&
 		    ti.ti[0].tcpi_bytes_received == r)
 			goto done;
@@ -386,7 +417,7 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 	do_getsockopt_bogus_sf_data(fd, MPTCP_TCPINFO);
 }
 
-static void do_getsockopt_subflow_addrs(int fd)
+static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 {
 	struct sockaddr_storage remote, local;
 	socklen_t olen, rlen, llen;
@@ -433,6 +464,7 @@ static void do_getsockopt_subflow_addrs(int fd)
 
 	assert(memcmp(&local, &addrs.addr[0].ss_local, sizeof(local)) == 0);
 	assert(memcmp(&remote, &addrs.addr[0].ss_remote, sizeof(remote)) == 0);
+	s->addrs = addrs.addr[0];
 
 	memset(&addrs, 0, sizeof(addrs));
 
@@ -453,13 +485,68 @@ static void do_getsockopt_subflow_addrs(int fd)
 	do_getsockopt_bogus_sf_data(fd, MPTCP_SUBFLOW_ADDRS);
 }
 
+static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
+{
+	size_t data_size = sizeof(struct mptcp_full_info);
+	struct mptcp_subflow_info sfinfo[2];
+	struct tcp_info tcp_info[2];
+	struct mptcp_full_info mfi;
+	socklen_t olen;
+	int ret;
+
+	memset(&mfi, 0, data_size);
+	memset(tcp_info, 0, sizeof(tcp_info));
+	memset(sfinfo, 0, sizeof(sfinfo));
+
+	mfi.size_tcpinfo_user = sizeof(struct tcp_info);
+	mfi.size_sfinfo_user = sizeof(struct mptcp_subflow_info);
+	mfi.size_arrays_user = 2;
+	mfi.subflow_info = (unsigned long) &sfinfo[0];
+	mfi.tcp_info = (unsigned long) &tcp_info[0];
+	olen = data_size;
+
+	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP) {
+			perror("MPTCP_FULL_INFO test skipped");
+			return;
+		}
+		xerror("getsockopt MPTCP_FULL_INFO");
+	}
+
+	assert(olen <= data_size);
+	assert(mfi.size_tcpinfo_user == mfi.size_tcpinfo_kernel);
+	assert(mfi.size_tcpinfo_user == sizeof(struct tcp_info));
+	assert(mfi.size_sfinfo_user == mfi.size_sfinfo_kernel);
+	assert(mfi.size_sfinfo_user == sizeof(struct mptcp_subflow_info));
+	assert(mfi.num_subflows == 1);
+
+	/* Tolerate future extension to mptcp_info struct and running newer
+	 * test on top of older kernel.
+	 * Anyway any kernel supporting MPTCP_FULL_INFO must at least include
+	 * the following in mptcp_info.
+	 */
+	assert(olen > (socklen_t)__builtin_offsetof(struct mptcp_full_info, tcp_info));
+	assert(mfi.mptcp_info.mptcpi_subflows == 0);
+	assert(mfi.mptcp_info.mptcpi_bytes_sent == s->last_sample.mptcpi_bytes_sent);
+	assert(mfi.mptcp_info.mptcpi_bytes_received == s->last_sample.mptcpi_bytes_received);
+
+	assert(sfinfo[0].id == 1);
+	assert(tcp_info[0].tcpi_bytes_sent == s->tcp_info.tcpi_bytes_sent);
+	assert(tcp_info[0].tcpi_bytes_received == s->tcp_info.tcpi_bytes_received);
+	assert(!memcmp(&sfinfo->addrs, &s->addrs, sizeof(struct mptcp_subflow_addrs)));
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

