Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531B365A10
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769798357; cv=none; b=ENG2Vt4ebFOLGepUj41mnvfx7a6+7GsClnRw+9d0ELMhjpCWijm3qdf4RXDdDRPaCAGg/reGyh/yR8EBkd2sOqS5VTUEFYAN9Im+W0unem06rnAm1wGkziqrQnlcxa45r1fkXmzyGu6Zkl7zVSl/fGE/l3tKOdxD7FQ1f5zf1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769798357; c=relaxed/simple;
	bh=NI3fvKsVUC8KjxnSnEFn2gBT9s3P/3xz0HhbhaStJXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jrAoScPjYtfhyNs9i/KRp2YNU9XUCCWVuQz4rd/W6p4j5CML9Oa1bYWO9mRhEy+EJRA+c33H2F+fZB4btxOs32j8W4KbTfMuBpgVQzrSo9eB7JOMWB30YpE12fpe5H6IQvnx7FbyDENZzaP6G1OJRXQX02gqBrIzBH4yln1sJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKjZqWwQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKjZqWwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE4EC116C6;
	Fri, 30 Jan 2026 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769798356;
	bh=NI3fvKsVUC8KjxnSnEFn2gBT9s3P/3xz0HhbhaStJXo=;
	h=From:Date:Subject:To:Cc:From;
	b=dKjZqWwQbCRGFor3mz5hqaygE26bC7qwNpqSMOa1lzEru8pDYeS92VR5tnRzw+knZ
	 x1fswAlzmPKN4srC79WeyFu4Q+02G9UibAgtf89DtWdimUswbYsIZu6rgZrB6i1rYt
	 P1QJZdpnW4fXwlsDT3H2oXWV4y/mtcPb3WFK6iMRwjoVnUvyEZOiP/xA1lIBMtkbX9
	 D7ioLOKD856KsQSBxLXuLZdjJ3qjihYiJYLZO0dNUcDmpacH6ESs2wvZIbQ2Anlb9J
	 bAHGMjhoIdBPR9539pf1ZR4uQ0AeTWlfGJjubr6wM5A92h+knBtZLG3ZdoKuKBgodR
	 P2bwXN0FsxhVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 19:39:10 +0100
Subject: [PATCH mptcp-next] DO-NOT-MERGE: mark some simult flows tests as
 flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-mptcp-issue-607-tmp-fix-v1-1-c7fbfa0c2915@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM76fGkC/yWMywqEMAwAf0VyNtDGF+6viAdXo+ZgtzRVBPHft
 +hxBmYuUA7CCp/sgsCHqPxcAptnMK6DWxhlSgxkqDa2MLj5OHoU1Z2xNg3GzeMsJ7a2opZoKpv
 qC6n2gZN+zh28keMzQn/ffyaYNIl1AAAA
X-Change-ID: 20260130-mptcp-issue-607-tmp-fix-9152922d475b
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NI3fvKsVUC8KjxnSnEFn2gBT9s3P/3xz0HhbhaStJXo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrfl1RtO47bWotseTlz+8ftMpeyd6IzWpOYM2b58iTd
 kO1J8Syo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLTWhkZ2rRyMwuaXDf0LIri
 zf0vGrW8rP48z+UVT9f8ahWeLiE5j+F/uFnTjgOn0mfPFWbXmamz99dX1+jQcuPcuDm7d2UmnmL
 iBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is just to reduce the noise while we are working a solution for
issue 607:

  selftests: simult_flows: "unbalanced bwidth with opposed, unbalanced
  delay" (+ "reverse direction") are unstable

Suggested by Paolo: commit "mptcp: better mptcp-level RTT estimator" is
probably correct, but likely it uncovers some underlying issues (in ack
generation?).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To be placed just after/before the commit causing the instabilities.
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 806aaa7d2d61..a9c9927d6cbc 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -304,7 +304,7 @@ run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 # we still need some additional infrastructure to pass the following test-cases
 MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
 run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
-run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
+MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret

---
base-commit: 50e7f60d4f2aecec1adf329735dd16a88d7d494a
change-id: 20260130-mptcp-issue-607-tmp-fix-9152922d475b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

