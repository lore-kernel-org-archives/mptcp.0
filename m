Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF726B95B
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768260; cv=none; b=mtfI1M6iUdtsC5PzaI0kUtQsFDvd7ME7ZTEke86GVwKvmJm2G2OfuduJ0uJ3u5RYTP6m86GlJGZJ1AtdPi2QwMhkTXmjtTJYq3d2qpk1/LdqRwswrHXbTskGurqoDgxuEloNpJv0jG68WiMW82XLd2EOUHEcN8NiMWFj3KoOKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768260; c=relaxed/simple;
	bh=8EuwF54v5BJiBXhslAd1hUmPcOYj6sDul1v3UKHtLqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UTi6IGV6m2dfmoBWAZ166k4W1/zPyRW5LluxYVwr/N118MBqojfrxg1Pb+CfooxCLmSBZW/RXS5xSSHQ+2pI+ohKDUQylx5slYG85+A1s9Z9XWC9Hr6go1vgIaZcZkio1RbfvQWwEZFNB4BA7A/hSh7m8RlhmQF7B41xtx7mCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTJoG2tM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTJoG2tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB14C4CEF7;
	Fri, 30 Jan 2026 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769768259;
	bh=8EuwF54v5BJiBXhslAd1hUmPcOYj6sDul1v3UKHtLqM=;
	h=From:Date:Subject:To:Cc:From;
	b=YTJoG2tM6gM3xNzSPtnL2vsGsSUDv6TrwoNbdRzb+Z1twfTnxEl98rU5/0W+BKcle
	 Gb3krdyLqqOSYpx5n1eHVip+dgTpfRKVd0d4EBZlp/yS+CL+Cp72MVVX9s7Ow9ncLO
	 k4S1fqSLsLbAEkgoB/JrH8UAYjLft8ETEN2+PTMR+sGFjRhHz/rpACo3MfgduCJOGv
	 o5UG0ju28f12xIiVsOy+vIcyNE6PCpE47SRFpYNLdVRgAZ4OgpqgU6RpwkdstXg5FK
	 72NivefTAJVxwJ7hsCDruXEwdCPrdto+Rvboo2rmv4zRK2weeqhBW9miKwqfQVwG8E
	 CitYpBzR4xmIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 11:17:30 +0100
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add splice io
 mode"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-mptcp-sft-no-ignore-splice-err-v1-1-af0a458b6ec8@kernel.org>
X-B4-Tracking: v=1; b=H4sIADmFfGkC/yWNQQqDMBAAvyJ77kISsdJ+pfSQxtUutJuwG0QQ/
 95gj3OYmR2MlMng3u2gtLJxlgb+0kF6R1kIeWoMwYWr873Db6mpoM0VJSMvkpXQyocTIali7Id
 4G1Pw4/SCFilKM2/n4AF/V2ir8DyOH5K/uhV8AAAA
X-Change-ID: 20260130-mptcp-sft-no-ignore-splice-err-a35a97c217db
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8EuwF54v5BJiBXhslAd1hUmPcOYj6sDul1v3UKHtLqM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrWp2KQnu1js3uK2dV7J17bcnPloePow9cULo12faEg
 GfYp/VLOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaikMHIsMR8KmMok0jBwQO1
 bPul7Nct2yGQ9M7/jOAV/mXt06fsLWVk6JGdcK6Le71VZ4VcVOvRLe+vPVv7Wrw584e2w5fnhw2
 yeQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

NIPA review assistant rightly spotted errors with splice() are simply...
ignored! Technically, mptcp_connect.sh will check the integrity of the
transfer, but still, that's clearly not a good practice!

The different possible errors are now caught, printed, and reported to
the caller.

Link: https://netdev-ai.bots.linux.dev/ai-review.html?id=93466fc9-574b-45fc-996e-13a19a1490a9
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 34 +++++++++++++++++------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ff1a298d3469..34d8efe429a4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -937,24 +937,40 @@ static int do_splice(const int infd, const int outfd, const size_t len,
 		     struct wstate *winfo)
 {
 	int pipefd[2];
-	ssize_t bytes;
+	ssize_t in_bytes, out_bytes;
 	int err;
 
 	err = pipe(pipefd);
-	if (err)
-		return err;
+	if (err) {
+		perror("pipe");
+		return 2;
+	}
 
-	while ((bytes = splice(infd, NULL, pipefd[1], NULL,
-			       len - winfo->total_len,
-			       SPLICE_F_MOVE | SPLICE_F_MORE)) > 0) {
-		splice(pipefd[0], NULL, outfd, NULL, bytes,
-		       SPLICE_F_MOVE | SPLICE_F_MORE);
+again:
+	in_bytes = splice(infd, NULL, pipefd[1], NULL, len - winfo->total_len,
+			  SPLICE_F_MOVE | SPLICE_F_MORE);
+	if (in_bytes < 0) {
+		perror("splice in");
+		err = 3;
+	} else if (in_bytes > 0) {
+		out_bytes = splice(pipefd[0], NULL, outfd, NULL, in_bytes,
+				   SPLICE_F_MOVE | SPLICE_F_MORE);
+		if (out_bytes < 0) {
+			perror("splice out");
+			err = 4;
+		} else if (in_bytes != out_bytes) {
+			fprintf(stderr, "Unexpected transfer: %zu vs %zu\n",
+				in_bytes, out_bytes);
+			err = 5;
+		} else {
+			goto again;
+		}
 	}
 
 	close(pipefd[0]);
 	close(pipefd[1]);
 
-	return 0;
+	return err;
 }
 
 static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,

---
base-commit: 7d56f2ba4d372e9660633de02a01236209c9df8f
change-id: 20260130-mptcp-sft-no-ignore-splice-err-a35a97c217db

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

