Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9935E1D1
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942469; cv=none; b=PiKaWMiio4UWVkhTwS/PzTeNLKhumRMhYS6Z0YZ+5sf7XHfrsLRm7l5ed5DsxRZQAX8WndV+CyEvR6T3b5e1uFiMo3owdI5Z1TV6Q4LOm4Ys4boS4gV0GYCaYORREPxOIJBZOZQUUld1cqQdKZ9hZyTGGI575QxTlt9IGX06kms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942469; c=relaxed/simple;
	bh=EjCht1h9T2RhKiQn4aVCRiiDCD2gP8TY5frpSO+82y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rYHO1iO8MYmLYB28hy78fsteHjt8Md2ampeQg8dWBSg8/+UEyqybqJd0Rf2uFg2Rx2Zz1/ibPDgSTX9xjkz4O9Pe8gKvi+W0qW9RNSDkeUV0lIavvKht0Tto81vZAYjXnin8FwOUuANSQA3LgUK8oFzTnBehyVHueq1aE8HpcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D79PgGsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D79PgGsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B3E1F000E9;
	Wed,  5 Aug 2026 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942467;
	bh=DKKMY2CamW9NapWN80moYtL+MHUHYS5MkHSSHImuC9w=;
	h=From:Date:Subject:To:Cc;
	b=D79PgGscZ/m7/29bltnxYMgnZHs10Y2hVdiD7WJNRbC+Rs+FDPow/bcEfVfoZ7uZi
	 BQnUqULVD60PNbVZsBkUysOZhJyBBgweDjMlzBD4I94EAOAJ/zSVfNaqHDXO9LMo/Q
	 S+1diR1wgr/CiJYvThyyaeB/sb8MVHhIacYSkXN14tRwNgfEYX7eK6HhoceXwm1QKx
	 4oaR5HToEvjxVaN6o83f5CU5keP1Vt/v/OBZXZdVfhF6x81M5M2wBbBr4Y6xzAD4ti
	 YgvuZ350tiSuarhBGoFfz9v3otCepu2olhs4w2SQOhYJTXQMr2KFBjB9UeioFrHDqT
	 JCudUb7gh6M3w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Aug 2026 17:07:39 +0200
Subject: [PATCH mptcp-net v2] mptcp: options: handle MPC data + csum reqd +
 no csum
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mptcp-opt-mpc-csumreqd-no-csum-v2-1-dbb52e01a36d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ7CIBREr9L8tRiorbGuvIfpgsKnRS0g0EbT9
 O5SegF3M5k/8/4CAb3GANdiAY+zDtqaZMpDAWLgpkeiZfJQ0vJML7Qmo4vCEetiUoKIMI0e35I
 YmzU5KVbVirNGVBLSiPOo9CcD7rB3DUZo9yhM3QNF3ADb8aBDtP6bn5lZrvzLnRlhRHQll7RrF
 HJxe6I3+Dpa30O7rusPTdDVIeoAAAA=
X-Change-ID: 20260805-mptcp-opt-mpc-csumreqd-no-csum-3f145fa19c4d
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EjCht1h9T2RhKiQn4aVCRiiDCD2gP8TY5frpSO+82y4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKKAw/ph5hc2vioLkyp7uzMy6yvXdoSirc/cDcR60qWu
 1taOqm4o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLq0Qz/VH5G2t0KexD4lGV+
 4IbwnJD5ZzZ80Yv792LDBt5PTtH98xgZjiT++3wkKGZScVFzA0Pw9TdXujuPvft4PlT+3meVKSu
 m8AIA
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
checksum flag for MP_CAPABLEs not carrying a data-len.

Such packet can be seen as a 3rd or 4th ACK. The RFC8684 mentions [1]
that the 3rd packet should have the checksum flag set. When an MPC + ACK
contains data, the checksum flag is redundant with the checksum field.
It is not clear what should be done for the 4th ACK, nor if the flag has
to be set if the checksum field is set.

Therefore, it seems fine to only look at the presence of the checksum
field, not to break the interaction with stacks that were not setting
both.

Fixes: 208e8f66926c ("mptcp: receive checksum for MP_CAPABLE with data")
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-23 [1]
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=1
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- back to my pre-version, only set CSUMREQD for non MPC + ACK + DATA
  with a longer explanation about why it is OK. (Sashiko)
- Link to v1: https://patch.msgid.link/20260805-mptcp-opt-mpc-csumreqd-no-csum-v1-1-cb2ad0b9feac@kernel.org
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e1b38fe5faf8..73cec164d8bd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -93,7 +93,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * In other words, the only way for checksums not to be used
 		 * is if both hosts in their SYNs set A=0."
 		 */
-		if (flags & MPTCP_CAP_CHECKSUM_REQD)
+		if ((flags & MPTCP_CAP_CHECKSUM_REQD) &&
+		    opsize < TCPOLEN_MPTCP_MPC_ACK_DATA)
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 
 		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);

---
base-commit: 064fb643fcfcdddbad6da71da8f1ab206f018af7
change-id: 20260805-mptcp-opt-mpc-csumreqd-no-csum-3f145fa19c4d

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

