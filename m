Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9003C8C46
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929511; cv=none; b=ToDQdkpcUIsHUOVBbmh5dXdYsCxNf3sPjBaudCcUA/AbTZ1yGdSlI3RahmGHwaaMCteQAkIdFPRlZCP+y//uFFOH4H5OYeNwr9AA1nciOBgYN/Ih9oTp7GcwIhjEfvp9Ax6qfC/T4XmHecilcLj41qLpK6TYad6BikD/B4j4Kno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929511; c=relaxed/simple;
	bh=y3NEe/mar3rLZzOXAdL4u6gJJVugPqrT5qGG9yKXGik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iy30rph1f0Mlo1weHY1p7tU+qJJNRQa/dnJg00Ea0i3AUdzUr0mvdWuiE7VnLUTd1wYHL0btkQaQAG25jwnUbTfd4TycjEnaGfMvfoo1beHIa27LknhzT+6KWwPHhsdJ5qtvp3x9lIxHJXARTq1TPQOMda8WjPqhcchicvFAEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdjVWFhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdjVWFhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8221F000E9;
	Wed,  5 Aug 2026 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929510;
	bh=GLI1NwWa0O/4Q/cO8XZbGfTphyLOrJFNcImKV0sWv3s=;
	h=From:Date:Subject:To:Cc;
	b=SdjVWFhHy/jhltkcAghMe4AyyDeQHB6wcehRdpA/nYoiYw7zquv2+KajaY6S4aUQc
	 /nty1trNTCxZMbbBuDv5MpzMKUzskfFXtb4MbbytYLKdpD8OBnzPDhPTbtx0aZOqZW
	 yPHPTgxTFQ2O599vmvn+95gnwQ32PmDgDjle01vewNPElY5jC0Kmdp2TrbKW04bLsE
	 PlSyks1aQX+T5L7fsjTwaecbLgtasuFHRGt1q2q93eAzjmkAjj7ltMX2UXtp+EKSsC
	 H44Ciy4qlGgm+FUSiP6/58AV1kTOa1e1l75V4EnHNF6sheAThgzeKOjbrbX3lPoPi4
	 dnDNPAp/QW0lw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Aug 2026 13:31:17 +0200
Subject: [PATCH mptcp-net] mptcp: options: handle MPC data + csum reqd + no
 csum
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mptcp-opt-mpc-csumreqd-no-csum-v1-1-cb2ad0b9feac@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQrCMBBEf6Xs2YWktqL+ivRQNxtdoUnMpiKU/
 ruxvc1jmHkLKGdhhWuzQOaPqMRQwR4aoOcYHoziKkNr2pM5mx6nVChhTKUmQtJ5yvx2GOKW8eh
 t1/vRXqhzUE9SZi/fTXCDfRu4wLBXOt9fTOUvgHX9AS/NQnaNAAAA
X-Change-ID: 20260805-mptcp-opt-mpc-csumreqd-no-csum-3f145fa19c4d
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y3NEe/mar3rLZzOXAdL4u6gJJVugPqrT5qGG9yKXGik=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKK5VXzOv6xXHnHIvbRZeraWSXbPAuWNTW9M+pLZ/lcd
 WPewfJfHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5J8zwP7Br9a3k+r3MH20l
 FlfZf//A/VaNW+WVp5r4SibN0qMv9jH8j/Sb/GmW1g1ukxXWO7rDVf0O8hQI3+X073n3bl7euvW
 VvAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, a remote peer could send an MP_CAPABLE with
data, with the checksum flag set, but without adding the actual 2 bytes
of checksum. As a result, uninitialised bytes could be used for the
'csum' field.

That was not a critical issue, because this 'csum' field is only used to
compare with the expected one, if previously negotiated in the 3WHS.
Worst case, the checksum is likely wrong, a fallback is done without a
reject if the negotiation was done earlier. That's OK.

Yet, better to take the expected path with this case: only look at the
checksum field if the checksum flag is present.

Fixes: 208e8f66926c ("mptcp: receive checksum for MP_CAPABLE with data")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=1
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e1b38fe5faf8..e94d4ad4dee8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -119,9 +119,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
+		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM &&
+		    (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)) {
 			mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
-			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
 		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",

---
base-commit: 064fb643fcfcdddbad6da71da8f1ab206f018af7
change-id: 20260805-mptcp-opt-mpc-csumreqd-no-csum-3f145fa19c4d

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

