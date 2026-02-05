Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2F84A35
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273736; cv=none; b=FvGMyJIUTX8lCnPvjgbaAfWSencrftVvIUxwKmYpyOzRoeW4wbHTTPE4fgYQ6pbRUVpXBGNO0BQR6dHaXRJDjgWOinbJvxdHYRElhRl1FlNEstgAeg5iQtHBJgIRvgtXOIwYBCADDWa7j5aSoXHxtNx4XFNzL8SFfDUV2ftAww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273736; c=relaxed/simple;
	bh=8p1L4c7q+qqobr0mHs++uw+6Q3RKYNO2+2QTIxOsrlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxRAzqCS0Nvek3A2MOFbUi3Zy4lVju7YWfnI5FTA7XJSxd9+oxBzVjXaH4DddgHXj8mY74qIuehh5vJbM1R737jUlSnTt/1aHg6czHIuuoaLqQz+x828L5m5B9CBabDvwIP2CfpDpwpPl99RQujuFLwosIg7pOXJRVC5nXqWUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c8RMom91; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8RMom91"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770273734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=js+glbFQ6NOluD+9//taqCS4F5wkxgegpkP/IXnUGD0=;
	b=c8RMom91EzVo3VCYHJWlVP6APXffYVO40BgLxj1c8LFAFPuxRRrJj14o7ViZD8N4JcfA97
	uGsNsuXEQWWedGnb54Ik2k8hspEf2dKZyS8Xmnr0ICO6RWEfenvlOscqJtzhzph/vB7LIq
	0OdxHLTyZaUAVH2U+w4lwgurpSHufvg=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [Patch mptcp-net 3/3] mptcp: fix stall because of data_ready
Date: Thu,  5 Feb 2026 14:41:31 +0800
Message-ID: <de0a7e3ea6a3cac75b3c2c811695c5d674d929ef.1770273341.git.yangang@kylinos.cn>
In-Reply-To: <cover.1770273341.git.yangang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
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
[  144.961282][    C0] MPTCP: msk->ack_seq:3442119990924456661, map_seq:3442119990924456661, offset:0, fin:0
[  144.961293][    C0] MPTCP: [MPTCP_BACKLOG] #0 map_seq=3442119990924655746 end_seq=3442119990924660542 len=4796
[  144.962310][    C0] MPTCP: [MPTCP_BACKLOG] #1 map_seq=3442119990924491850 end_seq=3442119990924500364 len=8514
[  144.962783][    C0] MPTCP: [MPTCP_BACKLOG] #2 map_seq=3442119990924660542 end_seq=3442119990924726001 len=65459
[  144.963260][    C0] MPTCP: [MPTCP_BACKLOG] #3 map_seq=3442119990924508114 end_seq=3442119990924514971 len=6857
[  144.963729][    C0] MPTCP: [MPTCP_BACKLOG] #4 map_seq=3442119990924726001 end_seq=3442119990924731093 len=5092
[  144.964193][    C0] MPTCP: [MPTCP_BACKLOG] #5 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[  144.964651][    C0] MPTCP: [MPTCP_BACKLOG] #6 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[  144.965164][    C0] MPTCP: [MPTCP_BACKLOG] #7 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[  144.965711][    C0] MPTCP: [MPTCP_BACKLOG] #8 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[  144.966260][    C0] MPTCP: [MPTCP_BACKLOG] #9 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[  144.966804][    C0] MPTCP: [MPTCP_BACKLOG] #10 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[  144.967308][    C0] MPTCP: [MPTCP_BACKLOG] #11 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
[  144.967793][    C0] MPTCP: [MPTCP_BACKLOG] #12 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
...
'''

The fix adds a check for an empty receive queue in addition to the
rcvbuf comparison. When the receive queue is empty, skbs should still
be moved to prevent the stall. With this patch, all mptcp_tls tests
pass successfully.

Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6bafc37eea4..054aa72c9aa6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -739,7 +739,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk && (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf ||
+					skb_queue_empty(&sk->sk_receive_queue))) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
-- 
2.43.0

