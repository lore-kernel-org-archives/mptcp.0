Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF213C3EE
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752293; cv=none; b=ppB/lcmdjkCcc4G8AMIM3B//UF7xokMYt8o6wGaRGXfJDszpG0cxYQ0SDO3YGGOXZ/d9SE/xK+niNK6HMNQP1nzOgT8kj9VtPz1eyQy7H8UwIsEPiRuMfsiNHbmIyA1Qq1B2LBvq/jqwu9s3knN8ECFMovxmEAruvMbvRNo1FEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752293; c=relaxed/simple;
	bh=apSMkqX6PlYgHFRluqpDHKw+wbmfYFw9YsE5MBU44Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbQNlxfTUrhk/ArnVTrcTpdveNK/YaYYQUuoNF4hr+JtDIffIxEFF7WTqR6ea1e6I8C7HfMrIuM3WDIlfzkt3Qak+tGnMO7Yrt5MfRQFf7vVUnV/bpCejlH5ZAXLCS74PhDCifx7LxCoJfiw14iP20mLC4yZWoKzjWx3TQpM7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoQEIaxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoQEIaxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC24CC4AF0C;
	Tue, 23 Jul 2024 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752292;
	bh=apSMkqX6PlYgHFRluqpDHKw+wbmfYFw9YsE5MBU44Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NoQEIaxMFp+yGimkoVAUrsrkJTNRGz7X0K09wsE1JMilqvM1Y2hRXarSorCfQYw2n
	 1OzPjXPrWZknVYKbEaWa10HFw1qfR4yZlKjlDjRT9Xz8y4/UJYdSP+QLK7yQMsG2ic
	 EXktzxjCKGRQrpIXPmIZsg2MZNuYHNjOgib3hTtcqPFTUchkJEApVPFM1ajWScLtxE
	 jjNaJLlAHCH3Q/jF3b8tCaLLessN21rOmACOSfIrj9kSxa+NMf/FhkYMbFEhx02Rej
	 F0hf2pLcw5JTZ5o4YMtzZCq6QQd7Fkc1P0NftB1FJEPNJdzdnKitAeVDpV9hcO8V75
	 IyqkNjvYs6eBw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 18:31:05 +0200
Subject: [PATCH mptcp-iproute v2 2/7] man: mptcp: clarify 'signal' and
 'subflow' flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mptcp-user-feedback-v2-2-59f18975401c@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
In-Reply-To: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=apSMkqX6PlYgHFRluqpDHKw+wbmfYFw9YsE5MBU44Eo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rgPSmd58lubH2NJlC/RoJk5x3Ct660v7/GB
 yqAFpH/CkqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4AAKCRD2t4JPQmmg
 c0XfD/9vW4yPAMkYxNCs6dH4FOcPjavXVXdNyFW8EddKi8NkOxU++bCYP7JPNbqXcJ1N5SjBGep
 wzMuN2We60R+dNEjmDS9N7e3qen70MSa8dAu87UJmmPsnDW/NiEOdIUcZg0qxDT4gC+cl8o63kj
 IyUDq/lSPDcKd7ytAfM10AMsM5hdkVzLzmsUiAxhUXEGHQTeeeHkP62zlUHy02Wev/AodCKz0hj
 lAtvdY0oGjVA7H5VTFabBbCt/qJYDcuYFakKmtRJ738OWXEd6AU8VXyExd/D4j/xG8RwOwvVBx8
 TRNMBDBoQoXep7Fo6IRsF9HvUgNVt4FG7UWxAI/sDp3HuyqdzuSSRLJoZgK06XSnOT7Bi41V4GJ
 U/V+V1javGJECLLcS87owPGP9frw1jex1AZch7E7W3XzPXR3n7o9faDXQB4hEx9JykeR1r/bRzJ
 Pa0jWZxz2BKaXtajsjjcgJwfKdTn2o92VbQsK1XXMWOy0ggBgTgFcDrE5V+fVfPRODZRqOs6j3R
 XZFBWSj69VHcPOTADVsqM7mLRHO0fLVacLpaDIu9IgDktWPKjn1ZTSZsq9Xx2vDWxD/5eSNKMVm
 O5wul/uzSmekJWJy4UoTQ8TaxP8tdK+PS2F0K7J0blCr0UPG21r1Wfom+bWR6H22VozfJTHmjxk
 pr4e9nLf0Q2T1Cg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

According to some bug reports on the MPTCP project, these options might
be a bit confusing for some.

Mentioning that the 'signal' flag is typically for a server, and the
'subflow' one is typically for a client should help the user knowing in
which context which flag should be picked.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 89fcb64f..2b693564 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -150,7 +150,8 @@ is a unique numeric identifier for the given endpoint
 .TP
 .BR signal
 The endpoint will be announced/signaled to each peer via an MPTCP ADD_ADDR
-sub-option. Upon reception of an ADD_ADDR sub-option, the peer can try to
+sub-option. Typically, a server would be responsible for this. Upon reception of
+an ADD_ADDR sub-option, the other peer, typically the client side, can try to
 create additional subflows, see
 .BR ADD_ADDR_ACCEPTED_NR.
 
@@ -158,7 +159,8 @@ create additional subflows, see
 .BR subflow
 If additional subflow creation is allowed by the MPTCP limits, the MPTCP
 path manager will try to create an additional subflow using this endpoint
-as the source address after the MPTCP connection is established.
+as the source address after the MPTCP connection is established. A client would
+typically do this.
 
 .TP
 .BR backup

-- 
2.45.2

