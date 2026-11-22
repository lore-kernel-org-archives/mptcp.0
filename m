Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318674;
	b=h4orhlFSGMYnLFv/k/8o0RFhEuu8yoiSe3n/aShbdT4eicbYF5iCFqFEqXIdPtB6ZTLu
	 U8HokA1RATPfIFYXE+uDQ7F3yK5Vex+Ql9tPy9+wo+M3eno/FkAU2vVKgS8RbLuMQTqO5
	 HvRHuZTZju77ze5N7Wm1XNeEGkrINXymPACaC8o3urMOmPQLOLbHyQxik834XOyOo3leZ
	 4OZ8NTFQaQ1rX+GxC0uK2BlC0JQ9kFcyE7NjczObLt8FO9jWl9FR+MsVKxWzWdFn5onzt
	 GdDHShCa61HfV0xGZ+YUZ2XWIaTUk9UYO6NvwaHVZTtGctAvAXtXxh786sthAidN6DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318674;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lpaoj/wjlPmF6aFG5CKAYVXkovx9kP7OB8aAwOinQJM=;
	b=hFIeMoSSwRIAIpiy1QuYw5KZck8E0P71xrD81Dez0tq4bYn1fHuaMYABt0H67VuJVwBe
	 vUP09qSQkww938B1Vr4oqiVFJZWhoL31AoDyWJqDyBaisdSb2CmT1pOm0PuS6R45L5aPQ
	 2dObOTwAHWQUat93+RNXDUjVGE2cgO9TZVbsD35FrSxnN4/FSjZRTfVR7kIpYO9n2QvHU
	 LdURHQ2TZwDul4O1+aFKg2LVEuAY51pbKwsgATz33S7d+mwddA7tIV8M4PXe7FDzXxfwz
	 mwWEURHjE7pJu3WYkaxB8zIR0YlBUc0GHbcxzdLZenjs+59TiTuZm40wMGdYjPgI2EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0yipkcv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CD606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0yipkcv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEBA1F000C4
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318673;
	bh=lpaoj/wjlPmF6aFG5CKAYVXkovx9kP7OB8aAwOinQJM=;
	h=From:To:Subject:Date;
	b=V0yipkcvUFMchaoMgPwIgSiTOSelPO3BBQeyxluYstPadhGXBa9Hr5kMX6OJ9Pc8A
	 m972XZ6loD/16fGhQNWnCkvDmFbevdTgTawSKJ6cSfGAwnmugEAKEM3cmQOvfjnUhD
	 Pcr+Ha1RDxJYP5iLXeYsMLOkAsbUBoJ6P3rGFsu1rD4zD45Cb8C/7oGJ/EFrojO2Ph
	 u2S4lxb3feytyj+Kwc4UI6tA7BoSKN5p0t+7kQDtz5x+fU74YNhsbk2Z9IRrLJ9SgG
	 fV/mcPGHZytxhSeKZXVkCHQmNkuJIqyxrBmanvzgm62jjAYGhiUMgBYsw0h2u/ZXeq
	 OcoebE8ERp/oQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/4] mptcp: fixes for SIOCINQ
Date: Sun, 22 Nov 2026 11:37:45 +0800
Message-ID: <cover.1795318567.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
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

From: Geliang Tang <tanggeliang@kylinos.cn>

The goal of this series is to make MPTCP's SIOCINQ fully consistent with
TCP's: both report the number of readable data bytes, excluding the FIN
byte.

Patch 1 fixes mptcp_pending_data_fin() to use >= instead of == so that
DATA_FIN is processed when ack_seq advances past rcv_data_fin_seq due to
OFO queue processing.

Patch 2 adds missing smp_wmb/smp_rmb barriers for rcv_data_fin_seq on
weakly-ordered architectures.

Patch 3 fixes mptcp_inq_hint() INT_MAX overflow on passive TFO by using
mptcp_data_avail() instead of ack_seq minus map_seq, and introduces a
mptcp_data_fin_seq() helper to guard the FIN byte (+1).

Patch 4 adds mptcp_inq() that excludes the FIN byte, matching TCP's
tcp_inq() behavior, and switches SIOCINQ to it.

Geliang Tang (4):
  mptcp: handle ack_seq advancing past rcv_data_fin_seq
  mptcp: add missing memory barriers for rcv_data_fin_seq
  mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
  mptcp: add mptcp_inq() for SIOCINQ

 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 55 +++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 16 deletions(-)

-- 
2.55.0

