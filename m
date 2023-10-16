Received: from out-195.mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A715AE5
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uw4mSofm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697441025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ED5JyDmDbl7LJR3HCKF8JAwflOvviXP7jwIwVFRBHHc=;
	b=uw4mSofmRbtECLRCN+zPpeEQZhP+D6oMnnphnwaTsfIeCovx4rAcmE7p91fTRMpgiHg9sE
	vyW2NYXCJn5xA2+AyhzYCeUe+iTwCq3kMrvYkk/IuNp27KY6epvsEqhsnBiTvKiN7XSLUK
	Qk4YmOi3lSn161hml+x+c98QX+1G6Bw=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/3] fix userspace pm CI failures
Date: Mon, 16 Oct 2023 15:21:21 +0800
Message-Id: <cover.1697431973.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

v2:
 - set speed to 5

Geliang Tang (3):
  selftests: mptcp: run userspace pm tests slower
  selftests: mptcp: fix wait_rm_addr/sf parameters
  Squash to "selftests: mptcp: userspace pm create id 0 subflow"

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.35.3

