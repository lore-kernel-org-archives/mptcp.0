Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795412636;
	b=vqEZrR93PTrDCZkxtH/McjXke0vOSBpKg08qMD03iw7B8OE9SN32/LUl5PiQ72KRIPll
	 8eeUmyivBAhdEoHuRlc0qMkI3DXW5t3QV77f62ottG6Z1Jb5JHNaVaRuhOj1bYU509sMc
	 AUF3vGy8qw7mXIx+A3/9LqvcSQF97BFhz2aW0MplQ5EcvFV2CrdluSkc+Ew8UDdAtBR6f
	 PLHpbnETMM9WGH4RT2S6QPkl1qSee5heDL3vhFhtVdg6rhg53R0Dm3bb6TC4AKs8G2MSA
	 d4xJ5rNETJVr933f27izgLfXJmlljifd1Kb1qOYukPVqoiggFMPcIWyKcKNeXmI2OXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412636;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=6hfyw7WhHFchEd16y0nHkupG7B36TqiBWqvjOIMwFnA=;
	b=N08VxIpokl/4ygNGqqk6ljm9lkJYoCQmn+1qtX20Wu1ZxNvV/3QJII6q4x2+90hspLuq
	 KaXMkbZpnXlSQNFMKLCWhojVECIKI6R7ea0JoXQokmcnTPMx7BoOb1YwddQvHzaJGTfrq
	 nqosSBrn/QDJm11O+WF/bnETEx6IdL6QeDCzdmtYzZl9AIWuXNFm/7wjJmW+8gyRpXQdW
	 +WUS+3I2nrXZefSFZpKhnQw3AYnmHewetq38srckpGHP5oHah1RsJufLn3IYRTGqjSVNc
	 bYaApWePMpt+h1Z6dYiMhrcD452ZZYu1PIbNKebQlUjB4jsjl2cvEn0ejQKJ9dWc1/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42043606A31E
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 05:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42043606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795412629; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SKy+gL/o2lI4DaUDgKZqLw/nZS130q+MfvTGg4YL1kcjpaL+ewJ4ovsuwf+ol4sxGPI5qRbP/JYf4DpaVASgMWWfgSF7N7QkX71zqMlwqy6jE8IONrjIpemQkAva15fK8wH+80uI8cEmCHekeaFDPHu/2ahtBkxshT2kX6muytM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795412629; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6hfyw7WhHFchEd16y0nHkupG7B36TqiBWqvjOIMwFnA=; 
	b=XvA62QMHKI9xt9u+rNcIiPsUgCzwQw2iwLOVWbrbtTb2w98yoo3pFkEzJgnYDlbZ4Z18cWJfC8/Hg36RBPnOv7RBOPIg3tDD+A24Ps9Shc2hEIngTakq+P3EQV4cwm9zGmWaDQcTWanJqIMt75TG1woOi21PYFwnhYHUUzbOWYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=tfu3qXAMkQ0u7VBO1CbFlbQUUFRwlcRhLkVxp+43KFaiThUHcq69m40LbbNDmnh8DbWuY0Rp+IHGNH+/BXGXOzNz9vwo9Yn2ncyU7MT4jTvxxWKIf9spVo9yVjDyZRdDjRE8+/94BqMUg0CQgR/82yMXmcrTkX0LKQiHnQTEnw4=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=6hfyw7WhHFchEd16y0nHkupG7B36TqiBWqvjOIMwFnA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795412622235369.2728429522964;
	Sun, 22 Nov 2026 21:43:42 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-net v14] mptcp: hide sequence numbers in Netlink diagnostics
Date: Mon, 23 Nov 2026 11:13:24 +0530
Message-ID: <20261123054324.561321-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
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
X-ZohoMailClient: External

TCP sequence numbers are not exposed through TCP diagnostics to
prevent other users on the same machine from obtaining information
that could be used to interfere with existing connections by
injecting specific packets.

MPTCP Netlink diagnostics currently expose data-level sequence
numbers through INET_DIAG_INFO.

Clear mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in
mptcp_diag_get_info() to prevent these values from being exposed
through Netlink diagnostics.

Ideally, these fields would only be hidden from unprivileged
requesters. However, the current diagnostic callback does not
provide the privilege information needed to distinguish requesters.
Therefore, these fields are cleared for all requesters, including
privileged users.

The getsockopt(MPTCP_INFO) and getsockopt(MPTCP_FULL_INFO)
interfaces remain unchanged and continue to report the actual
sequence numbers.

Fixes: ac3b45f60954 ("mptcp: add MPTCP socket diag interface")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v13:
- Remove the additional selftest for zero sequence-number fields following maintainer feedback.
- Clarify the security motivation for hiding MPTCP sequence numbers in Netlink diagnostics.
- Explain why sequence-number fields are cleared for all Netlink requesters, including privileged users.
- Preserve the existing getsockopt() behaviour.

v13: https://lore.kernel.org/all/20261117050804.134954-1-kalpan.jani@mpiricsoftware.com/
---

 net/mptcp/mptcp_diag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0eeb..fe1603ce80162 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -215,6 +215,10 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 		return;
 
 	mptcp_diag_fill_info(msk, info);
+
+	info->mptcpi_write_seq = 0;
+	info->mptcpi_snd_una = 0;
+	info->mptcpi_rcv_nxt = 0;
 }
 
 static const struct inet_diag_handler mptcp_diag_handler = {
-- 
2.43.0

