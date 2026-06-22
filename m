Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555603A05C4
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121166; cv=none; b=WGoxaYR7Ox12Gg4SyMt6mqYVbDuWkd6ML8Ip4pbFa2hX/FvtNxpKFfcw0E4KMHtQR7iz4uuXGpknt/dbJPHtDCMGOgvqvziIeSSl960a94ITB0J0oBeg7HMWQF5FPNSslvDU3EO0UhlajyczmwpG8wto8mZQQUWbSg+z6+Wb7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121166; c=relaxed/simple;
	bh=nvKtB6cWQU6jGJyD9lZOP2a7XdO8+ioT4ska3aZ+mZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNec5e5z/k5hvKJcW8viCZGyXChl91eiK5OuFSP9yQliaDtoNdRsNhIavQ92HiGDg3mX7AHfKJkdijiySL+xlqzfEePuEIcClIrZBPi4SaqiaLriCHuxSLDZKsbGSHWabx3wpgVhNT+L5no1ErXXE+ZJJl5MI4Ba039ov/YKEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxQJFWFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxQJFWFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0E01F00A3D;
	Mon, 22 Jun 2026 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121165;
	bh=vXRAaj2pbgMW1FkG+K0dYT2Mld1BOclxfeYQJoAoRao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LxQJFWFlkrMocT70sSbtQ/0ybWWKzwSAIYyZLCQ/UKXgBKP6sTfeA+cVBqmcVNCdK
	 CHAp7kQWtLm88hZ2sRV8wsVogjEoRDaRFIQbw+rQsKsKAtGsqHGoaY55YjH0NGfWS5
	 kAEA6xn/4d7eW2UjuulH8+wUnYGI62IAN16MW+Rpcz7x81xqIW+aMH6F59LKDL1fu8
	 BgLvebRahBZeDFEmD/vEo30SPV9z66obbMvsJ9eZgNuaiJEHRcmiZ1803t5eP5LDM5
	 hG76nFYyxZlccl3yXGO2C9kxuugovYMwUz0G2SiytVjFFQUZJE8kM/Koj+gvgLvTlf
	 /2Nz/fLh1h5HQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/6] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Mon, 22 Jun 2026 17:39:02 +0800
Message-ID: <59c2a3be0e3942fbc4321a88a411c9a8a4f09829.1782120674.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782120674.git.tanggeliang@kylinos.cn>
References: <cover.1782120674.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace bpf_mptcp_subflow_ctx(msk->first) with a bpf_for_each iteration
over subflows to find the one whose tcp_sock matches msk->first. This
avoids passing an untrusted pointer (msk->first) to a kfunc that
requires trusted/referenced arguments, resolving the verifier error
"R1 must be referenced or trusted".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c       | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index 96b002808ce7..13ecee9833cf 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,13 +20,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-
-	subflow = bpf_mptcp_subflow_ctx(msk->first);
-	if (!subflow)
-		return -1;
-
-	mptcp_subflow_set_scheduled(subflow, true);
-	return 0;
+	struct sock *ssk;
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+		if (ssk == msk->first) {
+			mptcp_subflow_set_scheduled(subflow, true);
+			return 0;
+		}
+	}
+	return -1;
 }
 
 SEC(".struct_ops.link")
-- 
2.53.0

