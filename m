Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32A2DB795
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381335; cv=none; b=TLPLDywTPrxwbni8Re9ztoitigkyLln5WMJIFGwUCPJ4PJmRZB3mup6wXn8hlOxvwKu7NGFoSM95IDPW7riURYMRZMwmVIcNFtTgp7YAmX7TzstF/COs7U8lUnt18BtVsSCHSgqB2A1f8Vt2i0TAiGVmaCUkmg9E6RMA6VXSL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381335; c=relaxed/simple;
	bh=uvfZ6kDhqO0L3HnNSmvXqrG4OhMUiWk1+eIM4AP+02U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzpMeUBbCoH7LewbtNG31zxitc+YcRWTuxgTnLqeEgDSHrvxoL54l2qIHlLsnucmakiDBge6sKaeb2FjqgJXhPxpJpsSh71Q3nvCIjiDeR9eOXP5kgIwspZKq3BorDscb0/x86CJlnB8IjkZnm2mooOqgD7sRisLqnX8yDvzX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmgunpA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmgunpA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506EA1F00A3A;
	Thu, 30 Jul 2026 03:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381333;
	bh=2J/s/eXSR8JDR/0lG9znHs/mhbbm0LpOf8PbPcED0/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmgunpA36F/9F73yfUF9cty9196FzbseLhxGXIzOWZ1mXGicDrD2Jh7me4HAbNHVp
	 Q6EpirRRdilhzy09WC/WRgZRtOqg6+NoUtNaMar+Nt+uAEp2vOULNQgtWayv8rb8Wm
	 s9lqXoXSAzpx+kD5BLXb1odMq7mmPXSwcvus2L8prS8zMbZVkwz3w3nt4Q3xjX04UB
	 +dJ+a1qFYC1JzkaxiJ7+q/OyvD7uNGhwNMR528aqWHi25QQ23yW+21J4VKBpan4q3Z
	 tcxngnma8t2HE4QsM4n6WFyD2P9ZtKI/kr6RzenHsL5nGegk/VsjSdNCAX3GLvTd13
	 2O9rVYo6VR6Cw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 01/12] selftests: mptcp: sockopt: reseed RNG after fork
Date: Thu, 30 Jul 2026 11:15:12 +0800
Message-ID: <f15197064d657dccc64d2057cdd8ee28a6026788.1785380422.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

xfork() does not reseed the RNG in the child, so server and client
processes use the same rand() sequence. Restore the per-fork reseed
from mptcp_inq.c by calling init_rng() in the child, ensuring
independent random values for buffer contents and transfer sizes.

init_rng() is now called from each forked child (server, client) so that
rand() sequences don't diverge from a single parent seed. But the fallback
path did 'srand(time(NULL))' - and time(NULL) has 1-second resolution, so
the two children spawned back-to-back in main() almost always land in the
same second and end up with the same seed, defeating the per-child re-seed.

Mix in getpid() (per-process unique, kernel-guaranteed) with time(NULL)
(cross-second entropy) so the fallback produces an independent seed for
each child even when /dev/urandom is unavailable.

Also hoist the 'foo' local to function scope and collapse the two srand()
callsites into a single one at the end, so both branches consistently write
the seed into 'foo' first.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..6c3d896d4a1b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -128,6 +128,8 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+static void init_rng(void);
+
 static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
@@ -799,6 +801,8 @@ static pid_t xfork(void)
 
 	if (p < 0)
 		die_perror("fork");
+	else if (p == 0)
+		init_rng();
 
 	return p;
 }
@@ -822,9 +826,9 @@ static int rcheck(int wstatus, const char *what)
 static void init_rng(void)
 {
 	int fd = open("/dev/urandom", O_RDONLY);
+	unsigned int foo;
 
 	if (fd >= 0) {
-		unsigned int foo;
 		ssize_t ret;
 
 		/* can't fail */
@@ -832,10 +836,10 @@ static void init_rng(void)
 		assert(ret == sizeof(foo));
 
 		close(fd);
-		srand(foo);
 	} else {
-		srand(time(NULL));
+		foo = getpid() ^ time(NULL);
 	}
+	srand(foo);
 }
 
 int main(int argc, char *argv[])
-- 
2.53.0

