Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92F3451A6
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045366; cv=pass; b=kcRsFaogyd9yj93zqKQWTB2xW++qv9tGQdG95PxZwq7/JA+r1jG7+J9f0bpROHPvMXKX1GLqJnsztTjDAV/ymTIpjVR0OGHpd/F5PTiorrKl6qSybckMHMVlPCLWSWZ76HuW1ByTOhIucsF1lE3EOCXBt7y/avK1c4VKDW5fqVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045366; c=relaxed/simple;
	bh=Wcl1OWRiaFLVILmKZz6aZn8uCA7GjZEbPMOJ+sshIak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DN8g3BBZC8yBkZvOkYMHmbS2hYtof+04x9T1vnb3tTvE3nOFptEVacrTKPN1Rs81QCEiFE+DpEzFUzwWPx3VP5dG9eqy0FfvcxHuTp0WDKF2HouwqBS9UqN1FcDvMmqw3jApCbTSt4ZJZX1tJEk4i+mKVaafKM/8Y2wyLvsNhRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=jbi1Hhvc reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="jbi1Hhvc"
ARC-Seal: i=1; a=rsa-sha256; t=1785045353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KnHbiCLnkordcWjHpJXxEYdTCRYaKdF5KpN6UEFvqknEPyJiAyCYHPXSim4+S4abNQ+U66qjUHnUez83wVdKAtLW+eZ2d/qiZSaeMH/qphKcsCTFlVCTlm5e9nvLpEVPO4Jc+aB/xUqyNJjYO2W8UK/82hFjP29IFJR5D2OL4Sk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785045353; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tqt2yBJEanyGRFea0nNwPoftyscrGxxlGP6g7vyJOzI=; 
	b=BxFNY/kvZI7Mgv20lYKetKHzcXPJkP7XmqTyDONMJZt9pg2Nf9iuoyQrXbD1AUZzC11so6d9Fq4mcynH9k3+qXWTHe744fLhL4HzaSG41nRgxIYsJoyhjbbH4qrf287xhQSrPALtisVpH5WYUwD5paLcqZKq1S3urnbOiapOvbs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785045353;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Tqt2yBJEanyGRFea0nNwPoftyscrGxxlGP6g7vyJOzI=;
	b=jbi1Hhvc24bV7oQI/UWcBtav4ZkB54kWMi9oGX0ak3SOOqkKyH5d9vODckcPmZkX
	QqWufQdwOTiOYm3C7GP0J5RCyt9SHRmnKAAgb1+lxxwW2Nyy//yVP9WYMOdmq/wroS7
	NUj9Zoepr9QYLePQRjE2r/zET12qIU7RKa6q0g78=
Received: by mx.zohomail.com with SMTPS id 1785045351427869.0745547738172;
	Sat, 25 Jul 2026 22:55:51 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sun, 26 Jul 2026 11:25:41 +0530
Subject: [PATCH mptcp-next 3/3] DO-NOT-MERGE: mptcp: sched: penalise
 counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-mptcp_penalise_send-v1-3-84485e0e995b@mpiricsoftware.com>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
In-Reply-To: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 MPTCP Linux <mptcp@lists.linux.dev>
Cc: shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Instrumentation for validating the two preceding patches; not for merge.

Adds two MPTcpExt SNMP counters:
- CwndPenalized: times a subflow cwnd was actually halved;
- PenalCandidate: times the rate trigger picked a slow subflow.

Together they separate "the guard held the penalty back" (PenalCandidate
high, CwndPenalized ~0) from "the trigger never fired" (both ~0), which is
what the receive-window-limited case needs to be read correctly.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/mib.c      | 2 ++
 net/mptcp/mib.h      | 2 ++
 net/mptcp/protocol.c | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d9bd4f4afcc0..1299613e183b 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -88,6 +88,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
+	SNMP_MIB_ITEM("CwndPenalized", MPTCP_MIB_CWNDPENALIZED),
+	SNMP_MIB_ITEM("PenalCandidate", MPTCP_MIB_PENALCAND),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 18f35f7e0a2d..93b3a7e9584f 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -91,6 +91,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
 	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_CWNDPENALIZED,	/* DEBUG: subflow cwnd halved by the scheduler (#345) */
+	MPTCP_MIB_PENALCAND,		/* DEBUG: picker chose a slow (low-rate) subflow */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7cbc5aa17e22..80866f09831a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1607,6 +1607,7 @@ static void mptcp_penalise_cwnd(struct sock *ssk)
 	subflow->penalise = false;
 	subflow->last_penalise = tcp_jiffies32;
 	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, 2));
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_CWNDPENALIZED);
 	if (cwnd >= tp->snd_ssthresh)
 		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
 }
@@ -1694,6 +1695,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * once per RTT.
 	 */
 	subflow = mptcp_subflow_ctx(ssk);
+	/* DEBUG: count how often the trigger picks a slow path, so a gated-off
+	 * run (PenalCandidate high, CwndPenalized 0) is distinguishable from one
+	 * where the trigger never fired.
+	 */
+	if (fastest && ssk != fastest &&
+	    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace)
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_PENALCAND);
 	subflow->penalise = fastest && ssk != fastest &&
 			    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace &&
 			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&

-- 
2.34.1

