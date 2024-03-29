Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639E38DED
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688220; cv=none; b=rt2LQyjZC0Ge7j8hXyRm4GMdxRNl2m3RnPrgWbJeNKLXt4jpNGw/CijrMx1oAolM1tcnWfCzCOAN4T8IGlw+k4qWNg6M1aBTbLTacJMydXSrQ3BHLfMySNjHnZadkV7vGRPkNhDbiMMupI595jYC0Gngz2vpCYB7HzkWoBh9d/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688220; c=relaxed/simple;
	bh=eSRJqV9TJ2h4XZ36wFKzcYL2mrgwjDwh9TuUPhAEW5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXEd3K/F3DH1Q2jnI1WM+zJBdQc4138eeAXVTAAS4ow6DecZFPeVXuwiyTA1lI88zTUZKOI8w44KIRH6qLKDUL4JZXdOB1Gw9aTuTRhgUT5WxFJhHXKQJOpNEpa5tKI6Y7At2Rc7PvJ/tbpju9k6EtNF+ZBZ9nu1Fulprraaz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV3WpRHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV3WpRHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2089C433C7;
	Fri, 29 Mar 2024 04:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688219;
	bh=eSRJqV9TJ2h4XZ36wFKzcYL2mrgwjDwh9TuUPhAEW5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV3WpRHyrVaPf1Vp4i+K+DAKhaTjori9sQ+HML5k8+hz583+3uvcQDZQrVqHJFWPH
	 BV/a7XwsmWDjjZlQB/DliaCoUglNrsyvXta+6xlHueQ1iN/VoBtZ8io1JWcUa4a2ht
	 BvhKcLP/4/MFlK3QTgJm9gCi40NnUywD75eaXw1ltf9PMBTVuIF4ZSgBe49ic7iCBA
	 qJfqftvJpH6aT2DcPM8XsKWcbTWOJ8Kvy0gqmsZLe4Z0GT2fD5LPA/EkLNde4Qng2F
	 42wm47vWtGsLnAzSr+TVGTYf71QnZK+u2z2dL+7Galgbl5SKFN41BzUk6/R89e/hOb
	 Bn6MzfeYv9/AQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 02/15] selftests/bpf: Handle EAGAIN in bpf_tcp_ca
Date: Fri, 29 Mar 2024 12:55:58 +0800
Message-Id: <86849c5613173989382bf679b653af82f7d6a425.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_tcp_ca tests may emit EAGAIN sometimes. In that case, tests fail with
"bytes != total_bytes" errors. Sending should continue, not break when
errno is EAGAIN. This patch can make bpf_tcp_ca tests stable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 3da3030c9365..885c8b4e21a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -55,7 +55,7 @@ static void *server(void *arg)
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_sent = send(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
+		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))
 			continue;
 		if (nr_sent == -1) {
 			err = -errno;
@@ -130,7 +130,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_recv = recv(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_recv == -1 && errno == EINTR)
+		if (nr_recv == -1 && (errno == EINTR || errno == EAGAIN))
 			continue;
 		if (nr_recv == -1)
 			break;
-- 
2.40.1

