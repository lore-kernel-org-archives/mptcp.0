Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E337A839
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994955; cv=none; b=UmbbiGbce2SKo5tlUDtGxZbGvf20ufgg7ntkIpdcoCoVDrnnxUEO8AKSWPovu3jpZL2EUloq515wwnL40RaPbmizE1VgJO0g1fBbnw/tu6yBIoS4ah7xrTecHULaaask2DXD/mmI8YWmPUBdXtidb8amzcATylqSMHhkFRVQN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994955; c=relaxed/simple;
	bh=sNwiXpzxO4tz8+YS0XmMEXMwc5igr61AHew42KffMS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUB1Sckhczb60Of0HgS/+Lg3n5M8UIj3vZRdQUKVCBPNHRGGpEOm1YSlys5rOHJtrhxGB928toQNHZuManyEcsPS3qtRmIrd6l22Y29E5eIUbUqyYfJAcT0BoxOSa7WwLYWj6KWSA9cyWiFCteG4kNBiA3/9UgZvgr5dtypE7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUWIc0VQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUWIc0VQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D6D1F000E9;
	Tue, 14 Jul 2026 02:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994953;
	bh=HySpgrAg9VZ/4tSSuxcra0GXJl+hi07cC82ft/zMjP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUWIc0VQ5LKGzmB7zaUb87JrBjQQnmWVJSHkUE7E9WRU5mkaYTOdN3ZAJNV6L0e3b
	 0iq7fvkj1sqTrpQR6IYBYdGCv+V0MK2BF+aK9DLB5Tym3IGT5Ly+aTqYL1O+Uwx6P6
	 GDTi2tJgsGxGmubAAuXIrz/ho1MBO70vITQ8qzsVwv5rSX5p3mO4Miib97LY47PjE5
	 YkBE1M80MiVN/YHaCJogFjo5UH9Hw16FeVBcj+krErMKX39AlVNI/7WDKHuAgAB/Dq
	 tGfKIirdWwWafYKwPWChk8LhWa8SO4jedrgRmN6UCDkYANGQ/iRnATs053vFdJt4rg
	 59VdG/Stfu+bg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 04/13] selftests: mptcp: sockopt: replace /dev/urandom with getrandom
Date: Tue, 14 Jul 2026 10:08:49 +0800
Message-ID: <c77d93ac1353d38891a9dc962950c72b5fa8294e.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
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
index 55929f0e851f..7c44ea9f5f8c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/random.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -825,21 +826,14 @@ static int rcheck(int wstatus, const char *what)
 
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

