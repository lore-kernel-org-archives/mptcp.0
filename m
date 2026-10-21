Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566214;
	b=IoOgfh+H0c3aoQ0hs6XqM/ZE5BnlezVTdaAWyU/ZkcGozhYzJV3C1C3Ykrs9tJ+M2gF2
	 NLrvyxOS9Oa+vE++W/hq9urEDsBhSoKBErtbqpb+6uSlX26mJujjjcxE7N3guEnOnZnu9
	 kiniy8L2xqQK7dP8ipLxs3ywSF3el1zrViiPwXofMqX8SwGzPZNp3GWDaSzqd38If0+4K
	 TpWzP1sYWHpIDJgSLgkTeAJNK4mxbMEtNt3VKDBro0Avm0+2m5fmFzN/DjIn+48q0m+Kl
	 TAxWbBV61U9q+pzAeY0ol8MncgBW7GgTKrcB+7XZhccTZUKRdVGMulyQYrP5UFKrKVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r7UgBzkOgkIY49aE7RQgGmpl5vSoNjCtBQrLqqDS2II=;
	b=BqmDzbhE0zokTgx88klKzn/cgMBPt3J79wtbd6aw31MHFeP6XLjadaePPyDY6FbIza6b
	 ZpFAYsj96dbb8oE0uyvshxxwbi1C75QHz/ohHoHN8e/63zEAfunNgh4gohQ5eTpoPYRHk
	 KeBI6pguGB3WN87SVzr2ZHFOtkQJy9O7UM+MCGh/NhmmxUgcJJSDuamO/yhDRiulNiqGp
	 zVsn/68E16swPng5uI6JZMt66TuTnvydXyi2NTCGTwph8bbJngj0PNLVyQCCzUJjStBTe
	 LBQm8GAAUlVER9+JbqU8B4LauAANIq3joCjQD2GD5/O3I3fYZD6m3AiEJ5AqGpfbaQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TZd3otsa;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF2606A31B
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 07:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66AF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TZd3otsa
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so757669eec.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566213; x=1793171013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7UgBzkOgkIY49aE7RQgGmpl5vSoNjCtBQrLqqDS2II=;
        b=TZd3otsaPq6r/fBO6GxAKi1zlLOBfLAwWQL7a+5s4ECSHXF3v6ay0bdcOyq0NWBAkv
         FId1n+8i7KwaFKCZXPg6/PJccbUvbr9vyAMwcipkb+QhevW0SPNo+/ItyJXmxSDpLA39
         eGp83+9H534sY0KqdDHlI8QZk07oAvK+BUNk5GOmnwYSSE/8R7TgbMfvQxoOgDQrN5/O
         dDAWsi1BDbI4qp3I0PrrKdjrw2PGUf3IhSQt5tEwWn/HR5vgaETtZe8Md0CWHc+vrYUU
         CcCPyidW4/zPsDwXAp6Z07dl5xgHU8aOdantnwne8JuYxtKakaLYPtb5DkIX+P4vmGHd
         h6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566213; x=1793171013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7UgBzkOgkIY49aE7RQgGmpl5vSoNjCtBQrLqqDS2II=;
        b=Vm3iyCh2/Fh/FHEqxTAxgbE9WxemL5OR1eORG+xo+OkYssFYCs9PzqfqKAG79m9K8G
         evhNfEJEf8dAe/7e6txiHsuXZPG+GF1/iewf0lkTsMaH3KwTSPjIadxtxSeM0yqHa3DQ
         ez1XocBIWMQMY+bJAFkGqDiBYEIBxXg7ij1PBWXJcEdTuU+0lp/+vuwPTt7W3sfS48Ib
         JeKM2F0eFJY+p4rub+QpvwrEQrdVT2aRhyN3Ndk5lKkkGeSO1B7hmOE6hHuxmrOWnrmm
         0uKHUDpWXXyL4kR3A71eSUOWXv6fvAzN8OItuIcRi10rqBzVhjK0xpEL1qjpGHnK45ap
         DDTQ==
X-Gm-Message-State: AFq9FYKBn3EtIAilxcE6nC49OZmhBVpUHwCKvf0DCWiie3ZaDT6WGbww
	KsL5XdJ+GeV/6Eqy1t+bHNoy8PwZ94JI42RbbG7Xy0DwUrN6ScEK+o/lvvrkMA==
X-Gm-Gg: AYBFou1A37ip2G9lm7SsnZ1lCGfqm4lW4cSvOIcpeySe7UqL7XkMXSX3MYgP8LNfaYb
	7tLH3ZgqLOP+aRyOJpOn8bET23OBG6l1yxmGFYWF+GLMomsu4JLpAbt3bSCSppQ9sI89k8rk9TI
	e8SY8V9xo3th7DLazlglj5rxmvBKoNwyOjVFG9tQILOczxIEXzb8flzBoqpwdrQpHN/3eu+ozz3
	P4qhfCSgNmr/khmNuu7kPYNQjmkDUyeZshAPXE2yp0l9aM+iVikQ5Rc6Xg+WcBZNwbRES8I9XQp
	YCmzQvcBd3tInODpee8c6RqN7YFanErgTdDdwP5qGPNGZDjTQzDWapBYLN4B5SSzA3ylMlEdLmO
	E4dvCip+k7VOLSWlAxr7P8K007NmLvfEhloRjQ+HIY2KyVRE9RSso/gHpFvsIJh8yVgDCvl1eiU
	n8p2GRbouubbJ78KHwLZpdQiqxcE2cvjWQJaqq4XMoEre3MhDeKLoar8Rgn0rDY1mtNnKWl5kY4
	YFT9ObG2rIcNY2q83DmY4Svr5rNyBo/0LXthTLRbSSAW+Vi68mIcOnZmm9s
X-Received: by 2002:a05:7301:1885:b0:351:29c8:643 with SMTP id 5a478bee46e88-3674cd33c0bmr2256286eec.18.1792566213454;
        Wed, 21 Oct 2026 00:03:33 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm6468910eec.24.2026.10.21.00.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:03:33 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v5 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Wed, 21 Oct 2026 07:03:23 +0000
Message-ID: <20261021070324.50533-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021070324.50533-1-w453y.me@gmail.com>
References: <20261021070324.50533-1-w453y.me@gmail.com>
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
the ID used by the re-added endpoint, and fill_remote_addresses_fullmesh()
then marks its remote ID as unavailable. If it was already in TCP_CLOSE,
e.g. after a reset, it is disconnected and its context is reset: the
'closing' flag and the remote ID are cleared, and its remote address
and port are zeroed. It is then picked as a remote address, with the
address 0.0.0.0, the port 0 and the ID 0, which also marks the remote
ID 0 as unavailable. In both cases, when the peer has a single address,
all subflows use the remote ID 0, and no valid remote address is left.

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
index 1a7750813..c240c1056 100644
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

