Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34220764E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347434; cv=none; b=teO62yQ/wi411Iit+ig+A827ZYoeh1LQWc8dWurY15/GmvFYsHXTTyoWnByve4MSEPk0NYMkDIoQzZujeEOZJtTCkqfpYZO6FUk3cUgApw+SBU9nG7xQqJttLQEw2J6sJet+/qKmC5DJOYuUdrnZ0br8UPWG8CThV1mGYMAmPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347434; c=relaxed/simple;
	bh=PQq1+Si2TDZR9w5xB3kALelxy2NlKHXh4/kK9wqlezI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVY6RPZrlc03fg3P8oepUrnBpJPpsM4FrrXcy9YDGQ5s4b8j/w5kP/FBSkq2kV68SgdJMJhDxRt4mey5R9MFvUk1rv+PNL8qn4o7UWLK5r8NMmvDSLuM0x/gsheSyDheCMmpIW+JJYE3inieO8y+T7Lh20irAwK8hex1HxYYr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEy1ltvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEy1ltvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B6C4CEE5;
	Fri,  7 Mar 2025 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347434;
	bh=PQq1+Si2TDZR9w5xB3kALelxy2NlKHXh4/kK9wqlezI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEy1ltvrOPxVUEl+MM9CHnsvrlZtLlecfJxWMZq5lmN/EoCjHz7JdIwT+omN0M0Z4
	 jBbZZm8FXhEWx8Kv+4cZNCrlvA5xplhVKYYEODbk/jxmeScA5hquRLlz7/BQbZ6NED
	 PuO/STZ+gvWBD2VKHAD3eOfppNPVeF8raDtbtdggdwomoo1THqmBJE3W/MPjMbvBAD
	 /RdrDmyhC4c2ulthXVckvBPyngJw5ZF+fpjtGKD6eVJAk0ECRA+4Qk9s37V0I7r9J7
	 Br65jwbUA8RsQEyzqBqJ7hdybhHXOX5Wc2z1BM3BTX1iVSPqc9JQqlT5wuJ/eGBQsg
	 Bo58iCLGq9+5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 08/11] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Fri,  7 Mar 2025 19:36:49 +0800
Message-ID: <d1e9b3a1e693268a08935c50c984ba1bc77ad825.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Keep mptcp scheduler API unchanged.
Use mptcp_subflow_sched iter instead of mptcp_subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 5128a886119d..5a3910fb0aa7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -31,7 +31,8 @@ void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk)
+int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow, *next;
 	struct mptcp_rr_storage *ptr;
@@ -48,9 +49,9 @@ int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk)
 	if (!ptr->last_snd)
 		goto out;
 
-	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+	bpf_for_each(mptcp_subflow_sched, subflow, (struct sock *)msk, data) {
 		if (mptcp_subflow_tcp_sock(subflow) == ptr->last_snd) {
-			subflow = bpf_iter_mptcp_subflow_next(&___it);
+			subflow = bpf_iter_mptcp_subflow_sched_next(&___it);
 			if (!subflow)
 				break;
 
-- 
2.43.0

