Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA893D47D3
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580823; cv=none; b=Sb0tXB4ebnkEIRljVy1AT07i2/iuU9UG9Jz7OE/bCk+N3z96BMqcLx2XYmijIMbKBaeZrAfwwFyKGwPxqzUJwmC006TD0hY4gkyus+9n/F9M48/nsCH7wZNxiWi7pxczHZS2xR8Wj1Awj6ZjegdSt27MH7rQDsqJmVmrg6FMy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580823; c=relaxed/simple;
	bh=QMwLxh7VVd4qKAvIHLMtyDuyVPUeIWkJnsZI6OuNuyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kk/hdykMVzOgpVeMBmzgsbRAI4U36x/A8NdIbYU8Zngt8ynSN27rbLMbsNJ1AOwnW0XEe6JiyRX/rAz/X+9roinf09CYr22a1eTlg2fqpCIG2jpp/b/eMTL3iJOhvFmUbu75LvkbWiqJ0Myo/Bd5qr7aPr1gGclx5hHD00uqNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUJTyjOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUJTyjOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D321F00A3D;
	Thu,  9 Jul 2026 07:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580819;
	bh=9LisMqvHV+xWYzW89mUgUb6NXOiG+2E5pmyEEF1r8mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hUJTyjOwZZQvNwwhH+eD5bSIFyX0Dj6/tr/+NW3/4iM/G0gVRe5QGf8EYzHrUIzsS
	 +f8+bTD0eyJDweOMjR4GnazM6nm2wOXvfHTiG152W9dGz+r5r5S2Oj7KlH6QE6ljCo
	 G3ZRsJO970pbEsJswAwfd7e6B5KF30KQafsPGYeDhS5oO7anruRkFOYnCYWg+uM6Zp
	 sPTAqRDVr+oHFbWPzCyC+4dcBY36EVrUqVR/5hkdLCygNja73/p7hhJiQLFbpZ6/0/
	 ZH8iLMJC2s2tSyf3DTgg2yqTO4UcY1UcCjxxhKa1bS7UDJVGWjqrEcXM9zuPaXHuO6
	 Ho4JZnedsGzBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 02/12] selftests: mptcp: sockopt: add TCP_INQ test option
Date: Thu,  9 Jul 2026 15:06:11 +0800
Message-ID: <becdcdab921369f121f05fbc0905a1f5af7dde4d.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add -i option to enable TCP_INQ testing. This prepares for consolidating
TCP_INQ tests into a single binary by adding the necessary command-line
interface.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 1d516779929a..45dc85d10519 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -30,6 +30,7 @@
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;
+static bool inq;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -140,6 +141,7 @@ static void die_usage(int r)
 {
 	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
 	fprintf(stderr, "                     [-t tcp|mptcp] [-r tcp|mptcp]\n");
+	fprintf(stderr, "                     [-i]\n");
 	exit(r);
 }
 
@@ -278,7 +280,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
+	while ((c = getopt(argc, argv, "h6t:r:i")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -292,6 +294,9 @@ static void parse_opts(int argc, char **argv)
 		case 'r':
 			proto_rx = protostr_to_num(optarg);
 			break;
+		case 'i':
+			inq = true;
+			break;
 		default:
 			die_usage(1);
 			break;
-- 
2.53.0

