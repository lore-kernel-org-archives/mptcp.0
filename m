Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688309;
	b=KIC3YeKEsyX673yYTZQQb5233xDTN6cKj3ndcLWdZ0sPgtFH5SmfpdulLfrJyz0pIQbA
	 znywmoYkYL8JYSCrK0mczUUk6X79KxlkbwJ5CacNW0b58rKgtR5N+bJ6m1d5x0Jj7hOwL
	 GmW8Yxswwj5SnbzTeoDC+y07rVDPaH7gCwcetWUjzQjRQrhEqfeE4e6Pbx0W2batVCw0L
	 Xccuk0ym3ye6k4Q+t4eeRahw4qFNtGi/0JvfhlVDmvFR/93g4xDme+Po4Qftaa6EDEt4O
	 hs/ceCYfe9/VoxaOfZU1q7GqTOKsyGghs2xYD3q1zr2J9ZIFi0ge17UzHBmVxAVEU9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SQ18LAQ1HnU801OItuw005RCsDZr9KcDeT+UKU9QZrk=;
	b=SCvM/tESpJeki+RFwjBrdsUhX80piMOZCqC5AObLSl6831t61HtMdXESbkjwszzuHp1w
	 DVQvjNxoxGcL0BFME05rPshneGXqHUIpmyqt/luRe9GSrC2Q/k5oEWpqcX/kCGOWqbExV
	 4tqTePAXry4gJtYMK6X7VIH6WB/E018zvP+XvA9Pkra8XFq+g8zuPSvyK1pc3N1qWRQ8d
	 fPKLEHR1v2bGscgXf+DEuPW7KvPQXR9FSLi+Zz68wveO+Q+k8PCjBjTsbl4tuYdOIA4R1
	 i7xQd0dnWTezQVAB1a1gPyKuO5rMASkbdhl6ruWuTOl39qhdrEfBAstWKdZKMjdX/xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vedyy6Fq;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA1606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 10:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44FA1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vedyy6Fq
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso4489314eec.0
        for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688307; x=1796293107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQ18LAQ1HnU801OItuw005RCsDZr9KcDeT+UKU9QZrk=;
        b=Vedyy6FqBEipTQCr1RUcKa/2jWycZV6Pty90WGtS6pG3O9I3bGKb/3AXoBzhLWLL/V
         NzyT/YXUIDkFyCL3u9HrPjx+VEooUCnP+nBpIkI2/YMfrNA3tFmsN9No6R8Zi51fLAzd
         8qAHWpE/j90A3sy+VPrwabeKb2faBqdxUEOC7OvCBOFwnhY/ddMLHvtEk5MNIk3228m6
         Ig6/LWwXcSJEyRA9vB/flK2Z0NMcR6FvG7HnVN//Xved5gEUlKm/3Xnn0mJUd31jNi4d
         0i3SdYYROwEttP6BB34JPR6eGpJTRPp+gRb9iO+LmN81lnxCVIJ+boTXi2SBAsZcqF/y
         i/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688307; x=1796293107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQ18LAQ1HnU801OItuw005RCsDZr9KcDeT+UKU9QZrk=;
        b=YiGMar3ziBLUGhYObNvlKWQ5h+Hy8WYhLOsNKH8qbIhwz7VoqciTxzHEhIOV1BKxKn
         T1ueneqcWGPaLvYnS7/9IJRBv6x0jI71MxK7hFdovFdqOPaPk0elLPZOsUeRbeC44oVO
         2Es5jszcHzqECOWgRAZVgnju5nCGGtDo0pyoDVWEc4gb5dRoTbAPAOzwIT1HT77CUyF4
         IH4BRD7uVtphfrZgfVK6U1WnQD1jyEcTyvvs/Mrx6aio2WeCP4rk93bdGnZDwRpV2y9z
         paauYuRSZ7YEjCZL6+5Nt3x/ZrjdXcRrQUjmpao5/YlnhBbGYIfbNvEDA3VlT9Lh/+ly
         yNKw==
X-Gm-Message-State: APuU4Z8RNN29VnzASPuSm6WI0GGspYWwVnUl7M09a2OXJ8j2N1HN3WaI
	kH1/8esf4zIn6DmDIaapOR+9BSuseZBzaPl1zgRyWiVtzhFNfo1s3CrVF/6sPg==
