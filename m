Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EE353A85
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616982; cv=none; b=V5WzVfS5/ysCWjuxlEeHFKuivIvcFVzQRBcKBNH5pn4kBntba3ttHyoMo0dRqWqq0fMt5UW9GFJvDcXO4r48Jr6cpBNR1ccBmZWsiTj9ed343qn+8nQlMyznTUI5Z/4t4GYHkFSEQXkgCA8uuVNCE48IQ5BstOQdoYkbhrI1WX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616982; c=relaxed/simple;
	bh=5iI4X2LU3mEAF5l8Ea6EsweY6REaWeaaikl1nppF0JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAbCUMNAZ4eF6xRwVSfINbr4W4FIjIISZxXVnkcJkl4US3F23NezBRMGpQn76IH9mEF/5OMtymO7TM8aZjdZjJHvQXIQ1S54TOXuFQSjHa8ApBMBYA3aTpqU4IF5jZ9vm7ceUr8y2wsN2AVpP2nHxwq/0KYccpsaIs2mA/0NLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeTiRBFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeTiRBFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7C91F00A3A;
	Thu, 13 Aug 2026 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616980;
	bh=ZZodWEkPKINW9rjjTljIDWFi27HkeJNzmTfkP2bfIR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XeTiRBFRi7DPnfkvJ4c8yBDhklv7/03i1lqRDatjCYrodY3hNuUH69e4w7egyHlAr
	 dyrphqett8FkO4qA5/33XfQX8rQqPNEQUkmsQb6JXPfDLhNVicnE7iivofY4ZX4Rfy
	 IsKtA/LqPdupQRUEkhOAkSo913wd22m4WIFVCMLxr9Ujx6SuUewsFxl2arpkEwlNJK
	 0VR3OE/CZfxQVSLCSdEIPwlXvS16JN0iG/C6+iE5Z/hwW8KHXAebaImAD4LU1i06sw
	 2NrkSOelZScZji0qXCZQ29U8IAYl2Bq2cIAvVPHMBxVdpPgoN2shZCS2WnmmsA7Sh/
	 hySf3W+BAWuRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Aug 2026 12:29:33 +0200
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: lib: get counters for the
 right test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-sft-mptcp-nstat-hist-v1-2-5bb96bae7ef6@kernel.org>
References: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
In-Reply-To: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2353; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5iI4X2LU3mEAF5l8Ea6EsweY6REaWeaaikl1nppF0JI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJq50zKSarj/8b6T38N27Kni/xDZ5ft0VlX/bxgrdw7h
 YBqWSvzjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlMbmL473C6/L/Av8IuJVuT
 Z37ZzGY/FLRmC1rs+79mpty5yJrpZxkZlm2Jdj2Y+1WES2pO4MJ+kS9pPbZ56hINTF/cvqguetD
 ABQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the value for a MIB counter is required, mptcp_lib_get_counter is
called. It tries to use the cache, if available. If not it falls back to
calling 'nstat' directly by looking at the absolute counters.

That's an issue for tests that don't recreate the netns for each
subtest. In this case, 'nstat -a' will look at the counters for the
netns.

Instead, it should look at the increment for the current test, by using
the history recorded in /tmp/<ns>.nstat, if available, and not using
'-a' which was dumping the absolute values.

While at it, rename the previous 'hist' variable to 'cache' as it was
used to look at the cache, not the nstat history.

Fixes: 71388a9f331d ("selftests: mptcp: lib: get counters from nstat history")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index da1da414c30f..b9d14647f401 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -416,19 +416,21 @@ mptcp_lib_nstat_get() {
 }
 
 # $1: ns, $2: MIB counter
-# Get the counter from the history (mptcp_lib_nstat_{init,get}()) if available.
-# If not, get the counter from nstat ignoring any history.
+# Get the counter from the cache (mptcp_lib_nstat_{init,get}()) if available.
+# If not, get the counter from nstat ignoring any cache, but using the history.
 mptcp_lib_get_counter() {
 	local ns="${1}"
 	local counter="${2}"
-	local hist="/tmp/${ns}.out"
+	local cache="/tmp/${ns}.out"
+	local hist="/tmp/${ns}.nstat"
 	local count
 
-	if [[ -s "${hist}" && "${counter}" == *"Tcp"* ]]; then
-		count=$(awk "/^${counter} / {print \$2; exit}" "${hist}")
+	if [[ -s "${cache}" && "${counter}" == *"Tcp"* ]]; then
+		count=$(awk "/^${counter} / {print \$2; exit}" "${cache}")
 	else
-		count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
-			awk 'NR==1 {next} {print $2}')
+		count=$(NSTAT_HISTORY="${hist}" ip netns exec "${ns}" \
+			nstat -sz "${counter}" |
+				awk 'NR==1 {next} {print $2}')
 	fi
 	if [ -z "${count}" ]; then
 		mptcp_lib_fail_if_expected_feature "${counter} counter"

-- 
2.53.0

