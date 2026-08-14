Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD533E3169
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743539; cv=none; b=oB/TyRHgSsy6icFqCI0VpLR5gM8ECSQywQPU1ORVjcvf4wWRd5jQyAmN5Lvv1yHzX6//K3CMdJsCi0tO4dHrta7vbcUeBCSkIo2Wlvc2wA35M6+4Rm8tz4Gevo3x0aygvnHB2bvHMe8XJan9al6ixwfTwd/wD4wqFJXkvehFt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743539; c=relaxed/simple;
	bh=+Cr7FWn4LsxbVJrNif0ZXWiMTFKe11uU/kH8aI38Q24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LRsVM6WnDGXM1swKeg08I08PMY5p3mn9pUEgPpkbtappjKQM/t5pf10fa8BKgy07fimYKXFthhtZ5AJGXuBRS3WFmH3fgIBONFoWgEMo2Oiw4XFyIWfGS07iRvLsPtsi3S7zDcCF0U5EYCalQTo0PCfFBOvWCl2whjY28Oz0xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R79InTxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R79InTxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6F51F000E9;
	Fri, 14 Aug 2026 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786743537;
	bh=b49SQp/qfbErXkrXarmZfci5G1svCC7nj9fm0Sve1ts=;
	h=From:Date:Subject:To:Cc;
	b=R79InTxFoo/W7c70tf2w6Ye0BiopT/9lBVFTPwd8RXtcMv4G0Gs8a7/RTtLRhw17/
	 EqHSxqNw05e9+48Iv94nJyr7enZu8TCbKmQr6LiCSCW8NaskPU8MPih8gwRm2LAb4x
	 PlsJ4hrKl39lQrGOjHL+zbD/9OWlfePC2JG3EpY5KDUp44WeZ7DHnLxJtCH9FZkvPs
	 aQHC0pz94mR7ip2e7NAYf2h+oNUdFGjW/6DLoof7SVSReSVEML811jIWyfFmF82KkC
	 8hxNexP4hlASkdtWAlcrJpUOM6r9qyYjeRSn2QWM6TfK3M/zANwIF+TbelpSRDxTnQ
	 uncoZ59f6e8/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Aug 2026 23:38:53 +0200
Subject: [PATCH mptcp-net] mptcp: options: fix uninit-value in
 mptcp_write_data_fin
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mptcp-dfin-csum-v1-1-08d0b9b86bb7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4Xcs5cAEhV/xfhgr4ueCbXpFUNC+
 HeqPE52ZxYyJIXRtVoo4aumn1CgOVQkr0d4gtUXprZuT/Wl6XiMWSL7QQOLTSP7Y+8EHXq4MxU
 rJgw6/4s32s8Bme77ZJN7Q/KvSOu6AeXSFCJ+AAAA
X-Change-ID: 20260814-mptcp-dfin-csum-d39bce4e9eb7
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+Cr7FWn4LsxbVJrNif0ZXWiMTFKe11uU/kH8aI38Q24=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLquz72WmqmVRw/cXai+4Kkfp99a732BZy1iPKa0Xn0+
 H5HvzTdjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImUWzH8T/3fdC7uvoi0Y+EZ
 oVum5r6ayzc+y0hkbKhJPBp/UM9iGsNf8VBxxwK5gEMHZIPqZj16HSNzbGFKp3PApe/JX8sfhF/
 lBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending a DATA_FIN without data, and because the DATA_FIN occupies
1 octet of the connection-level sequence space [1], it is then required
to add a DSS mapping with specific values.

If the checksum has been negotiated, it also needs to be computed, and
included in the outgoing packet, and thus the initial csum data needs to
be reset to 0 as well. This is no longer the case since commit
cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()"),
because the whole ext_copy structure is no longer zeroed by default.

This seems to be the only case where use_map is changed and set
afterwards, so initialising the csum field only in this case, along with
other fields for this specific case.

Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.3.3 [1]
Link: https://sashiko.dev/#/patchset/20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb%40kernel.org?part=2
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1bb486daf56a..9f6b4358e564 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -611,6 +611,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		ext->data_seq = data_fin_tx_seq;
 		ext->subflow_seq = 0;
 		ext->data_len = 1;
+		ext->csum = 0;
 	} else if (ext->data_seq + ext->data_len == data_fin_tx_seq) {
 		/* If there's an existing DSS mapping and it is the
 		 * final mapping, DATA_FIN consumes 1 additional byte of

---
base-commit: ab76ed72e0bed8352d3b8e2b4d1be7c823e5fba3
change-id: 20260814-mptcp-dfin-csum-d39bce4e9eb7

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

