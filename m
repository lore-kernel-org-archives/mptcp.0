Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487032D455
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546743; cv=none; b=uhjrjE+jYR7klldTRH2fpiDGP2Qe5f463aoS5L+c64wBVmG9Cql0dlrkmST0JpddOOiOMmUzWWt2zTrEH+Vxe7wHA/GF+qDg+WQClI/SOF65IWQd2aXvSc1J+bP01ZMUi0XXTFyg+YYO0Q8a17Cr33RVZeI141NE69JtIr6t0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546743; c=relaxed/simple;
	bh=mhcKCnPpm4791oDOPR7omwuP+5PqPb18qXF68Pm8uns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdAQVTcCh2AkmnFlrya6CdN+maDIRdJwQNJaj30p5Dq34O3Qx0NqZ3FIOxRXWANaXVQzX/JQ3/hxN9MbAMZXdmY2ABTpfMU7vTwfxeIY2ewqQBpHvppgx9JoWtUzC/iBZRINJ7eE9QDiBTACkN4QHzapA9GI04eO04jhPeVsIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5RtE0gK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5RtE0gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7425C2BCB1;
	Wed, 19 Nov 2025 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546742;
	bh=mhcKCnPpm4791oDOPR7omwuP+5PqPb18qXF68Pm8uns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5RtE0gK46fRfd9X7E3z0p4LX1B+ekDXI3mK4kp1awI8qf2joXCn7HM48vN+CIfwU
	 p61nqeXAt8Vxa+S4TYNLHU0aYyxGroFCbwkt7jQBljxJpoDgBYvsgkBrBYXnRrrE9F
	 Xt7+FFo3T5jmuUuGScBFOW+b22ussJ9B2WHkacbb3GFHN0HB/Li1Gc00UuNkpa2679
	 vGoLp02WuUOD3G70Ey9Ia/9NhwIQvSDp+YuU5NPQsedfXr7/C2DUPkKftJARR0M5S5
	 /ErmiWCVRk8ZdAzHFU63eZ9ZJaLGnS6Ifcub2bgSZJyOnWUCWLxT4TzpCl+VqufGUX
	 +dD01dmS16xIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org,
	hare@suse.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2 6/8] selftests: mptcp: sockopt: add protocol arguments
Date: Wed, 19 Nov 2025 18:05:05 +0800
Message-ID: <7da7a6b40b337cff2a0477456d6d6e0e99f04e9e.1763546473.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763546473.git.tanggeliang@kylinos.cn>
References: <cover.1763546473.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add -t and -r options to specify tx/rx protocols (TCP/MPTCP). This
increases testing flexibility by allowing explicit protocol selection
for both transmission and reception paths.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 286164f7246e..e4752f848f08 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -27,6 +27,8 @@
 #include <linux/tcp.h>
 
 static int pf = AF_INET;
+static int proto_tx = IPPROTO_MPTCP;
+static int proto_rx = IPPROTO_MPTCP;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -135,7 +137,7 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
+	fprintf(stderr, "Usage: mptcp_sockopt [-6] [-t tcp|mptcp] [-r tcp|mptcp]\n");
 	exit(r);
 }
 
@@ -201,7 +203,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	hints.ai_family = pf;
 
 	for (a = addr; a; a = a->ai_next) {
-		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
+		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
 		if (sock < 0)
 			continue;
 
@@ -259,11 +261,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	return sock;
 }
 
+static int protostr_to_num(const char *s)
+{
+	if (strcasecmp(s, "tcp") == 0)
+		return IPPROTO_TCP;
+	if (strcasecmp(s, "mptcp") == 0)
+		return IPPROTO_MPTCP;
+
+	die_usage(1);
+	return 0;
+}
+
 static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -271,6 +284,12 @@ static void parse_opts(int argc, char **argv)
 		case '6':
 			pf = AF_INET6;
 			break;
+		case 't':
+			proto_tx = protostr_to_num(optarg);
+			break;
+		case 'r':
+			proto_rx = protostr_to_num(optarg);
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -776,10 +795,10 @@ static int client(int pipefd)
 
 	switch (pf) {
 	case AF_INET:
-		fd = sock_connect_mptcp("127.0.0.1", "15432", IPPROTO_MPTCP);
+		fd = sock_connect_mptcp("127.0.0.1", "15432", proto_tx);
 		break;
 	case AF_INET6:
-		fd = sock_connect_mptcp("::1", "15432", IPPROTO_MPTCP);
+		fd = sock_connect_mptcp("::1", "15432", proto_tx);
 		break;
 	default:
 		xerror("Unknown pf %d\n", pf);
-- 
2.51.0

