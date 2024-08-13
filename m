Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16D4C8C
	for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548337; cv=none; b=BWwW7eiFNCL4P1/CauPn8q9q52GHoRfl+m3l0+l+UIYwEayvkzllf9vz50BIBi0b0a+zuvUJT/rb1tfazlMitB9BX3nQbNlFVJ9ClbvcZoahLpWWGgkMD0PGl9XDCsG87SDoNc3dOo/nxw5UaNTwS2SlhWVBsfBh3zGRh+ntJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548337; c=relaxed/simple;
	bh=jSMUnJZzH0LITKg5zchjAFOAamQoJxZpqbBNW3istMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gBYcIw32+V+1HNkvGUggRk450/xwU2BiSOK7osLLUN8m2ynniinzwTPCm2PdwqC3hoUOS+ugww+WKNCMgfnuoBhibEY7svazljMhg5PuOHOuEOIlnSL2UZZMzB2Ei56MAtEC0pzGr7rqPcaUSgoOO1kshHGqFAsSr+k5GJ5ND9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3cADy+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3cADy+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AC8C4AF0B;
	Tue, 13 Aug 2024 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723548336;
	bh=jSMUnJZzH0LITKg5zchjAFOAamQoJxZpqbBNW3istMM=;
	h=From:Date:Subject:To:Cc:From;
	b=J3cADy+OoFs5Arlofzzqp4H6oYW1zGo6B4+TLzDVHmBdCGM2fWEbk6D7yo5A1+wPM
	 7IOjyvU1GfejESt3czKXAig6tnKhW3nKkUkHtfUU6KRsZVq501Y+orvmOeDwb6rTfv
	 ZJNE1wWp4QNSPxZwiRcxJ2+zqhBBZbEgGzNnj9qgZZ422+bzZ4EyZZErPO8iNg0WC3
	 AQz2gCRfxVwqf4/JKFtLDCOu76FotMc6SJ0q+Cb9QsM5RK2djCr1HswscBcKggUxeJ
	 BhkChg7RDpDY6V9ZJOONyzE3f6CwyY8jNwh62Rea1p9s4Np6ryV7D1ujdrim0c2eAg
	 zbcPWA5tZb84g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 13:25:31 +0200
Subject: [PATCH mptcp-net] mptcp: sched: check both backup in retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKpCu2YC/yXMQQqEMAxA0atI1gZs1dHxKoMLrRkNYqckZRDEu
 1t0+RfvH6AkTApddoDQn5V/PoXJM3DL4GdCnlKDLWxVtKbELUQXUN1CEwpFGbziuAa0b9O0tXm
 VY20h6SD05f0+f+BBniL053kBGNaX1HQAAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jSMUnJZzH0LITKg5zchjAFOAamQoJxZpqbBNW3istMM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmu0KvaAH9nst3tCLiPTvS6pjAzqRz9bp76+Pbb
 eWgv3CCHrGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrtCrwAKCRD2t4JPQmmg
 c4u6EADgT+yJXQWjIUm3zWWcgkz6yMaD8Nd2CQH2uY3BETH/+QRJcgj2rZueuZwo9gmS0Lz1RD5
 zv0MUe4qJVU3wuLQzW8XVdTp1QiztbpPqDIEqqA8zdts37v7GsXRxiutVk6lYx7Pu84Hj9Yu+BM
 RSfcXUH6DEH6KRNYKhwxY9U6w0+H7fboAgruzFpe4bYLmxIledvjdmoKJDlAT+65xn2n4XEgSHp
 PX6wLjf2YXcra87GiSLfSRWAVh9C6miFBOtWPOHkWW+Ne3vdzsgfipHl5f3PNXKoxDSZLKcoOvv
 rN5t0RfoscmLF4s9cF3zNgcAC2IPG4SW49gQDLB85G1oHvl+/m8m6zmJOJROO1uSkVyQZyYyfee
 xVnT9fldA1m9bDLTCeUOWPFwMtvAkii4EmO8nVZ00ORAOGGsPC32dSnCIc6jTu1A54mQoVY5mpd
 hWZJ594Mz76KvdZbXuX2UcDoW3QYyjanJq30Hx8x/FHgjzprPfPtehXO7xITTFQeiVpkjBFF432
 8JAW9CSpDE2z4I5ijEapMTZbIwOTfHF3yxwHnzgg15RIbl5zGwiVf20q3OWeThAt2S2DnxB+2AZ
 6vONYS56J7+Fn3NslEaE72K5AU0fUGXtpGMIVMU5Nqyd8bkHIj+1nBj7oWRXGHSX0K4JOmZDdeg
 tDeIkvs9FsTd74A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Looking only at the 'backup' flag can make sense in some cases, but it
is not the behaviour of the default packet scheduler when selecting
paths.

As explained in the commit b6a66e521a20 ("mptcp: sched: check both
directions for backup"), the packet scheduler should look at both flags,
because that was the behaviour from the beginning: the 'backup' flag was
set by accident instead of the 'request_bkup' one. Now that the latter
has been fixed, get_retrans() needs to be adapted as well.

Fixes: 3b1d6210a957 ("mptcp: implement and use MPTCP-level retransmission")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13777c35496c..ad60d04f4981 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2326,7 +2326,7 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 			continue;
 		}
 
-		if (subflow->backup) {
+		if (subflow->backup || subflow->request_bkup) {
 			if (!backup)
 				backup = ssk;
 			continue;

---
base-commit: 971367a56ebfd1fd70608813898e48681281da99
change-id: 20240813-mptcp-sched-retrans-bkp-291785163b52

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

