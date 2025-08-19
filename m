Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9624167B
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626739; cv=none; b=bLJ5ydm1h0PhKH6cEWv3b32YiTGBAobdW43UpahCM/x+d/GEei6WFua6dKRi/ixGg5F2Ov5R4oNzTLK0DdwdnkI5Bc5oIHmiSC+q1DkS9k/PtYp2fAzJBTQYTlGh/w4uzhvSqOL+Yro42/zepPSKSBn7znoMr25brx4iFRDJ9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626739; c=relaxed/simple;
	bh=WSm22PzpWnWu4JwaNSwZ7Og5k7yiaspzpep/EyVMNJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=D9VQnw2Lv7eu2yXyV8FxJJi+HlX/SsGYzX0xA9XRbAGqF4pqPB/W5g4WUv7nrFGHFRAcEGDJ4TIlaibG+50YpOaTy+oYm+BlFdGHsEBliIv+jdpI7wfDVSzfl1pq/5t8hEhiFycgJ/Xz+IcMrZHYZSqcoB/E5MboCa2lkg+CtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TikjgoVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TikjgoVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F97C113D0
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626737;
	bh=WSm22PzpWnWu4JwaNSwZ7Og5k7yiaspzpep/EyVMNJw=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=TikjgoVFrd0VHl1JV4YGkDOOv0njnFIhkcFUmbJ0XBl70NkaStDgUO909bf0vwQRC
	 n8SUjhMuWqoICeKPVs+se+ZLk9Ndg6xY6t4XEy+9q2YTyqL7FRjGqbbwd+k8xhARNP
	 81rdFhsX1WO9r45+gP5NYDE+cvlZOTBwfxQimlElsgCT7L/UFbEKC9NYv3/3Y8JmOG
	 5vHlmtlTBBc1zBObU18Us88g6f6gbhiOAVNRWrPOLtkt3FVDB9Gy/t51SLqU7GJ0gC
	 O2EvNe5zWdaoXPz1yfLkj8oFwQrzOK9l5IH64+v2BKGzKh1Hya/Nzj14QCNn7E485h
	 UK4om625O3Nyg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Aug 2025 20:05:23 +0200
Subject: [PATCH mptcp-net 3/3] selftests: mptcp: print trailing bytes with
 hexdump
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-sft-mptcp-disc-err-v1-3-9d0cf296bc13@kernel.org>
References: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
In-Reply-To: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
To: mptcp@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WSm22PzpWnWu4JwaNSwZ7Og5k7yiaspzpep/EyVMNJw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKW7Hl3eOPO4rXvMy0eK/Y/Fr/amj15lU/HHo137Z/sT
 59yMm6U7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIABPD/+Sax5klk3Qn3J3s
 bVt2dHLkk5CoIK2ze0xipLae+qsRycnwP3rBxPCFs19mzn085d2OhSt5FjkHRp1MU2J9dSHm/5J
 P9SwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If hexdump or busybox hexdump is available.

This is better than printing random bytes in the terminal.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 09cd24b2ae466205dacbdf8289eb86c08534c475..20ce95c9d35538a03c1c3cac843657d258fc9715 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -382,9 +382,19 @@ mptcp_lib_make_file() {
 
 # $1: file
 mptcp_lib_print_file_err() {
+	local end
+
 	ls -l "${1}" 1>&2
 	echo "Trailing bytes are: "
-	tail -c 27 "${1}"
+	end=$(tail -c 32 "${1}")
+	if command -v hexdump >/dev/null; then
+		echo "${end}" | hexdump -C | head -n2
+	elif busybox hexdump --help 2>/dev/null; then
+		echo "${end}" | busybox hexdump -C | head -n2
+	else
+		echo "${end}"
+		echo
+	fi
 }
 
 # $1: input file ; $2: output file ; $3: what kind of file

-- 
2.50.0

