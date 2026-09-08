Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1B5803A6
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887240; cv=none; b=pOuOSHXKQd/Df5sBTNeukOeqVLkUlEXD1woZounDfbI2vyUwWosPQQcCxcTmB7F283/lvhIlNRwr/3lvJXtuqVY3dWgy2Aw4LG6eoTz3f6yRseJBy7iCWsTQJ46TozdxOTBJUJixiaPs/ad7OqBUjS8HXzzwS0nKgD9EJ/qjxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887240; c=relaxed/simple;
	bh=rMPorb55mGDGHXpl3WACHjK1YwyQ7Jft9KScjOR/+oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3fkVFFO7Savd2lFRtYNVuG/faVCIWdBOO+E03DXTqKXihYfqAxV1+CsFuSfRyJKU11Zs/2tX7HkOwT7G5YiR9kKv1u0cnnr/uXfKAEDJo1lheKyTzeCcSI9rNy5L66+4scvrF1mIpILIMpFdvJayiyAHrhrM/s4OnyZsDkoBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmCDh1pB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmCDh1pB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640361F00A3E;
	Tue,  8 Sep 2026 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887238;
	bh=UjlBDCNPNepmqDWXRKV94WKEy9W3DXRtJFNuvdBRFzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SmCDh1pBRwusfbmaWOIjoson2NAvQ5VDVkwfp2+uRuZJvWEsJ0KZdmEOU4Kkm2CN8
	 reim1XQkF8gTTPd0hFToZmaoi6wYtysBB+b9gSmuinLlxeevwTLqJstxXMCkHO2C3A
	 co8nZVo6m0nWy1ry7wB3ajLP84ouyR3zaYje+bXuu7ivAGTbTaxhfoEYdmgx2fxUV4
	 gMwDCRiE6JmO389I37q8i04NxVkivewdfhwgKJwnFvmNtHg0UJP329A6WUhZ3AR7Yu
	 T794AEzQk7FaQYrgTwPFaFxuxLSi1zANRLRxHT/DhMswEPIj4QQjr3ajFbDZ737Cou
	 0lnxwMQTU6Qqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 19:07:11 +0200
Subject: [PATCH mptcp-net 1/2] mptcp: options: mpc: avoid printing uninit
 data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-mptcp-opt-read-debug-v1-1-b3e74549b6f6@kernel.org>
References: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
In-Reply-To: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rMPorb55mGDGHXpl3WACHjK1YwyQ7Jft9KScjOR/+oU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWOBzZvpzrYOg1904Dm1nP67Y+YTnQcllsbm77nA9yJ
 SyiJl9OdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk/x9GhvZfi1aIWud/m33q
 c99HKd75l63qIrxmV5n4eM6N/GH9RJ6RYRJn1bYH9088d3ovvKPIriTX/OGvCwZhuas4f130mp1
 uwgYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When parsing the MP_CAPABLE suboption, this pr_debug() might read and
print uninit values.

That's mostly harmless, but that's also confusing. Fixing that also
avoids some tools to complain about accessing unint data.

So read these fields only if they have been set.

Fixes: cc7972ea1932 ("mptcp: parse and emit MP_CAPABLE option according to v1 spec")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f87707110c75..7f7ed4753100 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -126,8 +126,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 		}
 		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
-			 version, flags, opsize, mp_opt->sndr_key,
-			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
+			 version, flags, opsize,
+			 opsize >= TCPOLEN_MPTCP_MPC_SYNACK ? mp_opt->sndr_key : 0,
+			 opsize >= TCPOLEN_MPTCP_MPC_ACK ? mp_opt->rcvr_key : 0,
+			 opsize >= TCPOLEN_MPTCP_MPC_ACK_DATA ? mp_opt->data_len : 0,
+			 opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM ? mp_opt->csum : 0);
 		break;
 
 	case MPTCPOPT_MP_JOIN:

-- 
2.55.0

