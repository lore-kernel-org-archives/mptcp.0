Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AAB21360
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330941; cv=none; b=ur5ViGaZeC+VUJhpHoWc+WYOQ1qF9suJfFlNOvnBUQsuMFygs/tLUFJ/nSXFK9g28Kp2dMpVlz5EaWW4vii6ydAxydX3mL5A6qyJbUYL+y5X73tb5m8FnXBfLSzv9A9+hcPJgp8PZ6T0Ajy5boJgKbj1UfWkazv7aO3+BbuFHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330941; c=relaxed/simple;
	bh=kZ0DVshL6EzH/+LOEsndhtAoMjv2Rgk5iojNIAL2T2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6eU+y8761OIHYIDBpkHUxRISFmHI5ffdPsi38RgsBAGpip2FIiZYtF1utVjg6PvZdOwea8N1o/NBhIvRxkLquDGJOZxZAOaBMmTaUZcHe+MHNwV6EnDVMz9z2LL6M9k2el+Qr71m81V2ksnV0UX/9FtrW/oewFEGayoKZJfAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oss/6Yxt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oss/6Yxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EE4C433F1;
	Mon, 19 Feb 2024 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708330941;
	bh=kZ0DVshL6EzH/+LOEsndhtAoMjv2Rgk5iojNIAL2T2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oss/6YxtlqOJZQRs8eFDPoqa11j4JZBs24JcqznvqwpRgIsnw9zuNAXdwUstSH/BN
	 L5gSbiFmH83UpbdV+1HQ1mqDRsirt9AGrJ0203EOYO05jUnAuxl86VsD1+ObL32WIT
	 4SSK2ipn6cHSXRbnQxM8GTSSZWdRHBLrIF27R9hMBqHM5qXP7lP7E4iK8J89pzQijE
	 48GkRpog4v1fAJ9BPEgQjEhC/T/bnYnUo3AK8m0R2AXdBJaeTQ2tKXGsaadtdvoot5
	 3zntI7zvfTVMzdu46r3AnWI09TP8gk8bpJ3m3clGOMYGXuUXqd8i2KH0D5zYj3mW9W
	 IDjG2g6alpp/Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/2] selftests: mptcp: join: add ss mptcp support check
Date: Mon, 19 Feb 2024 16:22:11 +0800
Message-Id: <2647a5c158e5979e55f295819370c452868b2af2.1708330720.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708330720.git.tanggeliang@kylinos.cn>
References: <cover.1708330720.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Commands 'ss -M' are used in script mptcp_join.sh to display only MPTCP
sockets. So it must be checked if ss tool supports MPTCP in this script.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5935b1fcfadb..d797b27b7626 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -162,6 +162,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
+	if ! ss -h | grep -q MPTCP; then
+		echo "SKIP: ss tool does not support MPTCP"
+		exit $ksft_skip
+	fi
+
 	if ! "${iptables}" -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ${iptables} tool"
 		exit $ksft_skip
-- 
2.40.1

