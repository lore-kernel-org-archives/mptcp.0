Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73B2C235D
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872498; cv=none; b=p+w75QiteOUmc7DHd15+cOJEKag+ye2bRIKv4Gg6noJYXOUdFo8gWsisaTcCO2nGzBKDik7YTdJJQOJ81MmwjTlzeot5Q5Zgbyv5rKqdeAtbR+l7K3u17+RR0ckRkWuMhKHR11Sy61v7ddh+Eq1hdxvaW6AWsDJ00VdBMjYxP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872498; c=relaxed/simple;
	bh=MoIjvRK73js51lPSqjTSQ/0yVprC6j01NJulkgbep3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwX9sfdzPSAnuR3/icvMiddbTHDDKVAT00FQDZSLlLebJoOw1Fwz8o/YgW7hxcdjdBHD2ffaQdq7cwuJjpIMu0DNS1wtLpagLcBzu96VfkjCbSrIryAx6I+xsAoE0pK3N+PlAVYwpxhiveZzDxSJCmoUISt1JIApyytFWRkjuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBXcozuP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBXcozuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199CCC4CEF0;
	Wed,  3 Sep 2025 04:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756872498;
	bh=MoIjvRK73js51lPSqjTSQ/0yVprC6j01NJulkgbep3I=;
	h=From:To:Cc:Subject:Date:From;
	b=gBXcozuPqKw6MqYYdnKtb2pOEL4DnAz4BSbJ3YlQjThuqjfl1eu0eXi6XIMOOC6bz
	 bvSppi9t8qZlgdQW9Moa3zpOQa681FBh8Z7wbQLhC0IFpOJJdGbXeHxuBBXccD21jK
	 3hWmjOwdFS31OzP7pRSv42sdVIjDxP25Rzf9dEpu8Nt63SYsyCIoXrh5IzSPM//CcP
	 KqzGB+tba6xt4Z9FSU3YtvOfNNqOpYsNIW0z/zkoJoGtc3wPf9BEpZd4cxHpRMorKZ
	 P0PlKOPg8ySN3wzNhCaqHe2e0zDGwu+StoHjWl8KI8ofb0/6P+LD/lPZl2c6sCt+F5
	 KIZDNP25iQOfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v2 0/3] misc fixes for sockopt selftests
Date: Wed,  3 Sep 2025 12:08:04 +0800
Message-ID: <cover.1756872050.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - patch 2: we should address this resource leak by adding the missing
   close() calls on the server side, rather than by removing the correct
   existing ones on the client side.
 - patch 3: fix more error messages as Matt suggested.

This patch series addresses several resource management issues in the MPTCP
sockopt selftests.

Geliang Tang (3):
  selftests: mptcp: close server file descriptor
  selftests: mptcp: close IPC descriptor on server side
  selftests: mptcp: sockopt: fix error messages

 tools/testing/selftests/net/mptcp/mptcp_inq.c  |  2 ++
 .../selftests/net/mptcp/mptcp_sockopt.c        | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.48.1

