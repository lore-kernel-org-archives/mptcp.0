Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D213D276
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754763; cv=none; b=P78efkR5NRDEe2aXNO955et5pb+Z9wmUJWx6Mnho6Qlw14aGUqgkpBtCE3sWghXRnO3N+dXVmWgHjPSEkqsGteU8UERRHqsBVpf1D6TFQNKZ8OmqZKPXOO0RoP7UqNrf3m5w2a4T5ZhcL66FaC/2e+kr1ayKAQs0WDlADbq2VaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754763; c=relaxed/simple;
	bh=vgUGTwPz/t7fWTsaJg/df/Z3AA/RmRY7kgG8m6Rw2tI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mp6ylBGEyIcyIcAfXXq3mfnqXnPHcXusmi+KDV1isWNUKJ7N8bQcD3zEDwgFzJd4hS75YoGb/CBRUDU7tjRkFr/6QlxIUacZOGL+LrSM8XTQldtkDmHLkBVqJjsdkCjcPFaHMaIH7/hPhh2watnnFpSVEgUEU2U83GIStSpVOls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxzN5k1I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxzN5k1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45861C4AF09;
	Thu, 15 Aug 2024 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754763;
	bh=vgUGTwPz/t7fWTsaJg/df/Z3AA/RmRY7kgG8m6Rw2tI=;
	h=From:Subject:Date:To:Cc:From;
	b=UxzN5k1IpevYytkvptV2N6c7nm5sNu7ZWG3srWxoEpOaSCj6hJAQzQQPA+0rk9RdK
	 eumwX3mLhva9WyxBMeKLhJfrQR85/CWL22yVCtiJVxUuTCiX9PkLtFFbHupU6+UxkY
	 ehIAW8LOWmvTKFiYsuHpU5I9jRsyzbDNrzhdcYndEh80646TBbaamWzZO0MUKYb3j5
	 HyoCDoS7LpYPSzNP/EcN3pAZXjNvWX1a/7kAEl9c+HYSO8sPPuWir9KWwkKSBuP+in
	 nx1euICZwynJNfbr7pSi2xBYty3bTSzwnkrgbho9yeKS+LVCiYOh+i5cQpy6ApuoUD
	 3v+0955h56tgA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 00/10] mptcp: pm: fix re-re-create the ID 0
 endpoint
Date: Thu, 15 Aug 2024 22:45:41 +0200
Message-Id: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVovmYC/yXMQQqDMBBG4avIrDuQxIjSq5QuJP7VARtDEkWQ3
 N3QLt/iexclREGiZ3NRxCFJNl9DPxpyy+hnsEy1yShj1aBb/obsAk97YLduCYwjM2ynDVw/9NZ
 QlSHiI+fv+qI/8Mj0LuUGIMH2N3AAAAA=
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vgUGTwPz/t7fWTsaJg/df/Z3AA/RmRY7kgG8m6Rw2tI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJPIFZLs5VWJ03pIEpdpiIKqvCs+HYkc1FC
 /ZMAb1zQ5GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c4V5D/4ri0wrfbtNjLlfQZlnFS8M9Ov51z1PFTLglWrOqBbnEf2NnxwJWrMlTpU8iphCg1uQaZ+
 ax5iIounRmoUjsLZ7WONZYROe3E/ZhupZRxVHR3Es+gp5GXoTI16B/L0p2/GeyVVkomt4LGe9Uh
 4MMfp6Zwhfxif7MF7l04j/F2As4c3dHsyrbtAhpA0aXptRlXYV+CsX90AQ2JwBTu74IOYqrLjzo
 lPDeCkzMM14U8Vnnsy5y87+ADqPPZ8wfFkpVYQdMJYzfLsZC+JSnE4fPdDoqYKE0Z0h51V+ntT2
 WJT3XOL709hC36c9nhOaVfty++sowtCjHBESkT8lBTOC9How638gtR8iNHFSQtKGRDg/figXrqr
 kog7pvjKptdIDO72J3TV5vt+g3kVL/GRGe9rUbfAAH/RUqwhEndZjDnjP/74PYsPyiuKpNKFZrK
 5SWeYagDVzkQZwxdGhB3CohPR9f6qYQhK6TguNDlnHJWu9k79meTwiwt+9AW2rKPbyQWn+jj9hb
 uKxw3oinwHL5x+ShMiRlEzOIvg5GUSCFgB0JnGLsJOmPmxMORbFB/jQxODn+ZqNkWX8og6ckhHT
 38qeQ4IePeirhqzIMal/IDWYza1hw/B4z9pc3J0PbNFZxflLKPH5pgpAWB6IyPebEaYTUbfXeu1
 gQujAid3quDq0ng==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Even more fixes for the in-kernel PM :)

There are a few Squash-to patches fist:

- a partial revert for a previous Squash-to patch: probably fine not to
  block the send of the original patch then.

- improve code coverage

- small fix for the fullmesh case when re-adding the ID 0 endpoint

Then a few more fixes:

- avoid the RM_SUBFLOW MIB counter to be incremented twice

- fix re-re-creation of the ID 0 endpoint

- validate that in the selftests

- avoid duplicated SUB_CLOSED events

- validate that in the selftests

- ADD_ADDR 0 is not taking into account by the 'add_addr_accepted'
  counter, then it should bypass 'accept_addr' & make sure ADD_ADDR 0 is
  not sent with a new address

- validate that in the selftests

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (10):
      Squash to "mptcp: pm: re-using ID of unused removed ADD_ADDR"
      Squash to "selftests: mptcp: join: check removing ID 0 endpoint"
      Squash to "mptcp: pm: reuse ID 0 after delete and re-add"
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      selftests: mptcp: join: check re-re-adding ID 0 endp
      mptcp: avoid duplicated SUB_CLOSED events
      selftests: mptcp: join: validate event numbers
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: check re-re-adding ID 0 signal

 net/mptcp/pm.c                                  |   4 +-
 net/mptcp/pm_netlink.c                          |  31 ++++--
 net/mptcp/protocol.c                            |   6 ++
 net/mptcp/protocol.h                            |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 134 ++++++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   4 +
 6 files changed, 157 insertions(+), 27 deletions(-)
---
base-commit: 41b6d36c6f0efd987c937a4cc70cfb55be460e5b
change-id: 20240813-mptcp-dup-close-evt-e4512ec78742

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

