Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578A16D4C0
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670601; cv=none; b=jwrhBpVHtxn42ZbbpjVZ8HaQ7uLaswkU/GQoZRdAU7z3n/eiZDs0CkvWE0hv9I+KeOcmRCWhvIqaWI8v0o3FslZ4ZOZOQ5cb9MGDbSOd+KP4tieRcnaVY+9Vcd4j3rqcwU0mc9J6JKP7H7yQJ2QzFfx5sd5jAfMWNPb5cM2wkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670601; c=relaxed/simple;
	bh=Ttit8Sj0t88KyvcChT4U9PjIkI9d4LUsr0a9dNeF7Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8qFVHc72/AOEfdIXhkclkaGZhnzau5DZQe1tTzYgl3THnVst6+e5f5ZHB8AfEDEKtVbHEdOxU2z6Xhu2ZnYOJCVlYNCzaoGjI0+IpsehP4vb4mOi6zneJWQ+z+a8XfUEwLDpEEGc1NpSNQNWQ0uejLNaLwnpikebxLkJstTAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtjRTEuT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtjRTEuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD27C116B1;
	Thu,  2 May 2024 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670601;
	bh=Ttit8Sj0t88KyvcChT4U9PjIkI9d4LUsr0a9dNeF7Fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JtjRTEuT4UHeegiqzSMq56+rdivLf68Qkjud0KuiPKCwyTnhwVAjfngurVJ3AgfLU
	 geDRREupBQih1lF8iIcDGLZrPYA5qdbJmforZ/o97hyzB8rMePGf8hB5UwP8SYtWBk
	 42Rl7MRJCrpUwi4sq0FFnff8TlvIqBdPIEQ/+IWSYx1lGTWAUaujjIRdevY3I5+VWS
	 JHc5U2QSKpvUd9Sl9Er0paC6Zf4GIgpsPcQFvOdCd+nZIyt/lHq68hhdklG4SZWR4Z
	 1vWcFB/g9nYfNga2eGOdNcoZ8XOXPqwAJVoBXnmTDSUzobRep4q5Mjt4dIvzPLQtXc
	 ZovA605eopmSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 02 May 2024 19:23:06 +0200
Subject: [PATCH mptcp-next 3/4] mptcp: remove unnecessary else statements
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mptcp-cleanup-clang-checkpatch-v1-3-a2b46c0a6bec@kernel.org>
References: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
In-Reply-To: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ttit8Sj0t88KyvcChT4U9PjIkI9d4LUsr0a9dNeF7Fo=;
 b=owEBbAKT/ZANAwAIAfa3gk9CaaBzAcsmYgBmM8wFhQfm0HmgQcs5iHOkJRwXK0TM7ao+WAjVw
 hdU+icbWZWJAjIEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjPMBQAKCRD2t4JPQmmg
 c6qSD/iqnMTV0w50t0q+ucGnxrVTGwerEkPvrMeL5SFaft7wb0lVxHBo+Xd9cYftzKZvCvqtVvq
 xITxt3mUmEPz2Wva+T/my5Qa8AETwJzKW5V7wPzGDrf6XLNWMhwAf7llDO+r58/uOsjpmpVxdrT
 ix3Z5OULUoeHJZ4WlAo5G67gns9uh68x0rYA55YZgjtT9P3yIkkltxdS6DMfE3UWHvt5CZilWQD
 E6+f2kSZlQBg7Cz9sizxd1Uezoi/ax+9gK1ukTeND4Vu7Fl/ouWfa47xhaMf7SoFo/L22cdYgOc
 9dzMbbR1IGPVt5kUg8zW9uMhcPU0Rt9F5e6AMN+yiq/YH/G2s+v9qDxHsra8g9VnsCemcCiYLWW
 7aRB645y+Iot+KbmNPVF4mfTH2WmownliQJH5TrYlqpoKKqBkwDJ4bhbXw02dtzEp5VvRCK1eow
 sEuj78T5voQPX6eknMUkz8fvOOGuz52pMRSz56aR1JTeL88Ix4/YS5KR+zaEwKYktVPEzeSke8P
 ZxTQwLSNZWkD4sUylU2HFgk/FqL7I14OPFzVMTbcgp028we7ql1Sf89D0bc015qjBOlgz7Iigg2
 mQ3JJNWGEDM7ViLtm3OvqMWFD1fMp4HbJjT4MZARQ94tcPx8BYCbf0dbTND7mMo2UsVCO2dSKgf
 HKQ7ObLaw7HOb
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'else' statements are not needed here, because their previous 'if'
block ends with a 'return'.

This fixes CheckPatch warnings:

  WARNING: else is not generally useful after a break or return

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 97ec44d1df30..7987342f4526 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1117,6 +1117,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	}
 
 	if (mpext->data_fin == 1) {
+		u64 data_fin_seq;
+
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
@@ -1129,26 +1131,26 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				 */
 				skb_ext_del(skb, SKB_EXT_MPTCP);
 				return MAPPING_OK;
-			} else {
-				if (updated)
-					mptcp_schedule_work((struct sock *)msk);
-
-				return MAPPING_DATA_FIN;
 			}
-		} else {
-			u64 data_fin_seq = mpext->data_seq + data_len - 1;
 
-			/* If mpext->data_seq is a 32-bit value, data_fin_seq
-			 * must also be limited to 32 bits.
-			 */
-			if (!mpext->dsn64)
-				data_fin_seq &= GENMASK_ULL(31, 0);
+			if (updated)
+				mptcp_schedule_work((struct sock *)msk);
 
-			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
-				 data_fin_seq, mpext->dsn64);
+			return MAPPING_DATA_FIN;
 		}
 
+		data_fin_seq = mpext->data_seq + data_len - 1;
+
+		/* If mpext->data_seq is a 32-bit value, data_fin_seq must also
+		 * be limited to 32 bits.
+		 */
+		if (!mpext->dsn64)
+			data_fin_seq &= GENMASK_ULL(31, 0);
+
+		mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
+		pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+			 data_fin_seq, mpext->dsn64);
+
 		/* Adjust for DATA_FIN using 1 byte of sequence space */
 		data_len--;
 	}

-- 
2.43.0

