Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F048F003
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453617; cv=none; b=T8aZpSfegV9vuvMps4YembbftRLBLeWFj+kUkSFNjvbA2yX2p/+fXOqplpP+iNxyxD8jhwvLlBcu18xpxZFuHKvFpYXher/u/1AV9nSNNsC8sSbKgAN7LCc7SJK2xVyW1IgxZULqr7Pi4Tgxj9gRJtMzcNW7Pwre2mmXAkYI+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453617; c=relaxed/simple;
	bh=Z8wDgiznFc+HSGiySCsAZcKFbjrUmrYD7S8iZzMeWNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tP8iYXDBdtmh56pKSCTIfFsJp5yP60c0lkHcmesyWMI4zfKwmcD71lJS6krYbylOwJWZ+xwDQDAOyRJ29h9hFGSgVnLTZpFq2M52n/YFQ53FRnyBbvIwJIZiFX9TuDTcZoPP6uc5LJ92vT14neYy8zaVnoeUanTIh2ZXSVvyYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R1zPgkIM; arc=none smtp.client-ip=91.218.175.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R1zPgkIM"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Z8wDgiznFc+HSGiySCsAZcKFbjrUmrYD7S8iZzMeWNo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791453612; v=1; x=1792058412;
 b=R1zPgkIMkKj5Be/0Jm974F2tOsdDIOwC6muAy9LgJx7GliCZHQHkp7XdkiUqB4w9BvYUwHfd
 a2UeO58x3X4x5q9yye0x4a3O+eyiN9sJTdfHLaPxOP8/96gNy9WMkEO8vMS7pYkjhM+s3ywqQV+
 uLeIxx3o7U85dn1LPWO4P8xQ=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id d242b08b13c3830b;
	Thu, 08 Oct 2026 10:00:12 +0000
X-Mizu-Trace-ID: d242b08b13c3830b
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 08 Oct 2026 18:00:02 +0800
Subject: [PATCH mptcp-next] selftests: mptcp: verify nft JSON support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-mptcp_nft_version-v1-1-efe5f200cb02@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAAryL7nWBGS3WVCOmx1n5kohJBdPesz
 4GZuSFSYIrQiRsCnRz5cBnKQsC8jW4lyUtm0EpjqVQjd59mb5xN5qTw2bJtsF6wUoiThdz5QJa
 v/9nDr0tHV4LheV6vYCUobwAAAA==
X-Change-ID: 20261008-mptcp_nft_version-9865d63066bf
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Use --version to check for nft presence, as older nft versions reject -V.
Ensure the nft tool has JSON support, since we need JSON output for
parsing with jq.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 0559bb168203..e5896bfc75d6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -528,7 +528,14 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
-		"nft" | "jq")
+		"nft")
+			if ! nft --version &> /dev/null || \
+				! nft -j list ruleset &> /dev/null; then
+				mptcp_lib_pr_skip "nft tool does not support MPTCP"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"jq")
 			if ! "${tool}" -V &> /dev/null; then
 				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
 				exit ${KSFT_SKIP}

---
base-commit: 9651c766735c19e7a6b90d731bab53ef7959def8
change-id: 20261008-mptcp_nft_version-9865d63066bf

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

