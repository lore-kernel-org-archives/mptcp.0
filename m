Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9041862BB
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621118; cv=none; b=hrzH4y+dwCgFyabg+7JOs4l+uFu+gw6jnZLp0xFf7CIWIGp0aDP/4UPyYtbUev+xuBGqua7iEFeU6ce2oBHoilmXwOi8YSoEn/aIOV/Mxo/ITTXRCOK0wAlTZGxVIMGkNXLPOBAQVs+hPhq8DRktfKzzANtFeJOuDsGqkXpAmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621118; c=relaxed/simple;
	bh=hUeCdfvy1KLYUOQxjKBSVQMTwKknNzoqiFF4LLYh7aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owQ5/5URxFANDXoLAXShIlHjquiKLMRqaePLkOhS4L2k31xP65DTAtQGVKmIex+jz7nlagU8iKIV3ZnSm57K4lpYotNWkWzOoT60Pxuhj4lrQESkFtIDX5+OmeCTGrLP83bjPf8d3Jgr/saDScRcddOv9YqOZUN4zJ42rlEWbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3xymUj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3xymUj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E236C4CEEB;
	Fri,  8 Aug 2025 02:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621118;
	bh=hUeCdfvy1KLYUOQxjKBSVQMTwKknNzoqiFF4LLYh7aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3xymUj+asv3Jx7MxRuMepkhJ0hqba832MoeV5gwGWwv7gq39OeLsN9iXO3VIIm3P
	 pJNHrp3M6E8f22mnQGNDnPcsd0DoIDZCN5eBjr3XCWPVlpVA3cSw60bFqmQZWFSPNP
	 qT6LKUweisomOLv76/fctrTUfhohSEKm8ecRiIcwY6LXSQyPIFqrPwj4KW+rxIeNiY
	 WYVrgfD8bEeUWNKFw4nzD1qFlu9+SelFcvKN6D6PtvfdAMHfKWY5/c09zGTPDnxnRB
	 rEagGh/6qaf1zECOs9jvaNXT1Ndm4ykJ3x2IMGpAmASgyElqg6p/kmZvkyiMCWpEly
	 sLCoz0e1Bo0uw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/8] selftests: mptcp: sockopt: use getrandom for initialization
Date: Fri,  8 Aug 2025 10:45:02 +0800
Message-ID: <82946098d3b1fcc1ba911349ca79089e08d951d7.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
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
index e934dd26a59d..2bd75f731dfd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/random.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -815,21 +816,14 @@ static int rcheck(int wstatus, const char *what)
 
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
2.48.1

