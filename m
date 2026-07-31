Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA1426EAD
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505019; cv=none; b=kodl+RNP/4qJUhRDygQBP0q7bzNwfvI6tYyKTd79iMxMgKbMZyAQHorOKEkto0f3mjlm6J4NYz6+J9eWSFiAlBsDgH8aKhOcmKlGa//1cSWJ8M+hqHjqTC9kccmkhJE/NFeqNUmI0SMNRLusw+E4ON8/HRFYVmGiKqqstZVmVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505019; c=relaxed/simple;
	bh=A/1kUH51wJGNQJ1e/m0OL4JrNZeyNVOFalxF9ZgyO8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHDYTg7h5fbfiCNboSYZfZq3Pwvyvr6Ez1/5znrT3jWpWM+x6XqwlQ0yfgPRC3elkx74S6wjwsb2DcjtdTBXc4V3wS/QTLqJ7mKS9uyf2ixb4XirztKQHud+y+1t5NGze4+z7vAdXdIRoT9V+Ry6TZyxPZDfUrZZxJzyApikKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7phLt1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7phLt1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC541F00A3F;
	Fri, 31 Jul 2026 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505011;
	bh=zMrRwDSQPruKPueTszchR0AK15jiRZ/ywP7bgU7cZcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q7phLt1v5GJlO5bqGBBFVbb/pGovk4UeD/KVMviPU0JgOCjZeXKILzrj+ZLZ8+ZQA
	 fXXgP40khulPTkq/G3y4Ylu2dcRyDgclNoKYCYCK0OVMUmW0i5GXn9Gx+XqrpKNMz3
	 fGrWkogMyy99bAdatiR5+6vgZigISMOfVULoBmv40s61cPTJgnWnYLY9gmP9I1qTxJ
	 eYeUhpNh5oQKd/ZwOSpz6Ka5bpX6WUGnOL4i8lmQP+BHdym49txdBoC42wUCuybeC6
	 2kE+XKiPQ7ok6ROiBYrmO4nmn26IJgm2Qpz338bDWU3CWIzVpKJxQnlobSRvIMCZAX
	 gAS5r4g4LpQjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 15:35:38 +0200
Subject: [PATCH mptcp-next mptcp-net 4/4] mptcp: remove MPC && MPJ check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-fix-7-2rc6-v1-4-cfe460beb666@kernel.org>
References: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
In-Reply-To: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=A/1kUH51wJGNQJ1e/m0OL4JrNZeyNVOFalxF9ZgyO8U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJylrx/JXZM6rTqkdnTTRhT9goHnuc67rlWZv7m6E2L1
 4j7/d3e2FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjAR91+MDGeUjv8Qqls/48H7
 EDe75afDSiUsK2UPTJT5+2ZS7a5vXYmMDE+T7zScFI4vCXzxs/3oRM4jqXxKOx7y2a3ZuOifmO2
 GJ1wA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After commit <   TODO   > ("mptcp: avoid combining some incoming
suboptions"), the parsing step no longer allow to have both the
MP_CAPABLE and MP_JOIN suboptions set together.

These checks can then be removed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: the commit "mptcp: avoid combining some incoming suboptions" is
not upstream yet, hence the TODO for the SHA
---
 net/mptcp/subflow.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..e1f20ff8fdb4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -174,8 +174,6 @@ static int subflow_check_req(struct request_sock *req,
 
 		if (unlikely(listener->pm_listener))
 			return subflow_reset_req_endp(req, skb);
-		if (opt_mp_join)
-			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
 
@@ -277,9 +275,6 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
-	if (opt_mp_capable && opt_mp_join)
-		return -EINVAL;
-
 	if (opt_mp_capable && listener->request_mptcp) {
 		if (mp_opt.sndr_key == 0)
 			return -EINVAL;

-- 
2.53.0

