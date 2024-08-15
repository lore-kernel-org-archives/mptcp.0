Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFCBA53
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754771; cv=none; b=uvGHtLrnxuYr1NY2PT8pBUh3KSm7PiOYQwuciv8vcetiUxRkgck3Waz2bNmxszUZaA781EBaNoigRI24PzmmTkKXs+wEa1q1zqlLRJaa7mwHY6q8poxhjuZ7ZFJknBnXnnTlVzsNEMpfzEgLIuoPLiMITVqorSeXgM9ZWsGmyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754771; c=relaxed/simple;
	bh=X3kingAe+MIqD04vcc6XOI2en1Bn6QN9uOtcfEzO/lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hg9dkRqW1fNmrLnwXrpAbhwoszm26hap3KVh8JczKYDqGEheu8ZZS1nx9phcSuf5YeO32f+VRt2O350Ji4uDgGu2E+VmO0l0+nzRjFTvRH5VwDXcFdoLUp3+Nf+1MlANvRSUKhCQTPHKI/5Lwni/TTRCOp4q2FxK09CWaYzTL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxNb/VCX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxNb/VCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC9C4AF09;
	Thu, 15 Aug 2024 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754771;
	bh=X3kingAe+MIqD04vcc6XOI2en1Bn6QN9uOtcfEzO/lM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WxNb/VCXciz/+2+Qee9h3G78cHqfwKTk3dufiPnSZMX0qCvgP2RjyhqKXB4P+XrS+
	 be4TtLyRYnfEFkg09lH9gqmKJ4A8edpluhAbxoz/t6jE8noaf38cof2l+vf8D1y/Rh
	 RRpuA5SISJaeqB/j8dwDbUfWUwqEALx0F3raj8aq5fU8qgv8/I1gQCJ4Ml1nGb6fqw
	 sLALPqzBDhLPsFR8+fs+JQzAHzrkHeZ1hbGjm4/bqOZHwsjMLotHFYQnEVoyyVuI6/
	 a7yL30New+vtqN/E9sHPEJ0bmbSk4+AX7rJtqCybbuWUWdFcSmyBasr3Zdwxmt4VeK
	 l/xOX4BzYZV+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:48 +0200
Subject: [PATCH mptcp-net 07/10] mptcp: avoid duplicated SUB_CLOSED events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-7-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=X3kingAe+MIqD04vcc6XOI2en1Bn6QN9uOtcfEzO/lM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJmULm9uT0qQxcN+dhS8PlewAX7+xb/3Vqa
 dEFG+NKIiiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c27CEAC0FlU7sOe+ncOu4+AINoUE939WQjSBw85NDwQYBXszpR4oAM6tsYzarc9jvVJXWUuiQmo
 clYld9YzJcYjsHWmh2ZJ3U+7UcyfQcmyIQx4pJCl6jbBuxDxjqhBkWaJrRQbs7XuoeewTYBjN3u
 ICByBlx9Baanss4e6ryyAYkGyHhN0gtdRhQrtAsnwgs6QCLCO5lM0WogbU43ghjCMOY8r4n67v1
 IwblT6NhC74H/NwNocFYNNtQU6dbYiDP7y3V6Vj2qz335251lYB/8w/Zttwh532QAhwBuwP7SR3
 gKuAOVRbL6aOOcvZt4MhjVvXlrXDW8aqlvogfwQX37tsEKmITT8QwmsGtXJmzDufvATKr09OUon
 3pReqejIfyGfgw17I8T91j7Z0y3uz1f+v1L+K+MDzoeJcMAmFvLMHPWHAaSNfcX7pvpb1CW6el/
 nxhNVZ8CgtLhWPmRibsnPTx5RBTUG6hYThCYWCB2vb5jSHJZjbzj80WomZuYMNE0qnAOnN0tS0c
 mPzj6DvfSjvvee2bVd7zfSEzFCZtp9FFsPi94cmFBOxkEcUTlPsydM4HjmYouQxBE0u9ZJfkem0
 BkEhF4Q73HuO543/0up054Zm7JNpdsydtkSG1b+ijC6eTIlOY3VBHiTgAid36zAfcaKF2v96Opz
 ofJb9TItsXFkZLA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13777c35496c..9d6ef94ca6ee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2508,6 +2508,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->closed)
+		return;
+
+	subflow->closed = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 22b7eff311f5..ce15e7db464b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -530,7 +530,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 10;
+		closed : 1,	    /* has done the post-closed part */
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;

-- 
2.45.2

