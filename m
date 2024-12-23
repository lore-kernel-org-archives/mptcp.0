Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA264A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942635; cv=none; b=C2US0SVEWvHZZ4/juA1viX/ZVG9Izo/85NuKjEFsDFj9UsTWjPpelrj4KWoGG+qBRnCkGEhFqlKRMGUSJpg5e4hW42viP+32EWOENzwve+Jzoc+3jxF5DOvgYxu+HzBUL/K6fFzpiqE+rhYQqMKH0Jwhlo95UYPo81TXXItCAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942635; c=relaxed/simple;
	bh=txcXVQ1X6wdf7hLwaFIEoQz6R3N+BrHET3IpUn1wgbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNSUJgrzlxMq3g5HpxxDA2+dBXXzXSvlD7L8ZL4+98LK+CIPzpvroigs29DR9ZsrwkLhypcEa6lJeSmNTNbxX9zGWnSbri7OYlcppn4OyUpjbgDNSVyfNgfwfCiBSPFHq17uJsDb1qquH2r1nI2Z2JvpcOz0oBuMLgqgM70FMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6VKOIWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6VKOIWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3AAC4CED6;
	Mon, 23 Dec 2024 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942635;
	bh=txcXVQ1X6wdf7hLwaFIEoQz6R3N+BrHET3IpUn1wgbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6VKOIWnGaH3fttg/6Pq9aqIrRrTTAFIPWT9hXNM6787yoCD0ZEXufs6El97MG5OE
	 IU7fqLZIKzJIfgR15RgavEVSk/zRFr84nzUDCXor3QkVl/ce+t3K3CPlZqA2I6wz0d
	 XNCZoBF44fmsJma5ReJSdEpKxueVCz4WsM5kesx6xuKOawnId+/K1mwTw8Kedm903u
	 Gt2x4C4ccVFErwKzvFGr//oF37zxjkc0GYkN12ti+HcP3rxuCQd7CPEbNiV4lTEWVb
	 9aT0S7QfxkuuMr85G65rIhl9FKbM92WRqGyo9NbU2kmmflM14apE2Ct8fWAapMKz41
	 kNPdh4yCH2lFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon, 23 Dec 2024 16:30:13 +0800
Message-ID: <accbe1fcc944d790e3a1cfb158750f70948d0313.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Split get_subflow() interface into two: get_send() and get_retrans().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..5743601df9dc 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -67,8 +67,9 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 {
 }
 
-static int bpf_burst_get_send(struct mptcp_sock *msk,
-			      struct mptcp_sched_data *data)
+SEC("struct_ops")
+int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -141,8 +142,9 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	return 0;
 }
 
-static int bpf_burst_get_retrans(struct mptcp_sock *msk,
-				 struct mptcp_sched_data *data)
+SEC("struct_ops")
+int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
 	struct mptcp_subflow_context *subflow;
@@ -189,19 +191,11 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 	return 0;
 }
 
-SEC("struct_ops")
-int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
-{
-	if (data->reinject)
-		return bpf_burst_get_retrans(msk, data);
-	return bpf_burst_get_send(msk, data);
-}
-
 SEC(".struct_ops")
 struct mptcp_sched_ops burst = {
 	.init		= (void *)mptcp_sched_burst_init,
 	.release	= (void *)mptcp_sched_burst_release,
-	.get_subflow	= (void *)bpf_burst_get_subflow,
+	.get_send	= (void *)bpf_burst_get_send,
+	.get_retrans	= (void *)bpf_burst_get_retrans,
 	.name		= "bpf_burst",
 };
-- 
2.45.2

