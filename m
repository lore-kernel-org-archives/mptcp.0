Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815488;
	b=o1E+o4dCIbFDQd1fUpf+X63o2mdLyRa2c/c9YQkJk61vOGUOi2tLsMEV6z++CLqiPM/T
	 9+GBQdZVSNnKgAiFdkJp4lMs9m7Su4cc4YmVoduzIYmUpIq7Y5d+nyK47d/fI8qWCE9cy
	 Bo2Ka0+OBn3gvb6nyrLIng324JOQtD5w2uvJTHtk9zZkl5cm3uaZWKJ4agKnJUZWK+Wln
	 al/EjsfRdpGoGFihTfi6jG1ZMtiZVexS9rf6zqZyrjcm9VLmpc41eE30RNq3vwp3ikF7U
	 48EkfqydD/pjmSQChBsEAlEUDeuZlw7u97tBKap0hO6Eg05dP30GM8vGzuPuW/alLDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xqtBu2Wsy0B4Kw+r7BB49KJkb1PgkF+EWLfag1zttcU=;
	b=1QuOxAdRKHKKznjFoEVaDTTgCoBCqGU9iR++e/N4exhb30pyAVvT0dkhMy0wwDbATjQy
	 I1pbB+Bi8noFPZTw8o5k81Pc/VxNB+plZ9qaAIqxLrTr3Spt18iHj82yWvRjn0UM63Ku6
	 c02yXUY6ofpRJqWXo0TdL4ItiNFfcE7pewIgUPfxDfIgWKc2VT5PaQ1wOzGLCMu3kYktv
	 IPTLnL9WyeM9lCdEsWrGTZSFfJuOwcdH5fJH9/fxL+IPJ6F3PED0rEK8dB75SApNxvsZC
	 F4vxKjguZ+83ArFge179kG8L23HkQwmwQKwu8OOwqebj9tMuul5H53iIc1kR2hrqwyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ecDts4uF;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD3606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 21:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07AD3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ecDts4uF
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso11693778c88.1
        for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815487; x=1796420287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqtBu2Wsy0B4Kw+r7BB49KJkb1PgkF+EWLfag1zttcU=;
        b=ecDts4uFPuTtsYwpCISRngpdiHGpWfOAADnQgAfGsPs9AXcYjEDQgC26dF4XX17cGw
         /aCbwC/OHdStAgcb7wG5wRZu0cV5WMxiyQVj38wX25iu0kMPMVZwvZs6us2jAAW6J5Wr
         2fI32y2bteSiJ+XUVFggj6cAVXuMyi3qfgeHag9BNmGIZbu3gfOg+5ZTmSIX1bCe0nWg
         RDz70mCjD/KaanRZdMwsl3ml6EboIZ+JVZGnfYvnGCl7Mr7oDx6pTdIJu5nk7MkPOaSi
         CsIO8gTKbIHcpeeQIaSZQod/2sx10UWEhHKTURNGKWVNnMdP6PdA3/OJPqhIduwvgjmO
         Kw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815487; x=1796420287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqtBu2Wsy0B4Kw+r7BB49KJkb1PgkF+EWLfag1zttcU=;
        b=i5jboxTvCBKaRbp5tJeIbavoZPS6TuWYapBZusiIz7Lq99waXPTljqBk/b5enNWbvt
         ioLmO0/ocYSe7kLuVCFQ9fcJf0g1qQicoV7jkO+oVuMZJ1AiFAZI+ITa+FJ8OZu+f8NP
         5l16laHSfkksbCrgMXvZIjiY9NoaocMrbV5ulfsJZrgkb3NDcIDSZwKDhxtSQG0i8SN2
         9xopgoL0sZl4+V2oCIlWykmF/ADLCsO9oGh82NZXuYK6RUo0cEEMFaBWysBp85EjXC3T
         W7vCoF3lRRYywODNYRjqyVJJp80lDspu9rKvxMEC4pzI9whhEMF0iHIhSz0bHKFAXz9u
         qZZg==
X-Gm-Message-State: APuU4Z8fWmRQ/P9fxXsfNheWlz1TOACpphliDM8tz/KXGbr95YMW5/n0
	phBjjTK7MkHT/doxPmSBdiWNHrH8C+Ht4dxjsMQNT2qVRELlUPu3yGGyIjZuIg==
X-Gm-Gg: AZFdTZdY6OJsvhqhRswI5WOPCUbuXhhFtu0k12HnBEhjFxB9ZtL+ngBDS+DFCVaQRZi
	BVTtPvuOza44p1W9piHw9VDbFmScqfFVxap9SflPLHwDr1OIlcBpaS8E5zBgJqIKb+bf3+dA/3m
	gYwGh30I+MMs1UI/RjKFRfkSy+Dfy99sTDPanwSN9HHm01RqIo81fTZZqR8JIhGHDGjdJ0fgRIH
	NGw8pold4aM4A0peYCNIXgFIqzoPfxs2oMTq0U3ug7PzBWenTGPuV1uBl26JJ/cXwV4if0dDLrn
	fWxmBkFbA3S1MK7+kITzMurMMsUC3APkiUi+9uF6W6TEQK5NytJ94Vow3wt269EbqvBSw111ShI
	Rf5LsSzqRp/1htlDtpwbAYKSDCF5OgFBmElr5mxtOJuemTWnwqauOAFsHV5G7I9L3lrvrSl5wHt
	9aGUaTDZABIdkT2jWFnjwWG4m81ir8/shE9Lwj31oTX00i4PtUrdtQDQ0hWWO9gMMMXqtSJcYKs
	tlbbpoaQ/W8WaEXK+hTNcg/0uAWmxvyZwZgs2bURo8g5A/G2gDTpwY0pH1uR7At2UuUyiGeRblO
	uxNCvfJgBtkrXcZ45MofFkjU8u6344P8fmA=
X-Received: by 2002:a05:701b:4502:10b0:1b5:3616:5968 with SMTP id a92af1059eb24-1b556898b59mr25806584c88.14.1795815486836;
        Fri, 27 Nov 2026 13:38:06 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm67825547c88.6.2026.11.27.13.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:38:06 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	Gang Yan <gang.yan@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v10 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Fri, 27 Nov 2026 21:37:55 +0000
Message-ID: <20261127213756.4154872-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127213756.4154872-1-w453y.me@gmail.com>
References: <20261127213756.4154872-1-w453y.me@gmail.com>
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
the initial subflow was the only one, use fill_remote_addr(), as for
non-fullmesh endpoints: it takes the remote address of the MPTCP socket.
Before, re-adding the initial endpoint created no subflow in this case
either, and another endpoint only worked by picking the closed initial
subflow.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 88610aed45a2..f1e1576fb375 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -199,6 +199,13 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 	return 1;
 }
 
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
@@ -216,11 +223,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
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
@@ -243,6 +257,11 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			break;
 	}
 
+	/* If the initial subflow is closed, use fill_remote_addr */
+	if (!test_bit(0, unavail_id) && i < addrs_size &&
+	    msk->pm.extra_subflows < limit_extra_subflows)
+		i += fill_remote_addr(msk, local, &addrs[i]);
+
 	return i;
 }
 
-- 
2.43.0

