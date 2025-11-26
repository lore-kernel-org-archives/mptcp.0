Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493C8462
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181885; cv=none; b=U/9X2l8vOMtilGVWmYT9Nx4h0A8O7QnNk3ZR2bcbzgnIpvD9Eay+wAzsk66NBAM1t0aZpVthnK22qk1EqXyJLmFfcAf0maP3vIUjSJgb9jrk7qL/plked8cbGhsdT3UE2WChXcGClKBaWdGa+FpJyoq6RYJ1jwEdsvGke1S7WfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181885; c=relaxed/simple;
	bh=MhLPNzdTWtfH1tgVNYZ+dFModedBNk/+vgcSo4LUjhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lefKxpzk4NSYTL+V2ooXK4cv6p5Qo/JcsQU6iGV7hiuZrjJDJ//JwvkAUZ77ZvmH0eHAbsDv+dVqS95xS2jNdVExuHD+Iv0p+zCkh770F0Ulgufc6ieA26eYQE0SF19EnhanPlH3NzaPfRrjuC+pDaUVoH03yoFxscwbhj0ktis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDCZfVCu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDCZfVCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763D4C4CEF7;
	Wed, 26 Nov 2025 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764181884;
	bh=MhLPNzdTWtfH1tgVNYZ+dFModedBNk/+vgcSo4LUjhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oDCZfVCuWbXdxaRZ7b9QQS/eXuhMjPdx+NsfRFU3XJE/ZlLxTGWZ/V3MV5IJu9pix
	 GjH2eFprAdljJNYaf7Gi1Rvse7YuOBtVDDJOdUodCxrCb6j8t0yk+fQ0gf17W76kwV
	 oydSEBQg8Glvar5O1KNCQQSIIEMt8bEbiW4/hmul+MpvB1Iywuic1uFDjK4DcxD8gW
	 bvn7OVZT8my8VwoG0coJyNXQrfE8VGkbDYkwaCvi7W+ERCVH8u3r+fNiTVy+BceLNI
	 4VLzdKcbfKM4epgwUffnv17MMedXv1B9TU0hQh1r1jOru5sHnscdRLjq5mD6/sHSzH
	 IX5EyGx8JoDGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 26 Nov 2025 19:31:10 +0100
Subject: [PATCH mptcp-net 2/3] selftests: mptcp: pm: ensure unknown flags
 are ignored
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-2-d2e4c2ebce0c@kernel.org>
References: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
In-Reply-To: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MhLPNzdTWtfH1tgVNYZ+dFModedBNk/+vgcSo4LUjhs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLV3SvWf/msUrqayfWxdVP7XraGdef9t9jFrFonYJi+q
 HhdSvn2jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIk8+MvwP2Ji4WzWhpfVD9K/
 F4Y9tjt3oEY38G9R3eoFvPmu+7/WSDMyPFFdtFvNU4fv6/GOUJtajlWByRb3T/Nctln9Tz2uNvU
 1NwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the previous commit: the userspace can set unknown flags
-- the 7th bit is currently unused -- without errors, but only the
supported ones are printed in the endpoints dumps.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ec6a87588191..123d9d7a0278 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -192,6 +192,10 @@ check "show_endpoints" \
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
 
+add_endpoint 10.0.1.1 flags unknown
+check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" "ignore unknown flags"
+flush_endpoint
+
 set_limits 9 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 65b374232ff5..99eecccbf0c8 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -24,6 +24,8 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)
+
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
@@ -836,6 +838,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 				else if (!strcmp(tok, "fullmesh"))
 					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (!strcmp(tok, "unknown"))
+					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -1048,6 +1052,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_UNKNOWN) {
+				printf("unknown");
+				flags &= ~MPTCP_PM_ADDR_FLAG_UNKNOWN;
+				if (flags)
+					printf(",");
+			}
+
 			/* bump unknown flags, if any */
 			if (flags)
 				printf("0x%x", flags);

-- 
2.51.0

