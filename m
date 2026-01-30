Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE442DCF46
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758688; cv=none; b=LJEfU9OGvxg78rDJgc5x7L4yIG9Wuw9Cg+F6M/5WRRj5k9y9XWVaH2+I920ZT+hkd1Fj09//0CiIvDtic4REkjg/LFzQ1icta15NTj/azEniIwTpGYFJ0q/0BfmVZ28RC0I38FSwdMd0CxZYMSxY2gKod/SiL+j3bUbz0p7uvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758688; c=relaxed/simple;
	bh=lJmQvvmWX6mzMQmfZIzQDDkILu0N2Q3HrH3EeNTmNiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N+FRgsNjgeBfdhJL1xKJg5JlarQFPsUQXDhRZ47y90KgRyfLCRbl837E7TBiJou+eUb5+7I/82ISN926cEqTtuBfs3BeElwuk6HlDX6+c3EG2ARaWNcT0h0CFbwo1/WpyB/5Drp53DkPQdYQg1RWMi5EB11u9yKiX+0bUcKh4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6Kx2ir0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6Kx2ir0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4D5C4CEF7;
	Fri, 30 Jan 2026 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769758687;
	bh=lJmQvvmWX6mzMQmfZIzQDDkILu0N2Q3HrH3EeNTmNiA=;
	h=From:Date:Subject:To:Cc:From;
	b=h6Kx2ir0GLoYJtoYg3WC+YJmQw7FG0rRar30UcTrSKTQtQHisxD7BRTU2Y6P+IJ9d
	 ckc8VrygE/5XPUlcqyqEgd+a0SXxXA4OexGkDFLxkLNUzVHD1SNXFpStElEkUm8zmw
	 9mhrr3b1eBRaKxXro9eLjFnRH7XDI+AUTkUC0QuN+ZhxNMRr9uTAmxP3KxOkp2sJfO
	 uuQZ29PyPNTZx9GpTPKZuvb6orJsOZd2NVoqJU+gCgHtxeFxfMSLh3zTEk727veGbA
	 4cq4GM7UYWdpTU+fW9V0jzG4mCmMD0jLPw26pBczLmhdMBGxfTL7UT5JLSUn7u4/fT
	 Lc7sKzteKnHpA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 08:37:55 +0100
Subject: [PATCH mptcp-next] Squash to "mptcp: implement .splice_read"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-mptcp-splice-return-kdoc-v1-1-3363209d2e57@kernel.org>
X-B4-Tracking: v=1; b=H4sIANJffGkC/yXMQQqDMBBA0avIrDuQRAnoVaQLmYzt0DaGSRRBv
 LvBLv/i/QMyq3CGoTlAeZMsS6xhHw3Qe4ovRgm1wRnnjW0N/lKhhDl9hRiVy6oRP2Eh9KF3NPU
 ddd5C5Ul5lv1ej/BXkfcCz/O8AGUB7552AAAA
X-Change-ID: 20260130-mptcp-splice-return-kdoc-6d92ca94c461
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lJmQvvmWX6mzMQmfZIzQDDkILu0N2Q3HrH3EeNTmNiA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJr4u8xtttxeys1GURsaN7h2lnQwr1xRrNp4kwO15w7q
 nYnird2lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATOTxdoa/0rWPP03+uzQnS32b
 mWqFcCVLt23+dVO11gsMDlqlah9jGRm2vApNv77r+PPdjWsubGRI3Lzxz7vMO8dneXx+69Yj8i6
 NGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fix kdoc warning reported by NIPA:

  Warning: net/mptcp/protocol.c:4424 No description found for return value of 'mptcp_splice_read'

Validated using:

  ./scripts/kernel-doc -Wall -none net/mptcp/protocol.c

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1b87b3b0d089..c88882062c40 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4425,6 +4425,9 @@ static int __mptcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
  * Description:
  *    Will read pages from given socket and fill them into a pipe.
  *
+ * Return:
+ *    Amount of bytes that have been spliced.
+ *
  **/
 static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,

---
base-commit: 9eafdb3251fecf25d365143d1a7da2dca70f181f
change-id: 20260130-mptcp-splice-return-kdoc-6d92ca94c461

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