X-Gm-Gg: AZFdTZdy/Th63HodWrx0w4s/VshvJFPi9Tq+tNYWRjj3LFf1wLB/oEgWEX0rDTU1sfS
	/OMS2NZvUXze1PgTRl11aDK6OWsoZhVdZKHPPxwLMpDRJj/LZDPvNysThamHqbuesxQ2yp3ewXU
	LQivDaHL2SiOY9FUsyYCTwE2TeUZ5L6cn7DiRsN0HZGcw9q631TyLLzJy4GNUMv+fURdL4wYCBi
	cU5ZKf+Oo2trOpMCii5fev9EIR0UuX+QrSJNSrPJYFgK2/ld7AsI6vBb2VNy3ff8G/EkfTjkih6
	QFF5j3oQvYGodoIFIs+HQhirTMsdSaiKF35sV2QWZ/l6R0q++gEP2rfLwfKMNw49vdbkf98k9Ub
	aULh7XF63WeeAsY4eMM1h5X6bgG4T/Y5drBpalb3dySRRF3GvxO9CFGtjEbKzL3PcQ5kO8PVYHG
	+qOfm/9wgq9Vgmt0psULhbHrCUBacJHhCW20dssmsIKoqUzuW/Nk8029tPx3HdGjpJ3cgQ+Z8Iq
	/c6ZACEQwQNx2yv2VZW0FyANbxNaBx2sbr8kxKb+nxkf0LF83G0lqWFFbOoizlXrACWa+C+3Aou
	PiLTuWtqlaf+VYOaogn/SREbx/HalEV4YTU=
X-Received: by 2002:a05:7300:bf10:b0:376:b957:bfb with SMTP id 5a478bee46e88-3856f7563b1mr25741485eec.17.1795688307302;
        Thu, 26 Nov 2026 02:18:27 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm74221227eec.10.2026.11.26.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:18:26 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v9 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Thu, 26 Nov 2026 10:18:17 +0000
Message-ID: <20261126101818.3916631-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126101818.3916631-1-w453y.me@gmail.com>
References: <20261126101818.3916631-1-w453y.me@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fullmesh endpoints, if the endpoint used by the initial subflow is
removed and then added back, no new subflow is created from it: the
connection never uses this local address again.

The initial subflow is kept in the conn_list once closed. If it was
still established when closed, it keeps the local ID 0, which is also
the ID used by the re-added endpoint, and
fill_remote_addresses_fullmesh() then marks its remote ID as
unavailable. If it was already in TCP_CLOSE, e.g. after a reset, it is
disconnected and its context is reset: the 'closing' flag and the remote
ID are cleared, and its destination port is zeroed. It is then picked as
a remote address, with the port 0 and the ID 0, which also marks the
remote ID 0 as unavailable. In both cases, when the peer has a single
address, all subflows use the remote ID 0, and no valid remote address
is left.

Skip the subflows being closed or in TCP_CLOSE state, both when looking
for the remote IDs already in use and when picking the remote addresses.
__mptcp_subflow_active() cannot be used here: subflows still being
established have to keep their remote ID marked as in use, to avoid
creating duplicated subflows.

When no subflow is left to take the remote ID 0 address from, e.g. when
the initial subflow was the only one, use the remote address of the MPTCP
socket, as fill_remote_addr() does for non-fullmesh endpoints. Before,
re-adding the initial endpoint created no subflow in this case either,
and another endpoint only worked by picking the closed initial subflow.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d465524902f0..af3b092e45ba 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -199,6 +199,16 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 	return 1;
 }
 
+/* Closed subflows can stay in the conn_list, e.g. the initial one: their
+ * addresses and IDs are not reliable, possibly even reset.
+ */
+static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return subflow->closing || inet_sk_state_load(ssk) == TCP_CLOSE;
+}
+
 static unsigned int
 fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
@@ -216,11 +226,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 	 * already created by incoming ADD_ADDR
 	 */
 	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-	mptcp_for_each_subflow(msk, subflow)
+	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		if (READ_ONCE(subflow->local_id) == local->id)
 			__set_bit(subflow->remote_id, unavail_id);
+	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 		addrs[i].id = READ_ONCE(subflow->remote_id);
@@ -243,6 +260,20 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			break;
 	}
 
+	/* The initial subflow can be closed: like fill_remote_addr(), use the
+	 * remote address of the MPTCP socket for the remote ID 0.
+	 */
+	if (!deny_id0 && !test_bit(0, unavail_id) && i < addrs_size &&
+	    msk->pm.extra_subflows < limit_extra_subflows) {
+		struct mptcp_addr_info remote = { 0 };
+
+		mptcp_remote_address((struct sock_common *)sk, &remote);
+		if (mptcp_pm_addr_families_match(sk, local, &remote)) {
+			addrs[i++] = remote;
+			msk->pm.extra_subflows++;
+		}
+	}
+
 	return i;
 }
 
-- 
2.43.0

