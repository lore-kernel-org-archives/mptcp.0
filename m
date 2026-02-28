Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5441E8320
	for <mptcp@lists.linux.dev>; Sat, 28 Feb 2026 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241335; cv=none; b=IiKJQevfPReozGJFmn9Sd/+4lcc3BlPGGZQ5V5E+Q42sBTm7DqMMqr1SQK1H0Q3W5uQR150KW3NkrFCw5fx+aUWv/vgoyWgic9avL50fZC7GiiqGZhad7QfnLEEgjSa5i85gHWOGXySFYL1wfEjArPuYzMt/QgvbeTAu5cFUdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241335; c=relaxed/simple;
	bh=HTSn2E8VSNxH5vxl4BHDJAJhmX/a0M1xldLbUro/yOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XSMrqntQMS/hQXBJd9NgFb+V1jqZGy2ls947WJJjwAMbIKdIis2vWPI+ZRcwG6bkTjRWOV2DcWAUpKGFaxbHjJGrbuGQFX7iAtU/9nYKZoL261IzdRoD9K4BMuUeaIE87NHUjTdNO4liDCwGgvw27M/3+FyYDgrXJq1L4v5d/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hGRxfYBF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hGRxfYBF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772241330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vQrh2XjeEfIGvyvnPA2XM4RakSauP8+IVYJ7n+3ppQg=;
	b=hGRxfYBFcCbloHKeI+htiTMJssfK4kACh9JPbo06E5I2OsiQFV0YnEw5crItZYVV8uPvv8
	3ovKoVAYpMvheMwgAlklY9UXM3rhhelKyUY2fYVJl1NYe9SD6+eCmayfYlUTfUmp9S5rvg
	DuyUa30rHAF2vxE1MQL21ToC0l5gxj4=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RESEND PATCH mptcp-net v2] mptcp: fix stall because of data_ready
Date: Sat, 28 Feb 2026 09:15:07 +0800
Message-ID: <20260228011511.440437-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch fixes the second type of backlog_list stall issue that
occurs when the data_ready callback attempts to trigger data transfer.
The issue reproduces at approximately a 20% rate (once every five runs)
when running multi_chunk.sh tests.

The stall occurs under the following conditions:
1. A large amount of out-of-order (OFO) data causes sk_rmem_alloc to
   exceed sk_rcvbuf
2. The skb matching the current ack_seq is not present in backlog_list
3. Data reception relies on data_ready callback notification

In this scenario, the data_ready callback (via mptcp_data_ready() ->
sk->sk_data_ready()) attempts to trigger data movement, but
__mptcp_move_skbs_from_subflow() repeatedly moves the ack_seq skb into
backlog_list and returns false:

'''
msk->ack_seq:3442119990924456661, map_seq:3442119990924456661, offset:0, fin:0
[MPTCP_BACKLOG] #0 map_seq=3442119990924655746 end_seq=3442119990924660542 len=4796
[MPTCP_BACKLOG] #1 map_seq=3442119990924491850 end_seq=3442119990924500364 len=8514
[MPTCP_BACKLOG] #2 map_seq=3442119990924660542 end_seq=3442119990924726001 len=65459
[MPTCP_BACKLOG] #3 map_seq=3442119990924508114 end_seq=3442119990924514971 len=6857
[MPTCP_BACKLOG] #4 map_seq=3442119990924726001 end_seq=3442119990924731093 len=5092
[MPTCP_BACKLOG] #5 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[MPTCP_BACKLOG] #6 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[MPTCP_BACKLOG] #7 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[MPTCP_BACKLOG] #8 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[MPTCP_BACKLOG] #9 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[MPTCP_BACKLOG] #10 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[MPTCP_BACKLOG] #11 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[MPTCP_BACKLOG] #12 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
...
'''

The fix allows moving in-sequence SKBs (map_seq == ack_seq) even when
the receive buffer is full, preventing the stall condition.

Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---

Notes:
    changelog:
      v2:
       - As suggested by Paolo, the previous empty‑queue check on the
         receive queue has been replaced with a check that permits
         in‑sequence SKBs.
      v1:
       - Paolo has reviewed at:
	 https://patchwork.kernel.org/project/mptcp/patch/de0a7e3ea6a3cac75b3c2c811695c5d674d929ef.1770273341.git.yangang@kylinos.cn/

 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c020882521b4..25ed246db7fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -739,7 +739,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk && (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf ||
+					MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq)) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
-- 
2.43.0

