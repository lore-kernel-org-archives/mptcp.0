Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753416;
	b=H1czLwl9i4JRd5JSSkD/SikjFi/RgNkz3P6UENSdE0vrmmXoed7ZERVObwinO0xQwmac
	 18T3SdHqdpPNZjxH6rHZAMjSmNpMw3WPZUzSNC6UAWPMwMpIU2ih9NIH23qXEsEO6MkyX
	 0pgZC1pVlgIptiZR4CCWDsNXVx0OlkD5e5W86OAN49PgPSYd446A3wuF3yhcG4KWrromb
	 sbv2Sas/SMB0G8klRjdv1mKkSESIPVnmmiLX4LgW+sj9Q7kfrQ7SeKnlhqXnz/1EVYfOM
	 UaoESapGi0XZs1vonBWE5HaMrdK60+Ef0lzCDr6QBRUTxfLe7kVLEDT8Wy9Ly0Wn2+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
	b=mU7AvMrEEX2C8M9jHRa2dCUeQEVhv0cogFJHT3TUfhb9woKcAVnROlwxlszXGLidm+tZ
	 OV7JkQhRdYv//QeG6MreSwVrqKqLC7Ne50HZA0UY+c6prIgTMdqbcUzmQfgL59TxVR33Q
	 lDPNIh3qZq64rl/JR6TOTj+BEFglYRp+/28OT3TVjmU1VQ2XoJkL20ag+xKMCKaUBgKx5
	 6dN0VyXKBpa85RnGj62zLnM2WuiWEilzXoAApGlwJgRI+/PDkwY6i9bYx6c0ZDwZ9ww9v
	 4b9I5AC7B86kqULtc7ddAczPeJlHb/hGX0H2/Vd2TuC6LfzKcr4OB0E1E1CW4aGtVpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EcdZ6o5R;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C21606A31D
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 11:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C21606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EcdZ6o5R
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1211638eec.0
        for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753415; x=1793358215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=EcdZ6o5R8dZFIPVECBQ0iDsmpmxwLFGY2uRlWJJdhr7pjSBqyvO6UFeDSrwSIWSRow
         11vaXRna6RGQ66JIeGYsajhUvJFaX9jUlvbYRk9RHHQ2zVLX6PvYquJfHyRy1TX3oWdk
         PiARm5sSyXvDcvBiRoCqGm/fqgaDta6UdJ1NioKCVDb9emyH84U63SzTziU+DmiPnI3c
         niJEvEla8HaL9IAbodWD16du83mIiG2riXXcg1cc807rXxYlWFrC6eKMg4Z8B2e3Gg38
         cukrvpJ+ZbJPa0DJJ3qq3EDJTAgaZLsAyPM//X2XtWGzaykacO6yLAUHtKfUad6RJGZ+
         +zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753415; x=1793358215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=nZ+v6pzVDTSrFWJ1gVl/E2A8VkfCN3to+iEDTXchSbHCZjOFLpIXPPzOhsEF7fqqEG
         ZIAq4RxBc58W5eNMFqj/CiNr64Jyswza30aRKoekiiz9LTBe9UJefnwngVh63qRk92+a
         XphioaA339fAWGIUGgmO7rItTnvd4bm98HLRX3VnEv8dgUKAiJWAfmB6viJk+TqYjbY+
         6RqZOvWzkcw5e5LS3TFw5Xc+dggE+zdbd//jwIRi03T7tuUAWSATXA858Bni21GW7Kdp
         o2ALyJk0W+lo7qkFUAmnp5t7CNYLryhgSTwH1szE6QMmFxEmeoR4OrXxJ0JjKBX6lGFm
         YhAA==
X-Gm-Message-State: AFq9FYK0Ua9kTppbIBULCNCmzdzQkNGRKiUMumtG8mEnhByl81vOfmbV
	1FpjDV1HoDBzjN7ub2oZvIGB/o0RsIWT2JxcAuvTXWtqMX1oGDsmKGg6geRRDg==
X-Gm-Gg: AYBFou3/HnqgcuRCZdFVli0FlyawL8OtH0xl/evjDRPXPX0BkK7wDGS0S9jDChYewji
	EI2qib4EuoU2Uk4lHdwKSO3IBWYlZ/Qn8KvrhDYYKNz70wpku/RvBdMm8uO9qTdhuNHvH2CdOld
	0tw49b7h5VV0djSOm8N2subhSx7s1YRh6xYgMDqyQ4MC5gGP4F7ku0wOUGPqMrneL7RGkmbJ2Ca
	A2G2Vcq+InKj+7jL8FJYVj/hYKRYeMf/NuDHuFVVwxE760zLaXSgtZdFqL6veEh10v8Tf5WZnQ6
	9cYuI5fUFXiD2GYfMeWd+8g7CTjNC+X7ZagCy4hMXvdL4obmiFa8mO1s03yWZ44hJOZSVTtj+/C
	Rwc+jGNfjhxgAwDmvoH/mK+hsJwcJYCIPmaK1zu4shtcCks6OM6KwN18y+LOzBt75E1Gf7xD00L
	0U1nF3zujRMmnYmYBREnaX+5hyJyEYQPo8tFZaAKJ3cFdtkyY845JQSP183gYwxwKAXIvAcDAgC
	ecckBoQR985LjAzAuV4leQ4XTVBaqk1li7Jg18p08LzIwpCWcuiDulwxdh4
X-Received: by 2002:a05:7300:f48b:b0:356:23dd:3c72 with SMTP id 5a478bee46e88-369d964640dmr2476046eec.4.1792753414507;
        Fri, 23 Oct 2026 04:03:34 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9defcdcsm12695186eec.23.2026.10.23.04.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:03:34 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Abdul Wasey <w453y.me@gmail.com>
Subject: [PATCH mptcp-net v7 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Fri, 23 Oct 2026 11:03:20 +0000
Message-ID: <20261023110321.403874-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023110321.403874-1-w453y.me@gmail.com>
References: <20261023110321.403874-1-w453y.me@gmail.com>
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

