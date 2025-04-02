Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165511F5EA
	for <mptcp@lists.linux.dev>; Wed,  2 Apr 2025 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562396; cv=none; b=Ug/UPMnAGJIrZdx3sI7eV4J3nTjCw1xmMYuS0D//0sa4NC0MgbHRpNU7B9cpYG43EPzrawG9es0hgjOWjWE4A8XEyA9QznWkGCSVFJA5PmhTK0r0DmUZcsvVWlxD6s9R+h+cYOdzknrPpbdaEXFbbln28YlnHhYJ9B52iemk97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562396; c=relaxed/simple;
	bh=nJNXkw+q4Lby1NVe2bGezwksxJDXWwvr4wX3TkUBOKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSSY6w1FWnJxqeRH6gZCIqjbv3JNodZ75ThmKkXlPGn4r8Xs3Y5MIgsSH8PI4s7QPoprXhJ47QSOzZrcGYihYp6U78/PfF0L8egeUqMqwewpa6tgf6hLZVQpA7pDXiGoJoQFbksSCbaOBgTvrJzTUj9z23CBn/bYlTCiETtX6tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx3gPtmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx3gPtmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADA5C4CEE4;
	Wed,  2 Apr 2025 02:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743562394;
	bh=nJNXkw+q4Lby1NVe2bGezwksxJDXWwvr4wX3TkUBOKg=;
	h=From:To:Cc:Subject:Date:From;
	b=mx3gPtmQJMxehuI0g8q+ePtcxptdSjz/U3BWhp79z7AN8XNfl7znRt3OQ7JRNhsQp
	 bCaAMAw20pWgZlj1x9eYUnzgl/A0tuCFjKTFMTXKZ6hvP01MGikeSIE8WRgqXrevyy
	 YlnO3A25ImYy3NB4nJjPfHDvXutGJ/3dkDz1/R0n1ZDTDdtzqgCVV7/ZDOOPiXczL0
	 /Zo19tm0KKAvxKpVgKKCNUMryeoTW1v3AY2gsyo9lvBfJ/aRI9JaHoE0aeg47gJ31i
	 GWA1DRV1O3sU2zHmpkSMIA0FJa82AN1VEUn3JWQAiXCpbWc1oyKLi3k8yIDYFRL4G2
	 drQggQQD9xybA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] only remove entry from local_addr_list when sending a REMOVE_ADDR
Date: Wed,  2 Apr 2025 10:53:06 +0800
Message-ID: <cover.1743562290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang Tang (3):
  mptcp: pm: userspace: local_addr_used-- after sending REMOVE_ADDR
  mptcp: pm: userspace: drop delete_local_addr helper
  selftests: mptcp: send REMOVE_ADDR after subflow is deleted

 net/mptcp/pm_userspace.c                      | 37 +++----------------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  6 +++
 3 files changed, 14 insertions(+), 33 deletions(-)

-- 
2.43.0

