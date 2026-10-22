Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659053;
	b=E+S4z+afl/awRIR9J2PNzE4iou3YoyryvgfLoxsYdp+/ovTa1H7qE+7ScZXAocHXsqUT
	 1ZM0iueAJQsCijbRrb8u4UTD0/a1EGAMUN08ISt2FX5yMujZFfHsgVbXaAjLfZ/yRIXP8
	 UrVKsKPjKFcQK/3SQz/fIWCIYdpplPCyu4Hf4m+fIdZ8TkClSRa/VFdmfgqBjRwXhXTVX
	 EJAYp0e6SqN1DfnvFUtYUVm+w1DI4woJPaQLIk5ifeyJzSCM36bGH/AmhILifh2Go7Vfd
	 D2UyejI9nGBKz2ee+YCTc0Dq17r/jrQP3BXn5hHmGJknONIjjkgT6uKGzlgk49R+ZQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
	b=yVt2Rvds5G7Nn6PfrRGA/qPPFt2wAt4JtBVYLgCN+DMyxppo7bEpACu3/RDyiSjGgsrn
	 8zu+fpO9/TZnS861H0B41Lku0pwmsIpqvX76h2VKWzt+JYGrqkvpHBPOCSfYN+XAp/5a2
	 jS3rubjN4+whq7blyrvh9/BU1B4tNHS/amDxkwaUmnv3LRX9aCSvp/mmEbV4onRWYLLK9
	 dm7lhhJ5RwRA9lUQXeM23vdke+fb8SZJYT8UAmJhdl22c5UGbmdMSzUj8y1x0XmW41h17
	 VKB/o0rq8hHS9YWh4vFjoGtQrA1yIFF+BaecIZHooSTUMNdKzH/40SDAzjy5wSItbIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iYVlzsp2;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E53606A31A
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iYVlzsp2
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2772031eec.0
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659052; x=1793263852; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=iYVlzsp2wXP4AWmV1uMc695KK/onrWvGGiaGro+HBii3OfwC7QOvucFxzhbPCFCkYv
         2VWa6tpW1d4O3UhaWM6l0eJtaCRcz5ESoXnC81oLE/0FuLlBFVZtZLfh07PX4ZYzZqEN
         gg61gv43gl62dR7rJ3YWT/rgXWUoaYEiK0SfFrCFDc0dc9j+k0CZ9DVB/llg82+pkjPy
         KcjHYmdX3o91frYRew6hNmq/BFWNJAwJ5Lc/Qlu3+PzqJGHKPX1ryTlgGoNibcVathRW
         ha/Tk2uCiDMX3qdcQvTw6Y/lKzXbemaVuvsEjM+eYkhKkQFv8aEcgCdR0ORo5nr9kObc
         25qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659052; x=1793263852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=untCRppua0zMd8BN2mpO8fWMJNkECsAfNhc8Y1P0O4iXx0elF1wUSKBXbdAlPE+i6y
         A+uqlWF7b47+p8Xk2S2yIf0sIBtHReAETybxEsabSjRgbUPAXF0DaoBqe5SWsMkEh0s1
         kM65c3XfY5LdWIan+8RCCQ4zL5agI+NCRgjadAE6wlEC1Wn61jlkTREv5Sf2Xp+KZdyu
         X1YDi8qRyTfjJUnBOFpEzckOa07bfjHSlZz6XDXwTzX7roO/BZuyWAiAkq/9UkKUCYoL
         1ZMbWS8fFk6U7RSLIdeVP5Vd+XTO/A/9NFtHE9peMWych9lnBSk1kd6Gz44vXkgdgM6G
         PnEQ==
X-Gm-Message-State: AFq9FYKwxjala+DK56ixXMyKNJgCalB4vKQSmEvJchS9N4EOU8tkLGeT
	mnjvDD8n/X2NOoLDdMwo2lIAQjPnTxEoVFKdtMjdTvc0Kna2S+NTERo7vYcRWw==
X-Gm-Gg: AYBFou0m5wMQYlIfu1Z94riNdl+8n8PniE0m7Ou9A6OvhNybhde+BzduRgArVlyiuVj
	kY2icCIGkljdcQ13EvSUqvEF5lpP/0IUWb9dQGno/Hpu8T8NChj+Wc1In9D7IAhpAyWM/azNBLm
	FNmqDbLa+8aI235lVmYUjfsyPTdsNzBzKNfJo+0T/vsvpCnOIzMSsm9GSuxG9r5aS+z1o+0crWg
	rG1ebYmDfjuMnOEmzEpaCcelNlrSrWUB2OQGCC2yjAQIVdJSQfStPjiCXOYx4QCQVqVQq54f4Ls
	wPXbHwLfzBCwX+AemBrztTpjN/lz0u9rTG9Lae4nJAwkLUrDY/6K8dt1Mrz7GXhfpmgqFomQq2I
	V6oc4rWw241qUVF+nGYWCOS/Y1FCZWsw2WC1985Apyv6WRz9FHkPKw/8QPN/OKeqhRh5G1QQonP
	iIAP86Nl9d/w6PMkef4UzNgqQsG6El7AWgXfc9hQaHEZk1N+/AQCnDmWIooPa70K2ElP6q2q04m
	tB9BaB/CXirdgGBg3jaO4la6z+crZjk5Y7bFM519TNaZekO46paGDYH287+
X-Received: by 2002:a05:693c:41ca:b0:35e:5ca:e0df with SMTP id 5a478bee46e88-3674eb34d50mr5910217eec.35.1792659052273;
        Thu, 22 Oct 2026 01:50:52 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25343328eec.2.2026.10.22.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:50:51 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v6 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Thu, 22 Oct 2026 08:50:40 +0000
Message-ID: <20261022085041.211318-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022085041.211318-1-w453y.me@gmail.com>
References: <20261022085041.211318-1-w453y.me@gmail.com>
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

