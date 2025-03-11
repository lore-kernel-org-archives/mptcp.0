Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF253363
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674243; cv=none; b=BoT2Ow+X0rXiWRbaKSLBrS+CKSuZz7AmpM2YSSEUrtrjGvUJrPW9AcpZp4wWz5c1EZlMc32NMkwxVLf18Vm13mJHyUIP6hFC1wjLneITiIKu8uDxP8o5ApKUBNH+0hiBH8kRmZlGJuj6iZqngNFqc6ELQ9YOAHk/u7qwf2XGvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674243; c=relaxed/simple;
	bh=qscTGNmk+wUqkgDhduYP6Eq54BseDj1/1S45LJ1FB/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeYXMVXdjIwflHbqxZXR9BlEMApbQ7tzn6jnc/n4ZvYEw7h1Mww9Oxk+AQseJbePTZggcVxSVMph3e7A7n0sYE2e+9S6RqFCVcrHobS0Vtjg8D44dh883zXCrZWTDGrcS1J4iFvmuE/5DRQgoW2ZY9IYDclIVedO9hkgcHkCvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTVfbBVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTVfbBVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46314C4CEE9;
	Tue, 11 Mar 2025 06:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741674242;
	bh=qscTGNmk+wUqkgDhduYP6Eq54BseDj1/1S45LJ1FB/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=BTVfbBVLhuRfHQNB417nDWL8VMHyfNnV3XkCNYsTOb9+JOTFzeUdjd9FgYhQfSlKm
	 Vc8w6N4fCnuJMpA+7+5UWe//WRQrCPlqlenUTSFhqH/htxF2ROdjS2Vu1MBca23vrR
	 83vmjamAx22Fh60tlGryQIl+zF853LOm5JUQRqtwU6SDumMYjYLnIa8Kg+ybEu238k
	 +KR0cRv32Vmx3icPn7wlTXmMY9J+MV3KKak15B25lIZJTLEZFEx9UXcXernEpH5AqP
	 FBFiNy/ONu5n1wozXmiTJUF3Z6lLBUBo5aiakRBADKTWSAeg5/8K6FeYEvCnE0lCCk
	 m/Ivsgc64jhqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] add struct_group in mptcp_pm_data
Date: Tue, 11 Mar 2025 14:23:53 +0800
Message-ID: <cover.1741674101.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - A new patch to fill id_avail_bitmap for in-kernel pm only.
 - Do not reset id_avail_bitmap, rm_list_tx and rm_list_rx in
   struct_group.

Geliang Tang (2):
  mptcp: pm: only fill id_avail_bitmap for in-kernel pm
  mptcp: pm: add struct_group in mptcp_pm_data

 net/mptcp/pm.c       | 16 +++-------------
 net/mptcp/protocol.h |  5 +++++
 2 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.43.0

