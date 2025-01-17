Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0F1F5618
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096576; cv=none; b=P9SzAnwx7cUG43jxXIWvB9FfDxrV6XILhkKTwDRaqc6WbhGy3j33VZ6NHrLa4gZSqAMPc6ZqqC0tMDE0ptLTxbZDCgvMqAp4b2R6qndqlKxN5bHN2d5LFVnows0Jn7QNypwdRF7tKD7jYOZ517rff0CkFKDatpDa6x+0wQ+ce1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096576; c=relaxed/simple;
	bh=ZxjDsd3u3KFDFo7kZrCXYD65eAMDp3Cq7PWqxmnMd2I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qmFmlVf+9weZjCWBMeCI8LVgbfUMWHC5rtO9l+fZv/pIPFa6UmdKAashH+9sgqquBJ5F8ZARej150nLtsH4sfEe2mteDXxImuVL/ZNvs39otjjuGaxKVrYYWlu68bgDXWST7JXcaIDsqAubU0UcnG8tCJZSMpCGinRpSxbtnBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MNgq0hiy; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MNgq0hiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737096262;
	bh=gqNF1UImp4yUCp/wqicd1QbvS4x6eumsM1Qjh2KZeWM=;
	h=From:To:Cc:Subject:Date;
	b=MNgq0hiyMMIHfXO26+IXiLBIcMAhf5G2v4vLiXF7GXhLo4o8ywTepg1rm4M82mtq4
	 MXcfbe1sWsshggbPo8tvHOh8Xxf85bW/yqjwCUutsRkCswLlz6+ANM20jYVa5HwhuR
	 ey3IvGgLy8US+ZbXePfNxF3lq0N3ZecBy+2YJrYk=
Received: from localhost.localdomain ([39.156.73.13])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B14A1ED6; Fri, 17 Jan 2025 14:44:20 +0800
X-QQ-mid: xmsmtpt1737096260tgsw2ungw
Message-ID: <tencent_EE06C3EF8440C6905D8EC0B94E3E4A589905@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIef0RnDnGGujEc9aHHu2abC1OzxfEIiwe7QjitF3Z8zPv38ILwBz
	 oMcscNVD9IYSd5GUjPzHPqniZ0fSmr+tu/wfcFUOYvX6PlTTyK3zokIEkiraTD1pJLan0aZOyOxk
	 9ScfHKdaaSCc+P7/gvcASwQ72pdB2ioB5Xo+tujAewfFg6DQTHpOM2qD9QWtxf62bTrB5CbII2Lw
	 WuuQwyFHvlZjp/uQc4Su3SXQc+Za3v2rKaH8VvF9fVNKVywxif+CpVqpNASoizSg3nndz0gqmX5V
	 u9GBiTzdDNazi983HaoGyy3PsbwtRERdHgk1YnzfYOwnN7u4tX+37xS/vILaHqbqV+ZStFb0FI+1
	 Gvqc2SCDAa7FWsf3UoQqd5yPHPyx5V+PgEeOLyOwWzGNc9TTEqCI+bmNYrpk6tkfyP2J7UIxcgCp
	 jLH6E4K5C3Nob+Ickzp0/5c5HLnEDG23Id4yErTPwK29H+qEjWiTJep7+XfoV7h8fcPL//+FfRbS
	 qvqlo0cSOfODPLDEhrbD7o7zCl/WViq3b6QVrYwRMjJAVzlAmvqlIUTM/BwJlztysA3bsTuYMLYb
	 M9GLt0SJTfDCbVsGEzoiKBAokAnLCav6b2CvM2p7J/DbpnhG8wHxOaNqiL90W/yiwHcPR5UvqcXf
	 tP9Dae6GeqaZlv7NPP5mOnff/UJwwAMZMNPfOy2qEhHZTScxTI6HerrS7TjwCkTU0W6CfJHmooNv
	 SJOGaEBiFYRRklhUq/li2OAWA4JJNTo2yweSbrPo9Lyo3Ix8WuFrSzE9KZiM6nk6p9y26ew6d0rC
	 FjgG8a7i0nCZOVIdCCs2vFYjvt62OuPVCnzYgyMo7mGWqtkVX2sM/h1gAEFhvIlO7Ku0LYwV1dFD
	 f9ND/SEWBomtiZo/nwgQMEjCCJniHyJwgBGLzeqhL8CeEd7k4GqYk88wyWLug7UlwiiBgTrccM3n
	 IXTBioNq8=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	mptcp@lists.linux.dev
Subject: [mptcp-next] selftests: mptcp: cover 'mptcp_diag_dump_one' in mptcp_sockopt
Date: Fri, 17 Jan 2025 14:44:13 +0800
X-OQ-MSGID: <20250117064413.133234-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Through code coverage analysis, it has been identified that the
'mptcp_diag_dump_one' function lacks test coverage on the testing front.

This patch introduces a function in mptcp_sockopt.c, which is built upon
the 'inet_diag' module, and integrates it into the 'mptcp_sockopt.sh' to
execute the 'mptcp_diag_dump_one' function when server bound a socket.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 76 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  6 ++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 926b0be87c99..caa0466d827f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,10 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/netlink.h>
+#include <linux/inet_diag.h>
+#include <linux/rtnetlink.h>
+#include <linux/sock_diag.h>
 
 static int pf = AF_INET;
 
@@ -250,11 +254,77 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	return sock;
 }
 
+static void send_query(int fd)
+{
+	struct sockaddr_nl nladdr = {
+		.nl_family = AF_NETLINK
+	};
+	struct {
+		struct nlmsghdr nlh;
+		struct inet_diag_req_v2 r;
+	} req = {
+		.nlh = {
+			.nlmsg_len = sizeof(req),
+			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ATOMIC
+		},
+		.r = {
+			.sdiag_family = AF_INET,
+			.sdiag_protocol = IPPROTO_MPTCP,
+		}
+	};
+	struct rtattr rta_proto;
+	struct iovec iov[6];
+	int iovlen = 1;
+	__u32 proto;
+
+	proto = IPPROTO_MPTCP;
+	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
+	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
+
+	iov[0] = (struct iovec) {
+		.iov_base = &req,
+		.iov_len = sizeof(req)
+	};
+	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
+	iov[iovlen+1] = (struct iovec){ &proto, sizeof(proto)};
+	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
+	iovlen += 2;
+
+	struct msghdr msg = {
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = iov,
+		.msg_iovlen = iovlen
+	};
+
+	for (;;) {
+		if (sendmsg(fd, &msg, 0) < 0) {
+			if (errno == EINTR)
+				continue;
+			die_perror("sendmsg");
+		}
+		return;
+	}
+}
+
+void diag(void)
+{
+	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
+
+	if (fd < 0)
+		die_perror("Netlink socket");
+
+	send_query(fd);
+
+	close(fd);
+}
+
 static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6")) != -1) {
+	while ((c = getopt(argc, argv, "h6d")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -262,6 +332,10 @@ static void parse_opts(int argc, char **argv)
 		case '6':
 			pf = AF_INET6;
 			break;
+		case 'd':
+			diag();
+			exit(0);
+			break;
 		default:
 			die_usage(1);
 			break;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5e8d5b83e2d0..3f74100bc023 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -278,6 +278,11 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_result_pass "sockopt v6"
 }
 
+do_diag_tests()
+{
+	ip netns exec "$ns_sbox" ./mptcp_sockopt -d
+}
+
 run_tests()
 {
 	local listener_ns="$1"
@@ -356,6 +361,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_diag_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.25.1

