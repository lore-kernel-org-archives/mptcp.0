Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432996;
	b=1Grf9fb7Aih2eE7huzi74E+MsFmYR/c231PyD2sbHdDcX+BE912SD1Lq8pS6BAjgdeij
	 CUmeAVgX+PufL8uS4V3uJuVJT7diC+emQu4gOFpkxqVqMwe80zbcBbvZuGRQi7d4DMtNP
	 XFnECY2C4Wk3MVe7bFq4S8ivLLlnpFn+62yt5CoCcFIVrofrd76i4TzBWDsMULb9MD+08
	 Y+Bd9uRsDxMQiTaEXDBLQ1kdbLOJ2I6kTq6LtxoVS3uPXNkB+fHrSespJJsEfRO3TvkAj
	 BhNPj5s4mM/5k15yiulI6YDrfInY0C7Td1lpMjAJZvMFa4ZXu2Ph2BNiulOZjfqdByA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WiD3veyh0lMkZup/sX4u7RZCTs4WLYnqELgkUTqE04M=;
	b=lVJ5k4BmkaErUAOz2239hy8ZfOUUPnyzprfGlXEOGaGTAAhirhUs4vs3ueihsucoLx9X
	 ZpA9Y4md7GNiWK4ImNqNOIK87qRquLykFNpwmG/3fg6Z2kq4zAgw/LMmaqEzjEoQBDIgT
	 GtSEf6KKXI8lzP2n6Fmqcz/o5j7VUTQNJCtWxfRi4JX7+oPmujBGr1L0lSQRYzhFB57qi
	 wYayEigIHeQlvE6rUZstqYRMBCNF2Z3QLyfmmlB8YfUnDBYqASguHJNlEiIDVygEimIrx
	 /yn7ktGMffHKlvApgzZWY5LpSk9HlkRwpe+6nHwMB9GaN53Qsvym1pNkteQUDE5rAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mnflsyxI;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB81606A31E
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB81606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mnflsyxI
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-170135e43c7so798751c88.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432995; x=1793037795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WiD3veyh0lMkZup/sX4u7RZCTs4WLYnqELgkUTqE04M=;
        b=mnflsyxIPfwAaUa+CK8QSRMX33G/Q5rc6V6AeMp+uz/aW7eduCMZNmvOeNSI+KqX6R
         fXRn7L/+ls2sgPQS63UVCm8VidIv78KJZgqrpflNZEeDvXsHs1N8M+q0jHRSoBqZyMda
         4LF5hqZxkaysxzz4VMHvnctObMSV5y0gprufPRSgEZBKRS8rflXobTVZqqQYuvTaVkhv
         B6WNsdBZsNkgsJZzu3TNxaabP+gL05i9TlWGgy4qysCyf7oOlYJ+cVElQEa0LSxn8V5Q
         YFLQCTV4EC2FJ3fnJNFqAO5aD8zkpauwn4t0FuUFYs++TZUhYLq0lvZjW+7MBOU8MfhH
         0F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432995; x=1793037795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WiD3veyh0lMkZup/sX4u7RZCTs4WLYnqELgkUTqE04M=;
        b=tqrXuUmWfQlGcFRmDivgLTFFyCjUqCpMpP68bYeG2dGF5vd2/UsPf/3Cr0JGV/DxxT
         0c4j+bL5vm9K/50AdsV8PXmoYAEn/lGu/OVbUuFSJN1OicfgbkicoQ/oFaYQw7gV7XpB
         eF8paqZrDe43CHb0mjs/gVtwwi/FkEUA2H+72EO1XZvTvh4YtG+6HUtjjjdq23VmQI6B
         9vUP4TrUAnln36EhzikQ4L784hQbfbTcPGJtUi35WOXCp5I+wXF+5YDUn9OaADzKHnDb
         ul4TTN+4OjR70yD039pptp381/hdFmPIN1Am62XAOXu8wpuDdHo9K8UTzMdlcQPao2yw
         43Pw==
X-Gm-Message-State: AFq9FYJk8WfsJFKXA7RPdUyhCcysKgThg+IHRJjoP9yl/msXg8euOf88
	XfWwbwq3ewcr6Lkk4erotSr1Ovie475D1vo6z9k57odZ9wr/iiah7ONzRDkMAQ==
X-Gm-Gg: AYBFou1ffw/xzfU3bu6NoGCYktHOygSUMI0gR6FXAX19xTXkoZ0ILsg1QYNJcmaq4mo
	XskAoJKpUTlN7fQ/P7upjcdggOApiItz3DF8w8MYborQWaj4k03JU821viUKKm1fjI7v5t/YZ8N
	20dX8sbvKvrpiBHm5Wt/0ADE5qvMl+HD2t17GMeKLAEXWL8PU7u4xKXZhWVCXIGqFzzGdYrduoh
	USoNqLMRGxJTN/Xxr1k2nIZk/rKgGUWQcs0O1Kml+RIeyiCSK1nvGCglPd5qsgmV2U/wxUjY85l
	lip8Hfbdoi98FrlYaSGAov6+pT8t6gV68pz+JhJGnsndgNsvcDZqN8i0rH7f4wBNlVzXN8ryAo+
	V+cSfqjKuOJoBytPcNtqfUVDqdCSeRciSXk38vM4QZ6V6i81Ip/dotB/v++o42TJa2ZEPxgP9qF
	8sTdT2w9ltYeEnLgwRWpJLjRk8moW6ACj0mERfohdCi49hXoafIBIi9t42ho2187vz9Tlk8ON6Q
	Oom/haH
X-Received: by 2002:a05:701b:2908:b0:153:52dc:d04d with SMTP id a92af1059eb24-18512e23ce2mr10318015c88.22.1792432994780;
        Mon, 19 Oct 2026 11:03:14 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm28400604c88.10.2026.10.19.11.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:03:14 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v2 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 18:03:04 +0000
Message-ID: <20261019180306.382039-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019180306.382039-1-w453y.me@gmail.com>
References: <20261019180306.382039-1-w453y.me@gmail.com>
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
index d3014bf57..fcb5b1c85 100644
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

