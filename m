Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C0307AF5
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200586; cv=none; b=Cc0UnMnAvkZh5ZdSP8c64MuYwhr0B4GZBnMEazxvwxUlAFwtuNZf8Jf/Dzl7wPJl4b/BBtNr/1PHc2PX4d74Gkn2jVXkkE4R6+EHklbernTz5Cf9a/Zq4E8sqzoawRA+dnarvRoGiZUfscQdjkjlHUbA9I0JAeotEAPYy5qcq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200586; c=relaxed/simple;
	bh=hUeCdfvy1KLYUOQxjKBSVQMTwKknNzoqiFF4LLYh7aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsB/EPdGdgTHuiXTuiqHWiXfrJ2nQy2Zp/dQZjYm9NG+QC4KgrbsEeIhxm38W/0N3Y67iMYEXIA6JfJGuf4hFJJv5W4AIA3g/4CdOji8GRuwRdMItT3AuVmt2Me5fRATJRMb7BtdiPsoAXiDAhWy8Jr9b4UykjaJYJ4Kzb8AWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcBcZBDV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcBcZBDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBE7C116B1;
	Tue, 26 Aug 2025 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200586;
	bh=hUeCdfvy1KLYUOQxjKBSVQMTwKknNzoqiFF4LLYh7aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcBcZBDV05nqOaV0IILYQfxDZp/hdC6EGpo7nPgj4rzTttA1wyUxrJ7sDrd6l4C0X
	 Zspl8JAd5MVvVBJ0skknvvFe0i4GBSPpo5uUMuyjOqUHZLBciotojls1zh20hZY3iE
	 bdWdDbrkDSGjFtjQnA10Ip0TC6taAuAZfgk/2s+EpLd9kVudy/FfdBbMOa9nNEXJVO
	 w15kwlLStCNN3Xr+K5hRLv9zQLIPOuofwadBuRiEEuUZvzYxSEdxwqw8HrTZ74EtA1
	 a7ld2BdkY0IpkoxB050QEdHbT7cbm/t6SxuuYqvr48BPGYGyrijT/MaoRWTjZmidcj
	 m3rGH7i3PXbzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 01/14] selftests: mptcp: sockopt: replace /dev/urandom with getrandom
Date: Tue, 26 Aug 2025 17:29:25 +0800
Message-ID: <f10c973f7cf65d21d2bc73a99c08c29920230ee5.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
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

