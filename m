Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C420126A
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361653; cv=none; b=utY49w4h7HURp7Ll63+rn+3F4D+ylsKQc3miuSI9e3t7R3RnZ4dhig/SQpwZwJTny+AKrvxa61PByaZjXcIHDa2QwwacUqdTPpiavMAZtnjh+6vy1uqPQy+Mckq+OrmPOdEIpK/az3abQ9S+f4L18wx/kdkfJ9Wa8oH+ZjBZt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361653; c=relaxed/simple;
	bh=mTW6JkSxVzk1rEcOBRZptH409j4KIfEelzbeUwH2AJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRCCbnG6qpwNXizmteQVvshSaJPKMBgkAbcYITLhLNlwfKmb4Duy1IkwffcmiBybq0/o0BLcJtuH8aVoQNDoumBiaD3AS2zpRwn5gYbKYeJIoxhrxnaLG2Z/hvMwul5tq9YrNmsChJksFWezLkGPurMdoRc7NOShTY1kHpJqgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mREegjDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mREegjDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FABC4CEDF;
	Wed,  8 Jan 2025 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361653;
	bh=mTW6JkSxVzk1rEcOBRZptH409j4KIfEelzbeUwH2AJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mREegjDCtwmbKVOw0byhd5eFcniEAzarGx0AOVDs0Snqs5JswVorXeQuyZAJpCeK8
	 3PNB3LmBPx+emYtc8VDSfEjAlEZFsEOBtHpiT0IiSjzWx8i5j6C/TtoWc9DdMdDTTS
	 nEtR8+xDircEyIV+C2UBOPvSsptqU89pE8Z6KIMw6uNXmTB5uVAaqWQw/ZfSV+HjJn
	 OsQERqR+aPSaokEcT+41XRp08HosoSPbahTucIv7EwZjOl+XpRzMKxwxtLJd2PiUd+
	 ux3YRZa0CvRh1xuFFl/5sNwFIChibzKwKbp4mzQ2J1tcMj8IHfvVdB7mmbyEaEG+zZ
	 3ZWIPMeSCDClA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 19:40:40 +0100
Subject: [PATCH mptcp-next 4/5] selftests: mptcp: connect: remove unused
 variable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-slft-mptcp-conn-misc-impr-v1-4-bdfbdba48a1f@kernel.org>
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mTW6JkSxVzk1rEcOBRZptH409j4KIfEelzbeUwH2AJM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfsawMB0uE7axkKH9gLBTyY/49uu9I5IQ/xyr9
 skKCP6t5ZmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ37GsAAKCRD2t4JPQmmg
 c/RCEADR/dt+oxI3sUKmyDJp/7DpzpIDPWRCTlPylE2muWjF8ga+wNOyZ2tzyXSWlcRI9Yjw5Dk
 Hnou4A+jgHnyDXmwsGL50oACu8+daIOEGQJlcrbIoVrsjzyAfgkcffs2g8COmy/EBvfDTpWJtX7
 MNK6zxid+ecXcnNqrS7BIPJBNwe5xiPnjd0YDZiuiFBUuI8/V4soX9oc8+1JeWlMDDkGCFeH8ba
 ODkdTJ5Qek0TnzDjXH6CSkhcKZk1BDdomnx/kld1JBSxSF5bP9Vqz+f0SW6DdUs2bLw+oLD4pFN
 hmhxcYjAD1GezVGOd3/EKqNN5FBLFizfZGHQt4uahZg+D6/X7NihtRGHGGK6mBxJTWbUXIIKmTk
 oAPCt4M07PVgfL3MZVJELjNLE+ePoIU0iQEqGDYr3ThboxpUh3L2MRqMtOso7WmJEbbKgwztJ3v
 XYREGKS9Grh27eMDkukZkGEB8NUg24oa+jSZ4l2lwn4Qg0dEMBit+oPL2WLSTSguebZWzvkRLed
 /08UYLzl5kXxoJHoJpCIzdppqpQEiru9dgXZ/hN/QAeTQNV40OXOjFnh6tB3ZZWYQ/X0ZJZQ7dQ
 C9/0H3fuU2WQWfkC1MEwiPko0njfDm67P1ctyUi9mzm/z5xFPsHIODAHRCSqunS8y3iPkMhHvvF
 tXuaUiNzPt8q8gQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'cin_disconnect' is used in run_tests_disconnect(), but not
'cout_disconnect', so it is safe to drop it.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index bfdaecd0a6a0564020530345daf91bed296bc15c..e508d356fcdaebbfb95750bba0fa834a8463e32a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -137,7 +137,7 @@ TEST_GROUP=""
 #shellcheck disable=SC2317
 cleanup()
 {
-	rm -f "$cin_disconnect" "$cout_disconnect"
+	rm -f "$cin_disconnect"
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
@@ -155,7 +155,6 @@ cin=$(mktemp)
 cout=$(mktemp)
 capout=$(mktemp)
 cin_disconnect="$cin".disconnect
-cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
 mptcp_lib_ns_init ns1 ns2 ns3 ns4

-- 
2.47.1

