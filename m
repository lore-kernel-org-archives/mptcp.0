Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736664D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318045; cv=none; b=Q+XWSRHjfTs31MXVfC7s0nP9MKvoQ1/ATjVCFXOUzSEe3v7GsDB1TDyXFav2eLrnvyiP9lNKqVIJ4wvgIXmfALiBhY0FLRjI4WaVLCFsofEcbZDbj0uIG9J7MBQ4mIBikB1Mrd/sxt4mEfeyIEF5C4M+S3qkE12B+8dPzZvUrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318045; c=relaxed/simple;
	bh=jxs+sMDe/TzeRdp0PFolqjDs8IFlQ6G3fzAAb/EajMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8GArjMwc/0k7rEBtR4Bpy2djlWZ1gQ9MueXDRrXisHEXRMKh1FDdkQAT6SwnW8nfuGf7WQQISkafb2Gtt2tpVn6Crp7RVqbiEGyc+wU/IieclLVMx0OC0wFiT6iXAkV3hF2JRBwagSDXs5SiDJjeEUvGEsSyhItTQ0Ih+O6ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsB5F5mR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsB5F5mR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93777C4AF0F;
	Thu, 18 Jul 2024 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318045;
	bh=jxs+sMDe/TzeRdp0PFolqjDs8IFlQ6G3fzAAb/EajMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PsB5F5mR6e9Snd0mVCGQnwoqqa7HHOHa86ZbF2BlGIujOBwQL/EtpDS3eXZsvfviz
	 CK0zPYjjgT1XxvIvZth+HRp6sO9fZzvLFpd21Vd4iSzYyQMhR347SVQEkVrH1RIFJ9
	 2XM4TMocRbcRpeqjukzldtJpYc5cViokyY4ZNI4rgf34IjTlVS5xhxebfP55R3FInE
	 Th6J/ePmbZl3uksx7Vv2D86W/Cjt6Siapbbu8/yO9UOpG3uMTMNf+qtn1GX8w8IXpf
	 /8gWry+hdiAF/jltpDh772NQPUXUd+pOa3WoVnXiboVgvSZSO7qaVWD7WJBLb7JmWK
	 sie514xbr4SBw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:53:58 +0200
Subject: [PATCH mptcp-net v3 1/9] mptcp: sched: check both directions for
 backup
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-1-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jxs+sMDe/TzeRdp0PFolqjDs8IFlQ6G3fzAAb/EajMY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqajsZsW+Xy40SRkZNiNHb3Aw3+AB3xdkuzi
 hzdXn+syuOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mgAKCRD2t4JPQmmg
 c7iaEACrFfrKIXtKBX38Xh8Vg30R7q7fBRgNZhuLzISk1l198fXanqIf3+Lzly20tq2W6FQLZXy
 az7j6nHOybNJT2o0rNFOrVy45rBlnZ2TpPNlv+b9tbwzJKbLDp1B/VsBqkMziOZUmv8G7TgPh0O
 vml7IEDQEaktZOkC1qDV+Nbg/Y1JxgiFz827hN5eLxOfIpIT85On3Ps1Ufs7VWbiFBR7vxKWiJ5
 Nut6QgIYobnQhtnEV/PfMMrjlg4Tz5v4E5QkBfMBArXAQUn86ORjUhe5wzmPkKb0AArOIaFWld3
 St0jW1QYtRDuis1RQ8vJ9dpQmnGMttP8ThkSMTEulwJP5y3dlGyqsJzodUx10xCUUNG9nCM5FfU
 p7RtKErdIyfH0ZPEZRsjsL+bOBy4L70oBFxyiGqlvxFQmqxvno/uP62inYxC2JDy1rRQbH11xDf
 lrcGg6Yxb4cL6nffFjmwK9Z/D27F3LdsYMATZYMUAd3kgMxkuiTKZAeRwh/XKyfQfcTVdtbnrwU
 xXOFNb6Yqt4Sf34CvbLnA8UWdYKU3S+Sy2P0ooBKoOkavfVBbZ/jAjcL14jRVMxDspI/AsBsVtS
 sMaq+yrtqg1NeAC9qtND6xV8MKgRezEkY4KvMl5gizsUF+cUx9s4ZwGy4mqXnaz0eAMEWoSZ0sm
 KhiHg+o3/fwn1Rg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v3:
   - fix indentation of the 2nd bullet point in the commit message
     (Geliang)
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 09e72215b9f9..085b749cdd97 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac94225489f8..b3a48d97f009 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1422,13 +1422,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		pace = subflow->avg_pacing_rate;
 		if (unlikely(!pace)) {
 			/* init pacing rate from socket */
@@ -1439,9 +1441,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		}
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);

-- 
2.45.2

