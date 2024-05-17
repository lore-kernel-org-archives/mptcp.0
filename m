Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0D158D6C
	for <mptcp@lists.linux.dev>; Fri, 17 May 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967669; cv=none; b=q0bt6xtgJclB1wGVsCxCwxnKhQV6/TmYi0zzxafaukFLktwrK99NyLSx6/kpkcGtkvHlujFAlNRUk0OnIYJME/PkjBTHN6UNMs/TxX9iUHhb5SJ1h3r0D7HL8uLb0AjQTe/TDB/PewAg9SUdMnWKU6Bnw9fGH1JpKnSsa1Uviqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967669; c=relaxed/simple;
	bh=QvAXCGpeeMW14o/72Et6cpKOSgq6IzBqKq3q3bXDhGY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mQjuOhYqnlqRncBN8avG/ij3Ymug6mhngjnkIbbWAQCJjR3zck1zkLPYtrkcUYN+aS9P4nX/TGxzixyTg+Hxj4l90SyqAVRZ0UIQCI6DYTsl7phEo8NmIiYE6jz6FXWlVfCo7AGhmr4U+yeQ3XZQymvRJtjK/g41i2UKing0CQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTlKu+ZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTlKu+ZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FF5C2BD10;
	Fri, 17 May 2024 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967668;
	bh=QvAXCGpeeMW14o/72Et6cpKOSgq6IzBqKq3q3bXDhGY=;
	h=From:Subject:Date:To:Cc:From;
	b=VTlKu+ZV/7Hnhp9yiQPId3114gO7p1VlxTrNFsIdQO/esMQzBY5wIl+Am0Jl1reHp
	 oDnBrlEP80lthhxLgKcgz6u4kPksoC7PEISsxaV+UO8DoqdzGLmR30/IAbUZzToHUf
	 +a92IjAhd91qfBCrd06/8yZFpuDbizz54cdjwVkpdFeYDrC/TfApylO9harN+B/UjW
	 P24TVyVg4/g1QmUDH6Uu1D43GZioeVPA8/uB6SDw2Go51YKk8xSUZa6LIEqzzHVfUj
	 ifev3ouTclEQ31KZOd2wrKrykzyRVWsPhwaTjlB8FD8DpXzDD+KvuylLTkSslA+pd0
	 G6JLQy9DZ7XQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] doc: introduce MPTCP global doc
Date: Fri, 17 May 2024 19:40:43 +0200
Message-Id: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJuWR2YC/yXMQQqAIBBA0avErBPUlLCrRAuxsWaRikYE0t2TW
 n54/AoFM2GBqauQ8aJCMbQQfQdut2FDRmtrkFwqrsXIjnS6xNbo2CC0N9xYIZ2C5lNGT/f3muF
 nAe8Tlud5AVnzyZ9nAAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QvAXCGpeeMW14o/72Et6cpKOSgq6IzBqKq3q3bXDhGY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmR5ayuujV3Db/Ha94eKVDvM3UEtbkWF5tlD1Mp
 7tYClWiPVaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkeWsgAKCRD2t4JPQmmg
 c2PwD/40xtGRenNKtuZqL5eDJr4MfLGnYvYR7poa77QNDguRbZEsflYl4ApCemTBKqARZRud9c2
 0bepgJAKjULiOlqciqjboxECuKu002u6DdAM6F9hy8v29RgI5HXtu/HuxULp13iS0Iz/AWiZ3uy
 3pWLLaANa5sTdanBL69PwFhQL+5AW8H2xWXhjziVHYg8Xq5RfuuCR6XiHL/RS3HyNE/3Hvb40qK
 1JGlFEmuVzoX0NB4bILbuFkkeknxixw11i4iMYytTZc7ByUvY9OCrQg24hKg6IWjlcacXgrRqSS
 Axst+hMz4osC5m8Ti/hQ6D3DoCV7uEL5PwEIy485u8MgX1LKFWZegdqR0pWSSR8w6/aQjM4UIhN
 LVE4kfzze0XD+uu9uwgqYjlJTV+B/T5XOWU+EuTudkXlQEBRzf4AJ6bJKNSPkjEPeSCCRbUB0d1
 XuvqlfDeWB2mtIPCg6AK+JXjU8SEzVL4naY80TnitIq9JfqmaC+YeNpWtOTfslIenvye3iuJLCC
 e2FawGlcjhPvUCTsJmVjviXGJQZl487HCrWorIlTKVRvvR5aj2rCHx8FD5fM74YpBaQmKDxIZI7
 gY/cGpEb1V81I/35ckK7efGOfpHlouSrvzMkSu7fEqyQUglfbzmS/dNVz47fYAx9fLMblkZXrj6
 AIPrA4MzTqNlC2A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The most interesting bit is in the last patch: a new 'mptcp' page in
'networking' documentation.

The first patch is a fix (missing sysctl entry), and the second one
reorder the sysctl entries.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      doc: mptcp: add missing 'available_schedulers' entry
      doc: mptcp: alphabetical order
      doc: new 'mptcp' page in 'networking'

 Documentation/networking/index.rst        |   1 +
 Documentation/networking/mptcp-sysctl.rst |  74 +++++++-------
 Documentation/networking/mptcp.rst        | 155 ++++++++++++++++++++++++++++++
 MAINTAINERS                               |   2 +-
 4 files changed, 196 insertions(+), 36 deletions(-)
---
base-commit: 2ccd59d4df6aef3f553caf11e00af66300448e63
change-id: 20240517-mptcp-doc-315f909a12c4

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

