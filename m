Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4B282F0
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423797; cv=none; b=XKHBnPvv9tmo8hnGaBmMZpu7A+kA5JxwMf5XJK2u/OoorLmjXJkp/WAiGm41IGWE/knakhSGsTujPtXSQZDMUvF2f5RxR1+ZTKPHeDT4eMpRG7lZ6ICuYsL6VMyLlPA7dlDTyXAGOBtDPIfR03tAvwbwt+k7dbUrFob1cGmpFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423797; c=relaxed/simple;
	bh=NVokK7HmcpqNcfCzAEUb4oDmLtEO06w7zp3NUfPqoAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IuHbB+UPJJn5z/vQW/8PXKrXdEhG7exFUqFj9ovXFuGEyWTIwrU/6kLrgY+tKZQVcl6Ii7uuGG75M+/xfgDCVnJ+aRbYpXUS+Na1DkjvHPcviqxTPzXQR5wGTSm3XRTuVE3SJkP/5I2kj+yYEqhFWsM1Ae8DLSS7zeis42i19Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvJ3D79g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvJ3D79g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1ADC4CED6;
	Mon, 24 Feb 2025 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423795;
	bh=NVokK7HmcpqNcfCzAEUb4oDmLtEO06w7zp3NUfPqoAo=;
	h=From:Date:Subject:To:Cc:From;
	b=HvJ3D79gsIhowUWkXrHf9jO/qTxfiMUFb3MS/WKvinCFqz3luHqwh2PplFEve55Ka
	 BLYuGA2nFWdyFaT5fKiGLnrLNToM8GWKaEYSjzmMPTyE7XleQPpdBR7LBTGImauAan
	 +DvSAMqA2BBBxFS7nFHpGB5fg+Nl852etu6/yUsUI2yn/+NmWRkQ3vORcyNIs/cPAq
	 rX5pyUbFs5cx8wuA91pfwOpF6tpVI+ea2tbK6QQ/YxLWB3lhrF3BNkwEH/f8LxP4Gn
	 AaN1as6E+RWYxYlwEDCQfp/5N8SKUypKsKJNMEx0oErvbU1MT7WOBO0ETUVKgq/1lV
	 Wcwo5ZL2D8bgw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Feb 2025 20:03:05 +0100
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add a test for
 mptcp_diag_dump_one"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mptcp-sft-diag-squash-v1-1-81eb3843fa53@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGjCvGcC/yXMMQ6DMAxA0asgz1hKA0G0V0EMFhjwQEjjgJAQd
 ydqxz+8f4FyFFb4FBdEPkRl8zleZQHDQn5mlDE3WGOdsbbGNaQhoE4JR6EZ9buTLti6N1PlGle
 TgWxD5EnO37eDP/F8Jujv+wG65i+zcwAAAA==
X-Change-ID: 20250224-mptcp-sft-diag-squash-859ea35654a0
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2659; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NVokK7HmcpqNcfCzAEUb4oDmLtEO06w7zp3NUfPqoAo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvMJy4mHPApbCS/Tbuz0m4m1GuZ6W8J8OFMj0K
 5OInxCWbzqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7zCcgAKCRD2t4JPQmmg
 c59sEADJnkd3s/r794Ml2PpT0umAkGkl4YagYukbRG99XAxxX7lbFbAMEBhgd5B4NI+FN1E5pEd
 LTujuua9ZfTBdDBIKXFafF3SMSjiSYhDgBqtZySkIe2n3yMgqEbCzMw6nc4a/ilO2nM7m6H/5g0
 019GvS3nl0EbsnJE4mlvmYSLoXnPnZ3gB5CTI4RswalFwVIwqmWs416nxcR0p44uDuW+7rXfxGl
 w8wIDT4qE7PLnO6YmIFb2CAQilQwaEDsRrXbOdvUTGOc/1OVQQuDfyvWVXR8/jXZzNCNc7dQIYJ
 TfwrrUW2iSduQTMC4hQKuXX9RSq7NB8G3XS3W5aiBndlVIo83uWuJoI9dkJilZPfvPbUJeqlC8J
 rwlcfAGfJ7VOLUbZyEsOXWCE46K/HVEMm8VwkSmu9SSNBVzvgqEaytKq8YI06P1kjSr1/6qCrU+
 B/CWwyNTOFMNb3ch53aAGs8UqAnwqkDxk6lUykein1LAr5Z12Znppx5foedbIkwDx9fxL4HrzPh
 eOj5/imB2duVHiZSAeaLjelX4CELumWXnphFuzMLonAuDbE+pvxaie1Fvi9gJUf+yULfXL83Y0W
 Z31pRWhzwlQ6JywbCQyVqp2eQ74PpDWZfjRpZJPHc27cnD6Z+lIIWO/lWU34ODsncM9Iu8B/io3
 2fqBCDAuaBdbhxw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

- sdiag_protocol: avoid compilation warning:

  mptcp_diag.c: In function 'send_query':
  mptcp_diag.c:77:43: warning: unsigned conversion from 'int' to 'unsigned char' changes value from '262' to '6' [-Woverflow]
     77 |                         .sdiag_protocol = IPPROTO_MPTCP,
        |                                           ^~~~~~~~~~~~~

  => the real protocol is passed via INET_DIAG_REQ_PROTOCOL.

- printf: follow the same format as ss: hexa only for the token + flags.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 7915ef1fc0611654e0aba36c4121bef2e0f26697..284286c524cfeff5f49b0af1a4da5a376c9e3140 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -74,7 +74,8 @@ static void send_query(int fd, __u32 token)
 		},
 		.r = {
 			.sdiag_family = AF_INET,
-			.sdiag_protocol = IPPROTO_MPTCP,
+			/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
+			.sdiag_protocol = IPPROTO_TCP,
 			.id.idiag_cookie[0] = token,
 		}
 	};
@@ -146,12 +147,12 @@ static void print_info_msg(struct mptcp_info *info)
 	printf("add_addr_accepted_max: %u\n", info->mptcpi_add_addr_accepted_max);
 
 	printf("\nTransmission Info\n");
-	printf("write_seq:        %llx\n", info->mptcpi_write_seq);
-	printf("snd_una:          %llx\n", info->mptcpi_snd_una);
-	printf("rcv_nxt:          %llx\n", info->mptcpi_rcv_nxt);
-	printf("last_data_sent:   %x\n", info->mptcpi_last_data_sent);
-	printf("last_data_recv:   %x\n", info->mptcpi_last_data_recv);
-	printf("last_ack_recv:    %x\n", info->mptcpi_last_ack_recv);
+	printf("write_seq:        %llu\n", info->mptcpi_write_seq);
+	printf("snd_una:          %llu\n", info->mptcpi_snd_una);
+	printf("rcv_nxt:          %llu\n", info->mptcpi_rcv_nxt);
+	printf("last_data_sent:   %u\n", info->mptcpi_last_data_sent);
+	printf("last_data_recv:   %u\n", info->mptcpi_last_data_recv);
+	printf("last_ack_recv:    %u\n", info->mptcpi_last_ack_recv);
 	printf("retransmits:      %u\n", info->mptcpi_retransmits);
 	printf("retransmit bytes: %llu\n", info->mptcpi_bytes_retrans);
 	printf("bytes_sent:       %llu\n", info->mptcpi_bytes_sent);

---
base-commit: 3716d837622ee1baf6fbe7e6a6a7a3df116e75fe
change-id: 20250224-mptcp-sft-diag-squash-859ea35654a0

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

