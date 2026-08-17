Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FE443E21
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980287; cv=pass; b=f6DcPg4fsXRgiVmZqR9KCSBE07Y/OCOHB40lnoNhX5Vfu5Nrh4EzWUe6fxmfDymqoi/MG7fI6TRMY83oVrLXEK/i8RZP/yULp80gzBH9UsFokJjdFyRNCfr+Qy8rnSrVdfcZP2/E4x3MexdF/WtziDCEKA7l8w6b/luTfmGZCfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980287; c=relaxed/simple;
	bh=5qpBq6TMufhwOS//ppC7S8hbcjs6uSlV+ENpUdvWLwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5gNSSk9oeEzWHVtuvvjJL8NzhnZ0xgUqDlkndZoBnOEqcbnJRpBvCmmFtnXDYbRT/YHaON7lfBfswrwjcNkphmrDVluxsV45rm72EoT+gnxusETX9Fyaerne/NgJuXSlWD02jTQ7SlSc75DJ1d/tyG5MwqUAynjR7N7v2u5IPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=NoFwwOOV reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="NoFwwOOV"
ARC-Seal: i=1; a=rsa-sha256; t=1786980276; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nFVHWGBNmluNVTz1ZOfdlZdplPRjaktGYJtKuP1zxPYPrPyaXSfjYNOinYAX9nA5hVoPjNKQdFTM4ZW3U8n9A0fIFHlvFEwnwszyVebw5HOsLn83E1kMgIt8wLU0aHOPEyAM3Irdum+pfae+7Wu/i8VHGzcJy3jSoBQFqdNprew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786980276; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8DOkAHGpCJ8ngu+8XF3DXCdb4pYiNRd55hWsSFkl5t4=; 
	b=Pr0JYxxx5j04rij87s+5YW8M/yd4SkCnDeS0qOmutB/0ptui7oX4qHktW1r8U/JzrcEZf2jGa4YleZK3oGeCMaAHNDjb9VITfK2T+DiGPPKLC/Y1YCVsEpKyGJAyl+ADDvnOogoH0A/2ziRvO5TQYWxsatMWd0rud5OkizoNqko=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786980276;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8DOkAHGpCJ8ngu+8XF3DXCdb4pYiNRd55hWsSFkl5t4=;
	b=NoFwwOOVi2ole8AorvfEzt1cwJt0C2/jHpl83jPEsm5zo3zlcWoVBuw6QIw+4R7W
	ySIgMljdbNx+PTE/4sqbREZb+nKK/Ir+BGa3PB4AR5zPXRC7u0395HMrVS+joq+xUwL
	B9pMUtS+oE4rDzEblNoIr2LNNUqCCtaiHPnOOmLk=
Received: by mx.zohomail.com with SMTPS id 1786980273228277.124296770401;
	Mon, 17 Aug 2026 08:24:33 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 17 Aug 2026 20:54:14 +0530
Subject: [PATCH mptcp-next v3 1/4] mptcp: sched: avoid truncating the
 pacing rate in the scheduler
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-mptcp_penalise_send_v2-v3-1-e6a2ad2f1b82@mpiricsoftware.com>
References: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
In-Reply-To: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
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
index c2762d74f29d..46a49ec75e78 100644
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

