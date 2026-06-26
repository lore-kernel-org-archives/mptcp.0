Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDD194C98
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782513986; cv=none; b=kSv06P+Jxx916/t/1ZNawSZpYfFJy+l5T0zrStiP8gNtmWuW445n4nLU8mqpp3EIJYlyPeMV3I1j3+KYRMcJh8zoGj3ezREWuCHnNbPVnJ/JECU6R6K/dfwgo/vC2IHxSACzuFLm5oQA6VvNgVEjpTEW1TKQc0uvR60UwaAdtwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782513986; c=relaxed/simple;
	bh=7awrlOpF0GhrcsErcHSG5MXTmYMsa4mGXvzAzF4sW64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LazJHg+HbOi/ox6rEt7+iJ0MNPTnjACH8tm8eXfaNRwlTaaqr5B4GwGEHmpKHN19O6xHEWYTVUI05ukwbfE1UrmsGh1Cq9FTB0OhD210dqSkc7iLwb9wscjlFIY68rl/ZAAADt/6sOmancS986pFoczDEfl3x43kulagIJv8RWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obGTxrLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obGTxrLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171421F000E9;
	Fri, 26 Jun 2026 22:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782513985;
	bh=vfA7KaWqKDipuc52Z/3rS+o1qcEmvVfalIa8luDRqNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=obGTxrLi5W4Bj6spPBXU1vqVZ7DupjAu6QTirxs/PRBZb0OLpqU6KvavveVLnqaCv
	 q7SeD33QewFt9I5QaXwKsYfiRtYsCiIZecPL2JzgcuCopNscKGKOr+Zc+w0ZCb5mMt
	 3wWSJ1MQoQxXy0u+nSGoigUF+jwOa0eFMl4Ohm5zlo8R8D2f0YL6RH7CJG79os9ajp
	 82hrNWcRFFFTu5yVuBn9GWuMBReWGpYrF5pXXQS0PWBEUOU633ENDuJTERhHO1kvut
	 SomE/BKH4o0bgXe4FsjE2NN15mpU0p1dFiOyDisX1mlKPr5sxFSvjxST1it9ABJ5LV
	 /po3VtoNoKKzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v6 2/3] selftests: mptcp: join: explicitly remove userspace pm addresses
Date: Sat, 27 Jun 2026 06:45:54 +0800
Message-ID: <176327823995be8f450b6e654306b87e8ff23593.1782513313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782513313.git.tanggeliang@kylinos.cn>
References: <cover.1782513313.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now address entries only be removed from local_addr_list when sending a
REMOVE_ADDR by the userspace PM, they're no longer removed when a subflow
is deleted.

To make userspace PM selftests in mptcp_join.sh pass, this patch calls
explicit userspace_pm_rm_addr() to clean up the address IDs, and adjust
the chk_rm_nr counter accordingly to match the total number of RM_ADDRs
sent.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 550a6b6117a9..6651de43fa5c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4088,11 +4088,12 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
+		userspace_pm_rm_addr $ns1 10
 		userspace_pm_chk_dump_addr "${ns1}" \
 			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
-		chk_rm_nr 1 1 invert
+		chk_rm_nr 2 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
@@ -4118,6 +4119,7 @@ userspace_tests()
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
+		userspace_pm_rm_addr $ns2 20
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
 			"after rm_sf 20"
-- 
2.53.0

