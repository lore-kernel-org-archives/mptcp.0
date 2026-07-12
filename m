Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6C373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850095; cv=none; b=cADamKNgrH4ypPYz73hpZjHdhaySPQ9Cj07d1Ha7IxIpSSf2UKbKCm1RVe58wJkA/hJ0T7WvxbSsxs/OcIMZCQ+sMcgQsbFducBm74KqknAm/jkgiIWopQokV1aSyYKf+uWXkpFY0VNuBdu1IOjJBtkQPR3RJSbJE1o7PclooRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850095; c=relaxed/simple;
	bh=nMMjQDBfE2ogYwxp8gSqZKFzX9zGkK070yqIdqFUeXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEQVMsPGnuC72YyA0aCYLg6SpxiJrAq57mMJU4I87gbjNXc+AkQROdpN/gGRripEhb71jbeV+VXDN9sYe0ZMGOPWxwy3AdnmVANIn8L1aty2Kbb3ukacdGbC8rZD9v/nf00TpjcTMUQS4YRAwPN2AAY4RczLdF4dAelEh4omi8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kANwr82M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kANwr82M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC291F00A3D;
	Sun, 12 Jul 2026 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850094;
	bh=6FHv24WUaJgGvOEGiQs8y5BDrWtl+De7QHF1+lUQohw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kANwr82MZ97zMYAgcnqtknyJ4F4V10Vc75Jh0QDloY/fRuv+SY0sOP006Ej3KXVQt
	 0MnjXiTuGpFmd0408srq6GAwr4TVrzSmDN0T1tdNu5TREzp2tvOw59nptZjmMa3f2N
	 WsaJ6PTJhXJXjuvOO+h5vLQuhhARPj6n8GrY4eg1q37dr/TbhL4Ln/IBIgCjgdPYef
	 7a4HaB8Ab6MHRsMsVbKY5My2i/xI5/by18FDgs7Hhk1bPMwLLWrr37mFOSvfz4a4+B
	 NXVYcmgJzV4v48783cD+qjRbFqWJSEuaQwOcw5c4382E7UOiPn+3MEWO9rWz60mYEd
	 zicEcjArpY1jw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 02/15] selftests: mptcp: sockopt: replace /dev/urandom with getrandom
Date: Sun, 12 Jul 2026 17:54:08 +0800
Message-ID: <de253253b5ab7ba076bd5b560aa4a014b4a94093.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
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
index d4ad03ed64ef..1f719885cd47 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/random.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -821,21 +822,14 @@ static int rcheck(int wstatus, const char *what)
 
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

