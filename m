Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0223BCE7
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096359; cv=none; b=UZrU8Mxq/VeTfAXmdKWvk0FRjbkZMzBbdVC1J1sHTeR4i/THhA3N5lA2NkKtGEmmfFnnnfmZhn6LlRcjAVhEdG4rLlvm2Ax14cms/XMLREIWNran8ke4r6W3ttWl2DItnOPsV1W01/HaQ9gCNd4KWBO2FTe0XMxSdtyNYClGjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096359; c=relaxed/simple;
	bh=Ol21gGhnsE1xDuPIY+KT8VKIVucgBUsN+lG8v8makhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMld0mk76QEeLmoGwTb6lSqpXVihiWYe9FLJtdQW4vRKSzVU584v/Mdpq1lAsN6R0WoaAb/Q0u3MgImOVLQIb1OSC6q4OeB7wjLVfUNxyMvSrsb/FxYA3R1SNm2D+Nr+tdRBTaycO0tlKxxP1Sbs4BWrkLP+1ZSrTSDf1vhUsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQG1fcex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQG1fcex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAA3C4CEF4;
	Fri,  5 Sep 2025 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096359;
	bh=Ol21gGhnsE1xDuPIY+KT8VKIVucgBUsN+lG8v8makhY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BQG1fcexnU0yLaG1TEugQKwnH/0ERzQjOxC5sv34Izuf8K5PPzprp0SqkNTkHfTEW
	 qY/Hng9NVsvzhOv3wGORJHomXd6/2ver8pt0xQCLEQTmn82LTAhKSH9uHugENkYMVC
	 w9eov6/JgUMIry2wEM2cQVZZ2YX0NjorGH3OfXCs64uoa1Ns1qBNhjmhPi1Od9L3lu
	 kd5N/Z76rLrIX4/O8DTID23+R6BdHf3An549m/tlgvJpRWcHtPSKAHgSMrDQSqw9tP
	 Yts6jJXqr6pfOrEvmpoaeJ+dgg+Ka06cSeAO7p9tE60wcEKXnG0ZvXfsm3XbbpHA7R
	 MpOR2YskpAy1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Sep 2025 20:18:53 +0200
Subject: [PATCH mptcp-net v2 4/5] selftests: mptcp: print trailing bytes
 with od
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sft-mptcp-disc-err-v2-4-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ol21gGhnsE1xDuPIY+KT8VKIVucgBUsN+lG8v8makhY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2ay5s/X0s9UFlT9Oplf+/CaTafZx07btqXu+q7KWGQ
 X+Nv1kIdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwk4w4jQ8O6yrrTtSo55lEr
 t7OdsdLKeLTX2cz9T3uY5ZRtE5+tiWRkWODMMDXr8C9W58kFE066q/xgdtrRtd7KLzJZNPtfyOF
 GfgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is better than printing random bytes in the terminal.

Note Jakub suggested 'hexdump', but Mat found out that this tool is not
often installed by default. 'od' can do a similar job, and it is in the
POSIX specs and available in coreutils, so it should be on more systems.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: switch to 'od', and no more check for its presence (Mat)
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 09cd24b2ae466205dacbdf8289eb86c08534c475..d62e653d48b0f2ef7a01e289fa0be8907825667d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -384,7 +384,7 @@ mptcp_lib_make_file() {
 mptcp_lib_print_file_err() {
 	ls -l "${1}" 1>&2
 	echo "Trailing bytes are: "
-	tail -c 27 "${1}"
+	tail -c 32 "${1}" | od -x | head -n2
 }
 
 # $1: input file ; $2: output file ; $3: what kind of file

-- 
2.51.0

