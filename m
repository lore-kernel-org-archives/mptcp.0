Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A73164D8
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913154; cv=none; b=cYijLfMhrURWnC33wFgW6xiO093DsQ1RzpfuN6kb0ktOf2uld2fC08vQaDY/5RnQQXiPAkkg/+MEekTs7f9vnqRqILm1H6y+9LHfnJhIujIHRJXtvX+j2jFAo8WuKnjY7lfR6Is4XhEUrz47KV0G+BvXSxFqh4aXihjzaZeLmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913154; c=relaxed/simple;
	bh=gdqdyDMEC0LwQ7Xn9XWFtOSJ+xl8tX/6YkHMSO7zZuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nslkk5lb7MKPJ3vZFSRJvA13cxkvCJNuUGnbrf/CtayQjx8TUol9oZp9TOGzrlWezPdHtnlIfp/ZtVK+GBBpY0q0pQsvo3pvWV3OFCE1aqzh679lqMbb3vaqzw4PDbEa9PhTDb8tR+KDua1hdER7oQJb+OGGZOxgH9gZmkpQvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6xCotKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6xCotKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7141F00A3A;
	Mon, 13 Jul 2026 03:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913153;
	bh=EVNQEdWaEc+19+FWypIlzPbWRFSj8sLzCR08vuaHHDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6xCotKwpLWq7Qg4PtRg/gqGAsYVFHFDbGxL0Dt3PXxU4LtOM/cmw2gi4uYTIu4Ch
	 Qq16IwfBhjbbkbqua89SQO+tXkx3NHNL9SCPe9bFQY3B7j1XfZMRUkg+T+XAzsfrOQ
	 SjPSPxi+Hmwokp4qEn921pL0+parGJEx19WKB484zk8LmRD42n4merrH7+veCNYjGF
	 JyQERteXRN63BpsTFaTseigGeOUMvbH1oEe+nbYc0QnmmaF9r5yJ8R6k2UytICLUDV
	 5ZJoMswGuo3D7A3OdDLKHHTlJBlxLFLKxekD8n8knrHkrVTUC2XjfGoloAZrDt7mss
	 IOpEGpEefds6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 03/12] selftests: mptcp: sockopt: replace /dev/urandom with getrandom
Date: Mon, 13 Jul 2026 11:25:27 +0800
Message-ID: <2897025f4df37c36a355d8bad2fa4a356247a76a.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace /dev/urandom with getrandom() for initializing the RNG. This
simplifies the code and avoids potential failures from opening device
files while maintaining cryptographic quality randomness.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 941af179867e..9442ed5239f1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/random.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -824,21 +825,14 @@ static int rcheck(int wstatus, const char *what)
 
 static void init_rng(void)
 {
-	int fd = open("/dev/urandom", O_RDONLY);
+	unsigned int foo;
 
-	if (fd >= 0) {
-		unsigned int foo;
-		ssize_t ret;
-
-		/* can't fail */
-		ret = read(fd, &foo, sizeof(foo));
-		assert(ret == sizeof(foo));
-
-		close(fd);
-		srand(foo);
-	} else {
-		srand(time(NULL));
+	if (getrandom(&foo, sizeof(foo), 0) == -1) {
+		perror("getrandom");
+		exit(1);
 	}
+
+	srand(foo);
 }
 
 int main(int argc, char *argv[])
-- 
2.53.0

