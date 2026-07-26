Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6D27703
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054624; cv=none; b=dWj8ycEe3ijSBFTWLUos17OT/ThIfttyAQXTkj/bWtIPReQx+mg09FY5V7ZdFHnCluSl8epEM94LI/wPDsPVtIQUDvNCAQ+Borcgja7xZ69A/XYD6Dota7WqMJ+1hQ7/NWoNEU9RuN4WcU5gk8apTbEshls/X2yTKhb5gK9IO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054624; c=relaxed/simple;
	bh=uvfZ6kDhqO0L3HnNSmvXqrG4OhMUiWk1+eIM4AP+02U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA+6c0n6g8d2sYBLjUIs+Zxm13ZgaRocB2zFxqnoGECfSg9CZRmgEgDtpDeN7nc8z9JltqQ9Gs38bQ7Py0zDWe39LjzxAlSHyS8tNMUzcEsGtPyoWGxe4VLuM+Ay3HHysT/wNNYm4zrPR6MyoBbozQVr4Wz4wpFVeutyVDgkD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsJ4iYIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsJ4iYIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4481F00A3F;
	Sun, 26 Jul 2026 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054623;
	bh=2J/s/eXSR8JDR/0lG9znHs/mhbbm0LpOf8PbPcED0/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DsJ4iYIMGY3JWQvG37WxytkZAvcTc3uP7lkXi7C18LQIxzfXsRYvv1ZGObDmbdsGi
	 1gCZoQy0YEH9WpkJycEKNfC9kwRadN0vn/nx1CSInxOMkHSkIBZUIlT0iZHHL0GagE
	 ij//vip1TvwymDy6/w3x47t7kFXkcHFAxq9fKRrtr8ZZdKBUWdOw5gxeVnPW5eTbQf
	 7JQg/yBbam8htD4oZJrobsdQ+XxuW4afom6cSIcE2W/zFZtVmN1S4XoAEvuC2VU6Zi
	 2A8MYlffG8Dp5heVAbRmI4wFxpf1Cmhqy11SmwfBk2wQmLD+xOwZ9P06/XWyBq/6mc
	 oww4Ikc8CRASw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 01/12] selftests: mptcp: sockopt: reseed RNG after fork
Date: Sun, 26 Jul 2026 16:30:06 +0800
Message-ID: <bca8ac7a1bb79bec01da8b3d7000e0140cc5c5d9.1785054129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054129.git.tanggeliang@kylinos.cn>
References: <cover.1785054129.git.tanggeliang@kylinos.cn>
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

