Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF01F9409
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106475; cv=none; b=jxvLNBkPFBngH9v5QvsaQdYTbCPMNi7XAxOumtaJNlYEHf0wHv4GGZdY69l8p1TXqY3X2oXOJ7MsoznJsRqhzw08oO2Ums4VCTC3sQk3XmnJ0xk0mV3A741dmYFjy97kyBIrwDQmcRYE4OCc9gzvY4hOExdHY0rG7SnEEZSg09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106475; c=relaxed/simple;
	bh=BOhXJ2oGVRv/rpYXSZaBLHgY8MqKXDjSqdCbWK/+8rU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UA8nLUFgo10bsZ1bulNoAZNd5e7ARltEC3Abqjd70H2jtDy8IDEs1IjK0QYqrW47DIw40fk9CBOiWW3vConkagRSog4nD9RSD+lLm+Qi0UOIhyWa7AqDF85GokeCjQUQdokdsw6YrzK2PGVXNtgCoubGwPyRDeiw6P+shvvhAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKQzQLzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKQzQLzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AADC4CEDD;
	Fri, 17 Jan 2025 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737106474;
	bh=BOhXJ2oGVRv/rpYXSZaBLHgY8MqKXDjSqdCbWK/+8rU=;
	h=From:Subject:Date:To:Cc:From;
	b=dKQzQLzkFQeoSlDBGD0b7X6p9/7fuo5K3C1rUOrFuVwrhPJMq9r8jWYw3GVGSvedC
	 F/FsxP8uj4qFhEaeg1lG4FGZkuHTtt+CDBVKJVdCjMdcSzioGKr4MGtOkKjK1hd2Vl
	 8oEB5oj0JAKVWa9nIj/n4gHI9UjCFAwMsJqgCrcmQ8vJESBm2bpk7KO1MtXO3wrYAG
	 7G69H7zO9LAl5S7Vr4pDygze3KiUIXtJrYZ8LN7a8Nw8GR9eInBdN+I5C4A4EkyrR2
	 f4ZxdSCcwjVS4jCYMsL53VsytZ1XQOj5FWg1crwzEv2yh20jdJNC41DnL/GX1y73Ui
	 Q+oChaal7cmcw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/3] mptcp: pm: only set fullmesh for subflow
 endp
Date: Fri, 17 Jan 2025 10:34:12 +0100
Message-Id: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUkimcC/3WNwQ6CMBBEf4Xs2TXdUoh48j8MB1pW2KiFtEg0p
 P9ug2ePk3nzZoPIQTjCudgg8CpRJp+DPhTgxs4PjNLnDFrpShHV+JwXN6PE+GKsjELT9NTbsjR
 110BezYFv8t6NV/jBnhdoczVKXKbw2b9W2oG/2pWQ0CrbaUe6Znu63Dl4fhynMECbUvoCFO7eC
 roAAAA=
X-Change-ID: 20250116-mptcp-issue-540-49d1db3346a9
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BOhXJ2oGVRv/rpYXSZaBLHgY8MqKXDjSqdCbWK/+8rU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniiQoq4JUTMhg7cphtKvlSKgRBoPgiRAwkYNbq
 ceXq6abeJOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4okKAAKCRD2t4JPQmmg
 czHrEACYLN71X41gQWCWajvUmh2oDpEqXWNz0Vu5VF9xM+z+UjFXBIIhfZENeFGnbH/A84DMw6O
 f8XTSULSlM0AVHeyyix0GFfQGI+0ajbiSmXRZZYU7wTmTadnNdPL8xEXFew8c+ltdqbLu5GhZgj
 mBf5RkDUxp/yRMpfRsq5gVRYigMEaHuar9Tq7Gs4VaPfjlXQudNCerO1zVaCaEsdSDhAskHIfMt
 iskXiNoUDqGbnzFpp5MEBK09qNp+QD85QpLCNub2xtLtDker74p/jHEPh95I8YozCNWDzYhqG+Q
 Jw0oyjZndlpvra2jmcDUy+PU9jBgqEXxw2K51TvVipaJKXohjII9nLkxaJVf33qEeVNWo7m+NFU
 K9Ibuc/5uebkfIdiyFxK7TtUlR6xcR4A8sU/Ik7xlX2pXubTfvgfIESFb2S37hItwghgh3ltAdS
 qukfkitgfyDMKXDeJcGW9c+28TNcAm0cT7pj+Pad4h4iwPH1ZYY3+92RMRr3s5ext3qaOcthkpk
 HzAh9eAzgUrfPsaxyJmTAzjmrA0a18Kl57R8HKYfpOiTceKxL2oQjD9eSrLNbNEfRtaZfJd5Tyw
 m3L/EeEZBTl8U7LzUvgs/kgF1+79/eXu071O02pfkfonhObKRBFFMeBLnspTvkrlHXh0PHqqU/L
 /8hv0TYozLIQs9g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few patches linked to the 'set-flags' interface with the
in-kernel path-manager.

Patch 1: a fix for an issue reported by syzbot. For -net.

Patch 2: a small cleanup. For -next.

Patch 3: a small optimisation not to iterate over all subflows to do
         nothing. For -next.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- patch 1: check the two flags in one instruction. (Paolo)
- patch 2-3: new patches, for next.
- Link to v1: https://lore.kernel.org/r/20250116-mptcp-issue-540-v1-1-b0ba2c126eb8@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: pm: only set fullmesh for subflow endp
      mptcp: pm: remove unused ret value to set flags
      mptcp: pm: change to fullmesh only for 'subflow'

 net/mptcp/pm_netlink.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)
---
base-commit: c466642ac4d22d6f294d669d8a1a3535610cb45c
change-id: 20250116-mptcp-issue-540-49d1db3346a9

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

