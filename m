Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429692;
	b=RbRSwAS1PXm5o2kghsqm44D3LKzqykK9EW3ElbjngmXOU/nA49AVcLYBQu+FUdjfyt5r
	 OR3Q0XmVImLC0ASqe7Swk00XVMYp2zTPoT00T2RyxERx7VokrKgOe3BomT1VHs1J0OPaP
	 6otHJaaJGnWICcKVAmyY+WujmCLEViYbr1MuSAcr3SwrkCS7GWWyF6WSBImgp9abG5I+H
	 801rgxEKcMC6FSaa48rUmRVxMhQTFBZaX3Gc2KPOgjGPe3bbt7oqIdyWwrdckdjhXuNUV
	 xYvS8301w9DU2WoJGM2jquy02DFE3qadC3DnFYnRkOOCRWTKViCTO51VA/+O9LVtSOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j4/7Kgm4XZXwlNXK7i/XyrsG1PgqZdxrffszkRMdy3o=;
	b=chcp67CW4zSy//YK4JCP2vgyTkaFE0mFwa+UgX8vJqAxtnHuBeoGN1k6O5/GW+3sRlhX
	 pt52o/3YZDuIX1P2irYs+2PjsOXu0mIJ246JWmvGS7ZnNZsNsxASYp7YlHaitTZmK/7CQ
	 3wfdgSTLO5qmIX0CfqKLDpTTNkaEQkjxB4WozdZ83SHv46Xpeq9Qv2QWsR8J33DJ7dZRK
	 DsVF+2q/M1Bquq+bSmvhKDTIaSAxxg/VS2U6jYdCvi9INff6892BzSbho6gZ3t5eeNHA1
	 idAySMReREkVZC05p7+RbgjCG9Joif/qLgr3YrDPahZbE6Z42iMZPWkKrBQomeBixrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kCLIQg2w;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5A606A31E
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB5A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kCLIQg2w
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15354aa70e8so1846680c88.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429691; x=1793034491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4/7Kgm4XZXwlNXK7i/XyrsG1PgqZdxrffszkRMdy3o=;
        b=kCLIQg2w4VeUiZvhmmx5WDHHTVOd3cB69y8uioA8jtgKqKtaiecZAk66chM9ScxR+x
         HPngcxieGIrS4qChiwy4MZJdRDwihX3zr8osA8LRCRZMidKv1H1fTnl2LrNWZuECzbst
         ogxhhG9kKY8AkpMJ6OhwbRpfgxvlsDQpZ/HE71cFBc21qshJ/PIAQ98k+xJPQ9f+x0B3
         Mj9+dxhUUoO/IrsQfgNypswrjZiOKKVwqRUP4mm7/ZBymUWOoLfef6ttvJSb0vOg0Y/m
         qqNkvQ/1yC8ia32hryLUHaePKSK99DKUirovaeRO/LKqHnKJWohrUwzqbYm6GbazLqnq
         4+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429691; x=1793034491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j4/7Kgm4XZXwlNXK7i/XyrsG1PgqZdxrffszkRMdy3o=;
        b=HSlt1hxkM8yndeYlQ6LspC/hzI7Qfed0ScwR5bV1TXqP/5gA463Ugz6SQ0IQ3imVJB
         lmqMqor4sDcjEe5xTfl6V7wf8MiSlgcQgS0NSfm5qLkw6ers1sMSFEQjw0TgS02usZ96
         o9tbD7+P6reGU8jDWymG0PWm43y2vNlDwDzcmU68yCtOQgsEvf+DqHrahEciEajY2kSr
         Yfg0x5aPre6JVvPO/znJaDFaEhsg9c8451972b69+bTUfjOT8C09yDDwdaUOEOxT03K0
         FPy4VGE5N7uiBV03Q3zH+jdHi/wD6N0SG17TDS0sF3P7C5eEyDSivwNGBRCMcV2CsQ5F
         0B9A==
X-Gm-Message-State: AFq9FYK+Kc3gBo9gBGmfjEC+eK36SdtHprd5NzZNWcYWiA9bwAKekY9W
	ozb54qorhajqlk4o5BTJdt/2HP4+azPk9AiX3bA6EeDobXfGfHnr7d18b3HTdA==
X-Gm-Gg: AYBFou2c3RQAb1rz4RNQAUe1VxVoUCNDAjkW7C5LmejbE2snWlCTgTMO5EpnVEKt7Du
	0Lny7BnC9kb2QTMiFwHexlz5AOElfqjBKGUEdpXzailobiWnoe7PCAn2nywQJg6/sVQ/o06DYDd
	FBFgfShET5y7Y4WnTAlS6HvRIU537FzPgmxy9MzxYyk/5wckId1/sNMhig2VZkviNmxknSq6efO
	rP0ztgUcMw8jEz9EQv1OKcZtqXtPXT8XxftakidMQd+g54TEsc866X5vc68XA3/8DElbWYIy3Sc
	QpBFtdbyqijXuP0yufDSFUIf37J+Y5sMbD6Bt6JiRLfUqmLnJiSuKG42NesSUZaQCNDSimGH64l
	MCWcon4sN6wmqsNdjtLqz6ZOmTKcWFHuV6Tgv3sV9iU8VUMVahzW8umWAF1yJgFV7puajDDDbsj
	2zkzOG150QFmr7fVsoXJiDUmApTDjBrdaYNgut/+f7ypL4MwBwZ65PLlPG1YHyhHsy7HoKyWlT0
	m8y6ue1zPkMdG5y6A==
X-Received: by 2002:a05:7022:1608:b0:16b:fdbf:4a9d with SMTP id a92af1059eb24-185139add2bmr10116222c88.27.1792429690701;
        Mon, 19 Oct 2026 10:08:10 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm29247207c88.5.2026.10.19.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:08:08 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 17:07:50 +0000
Message-ID: <20261019170751.200446-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019170751.200446-1-w453y.me@gmail.com>
References: <20261019170751.200446-1-w453y.me@gmail.com>
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

The initial subflow is kept in the conn_list once closed, and it keeps
the local ID 0, which is also the ID used by the re-added endpoint. In
fill_remote_addresses_fullmesh(), this closed subflow then marks its
remote ID as unavailable. When the peer has a single address, all
subflows use the remote ID 0, no remote address is left, and the
endpoint is skipped without trying to create a subflow.

Skip the subflows being closed when looking for the remote IDs already
in use, and when picking the remote addresses: the addresses of a
closed subflow are not reliable, e.g. its destination port can be reset
by tcp_disconnect(). __mptcp_subflow_active() cannot be used here:
subflows still being established have to keep their remote ID marked as
in use, to avoid creating duplicated subflows.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57..ca794853d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -216,11 +216,19 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 	 * already created by incoming ADD_ADDR
 	 */
 	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-	mptcp_for_each_subflow(msk, subflow)
+	mptcp_for_each_subflow(msk, subflow) {
+		/* The initial subflow stays in the list once closed */
+		if (subflow->closing)
+			continue;
+
 		if (READ_ONCE(subflow->local_id) == local->id)
 			__set_bit(subflow->remote_id, unavail_id);
+	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->closing)
+			continue;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 		addrs[i].id = READ_ONCE(subflow->remote_id);
-- 
2.43.0

