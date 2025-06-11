Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622125C83E
	for <mptcp@lists.linux.dev>; Wed, 11 Jun 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633909; cv=none; b=kDPJlZ1oW9uI/7UH21aTLcGzeVMiKec1lomVIc66jhnN9dXEf2rm+Stn1oj9go8+JuQoEKNpRUa7PepFiw03qWFaGY+IxsR7TzHT1jPz4gnU3mD0CT01rr3YlW+eqP6gFj6nZhNkE3diiad5Rmj6ef82lQyYuqVKn0YPbkZKeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633909; c=relaxed/simple;
	bh=IFl52TMRxUyCAxJzRFXehFbdxh8EAUDLPWgzrsPj+to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVSO+i4FZEWNoqiXsRpbJlF+KD39chf0BJvWIB6rhvfsn+KQVcf0Iss/5MgGpTFtg2gBfSkJlYmOufwcghli+hBVrnkgo3gqt7ve1RzCF2seYnYKtpqyZfg5GwNZ+UigKOzk+R1wJw6vo9V8NPVzlV0DhL2ZlbiLDjKr+oM5lFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svi6uBJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svi6uBJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79288C4CEEF;
	Wed, 11 Jun 2025 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749633908;
	bh=IFl52TMRxUyCAxJzRFXehFbdxh8EAUDLPWgzrsPj+to=;
	h=From:To:Cc:Subject:Date:From;
	b=Svi6uBJXeCHlqms76PwC9moHvUO5XYDFpnhQmi3wtSx/C3bQ9Wa3CMWHTlBydreTN
	 pa/cgTAUzRwop75L4OqDM+6XvLX/vkhmby9MQKb0X6I17YuLNENME3LAlyw/XxkdwN
	 SJW0a4XYiRWjN4aXP/k8ReZLGkICrZ0AWoyhS+ueEiytzpzH1gsoPXVKsLY+m06x0a
	 fkJ+DEIVxN4ZBIVf51RWA4ddOY5QR4dpSHha22v9Vp2h5VnNu0MQFifJZSxLyTjpe2
	 dIEkqcAD1OkkfnzYYFavRw83OfpleUimVZ+v+9P6o9r69E0+N9dYsgptmQSlfjT4ZE
	 sEh2zNfLFJRzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] squash to "implement mptcp read_sock"
Date: Wed, 11 Jun 2025 09:24:51 +0000
Message-ID: <cover.1749633671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two squash-to patches for "implement mptcp read_sock" v2:

 - Use sk->sk_rcvbuf instead of INT_MAX as the max len.
 - Close all fds of mptcp_splice.c.
 - Add splice io mode for mptcp_connect.

Based-on: <cover.1749286212.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: implement .read_sock"
  Squash to "selftests: mptcp: add splice test"

 net/mptcp/protocol.c                          |  2 +-
 .../selftests/net/mptcp/mptcp_connect.c       | 61 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 10 ++-
 .../selftests/net/mptcp/mptcp_splice.c        | 43 ++++++++-----
 4 files changed, 99 insertions(+), 17 deletions(-)

-- 
2.43.0

