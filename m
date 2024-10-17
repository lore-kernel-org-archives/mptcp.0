Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA781714B4
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160197; cv=none; b=WWDZjPR/jx6GcCVICiYb9N736YFIS9RcwBs/z9cAmuBSrQiHTlycQLfz2EOIUk/ucgdARIDmt1z/1b+QV0MKpROySR9AULOWtVmWnD5aGV126LQ8vsdBbVdJNRY8JilgfwDYjhX03YqWeJFRNDUS13oQb+vnkxHMqdUH3rchG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160197; c=relaxed/simple;
	bh=+ERGzFcGqAZgfpbsL0KQxvrUj31An94qTY+Z0b8vfJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLzdv1w2eh/JWw8a5iLK0K8tGWq1SaB+xWON3u1fV1jloadTiWCRoGzpxq/6qbKMSec8iluJowA7/OCphOOkNMjvkSeFO8TLfQo04EXfY5WAeOSVb68lpgdowkHHwF0UlLR5O/qU1NXvWHgYDWNL2MJtvqhRYssa0+/P/r/jHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do8Vu6G9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do8Vu6G9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E5C4CECD;
	Thu, 17 Oct 2024 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160197;
	bh=+ERGzFcGqAZgfpbsL0KQxvrUj31An94qTY+Z0b8vfJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Do8Vu6G9ySJOrbcTHqMimODTPjmq9XpuJPb/fdFHov4S71VWFgx21bt3PiwKLt4l6
	 cbj7tXzO9KjhvxqlhIG5Yzf0L2G6u7fmCGccIUb01KtVHLryjJ6bmJ9fr7F+7eCuND
	 i5suaa5VxpD3QvWQFdFPm1lQneohIQEy1uSi/DibtPT9qLpnztR3M2lQQlTMfm/cVf
	 ZbzCcgIw8RhYUAmdtNWoTEcDvRnbSt8gzqadUcbJcxrsFNufIovElrbZL2JfV4ZIiy
	 8ddFpiBNhuoOfvG/llei21RmRPLwv79TXMscLNR58IXFfUX+YrhfT7nuFxBAn4jA2t
	 PTIUuYjMM8Ggw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 17 Oct 2024 12:16:26 +0200
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: list sysctl data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-mptcp-sched-avail-lock-v1-2-028ef592c6f4@kernel.org>
References: <20241017-mptcp-sched-avail-lock-v1-0-028ef592c6f4@kernel.org>
In-Reply-To: <20241017-mptcp-sched-avail-lock-v1-0-028ef592c6f4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+ERGzFcGqAZgfpbsL0KQxvrUj31An94qTY+Z0b8vfJE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEOQClvJeQAvHhbBGW8X114vCMIjyOTnMKco7q
 b7mZhMMgk2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxDkAgAKCRD2t4JPQmmg
 c03/EACn6A13WmjrX8T31vWQwHgQ9ah9dTe8scv0OWgHrbKfUIsdjdHlWoFruhCA+WMdfYL6l43
 IHt1Amer8r8auwd6qLIsWg8tAdfdbVKlR71hT11V5xWy9gJv5+5YOsyugLe47xVYwQT9f6XJpW7
 4OQd3FaUtSt7nAd78eKrQ/GYkfk8ySJblqWTER4AOCqU104Qy5/NRXT8uDNKvqpCRyDMfq0HdT6
 cmEDdv7a1yTa1njRsiHwAsnHhfqdgvjTfRgwNOb9Jbi+dDc8gWt+R1eUI/r7WLucPyLuauOqAB3
 53OtqnrkrJhtDPRY9a0kaYtsXs0N16lxlp/myGxLUaxyB1iexaAQy4xRIG9mgQy4zPIFh99NY/q
 7Uu2D9JMkdne9lEbPoroio1OoYJmRYXWrZl+c2j6mGZWQQgn/XtqVPTzmq0fP6OseYufohxueE9
 tJNM6HlzPKvEfBFjic4Ou0iu1cFveBiVUvEPod7HhCbH0vesYJTXx4QF3iAN8Xex62OASMdNVmr
 /7Kn0HfKr9hGeGNUwJQV6+eHc+bXgw1ak9zJn0uNWKzVu85yLhS3qZt5CFZpa9LG1x3i6PnE/y+
 VfUbuEVf0lQzDN0Mc2NLy1xXRPO69FYi/qI93UjWqgwyIEQRa3Bnr3rO72tWCvDnn9kFg54h9Jk
 2b3EO/THhEHC1ow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Listing all the values linked to the MPTCP sysctl knobs was not
exercised in MPTCP test suite.

Let's do that to avoid any regressions, but also to have a kernel with a
debug kconfig verifying more assumptions. For the moment, we are not
interested by the output, only to avoid crashes and warnings.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 57325d57e4c6e3653019db2de09620d692143683..b48b4e56826a9cfdb3501242b707ae2ebe29b220 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -259,6 +259,15 @@ check_mptcp_disabled()
 	mptcp_lib_ns_init disabled_ns
 
 	print_larger_title "New MPTCP socket can be blocked via sysctl"
+
+	# mainly to cover more code
+	if ! ip netns exec ${disabled_ns} sysctl net.mptcp >/dev/null; then
+		mptcp_lib_pr_fail "not able to list net.mptcp sysctl knobs"
+		mptcp_lib_result_fail "not able to list net.mptcp sysctl knobs"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
+
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"

-- 
2.45.2

