Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806C6089C
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200282; cv=none; b=RMih/fEJ1uOLDksM3n4A9dFLoqqGmwSDVhb4I3TG8AYe2gVSdHDIWxZsbQySSH4e+MXgUzgUqYg0wN5DuYn6Xgls5GQEYCFwvo30wXtf/JCmYQgcBSiFydn02srX/rhXkfF5jafPjG7NarYZ3rElaeJRWFM7E8QgSbAOD9TNz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200282; c=relaxed/simple;
	bh=CeysPUs859NGxTYkiD7yPGixmyXJEiqppZF4B17j2vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A55aQmRiiwQz9EOAqL+wFsp44+2fPxmXZwpQSABBDdqhcupkR5Djgv88IjehhC+LzXtNP+uhyx4UsdjmFSrhNMilo57zv3ZfThn2A1j3PL9rifYaZIfXDM4SnEphC+sHr1BDqV9mivWas+ZLEumli3xmtN7HNMLk4VwpO6JzS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoZAeQWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoZAeQWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1683C433C7;
	Thu, 29 Feb 2024 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200282;
	bh=CeysPUs859NGxTYkiD7yPGixmyXJEiqppZF4B17j2vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoZAeQWncd5e1log0qKzlfAKjKF9gKGLEAEiTmY7mYiFG7+R+DkBSeokmjgYX4Gqs
	 ScIqAsU1sxPzMJewgWvujgk75nlVeUbqmL2N3i61137sPAKBmf5MKRehAQAsXzw50k
	 eg2nqutGCDOVeUQhNzzrfTAyohrN0Wh/QT1pCPZyZc2ZXkTtdjb6Kd5L4AQtomqDHz
	 ho0ZN5GG0QXTSggDjYeR9IUz3rvVgetW2LXkuFYw48627+T4e+Ug6x4Y7+7ESuJ6ut
	 yWpTYczeXZM2EsHk0RxiNHp8P8vlYH6YCUIhn0Qx1+i6khSdijZikuNC89fPiJdKOa
	 nH1TUHYZygkcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 2/8] selftests: mptcp: connect: add dedicated port counter
Date: Thu, 29 Feb 2024 17:51:05 +0800
Message-Id: <dea8ab3b33e331083ef740bb385bad314dc321db.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709200070.git.tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0ca2960c9099..4f40221a86cb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -314,7 +315,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +711,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

