Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3417C9AE
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544019; cv=none; b=Q51H8CXbZqvXu2orUUHoi+4Kbj5qz50SMgB+MZNaV+MwK0Po1uij+LX5QT2k+SJvE+X0eFFaVc8OhftWbijeav9Cu0SioaYvcT3RDD8l3DTJYo4nEF77pHzsSuqDQbRRWzJypbnS3DFcBo5LRBfdajgHflUJEa7zLycT5kRNgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544019; c=relaxed/simple;
	bh=mkLP8+AN9cao44fZKGMSqhr1hQQrAQmxxj7CV/paazc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQwPg0VuFzCcF0nxNf8mwr5uFdHyDhrMFiBKRDw7Wl3cAYkypUw+Q60bkcqFzq0sH0bEi68OuxgEV8HMXbE96xtsgyidUuMXE67gmSN1r7Efp8JrQKvNENogsqhUXcrqKf5NwdLFcutIIntgG619SZnaGOW87L6FhkNNbn/nqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXkThF9x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXkThF9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A358FC4CEC3;
	Thu,  5 Sep 2024 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544018;
	bh=mkLP8+AN9cao44fZKGMSqhr1hQQrAQmxxj7CV/paazc=;
	h=From:To:Cc:Subject:Date:From;
	b=WXkThF9xLbwRPJC2xv4gOekkq0kDLehh5wzHYesiX+RiO4Jry3hPwVNPqN5FKXbIp
	 Qj302xbWNEpSIWvRwKp3mryp0AIticqfsSKxXi56Z1oNtb8pZkL7+C+MjrZpzxo49d
	 ZuKW28/fDzZNORVV6e7xw7ydsbw84p+EueYWDTvgpgXuCsOCLHlIoQgdE8VFRXAfzt
	 TVintMdBxALv97wstXnwxllVykZ70M1Vdc4jjML3iIQ1sy/GluKKy3tcgqwctVKl7Y
	 U1WJ/rBI++OhQBn9baJCOL/vm5jVGxw05xyv4W2wUClWaruhMvl5JOsgVBD4YyqD4h
	 2AThcQxpLKBFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add getsockopt to inspect mptcp subflow"
Date: Thu,  5 Sep 2024 21:46:49 +0800
Message-ID: <11a224e1bade27689271af77cd47c6a49852a2cf.1725543947.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update error messages:

 run_subflow:FAIL:mark unexpected mark: actual 3 != expected 0
 run_subflow:FAIL:cc unexpected cc: actual 'reno' != expected 'cubic'

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index 70302477e326..a5e42bfddbbf 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -63,6 +63,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
 {
 	struct mptcp_subflow_context *subflow;
+	int *optval = ctx->optval;
 	int i = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
@@ -72,7 +73,10 @@ static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_soc
 							   struct mptcp_subflow_context));
 
 		if (ssk->sk_mark != ++i) {
-			ctx->retval = -2;
+			if (ctx->optval + sizeof(int) <= ctx->optval_end) {
+				*optval = ssk->sk_mark;
+				ctx->retval = 0;
+			}
 			break;
 		}
 	}
@@ -83,6 +87,7 @@ static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_soc
 static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
 {
 	struct mptcp_subflow_context *subflow;
+	char *optval = ctx->optval;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct inet_connection_sock *icsk;
@@ -94,7 +99,10 @@ static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_socko
 
 		if (ssk->sk_mark == 2 &&
 		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX)) {
-			ctx->retval = -2;
+			if (ctx->optval + TCP_CA_NAME_MAX <= ctx->optval_end) {
+				__builtin_memcpy(optval, icsk->icsk_ca_ops->name, TCP_CA_NAME_MAX);
+				ctx->retval = 0;
+			}
 			break;
 		}
 	}
-- 
2.43.0

