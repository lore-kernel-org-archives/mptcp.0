Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80424374D1
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688218; cv=none; b=KO9TZF1JtFgf9GcWgc+gqjoySsVGSDymLwSrFas2FbJK4GzPdG11NfiiC0Wt4+sS99skuLdwiG42FkwZ0EsVbbzq28RhxBvI31omalj+hbPAcKSFune0FPYS8yQahBPJrWtv74QJeP+s/gQdmJIX78N6x0X60DKiv8PzKOIwvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688218; c=relaxed/simple;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGVPViuDX0pqHxixCJwkQkB+hmzf0gT44+WDiVQc/Q7kz6s21xQIhQzQj1LSu2CRD02RHcwBN6zBu+o8DE74Cd6/z1SdZeJz67gZBt8EMRbAYgPylN7zORbkKgoxOF+k3rU7oUDUdm8dv7E3UnpP3jReUObX8+RZKKotyb5uPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb+sEDaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb+sEDaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12F3C43390;
	Fri, 29 Mar 2024 04:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688218;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fb+sEDaPRTmNdtKE1sxMz/gb5hI8FIR2hH5yYD5/5RwsuVjiJMTipHDN2ghZrt0A7
	 +Az1A9yK9ByUWkIZX/0cE5RhP07eR4m3xyjopNJgslE1DfNt41XgwH4VHclftB+bt7
	 V4CEsKGwhhWss1o/ZhGpynpRJTqT2Bbzi8Cup7ihA/90LVlb/5vvCUKRprxsKZaaJ6
	 jKSe3ry/d+rEBItmMJfWQhh/W6wZ5d+xA7D4MMbxOhQDmdJg2Z/k6DI/i19EsLeeOI
	 +wRu8QEG/PqkBkBiV4TEILoEBV3i4xuK5J8tSeI+VbZVIA32hQ4Xsf1mf6helu+gxF
	 CA0RtZA6gz8DQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 01/15] Squash to "selftests/bpf: Add bpf scheduler test" - fix
Date: Fri, 29 Mar 2024 12:55:57 +0800
Message-Id: <74e771eb62337bf1ee04ce1114c8fa9a858eafea.1711688054.git.tanggeliang@kylinos.cn>
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

BPF tests fail sometimes with "bytes != total_bytes" errors:

 # test_default:PASS:sched_init:default 0 nsec
 # send_data:PASS:pthread_create 0 nsec
 # send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
 # default: 3041 ms
 # server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
 # send_data:FAIL:pthread_join thread_ret:-11 \
		test_default:PASS:has_bytes_sent addr_1 0 nsec
 # test_default:PASS:has_bytes_sent addr_2 0 nsec
 # close_netns:PASS:setns 0 nsec

Here errno 11 is EAGAIN, sending should continue in this case, not break.
This patch makes BPF tests stable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6e28215d7404..7fec91ab19cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -353,7 +353,7 @@ static void *server(void *arg)
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_sent = send(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
+		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))
 			continue;
 		if (nr_sent == -1) {
 			err = -errno;
@@ -397,7 +397,7 @@ static void send_data(int lfd, int fd, char *msg)
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

