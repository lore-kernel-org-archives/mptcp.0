Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436122;
	b=3xIxfxcKPnfcXbcN8q4zBlpGprkxQb+5my+jj+sGlx0MWiyTwYXczE+d6XE/3fowCXnK
	 L/GqmYEsrtdMg2EgOz13T7UhupcZU7ro4L0QLIC3/G9o++fQySscB5AyQYTwI0MmPDP90
	 gFl1WyAQepc6iazH2Vq/KpyBC2+C7gbZI7V9i9Gx/IvPDpeBcrX1W8QAju1LIAF8ztEXu
	 8c6qjV1CcXHTfs8NCmP+nZU7p8X19y26/Fbg8omwtgWh+tB/O1Dhil7NyrNld/FCQ3xVQ
	 mA68EVd9Q3oDSpPordgR3yN8OZW7Jo9a8vnUtxbYHJDaYWH09btAAj/ZtxAImx4BklQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
	b=1pSoUYQ+LXUNqmhRb7dAWrR8PVlb0IEun1puznrNmM25Srx8rmDNWxSq9xdeLrryUplU
	 J8hxUMUNQxCSU2MRtifgHhx6vSm97nFF7SnyrHqm+kmBHsIZLnNMc1XIokfq+aGb0tDd4
	 nbd/R4ovQHU+w3kiGA5QVKxezQ5PHs5AO7BVLC4xpezN/Qztd5Bz6Ygqwwk04mdhbqej6
	 j9t57/M25C11YFgHwKjgT7EN4pYen9xoT3QXpQ+hICl/1/dMmsrN6cL9A50EXgy/D1vHm
	 QklWOh6P8+G0YP0qj8LuWH3vNtGLkugDlE3gX3dN7pmaUi31bYWWGpAPNI1LSis9K/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rxXom7aw;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9B606A31F
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD9B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rxXom7aw
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35d7fa491deso2969566eec.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436120; x=1793040920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=rxXom7awLG0DTHjsC+QWIj73wp11vMKGqYH9DJjrnYST2fvhdbqKfezhNIOR7a5rMq
         p5IDhiKwwJpTPidWzrfLjBTy+/Lbc6KMkpiz6LmycMq+3se3YtgR0QNWjgrFPWW5L0qU
         mUVEX/qTeZmmC9K5JmGENy7w1qVire2LljW/AH0bBxmrB7+EQGA3fK10ezrCONjaFguo
         Cxncz0rq2KLVi5THJbVG35GvAViLrbWIWS/k7zC50X8fQY1TP5t6QOcfpOgMDM4tA4pw
         QKj5bac82vOpNWVfCuoijJzeFhPcVTOqMOT+IepBrls0ArOjDcYEidecH8fLtGibB9DO
         yT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436120; x=1793040920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=X4JidJiegyso7Iy/+Zw0Uk8XzX5NkZlCfWYZayQiv0PDa0fCW7zwc7oM76Mw9YWzFs
         nTjF0ZuG985v0mM7VM/uuKprq7Xx5ygBVyM0BaQcQjlbZnynki9wdNzcPBJKjyzRgvC/
         OlMRzcAx0CSmpk2XFIY/QbY4lgKkp3fyVBzGkGDPcblM/IXNDzRFX7N9blFjnQv2yFiy
         IhzRZVTJmwj5/5S/vVAZgFfnVyhoSr96ormvK580BFUT0Osy9wnOCe9Wx/U9+g1O2bCC
         E2EV+3CLXsOHjj2//FXW0siCT1bejdyIoF90cZd4WXaNbJpjXlMtLjCr0Hd3z6iludjj
         rKaQ==
X-Gm-Message-State: AFq9FYL5sneqt6pJkJHF1/p9c/OhrD9xcwvmtw+JqpHtQ0Af+uTZxE+u
	Ye0heu/UWvIg5ET8QzHdb56J5fS3ER1UubU0jVR/YkzddjWnuPYbt6yvjIXKCw==
X-Gm-Gg: AYBFou3vpysb4yvptNoM0PeqI8uy3AZ5fRIV8zfe9f82vfZPKAeBV/u3vSYLhIZBOKs
	1R8sxwaODNV9UW61MfQDMFvEFtppWMqQNB2a++kW2qAg211srbEetyYddJ1WqxCgUYSVkWhEFv/
	SifF+6j6RNKRCT7XGaUItXc2X3EtM1CTuaz4zdbLQzIXY5/HT6ntYK8Ew95RqbQ8QuRlmIjFrzn
	yZqy1nO82CB8SUG13nP9vlz4p+MMcnxIXyCpSRLeHDZk14/AAeidlaKXRi6mO+R4r3XJ9Mm+MAr
	EkGmw8lhAbkdwb6nQU8wT1wBssok4AZM9k4X9kpQwpdwv2OK+Ls7BuIie/WX9V1klGuWCm5UyUd
	p1/IiZPgievU0yeqemR7zbsdiUCLnJKw+NVF99uOcp6BZ8frTRLOQxNHg93Nl/d4SnHknJtkpAm
	1l0ZV2sI+kfcPCcZ/sfo1tkE9tu7zIwB9t7D4Hf5K4h6b6DBPFPthmfCYMOR8uQa6gvAqIRQJX+
	KcB5StG/Iz2Ne1l8KNranXqKhx4wyXdZpAAC3qQzkVh4g8kJN7gA0H5+eMLySLI
X-Received: by 2002:a05:7301:6486:b0:361:8d0:6c7a with SMTP id 5a478bee46e88-36108d07524mr12626026eec.26.1792436120023;
        Mon, 19 Oct 2026 11:55:20 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm35749512eec.7.2026.10.19.11.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:55:19 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v3 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 18:55:11 +0000
Message-ID: <20261019185512.458313-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019185512.458313-1-w453y.me@gmail.com>
References: <20261019185512.458313-1-w453y.me@gmail.com>
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

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813..24cdb170b 100644
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
-- 
2.43.0

