Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3F3D9027
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120690; cv=pass; b=Og0f1DBVP6gXVPeTEyVxqxZcfShIfjLWhG73I9yaLoZxaaMI93dw3soQ1fLyLA5MAOhlkcdts4PaV93njvJAifSgj6nOUFLEhG1NYdJoCmEIYO0bKjJE9MTpaItSv3y8EjhFShCwh8NmVaHH4jF+Fj+OMKHFDIwk+b1qr9wsr/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120690; c=relaxed/simple;
	bh=rwKkAmfKb2W1kmh4zsjOb0NlrArYQIeKEzK1//x0qzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iunN8ES5nQCZgZ+34iudnQwZ5z+bpdTre4+DrQFn4BfpVhCyYVUCfaw7FuJm116puk0hVFqwzGeQMjiaQpWuYPLIzJ3o9yVIJsL8v0Fc2DENbERxuORNUbovh9aTcfdvOLmo/11niAw/MY1JlNpYL5lSmR44/78G6xMzcrXeCtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=t4I0ct9r reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="t4I0ct9r"
ARC-Seal: i=1; a=rsa-sha256; t=1789120678; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AbxJ/OvrHYMGhAXrBlKANbwuTgxo3z8dqry0/bv9oBNslIN0HoYfVOvlaeM5fxjsNsIii3awxXj1dSkIOwx4thmzenj8lb8znkn5ffQ2MahIbspV87apdFM1u37CmJBE0PSHDPvGh7052bHq+5sBkWm7N7BcI9zGBtteemKQsNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789120678; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9nbWN+oEUxSze9sT6JkzIRY9/EqEqpRjIr2rFD7yPWc=; 
	b=W8abGGb0/7nc3SpkGO172lOPx9ugJSVHrQOLccgNNxLot77qLN5kjpuFuAi1gc87ai1dRN25SBmKvnfA/5W7HyOaCuQLUu6OH0HRt5y1GVOJveeTdusO3MwLvijmtFBEa0NQZd36BGWa4a+MUsoPUrZJUuvgxwzj8zgAyxlVrDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789120678;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=9nbWN+oEUxSze9sT6JkzIRY9/EqEqpRjIr2rFD7yPWc=;
	b=t4I0ct9rW7snu+Yp3PFpKhnOdid2OWgYtM3rE2TZhPNP3GKMvcaMIw5wVOKMXgwW
	ix17uF+ssVVZ6LI9zluuzx9yGEHnxublIp/lrbI6HMz+/phsPvrt4hSGdnnMau6okIr
	NMwy4ZbBmIUl/M+tSPTEQzV5r3+LzhLSmnBglkGU=
Received: by smtp.zohomail.com with SMTPS id 1789120677164968.410148950479;
	Fri, 11 Sep 2026 02:57:57 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 11 Sep 2026 15:27:44 +0530
Subject: [PATCH mptcp-next v4 1/4] mptcp: sched: avoid truncating the
 pacing rate in the scheduler
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mptcp_penalise_send_v2-v4-1-820f2be4a8fe@mpiricsoftware.com>
References: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
In-Reply-To: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_subflow_get_send() derives each subflow's linger time and a running
pacing-rate average through a u32 "pace", while sk_pacing_rate and
avg_pacing_rate are unsigned long. The u32 truncates pacing rates above
4 GB/s, skewing subflow selection on fast paths.

The running average has a second problem that widening "pace" does not
address: it forms two rate * bytes products before dividing, and only the
avg_pacing_rate term carries a (u64) cast. On 32-bit systems the uncast
sk_pacing_rate * burst wraps at ordinary pacing rates. On 64-bit that
product is safe, but avg_pacing_rate * wmem still wraps when a high pacing
rate meets a send queue near the 2GB ceiling sk_wmem_queued allows. Either
way a wrapped term can report the fastest subflow as the slowest.

Widen "pace" to unsigned long, divide the linger time with a 64-bit
divisor, and compute each product of the average in a 128-bit intermediate
with mul_u64_u64_div_u64(), which bounds the error at one unit per term.
Dividing each term before multiplying would avoid the wrap more cheaply,
but that quotient truncates to zero once the queue holds a second or more
of data, which is exactly the bufferbloated subflow this estimate needs to
describe.

Fixes: d5f49190def6 ("mptcp: allow picking different xmit subflows")
Fixes: 3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation")
Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Assisted-by: LLM
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b24e0afedfb..1c3c1c902d1d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1628,7 +1628,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u32 pace, burst, wmem;
+	unsigned long pace;
+	u32 burst, wmem;
 	int i, nr_active = 0;
 	struct sock *ssk;
 	u64 linger_time;
@@ -1659,7 +1660,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 				continue;
 		}
 
-		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
+		linger_time = div64_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
 			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
@@ -1692,9 +1693,12 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		return ssk;
 
 	subflow = mptcp_subflow_ctx(ssk);
-	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
-					   READ_ONCE(ssk->sk_pacing_rate) * burst,
-					   burst + wmem);
+	/* 64-bit arithmetic overflows at high rate with a large queue */
+	subflow->avg_pacing_rate =
+		mul_u64_u64_div_u64(subflow->avg_pacing_rate, wmem,
+				    burst + wmem) +
+		mul_u64_u64_div_u64(READ_ONCE(ssk->sk_pacing_rate), burst,
+				    burst + wmem);
 	msk->snd_burst = burst;
 	return ssk;
 }

-- 
2.34.1

