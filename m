Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E859823DD
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490133; cv=none; b=cK1q5fPmlaZEdotJV6YVV5zUdRLiE2bnzte2hpKOl7vVE2hdZDgovWgr/QDT/LsZbQbJvyUAs2Q+v2vsGUByXACKaEOpUtQFCCPxYFmeNUBPZAjm7eInt30Qhta241fw1Dm32ry5Nm1YBP5ulU4tUirHy97uyS+BSb5svwHLV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490133; c=relaxed/simple;
	bh=bPHEZn6AKSQV4xTPaYLwjfHZpWY78Pyl1HWi4yUS9fw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KahOfHXF4WBT2EfQBgnzN1nRLF3QNgWjycLwzgLbkxbZOUsy9dKIKrK4nx7YVYx37hGXuHlLQnPS2P3+F66rdQbyi9Y5YdsEUhPgi9+WBz6v30vrCSi2GlTQYX3hc1CtO5nfPwqXhujyA/J+DKdOPATkJn79X9AfskVS9p5fK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMncggwi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMncggwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D92CC4CEE7;
	Wed,  6 Aug 2025 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754490132;
	bh=bPHEZn6AKSQV4xTPaYLwjfHZpWY78Pyl1HWi4yUS9fw=;
	h=From:Subject:Date:To:Cc:From;
	b=JMncggwiuIQIZN4KYzfOPaNc5v+ZXG2b3w6r5eWrDXac5KmHYV7gAUCfOT4CHZl/u
	 bxvCoz/qpLqgjdoxY6eQ0jelr8yj7Crlo+f+tjow62JTN5brP7QeEXmhT2CfDN8TVc
	 AwMBtlfY2/XACL+vD609/Ldxd6tvC5MoxabC/SPOJ8288MDkgME62lu7vM+XjOBSgD
	 KSv/0yDy0buOsp25WNgiLPHu9ng23nmGI5H9AJ+YIfmucJn2UxX/g5YpUZmUYZ6wo2
	 xT0DhlUm8p0oAi91G7PU2jrM7A2hrGxd/9vDizkG4UZOhiejVHARgmVZhY3dpEXvlX
	 Um2/CL7mkMsRw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: pm: kernel: flush: do not reset
 ADD_ADDR limit
Date: Wed, 06 Aug 2025 16:22:05 +0200
Message-Id: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1lk2gC/yXMTQqAIBBA4avErBsw6Y+uEi3ExhpIE7UIorsnt
 XyL790QKTBFGIobAp0ceXc5qrIAvSq3EPKcG6SQjehFi9Yn7dFbNNsRV9zYckLdKDl3tdGSFGT
 qAxm+vu0Iv3CUYHqeF+GZ93JxAAAA
X-Change-ID: 20250806-mptcp-pm-flush-limit-c5a2d74fc2ea
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Thomas Dreibholz <dreibh@simula.no>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bPHEZn6AKSQV4xTPaYLwjfHZpWY78Pyl1HWi4yUS9fw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDImpwpt+7JUunu3wcpChfdi3kcrTFtvm5skqy1+ssnak
 /22A7NmRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESEHBj+h25nv3bp1DXrCSGO
 Rr/2P0uaYVo8xyQ6ReqYSdQeoytaXxj+O10/tc772667ceqHDjHLrlr+9NvK6ofJX1ziXvlKum1
 0YgMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A flush of the MPTCP endpoints should not affect the MPTCP limits. In
other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
limits'.

But it was the case. Patch 1 fixes the issue, and Patch 2 modified
pm_netlink.sh selftest to validate the modification on the kernel side.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
      selftests: mptcp: pm: check flush doesn't reset limits

 net/mptcp/pm_kernel.c                           | 1 -
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)
---
base-commit: 8353c34f924e5fb87e86e5587e15df160add9a44
change-id: 20250806-mptcp-pm-flush-limit-c5a2d74fc2ea

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

