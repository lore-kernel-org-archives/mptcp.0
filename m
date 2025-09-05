Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43823BCE7
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096360; cv=none; b=WbT8xcH0PzmgtAn8nLLr/MvFauM1B4UE9ynucfT6feU3OXKoom3UyXkwxCHToTMZ/kbEV/uT1cWp9P/sj9eG/cu+EyQ5kzr55GGa+SkipYgIzgvXhC+aMp35XmHpUq+TXXzxSVWJBo+IPNpUmuz56wNeuf0ULXwkOP+UHJ3diaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096360; c=relaxed/simple;
	bh=tZdlyk5IiHHI/PKgw6+TAHLe/QlloNlNqhCRGPJbons=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMA/bpx+o4k4i9X28viwro/Ve4X7fQJ72N/uawPDrA0yrQA1u+luZt9ZDNWRMVWZCZmTleFjO6lMVCsSoS3BsuNycKuPCgi09dcHh/tBWQ2ujEwGhKX9ByiskzbfgHdvNrSLmDJwz0FbUKFDH8hXVWf6MmbMSrje+gF3A1q9YQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJOj1tAd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJOj1tAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38A4C4CEFC;
	Fri,  5 Sep 2025 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096360;
	bh=tZdlyk5IiHHI/PKgw6+TAHLe/QlloNlNqhCRGPJbons=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SJOj1tAdknXmGM1+BmA8XLLJCKV+V20iLo/+j73A5FKS8U7yEeLJPBcAxLR9EZGSc
	 YMykLtbR0RQEuSS96G88RYzI47YGxXh6dFrrMDNguUDm0f9NW+cj63UJUKkYJq2xXP
	 Nih7U1vO9x34JYB79/Txj+Cu2Zfc6STlpHOILn3bYrmQfT1kLKTlWHhTrVvYokx63M
	 WRKSNy1v59LaXxbBione6s0LjxAv4muoxefyYMoe9xBgyakBknvqMiI9SrnKo6yhUJ
	 TFxi6QsqbFYZ/ODL9PbpyEyMIS2/YBP9k8iwtHPjatbxXHTkX5l0SXfCBJWq5gcG8H
	 60sxO/mdj9j/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Sep 2025 20:18:54 +0200
Subject: [PATCH mptcp-net v2 5/5] selftests: mptcp: connect: print pcap
 suffix
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sft-mptcp-disc-err-v2-5-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tZdlyk5IiHHI/PKgw6+TAHLe/QlloNlNqhCRGPJbons=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2ay5KO+Y058VrOY/HKzLmXC6bGVgV/nibXfzHwxr1r
 0MDpzEKdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkhz4jw7GkZJ/Ih8tePH51
 VL1K5gjHzyUvJfxF9SQj51s2iEsy9DIyfOvhClWf/sDdsfIU6/Q3J48f+q2qY7+mZBZL40rvBxE
 KbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To be able to find which capture files have been produced after several
runs.

This suffix was not printed anywhere before.

While at it, always use the same prefix by taking info from ns1, instead
of "$connector_ns", which is sometimes ns1, sometimes ns2 in the
subtests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e3c56253274a1f938d2ed9986c4290fcea8b96b..19e2bd3000ec8be470a34d503ec034404e798fec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -211,6 +211,11 @@ if $checksum; then
 	done
 fi
 
+if $capture; then
+	rndh="${ns1:4}"
+	mptcp_lib_pr_info "Packet capture files will have this prefix: ${rndh}-"
+fi
+
 set_ethtool_flags() {
 	local ns="$1"
 	local dev="$2"
@@ -361,7 +366,6 @@ do_transfer()
 
 	if $capture; then
 		local capuser
-		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else

-- 
2.51.0

