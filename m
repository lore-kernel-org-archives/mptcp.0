Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557718;
	b=iPj+klbIyoMTTLKCRBHU6v9lELpaNwU4XRjktUOYVMqNQWT1794KAoPrq2PMIQuy5LDT
	 H70G8QAFcgAXwvdEqIEkfcsrx1Yfmt49g23kbg5+ApQb/G8rZD2dtFITJWmJV2V6F9m8L
	 DtaKsuNI4zD3kDV2xo8doypRNepy67nA25GowjgEfZ4LtEB6HDDDYwU7KBOQHQYd2PJ1I
	 KPMiVezVb8eTySsPxAhNsBgcLmvTSjYVqGgkLO5xQ5evucacelC/T63Hnqx/sCUnp803P
	 78HO1L4qzUqICa9iQvCBAcaR7ZZDBM861GUev8iyXddZ8TcCforIIuw6ZAoTGd2T9eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557718;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GKy4IzqPyNbbe/Z9k7aHJ2BdVCuLhUY3DMyghIU6m3A=;
	b=pWfiP1Qk0VjEi+QmO+ZzxfpB4v0dn7EoCkMGViQkgDtk+M111NUmwi+3DQP1BsKwLm6S
	 IdeG0v0cHTH1MZXrOa4rsi95s/RxrDgF3JomxUlltn3BKSrFRfJA++MZTxvA9V1Vnv5E4
	 j9O4kkSvefpfqWb4xV1nk7Rs+x++3kMFqV48eB6PsuDLac11fWlQ2w3nS0mS+JmkKCERu
	 8S4MF6ESRq2KC/0GWuTUU/eJsSB3FnYsY4OTCZ2uodraLk+OXvPVmuvDSfNw+e0WQkpMq
	 hVPctDFIotNUOKtIrc6DP5XXbq8NjqPV4Mm7r8a/MXdHAhVl0O9/K+D1vPsoQK6CaRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFKvQLB6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DC606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFKvQLB6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81AF1F000C4;
	Tue, 24 Nov 2026 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557718;
	bh=GKy4IzqPyNbbe/Z9k7aHJ2BdVCuLhUY3DMyghIU6m3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aFKvQLB6D7oyubjHLgh4/FFmBbXvUeG2sMG9e01cI50knY+2SQZz+WP+pchhL9OwL
	 iG4keA0VjiyGeeCvvfQYub43d8DwO7eHilmzY4jAGwZs4eg3ozXSng6UoIZZGd1uOW
	 Jragh4UQxumaQ0VcG/o21pVAjysY1vrkhN2sP6pI863UfWm/OUCxs8z2mTyZ49mSBH
	 V6R8iTuXtjACXj9sozAOA7NwIrDuTLY8IcBI+mBrmSHMKg4qyVp22Bo77KCPS0ovBg
	 UDW1GXQ8+EjC+GxTshnEmM63SU2wYpo3JoDeRIVzwwt7zBviITqeN/nfWq8nPPrfcJ
	 bqBIhwI9kmSsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:06 +0100
Subject: [PATCH mptcp-next mptcp-net v3 49/50] mptcp: trace: name all the
 mapping statuses
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-49-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gyak2MPogMH+dV/UnL8UcZqNnchGm6wQy7IX9HHs9sY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOMXC8guznJ71G0z6/kTwncOGTYHvGjZN49jKtFRm6
 W2h9C0MHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZVMTI0OYRXVfhsWOxnfGR
 l7ZsfCpHlD7pCnHcka3W7jNwFP67h+GfwnG9jKgpa80ULrFYnrnAZiK+IfnB4i2vXz1pmqMv3nC
 RDQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The subflow_check_data_avail tracepoint prints the status returned by
get_mapping_status() with its name, except for MAPPING_BAD_CSUM and
MAPPING_NODSS, added later: they were printed as numbers.

This has been found by an AI code review agent (Clashiko), while
reviewing a patch adding another status.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new, for an issue spotted by Clashiko
---
 include/trace/events/mptcp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index c47fa2672b84..ebc7408c1fa6 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -19,7 +19,9 @@
 		{ 1, "MAPPING_INVALID" },				\
 		{ 2, "MAPPING_EMPTY" },					\
 		{ 3, "MAPPING_DATA_FIN" },				\
-		{ 4, "MAPPING_DUMMY" })
+		{ 4, "MAPPING_DUMMY" },					\
+		{ 5, "MAPPING_BAD_CSUM" },				\
+		{ 6, "MAPPING_NODSS" })
 
 TRACE_EVENT(mptcp_subflow_get_send,
 

-- 
2.55.0

