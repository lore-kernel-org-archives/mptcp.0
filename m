Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7D2C194
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307010; cv=none; b=XGW4M39f3VHaaJlwl+i7AVM39AIDsaCfqnVB4dJbgsJnLPUyrOsbXOWujCEaJUqkbrhBHaXx81eNcQslUao2/cDCoFGjr/fGMgPlJOtPXqx9IcH5uyLxmVNV5GGGbNJLNIaOT5YjsXCZhInsQfjtiftz6kVimIcz0wEPLqeD72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307010; c=relaxed/simple;
	bh=12TZTcf2J+kL6MzUG6BnCd6OvMgOMPOx4ASGmWvOlAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CM1SMIScjFujJ6zTfqriIBLGKQmkBsrSaNLyzNSOENYhu02Fx0ZI/IU+dkcwxEn1diIs+FZ0e/V6H/fhgw/hB9gVoNuwDpw8Rd+irNq1ESjv1Ar3Z9w8iK83BuIuRzhw8luVWL8U72Z7Jrz18uVwKE00nfGqsaPjRgNzVhL9KPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEDq/dbZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEDq/dbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36763C433C7;
	Wed,  7 Feb 2024 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707307010;
	bh=12TZTcf2J+kL6MzUG6BnCd6OvMgOMPOx4ASGmWvOlAM=;
	h=From:Subject:Date:To:Cc:From;
	b=vEDq/dbZ+87TBJI3l3deICu1dEl0Wrh2z6XR8GAV0tkde1PP6sKiiKCoo/DiGNFzh
	 NdjYnaq+s7lGbsKse6S8EtZurzqD1yw0bQFHnQfczkjZZIX2tKSrSs9xDV1IhpjOjF
	 mjmHusTJy1QO96uCxVPYnSa2Nood7XdX7/HxyfH8JbNCNbUHjrb6rxWfQEl1tvzqP8
	 HFaaCqWDYdVf8k8C3xWkaNbyw1nTJNzTTBMrr7w7cuXswjoF5O1rQmcECeJRA6RQxi
	 JsrpxaBZTttcV92KIMeEy7lGnXksUNhSR62+hBx0+jAt3qZUuBSms041PgXAsDuVlB
	 f9sQBFKcjkHAg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 0/3] mptcp: check the protocol with DEBUG_NET
Date: Wed, 07 Feb 2024 12:56:22 +0100
Message-Id: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOZvw2UC/33NTQ7CIBAF4Ks0rMUM0B/rynsYF5VOW9IKBAipa
 Xp3CS6MC12+vHnfbMSjU+jJudiIw6i8MjoFcSiInDo9IlV9yoQDL4EJRh82SEvlhHKm1plgpFk
 oCo6V6KHsmoqkqXU4qDWzV/JeaFwDuaVuUj4Y98wfI8sX//HIKNAOaqibAe49nC4zOo3L0bgxi
 5F/FA6/FJ4UhrwSOFSsbeFL2ff9BZAUGI0LAQAA
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=12TZTcf2J+kL6MzUG6BnCd6OvMgOMPOx4ASGmWvOlAM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw2/8cvr/WjilogV5RlUO6KkeX2LOwUVYn+bQ3
 0PBT3Mb7u+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcNv/AAKCRD2t4JPQmmg
 c1yOEAC5R3fOBzqTD1uyE94+oQVEClq9P0TCWJoqGwVo1t0trKtOKyS9ZPMzuGC9J/uwySRfMvv
 MuE/j7ZtJJwu3yEy4rXqSXdDW7mt45B3a4mjrQYm5wYlzFagkSo+Uv3SiSyhF78t/ic5yPhEUuf
 mV8txIg+Ea8QUpPIz3mtwUA9qepdCK+9d9IBtXCZxhnYDYhqj3OGT7ap9p5sgAOuXcGjx8oFNoI
 xbhtcZ1MgBa9S/quEIk4bttHjRIRoxeaYmQolNIV8avxiP37LVG5RApTLUO9fH0WarHfUPuaBE+
 U+NsC/cxCkf+wsLvebASr3Yd0cVCStfehd1SuyUJj1VB1MKvqrr3jJdYQrVMGSaPSP5M9Gv3xLn
 Vrwkj7MU+4KjCEVa66cda5x7Da7O4bP6S9PRzPHI4hIrI28I7J2qG509l77ctOksKSW0LoaWnQB
 wwCuhBtdJ0ABHMIZF6aMZwI9gLUIKHkKce05zbADPfA+v0apNBgxLqBccCrOsNK5GwxKAG5M6VR
 UfCeJ7iEhOJJEviyp2+CQadWnNg0lJ2XAt8zS6qwulLApqA9Igh0J3/WKUhsFoAhhppisE7Kae4
 4yKUY70arP4A4BMfq4HfP1qmhL9TawTJ4KhV46UVm9kVblHMm/eEIq/Bv/v6mtdhpyAF4rha80C
 7yd/Vp0LE6mjmvw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, Paolo fixed a bug where a TCP-specific helper was used with an
MPTCP socket [1]. The bug was not detected by fuzzer or static analysis.

Following this, it has been suggested to add a check, only in debug
mode. This is what this series is doing.

The series has been split to be upstreamed: a preparation patch for
MPTCP, the modification for TCP, then for MPTCP. It is not clear if it
would be OK to add that upstream. If not, we can squash these three
patches in "DO-NOT-MERGE: mptcp: improve code coverage for CI" commit we
have in our export tree.

Note that the MPTCP Token kUnit test needs to be adapted for this new
check. This is what is done in patch 1/3.

Link: https://lore.kernel.org/mptcp/35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Patch 2 and 3 have been modified, please the changelog on each patch
- Link to v2: https://lore.kernel.org/r/20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org

Changes in v2:
- Patch 2 and 3 have been modified, please the changelog on each patch
- Link to v1: https://lore.kernel.org/r/20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: token kunit: set protocol
      mptcp: check the protocol in tcp_sk() with DEBUG_NET
      mptcp: check the protocol in mptcp_sk() with DEBUG_NET

 net/mptcp/protocol.h   | 14 ++++++++++++++
 net/mptcp/token_test.c |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: c2469b38e369c3f2b9577beeb9470cc757abc1b9
change-id: 20240131-mptcp-check-protocol-e32e53d04a75

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

