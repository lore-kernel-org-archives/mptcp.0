Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BC193
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853564; cv=none; b=txEUq22UCDAvltVXZ7Zmgvyyx9EHWmIrxNJh/DHDS4vmOOz9unvQGkT1yC2tKk8FKyi3oEgedlLe4gdryK24fjvQrPlluArokZqVhQDGxuS64DxF90YUJT6pgMaYJu/VmdCeB6lEcYi77r0rK3GHfCr9Ol8rcXpiITdyKg4bvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853564; c=relaxed/simple;
	bh=K3Y8jWPIDG2fMkw1YLBN4/L5kT1Z3tfkAP0w/0g9ogI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyCpv9FvW41SHVZdGib32NiKKPi85f5+GyXuXViWOkt0IdY/OyjvrjUULUy+o0H4z9HkDmL148ibbTsoBw4aPc8o3U5qqutdE3IGbn3YQY6E8i75zIzoOOAjM78KXT9UcBlsdfHSeyzUOb20JdMgwd9T1SVten3wp75W7QSbB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+Ov9UPT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+Ov9UPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAE2C4CEC5;
	Mon,  9 Sep 2024 03:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853563;
	bh=K3Y8jWPIDG2fMkw1YLBN4/L5kT1Z3tfkAP0w/0g9ogI=;
	h=From:To:Cc:Subject:Date:From;
	b=P+Ov9UPT+W2c7V/zn1Adx7DTsKAx76Ia5e6efaCAYEsqBX7zdWNFo8YPBYrHafb4q
	 92U6An6dbXl6ISCBDWVHNYGDI4CmO02f3tIOt8vqdYql12HVhc8n9TFDmsGYjM/aoj
	 64OK3FqAhq8xONAunI/+JzxAG5MjlNby5ajX3rd5N/9zcvxTI1ltnXVAhcOnj5LtUh
	 bZlmv+R7wdo0km5vqrw1eluvxbE8gYi13bvE7CH7/1368xJzWLKSfS+RgGBR3of9ts
	 ghbNdqKNR8G61kE2NXey0IIsMalcA7uOLYB/VISJR3lvolf7FQEF/YwzsSaqTOvXkw
	 49jIIxzo/dqew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] update PM event CLOSED handlers
Date: Mon,  9 Sep 2024 11:45:55 +0800
Message-ID: <cover.1725853370.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update two MPTCP PM event handlers: mptcp_pm_connection_closed and
mptcp_pm_subflow_closed.

Geliang Tang (2):
  mptcp: implement mptcp_pm_connection_closed
  mptcp: add back mptcp_pm_subflow_closed

 net/mptcp/pm.c       | 10 ++++++++++
 net/mptcp/protocol.c |  8 +++-----
 net/mptcp/protocol.h |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.43.0

