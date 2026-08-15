Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752434248C9
	for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805268; cv=pass; b=cTuokscTUekQu70LvMoMcgaoO6IkItpba8xnHnV3j8YmOUqT1nDvcN8Igm5E4lZaVXeeSsuMvUz7ViNCTa5RNKAHJ4H/K2jrF2NZHop6EozLs64lEk2ezAlqoapPJHIzIAi52GHiljdf2nesfZKn7X1/Lj1IdFQk4C9xLmpJkS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805268; c=relaxed/simple;
	bh=vBbbKGN5T0BtLVxMzPn0CcCZwK/f9k6hfR6B5NbYrLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THt01QKVcMPi8XxZkK6nTieYG29enI43ebySCUUl0jxRT6mr9C8VK62B+2aNlFFPWl0ol61CcTRcFRwYqD0ObfkH6BO2Ga6JoRhAHYmj/8iK1OecS0WLsnQxs8iJFg+KRGCqB4oUzSYUe5kI5+BoQdWBfXFCyLZ55O78HC7Q3s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=RXG8RS9w reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="RXG8RS9w"
ARC-Seal: i=1; a=rsa-sha256; t=1786805239; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ex4j/fFtSFGgQFmOIKnlk0+ZpHV0yJEMGDpzdAKVqOqMKSEjbilRZJ6RwOVpIGOY0CpuccatKVEo+bE85zk42G54dsLS92fmyrAZvOtyzmTB36cjbijxL8/adEJAlfT8KGxqn4eHgukUOfoBaPDJBfP6+YdCqHLEiGRUKZEy6Sg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786805239; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r8fYAOFqVo8O9YlgnSht+w4dcYH3rMOr7Dd5/qjkL+M=; 
	b=EyYWG1SOi6BlBG2krhCVO0R+UqIW0xFgEoUUgZRjBqTKf3dy47w0G2HsxtlacdpA0Exc02+gHQWHHXOucJ9Bc7octVr4lr2z/Ntjf+RBCNStHCgZMN+K9UO5JLiIkxXkMJiJLvmwThRQmndomGI4pQ6lf2XIxnQzvK/RbQPDvyo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786805239;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=r8fYAOFqVo8O9YlgnSht+w4dcYH3rMOr7Dd5/qjkL+M=;
	b=RXG8RS9wc7WSg1t0Elta7/N7qj4w4czHjmAOkt8/T8CWNghPzQMB/5hUzzMZXNY0
	qNIUHOg0WYyi1aKG+W181IjwwUVgmVVRxmsdPyLGr/Uv/nONBjI2/pkgfY77g/ejyvu
	0IES5kgPh9e3oorY/ZEbCsof3zxnZc4Tu1QO+d4I=
Received: by mx.zohomail.com with SMTPS id 178680523587137.545802684552996;
	Sat, 15 Aug 2026 07:47:15 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sat, 15 Aug 2026 20:10:14 +0530
Subject: [PATCH RFC mptcp-next v2 1/4] mptcp: sched: avoid truncating the
 pacing rate in the scheduler
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-mptcp_penalise_send_v2-v2-1-3e5049a73681@mpiricsoftware.com>
References: <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
In-Reply-To: <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_subflow_get_send() derives each subflow's linger time and a running
pacing-rate average through a u32 "pace", while sk_pacing_rate and
avg_pacing_rate are unsigned long.

On 64-bit systems the u32 truncates pacing rates above ~4.29 GB/s, skewing
the linger-time based subflow selection on very fast paths. On 32-bit
systems, where unsigned long is also 32-bit, the sk_pacing_rate * burst
product overflows: with burst up to ~65428 it wraps once the pacing rate
exceeds ~526 kbit/s, misestimating the running average at ordinary rates.

Widen "pace" to unsigned long, divide the linger time with a 64-bit
divisor, and cast the pacing-rate average product to u64.

Fixes: 3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation")
Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f879b1061f2d..c04b73123d27 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1626,7 +1626,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u32 pace, burst, wmem;
+	unsigned long pace;
+	u32 burst, wmem;
 	int i, nr_active = 0;
 	struct sock *ssk;
 	u64 linger_time;
@@ -1657,7 +1658,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 				continue;
 		}
 
-		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
+		linger_time = div64_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
 			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
@@ -1691,7 +1692,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
-					   READ_ONCE(ssk->sk_pacing_rate) * burst,
+					   (u64)READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
 	msk->snd_burst = burst;
 	return ssk;

-- 
2.34.1

