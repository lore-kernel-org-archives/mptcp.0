Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCE3112BD
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656871; cv=none; b=IpPE1fxZN5j+knRJbZb5M0XLb6JNIZr/oTzYmH2WW6xLGl6wmACjTSEqvuqxMKzezld83Cq/UB9Hr4W25mVjSrs7kuyoAXLlLvDtbsW0LlyLWQpAApZaZQKWzbrHb6TfAxH/TKVBWrjQXL+2ZIwIhbZH1pk8/+yBD2O8Dqk4/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656871; c=relaxed/simple;
	bh=ME5GtZBIozN3EIS0hDp02Kzh6uIOM81B3DSu8OVvaNo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YnfnkftUfG71P9Snlm3IisnFgvtTy1xvweJZbajrf67hofvkWFsDHuQCeQgwOat0dNh4y/om3sUb838sA1s9GlCfpFk53D9bjHDNozhczsqVxfJ4lei8qzEk/OIszGt7lCOy+iCiI4yrgpE7+wZ3UQmk4kAtDOVraAPEUQ6adRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6M1zxXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6M1zxXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC62C2BCB4;
	Fri,  1 May 2026 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777656871;
	bh=ME5GtZBIozN3EIS0hDp02Kzh6uIOM81B3DSu8OVvaNo=;
	h=From:Subject:Date:To:Cc:From;
	b=h6M1zxXaTgSJoJ3CIONG/momSdoloN/DC97XWomTSAlR8GdJVOnRgg/NYOKE66wPn
	 8274iSw5ROojM5k0I5NxTUGbUCaro7bQsakrp+b9OMVv/eoNrGSVvWO9xEfrtMC68i
	 81HrYi8sezZxuJTlbTis7pV3e6VZhlnYc5uzGyCiyZPKo4o2NvIFWmPxLJJfO7HKrq
	 FzX7BDs7ZA0ag22sKh9zl+4XNgZi8i0j2VJPFLDhHlto5HWHO9M+l3jUG7DJR5kfmU
	 /O2rmxkhXhIjwIL2/T5Vd+qm53p6sDzntKqt+7dZYGwjzuas28FPzpzpdkc7+9/qMe
	 k+BqP53iQhobw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] selftests: mptcp: small pcap-related
 improvements
Date: Fri, 01 May 2026 19:34:19 +0200
Message-Id: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQqDMBBEf0X23IUYMIf+ivRg1rVdwbhk0yKI/
 960gbm8Gd6cYJyFDe7dCZk/YrKnCv2tA3pN6ckoc2Xwzgc3uB43LaRoS0GlSVEzL3JgDDH4wVE
 NQ3Vb/f8doSmJjwKPttk7rkzldwzX9QUfE+IDhQAAAA==
X-Change-ID: 20260501-mptcp-sft-pcap-prefix-b6b6250c50ce
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ME5GtZBIozN3EIS0hDp02Kzh6uIOM81B3DSu8OVvaNo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/PFFa/6FplUjUIqk/MspdW9ZyfKzv8P4k0L09XnfZw
 wlLatTMOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACby2JCR4X3xS5bJS37q8oWv
 mjD94Lopn2W3bapdduJnGXulyxnzEBWG/0lJf9bd5rCbyTblaKn+7oyuFNHe/Zv+bi81dTDVfT7
 hGysA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

- Patches 1-2: add test name in pcap files.

- Patch 3: drop payload from pcap by limiting the per packet size.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: connect: test name in pcap file
      selftests: mptcp: simult_flow: test name in pcap file
      selftests: mptcp: pcap: drop most of the payload

 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  8 ++++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 11 ++++++++---
 3 files changed, 13 insertions(+), 8 deletions(-)
---
base-commit: 7478b1b74fb5013908a4237d3f929f3db03fb74e
change-id: 20260501-mptcp-sft-pcap-prefix-b6b6250c50ce

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

