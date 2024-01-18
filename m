Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E6B8F51
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558348; cv=none; b=J0SOZIy7mjfrJco/eNDcuag7xd2T9AkvviS2PJhnChac1gDb5vTvE/+pShm6nHCpzqZS2Ec+36uBLZYC956BlAR9MNya6r/cKl1w6DTWJyBLgTdEE70VrU3yXUUgkNxNM2zs2GLpZ7IAv+w2dwlIAIEF8p8wr73KFUyJvpwSRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558348; c=relaxed/simple;
	bh=eEF+kQ86yyD7TIQk0f5UX8EXFVpTF/MVPzfSM/OMBNk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ovnjC5W/oRmNVidpOXx7CWeaKKJI2OxTOT+fLX8Q3L/GLAypAH5sHnWQsEnifN+mHKEYO9vXM25Cakvf1yea4A6Hr9XRTMRTMKRnhmuiA71bOkMrezzze+s+0rR8s7u6nITtXZ2hLaZjCM7KmebDRk6Ci8K0hK0FmbDqaWYnfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItRheYPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItRheYPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8A1C433B2;
	Thu, 18 Jan 2024 06:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558347;
	bh=eEF+kQ86yyD7TIQk0f5UX8EXFVpTF/MVPzfSM/OMBNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItRheYPEKwygLfYcLzsPkMtLglfES1Kv8LMOtZme1kN07gR+P4AMLJkF/lv82N8I3
	 jJEHezvGULEoiCRjnz6hNOYD6t24cIoc9DlCqaLW5+qgMINKcrJEcdxbePYYv4B/aT
	 M6INd6t61i5t0EOVshsHNbBB+TDlbh5/fG/Y7X5fw5BHrMTr/Fm4hSLbmnfTOU6iRH
	 WggBxYE2wY92lsS1QX1LjHRUBN7k3PKcKbeBGOJngvQMamwo1NGdRtSNSPfhnJId6f
	 MbtGDEQB2NLhOB1fgEaieJhKLpjE9PSC9lFv59sv3usksmDqEhh+C/CSvFCkDPtVVn
	 S2UAmShuNwCXg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 14/23] selftests: mptcp: dump after creating id 0 subflow
Date: Thu, 18 Jan 2024 14:11:54 +0800
Message-Id: <a50cacd811730c9323401e7ac9efcdc829a050a6.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4043baa59c6..a92fb5469621 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3361,6 +3361,18 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns
+userspace_pm_dump()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl dump token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3522,6 +3534,9 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		check_output "userspace_pm_dump $ns2" \
+			     "id 0 flags subflow 10.0.3.2" \
+			     "      dump addrs id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.40.1

