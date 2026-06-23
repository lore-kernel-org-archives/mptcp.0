Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD834AB01
	for <mptcp@lists.linux.dev>; Tue, 23 Jun 2026 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183380; cv=none; b=STDM5Jm7fu5FeModEZvIl7bZpgWZ0Lm8NARimGEQ+TQ/UjwkVUfPEo3/ZcfBqBcG1SK0fLYU0bQ3yh4FW6NV0dAry1mZmLT8SSHCwVBOMnYw2qicTJPzGUh5D3dXnNJE7PBf4UWelLJi+ovQa5Vs226xTJsqPRzPzmL8bM9gDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183380; c=relaxed/simple;
	bh=xJ+D0+2xkhlUy8RPkwthAFNgOf69nIdWqhX0ok010CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECexjSucMq0i7C5Z0mzRwWQq6wA4CqOb/eGumzf4YzG8v1rCzm3HxfmeJK6CykiunWVJSPhT0cRed560fr1wRGgHxj3ir7xMlJUQc//IoaspjLx4wFtN1sJ6+MkVzHJazmA8AAb1ARBRCq3CVJQA178HNdoVAUWUgkLuusGNQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF7N1zJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF7N1zJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817CA1F000E9;
	Tue, 23 Jun 2026 02:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782183378;
	bh=7lF9xxzxQdr82+d3HjlVMmjZOypc5Xg5QU/bh8cPTH8=;
	h=From:To:Cc:Subject:Date;
	b=cF7N1zJQlxewK+qTzV26t84E4qDKA5LZc3LP45u47k2LQOs9BP1sbX3yL8PPw+YOC
	 bvCxk9w1LBT7nlL9mm0EaKjYduSZ/xgvoxzHGV0b234Z9QuEM590f5FBNVjp/KBbUI
	 lcAYzyS3gUJagL5vYYAzlfLlmN8lh4pV9vxSzhfMo3ZXG28r50Zp1yMWqWm2TqENIM
	 PRTcEBIaOXyeCJRJ2juxQ/LpsqyuP321XQ3BW8+yjlkSGBdXqXSUfSX5KkR2LdK2HZ
	 CJg9e1LgO3GT9iwvFPYZs8QbFqYtdBiTP0riKu7jY9mFqkRaJdR9x4IygebL/otlfi
	 hkVych3pXklWw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] remove bpf_mptcp_subflow_queues_empty
Date: Tue, 23 Jun 2026 10:56:10 +0800
Message-ID: <cover.1782183266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set removes bpf_mptcp_subflow_queues_empty() kfunc and updates
burst scheduler to implement tcp_rtx_queue_empty() inline.

Geliang Tang (2):
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                                     | 6 ------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 1 +
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 9 +++++++--
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.53.0

