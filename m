Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1321F1312
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047825; cv=none; b=ABNFUuZEoc6oq3ITV3Ig+TAmKOiq0pi/4Y5HTtmCKH1b30ZB8uYfvgKAj/bXuJHjjCw1QVzS9WF1AbnAIe6nK1vSVpfYezfDo7KbdXwmXNnWLVYqfFyo/EOXNzlVNWmVgPj+e7R+kMfF8oj1jROMzhmW3bGQh0/Y5rDHqOhDXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047825; c=relaxed/simple;
	bh=/2YQqkararK6tLUJA+xLkB1PAh9vxL5koKjPkFRVRaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxIUDxCMkxU0tpv/+Uyiga4cjIvsK9vyCo4HpvobntIcvRG6iRVUETqfzPSGuDSxpmtm26+MrbJ6dsOhfjJ/KFqhWvwa2VJ2FMaypbPZeOWzAGjUSme1hQKITPBdAiCsJUYTd8i8L34Z9ph8ahvc322ZWR4luY9Il4fJKO8+Xnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3thYVyX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3thYVyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35778C4CEE6;
	Thu, 20 Feb 2025 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047825;
	bh=/2YQqkararK6tLUJA+xLkB1PAh9vxL5koKjPkFRVRaY=;
	h=From:To:Cc:Subject:Date:From;
	b=j3thYVyXKSpnfsz3du6TwDkBSqeBYsgixu5Bu14jUfDZILOdcC5pgeMBqhx0wDvBm
	 33OzQGuJoVWmLin5HRVL26Wvd3acwDUo4iDw6ubTQiGEfRooF9mpcoKW2Htc8LJ0+9
	 sjlCp950L9ma0qhGju5XKmKnb6ELL/dO4VLe3IJMue0sNYTGttDH+JmqoMnCn63VS/
	 L26wQPQwGtuDYLPrjgXoOUmoDZLLZ0xJa1JGiJ0PElsknKu9o8/ROVVuqgz0MoJU8g
	 kwp9R+1wRQUlgYq9RR0MF5av4zDAiAVM4//51mmkqU/UNuIkv8+GlBCTxKQnV/xl9/
	 ArSHkJIAXCZRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/9] BPF path manager, part 5
Date: Thu, 20 Feb 2025 18:36:49 +0800
Message-ID: <cover.1740047738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement address_announced/address_removed/subflow_established/
subflow_closed interfaces.

Depends on:
 - BPF path manager, part 4, v5
Based-on: <cover.1740019794.git.tanggeliang@kylinos.cn>

Geliang Tang (9):
  mptcp: pm: in-kernel: add address_removed/subflow_closed
  mptcp: pm: in-kernel: address_announced interface
  mptcp: pm: in-kernel: address_removed interface
  mptcp: pm: in-kernel: subflow_established interface
  mptcp: pm: in-kernel: subflow_closed interface
  mptcp: pm: userspace: address_announced interface
  mptcp: pm: userspace: address_removed interface
  mptcp: pm: userspace: subflow_established interface
  mptcp: pm: userspace: subflow_closed interface

 net/mptcp/pm_netlink.c   | 115 ++++++++++++++------
 net/mptcp/pm_userspace.c | 220 +++++++++++++++++++++++----------------
 2 files changed, 215 insertions(+), 120 deletions(-)

-- 
2.43.0

