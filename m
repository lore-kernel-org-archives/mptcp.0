Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E549504A
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463354; cv=none; b=LEsBe+tLwb3OAewwvu8Gi1HB4g+7ZHfcr8aIxJmo5KapnpG0wcvye0KSIt8J9aoct+tDNzAMW17gh1nAIFxq6DHKdhT0PNmy3tgChoQBLSX2e7JyroyQF/A0yYRwNYJrmBHaG78y2fHKUDOHQVH+swRYFjp2V6BpHPKvFjCsMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463354; c=relaxed/simple;
	bh=dp9gXgcVHLix9/dLfb7TJBGwTzu4t2QwFfBRY1D2sEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dpeO85u6x3RVRXVyf9XuY8wYvciwQ/ZjZRWq/5hUoZPSeziO3+U9ddtSJ57CwAkaqZArxly9qhOZpFdrAnpS/dV6Qa7AXvp/SDrlnlO41wfd5ufLVPoJMPUmeKJXDPqAx/2eJRWtF6n0aqK0Hc9nX/NiaGeTlVUQjIoXGMx1j3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suzVVFGW; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suzVVFGW"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-82478760557so4326424a34.3
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791463352; x=1792068152; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jy2NdkwIfV1h+1eWz+k6BJ4plif9rqbXvoVE4ZowG5o=;
        b=suzVVFGWQ6utbV1+XVffu9iNRhAyZEuJJ1YpcYuHjukXDLSycHdwtbYqNaukykzPt5
         /qSjXNXuhZLAplCKlvCE65cY6Sb5okgFL+Iq5bgYvDwvM6YvIJWJ8bnthdJrHZWW839+
         XS6xCxdRF+lauYT3a4BroZvyR1E1Bl+TWf8EiO38hw0sbczuTNchjHN3KESp9SdsA/th
         cbPBJtaYbXMLFh4oPEIFfpsR3EGJSvT6snuAQJ6xMIm2drbCdly5znBJfyIy1ueW8hu+
         rDk/tu3JHqg4aGllC+nWx4A9ya2thzWCNy6BtyAUuH4zviMyarObwIrHlFbtz0f+pWJC
         051g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463352; x=1792068152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jy2NdkwIfV1h+1eWz+k6BJ4plif9rqbXvoVE4ZowG5o=;
        b=myZiwVRTjaFAEVLwRK+InHOK0VUmS+8SYz3GHypzpn3ox30OeIgbvdzzsT5lgBdaIv
         11Bzn82q/b1rd0l88SkzSE7UbaYul/vKV+NdKK/5xGYSN93lmT6e91lZ1RQAyI1JizYa
         eXI08g9WRAnOzyShQydGQIoGdpbtgibgWbRfc6wWPJqSffEzdRfRpT2/xjbsTA+nlF6j
         ot78/t7eg7SxQng+HcZ/w1uqUsdqhlsdta4a6i5Q7++tPbiDRjhHgQ5TS1NCDboOHNpr
         P+vOMj6Pv+jc8uOn3GQHMvN25PtehUkp7E4IIO7jQZ2ylnr1hKt5Dd10G6Iy9ghdfR/W
         NbzA==
X-Forwarded-Encrypted: i=1; AKwUvByo25MmXo5ig/v1tFaz5mtSh3JS37Z4cMvExigmttzKSe12VIRNd67oQbhjgIg59U8ctdQ6kw==@lists.linux.dev
X-Gm-Message-State: AFuF++mMcBY4Dvr2K0Y5khVBNYfjGGpeii1kcXfygNNhAAUtgdAHRfpV
	m98OJakwgRQ3PlfIHH2ZALlGgNo9H3PEmQTJARewAHI/Fu1ed+2/WFsR
X-Gm-Gg: AYBFou3QyK33EvjLgCHq437+JITmMXao5C1weD4vu1WvRkHfDDgxiKi0NtZEDS+EowO
	IU1OYgC/BVYaa45qZ/zlHJCJXFV2xa9zopT/ojw1yAlTdFJMYB3MtpU/9jCRotLZCiPKxSBbiIT
	6kMrTECkXPZRmcDkCBEgCEgkBm8soDWWSijsNN1kAq1rFGbCDJOjjUemlWhqU6ipdVSPh2Ahtpw
	0AC9iAuWkQhqzejtP3bh2YKw0u3Bf7XBbhxYk1DFqJjg3PGs5TWMCDwiBn59cKbahJExX5+Limt
	h4iBGo/uJg9sCbR2CwvAVMc2itRXPZW40nOD3F2zOvx/rqArfjXHQa0Jj3kdCpbDmMBVtE+tHuU
	2EKhtEewz3Ueo04rUCnbPR00JxJMPgeE6+tgNAU27X+B4Ol6+GW7I+9E6kID5D+0Atym3sYC3vj
	hT1x6O5s6q6+hTnIeE+mgQE1U19LuQ+LaJ0QffW+Q2NXglLiVJMfRG8yCeK5+P8/gQEu5ts3d/a
	JAKGrhb
X-Received: by 2002:a05:6830:441e:b0:821:15e6:d2fe with SMTP id 46e09a7af769-82ad04bf1aamr7583256a34.31.1791463352389;
        Thu, 08 Oct 2026 05:42:32 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc3f8cbdsm5224009a34.15.2026.10.08.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:42:32 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: matttbe@kernel.org,
	mptcp@lists.linux.dev
Cc: petar.sakic@ink.fish,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH v4] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 18:12:20 +0530
Message-Id: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (after
consuming the client's SYN data but before the MP_CAPABLE third ACK
arrives), __mptcp_subflow_active() refuses transmission and the data
is queued into the msk write queue.

When the MPC third ACK arrives, the subflow transitions to
TCP_ESTABLISHED and is marked fully established in
check_fully_established(), but because the third ACK carries no
DSS data, the queued bytes remain stranded until the peer sends
more data.

Fix this in check_fully_established() by checking if the subflow
was doing passive TFO (subflow->is_mptfo). Under mptcp_data_lock(),
flush queued bytes via __mptcp_check_push() and clear is_mptfo.

Also move is_mptfo from the shared u32 bitfield to a standalone
bool in struct mptcp_subflow_context to avoid any read-modify-write
data races with concurrent bitfield modifications (e.g.
close_event_done in mptcp_close_ssk()).

Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Assisted-by: Gemini 3.7
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 net/mptcp/fastopen.c | 2 +-
 net/mptcp/options.c  | 9 +++++++++
 net/mptcp/protocol.h | 4 ++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f71775090..c11fc3c5c 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -29,7 +29,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	if (!skb)
 		return;
 
-	subflow->is_mptfo = 1;
+	subflow->is_mptfo = true;
 
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5..7ea97b283 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,15 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	/* Passive TFO: the application may have written data while the
+	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+	 * it then and nothing else spools the msk write queue when the
+	 * MPC third ack (no DSS) arrives. Push it now.
+	 */
+	if (subflow->is_mptfo) {
+		subflow->is_mptfo = false;
+		__mptcp_check_push((struct sock *)msk, ssk);
+	}
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0384d6a02..0e44de129 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -582,15 +582,15 @@ struct mptcp_subflow_context {
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		closing : 1,	    /* must not pass rx data to msk anymore */
 		valid_csum_seen : 1,        /* at least one csum validated */
-		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	bool	is_mptfo;	    /* subflow is doing TFO */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u64	thmac;
-- 
2.34.1

