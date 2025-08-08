Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B49282FA
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664223; cv=none; b=O4nIQp/8XO6MKqdbdX/nboIJ2hwq5xF0M05pHEkEogoLFL2YE/qlUmMrxOnrtgSSVAuzkdb3Gp4bSzbtkcxa7SvR6LUabki26Y3HW7BTlH9kzkjsBHbnLN2lzK33hii99rx4J5hcNKt+DVCBS50RzOevZfW9KpRzA92Es8BMAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664223; c=relaxed/simple;
	bh=hUeCdfvy1KLYUOQxjKBSVQMTwKknNzoqiFF4LLYh7aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYQ7LXWVK3MY8oJC/ybextFTotQ5a3WiD5+ukxkrGV/Yy92rQJ1i1QKkOeBfj0sRm3rNoY6oMrS9459VwGDbBjJUZsqtrNx46HfUWD76+0W1S1u98RqQP6pC1cWrInuSnGxq0KKZfodQ4rGy2uqCeYE0zhmmZwVcADdu8mTcHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2ga83Ps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2ga83Ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29DEC4CEF6;
	Fri,  8 Aug 2025 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664222;
	bh=hUeCdfvy1KLYUOQxjKBSVQMTwKknNzoqiFF4LLYh7aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2ga83Pszzojlj2gsPGa/P2WFDCNO96g0i+DOD+J7q0tY9OkNVpjWILChCcFaMhcT
	 dtEBgX8eahNQbakysX71H3/rtEPkNBALBaC+lBzBVqhO1zQ9V3jxUWstvA3vEfLuVG
	 /wVVDr4bw5rqXXFVdpJygoFG8j3DgTm5y08+yfEIRToXmNgW6xMiWtbEM8mDf1CKeW
	 ZDhj4rPTFGxv0HFYfXJn56UhDTFx4givj8PTFEzUjifVuy6I7FCgyhQ1Z+ILjnC9H6
	 pNeQBTZXNNu/cj5JpLX/ZYCJQdH+lw+5/69jlA4IG3qrKCxf3ryYJqBBZ6FpF9/JJ9
	 MzHY+ozOB6K2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/9] selftests: mptcp: sockopt: use getrandom for initialization
Date: Fri,  8 Aug 2025 22:42:46 +0800
Message-ID: <2429797ceb15a01ee56c96864c2589437c22032e.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
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

