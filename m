Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186146;
	b=UNWnC6azr8GuWPW/rbgP6DABuQAjeCa8tfCZAR/DJiwtmKKa3klZ1L+0oT5XaiD60OSq
	 qCaB63JRZdje1MbjrmS/vcvnuICh1QcU92jqltf9wbD54NBTw/qqAo1HWANN0ewR+O8tG
	 xX+tcPIj45LiPSqzOtXMDgIVOiOA8vW1qvqwLjFu8CES4bJDr4lImc8ijurWMBmTm74iQ
	 Xcn3eTBBYo+jtaNZ01NhfFh/NjYEfz9na8xh5qM69qLwb+es9fPLSc1H3zo/w9nJeDgX/
	 OFWsqZNjhgcvVGW97fwoQf//+WaB5PiJ0+jmub83NAJffVC3tx5xkmsp+evMhs4Z/XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186146;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=/2BOEtMOXrwTmi7Wsdl4Aw/+k7fI2nZPAkr436p6KHk=;
	b=sBaggFpH4aTDhe3WCaFlAGHa78ZnZHLeArUvBEW+Zm+lOomsYt/JBaDUgnYCJFEuzgrp
	 FCpZAb3qo6bizM29hhzgwc9mPZuPryKgjAJIdAdWLL7V+cqo1DF2k3wDzeqgQleAbq5r9
	 jhZFE4jiUn5dBC7lWyYuJMqayZ9i2zviTN7GPj8DuGiGRZI/83ALxWVT8O7eVqkvTrKOc
	 CyvcImqnWKfvQRGTvOSViqgsflYPNUTTXdIynl2vr4wE6xthOMzuOf3GUUzg1Km9qONu8
	 apogckBeHZ0T0Wj0KxNwCg4+bP/YshMaKenbqwHrlQsyymLeAcXZS+hK61rRqZySk0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.52
Received: from sender5-of-o52.zoho.com (sender5-of-o52.zoho.com [165.173.182.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7810B606A320
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 11:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7810B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793186136; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NtvRUn0mJLdxrWK6kX7r0wtgHTynY+pDXc9y2+eCI94XT/uTQ+MGonIu7qnMFJjFszxZjjzCpnszRg3ZufmhJ+WqDnqtLBW/K4DTOhcH+3d8O38uDqIHK8KWjS6DUNZpbWb+ftTAEHGXa5EjvZ1jvZZjqPvg1fUDfU77L2AwIC0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793186136; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/2BOEtMOXrwTmi7Wsdl4Aw/+k7fI2nZPAkr436p6KHk=; 
	b=lC2GJVr3UzTvSTzdZc+DrZtIpOEijmtTuy31FN7WBiJDZR8DrLM56bw8mtLOyOD25bUJggfrHmtMNa0qL8Da1yOHaLyvhl1uAInrPT+EhtyUz2VwBTP3sb1OgDgAKnUymnu6YNpcMZqjh/BO3coXwq320ut3aggN8pUGCt/maS8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793186136;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=/2BOEtMOXrwTmi7Wsdl4Aw/+k7fI2nZPAkr436p6KHk=;
	b=iBue9sC0yYpRyCfhh20dFdf0nn5Pxe1Cf4co1LjvhLYE9Iqq9qOKG32X/DYGIOzO
	a7chDkeJGyzoNYhyOj875C8RBF7eoFHpKPvZez+5x8WlzGhXExHKIScT3wB+OTU9znJ
	WVH8pj+lViPHM+oE/0eoeE8yjzGopVhY7efCXbik=
Received: by smtp.zohomail.com with SMTPS id 1793186135023614.268806724573;
	Wed, 28 Oct 2026 04:15:35 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Wed, 28 Oct 2026 16:45:08 +0530
Subject: [PATCH mptcp-next v5 1/4] mptcp: sched: avoid truncating the
 pacing rate in the scheduler
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-mptcp_penalise_send_v2-v5-1-32fb379ce117@mpiricsoftware.com>
References: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
In-Reply-To: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Abdul Wasey <w453y.me@gmail.com>
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
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Tested-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..886f00ee2a4d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1633,7 +1633,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u32 pace, burst, wmem;
+	unsigned long pace;
+	u32 burst, wmem;
 	int i, nr_active = 0;
 	struct sock *ssk;
 	u64 linger_time;
@@ -1664,7 +1665,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 				continue;
 		}
 
-		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
+		linger_time = div64_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
 			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
@@ -1697,9 +1698,12 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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

