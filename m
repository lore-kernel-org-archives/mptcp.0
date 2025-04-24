Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC741F4CAB
	for <mptcp@lists.linux.dev>; Thu, 24 Apr 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480667; cv=none; b=QNygKETzsOmcA5VGbYnhzxoCx4rSThfjbt84u7mKJvzpd3bf2nNNav/HoiG0tb5jPU0AJGk03nWfRlviUHioYFFLHZJ/8Dxk8vCa/BGuTfp1ltWKpdmP0CAan4iUqkswNbWB9n0gAkjtKXrOtuZK8/DLRc8r2wLIzbt12444ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480667; c=relaxed/simple;
	bh=WQTY3Mm8MiCnFy6oK4d/4XBr3DzHUYGjGKHO6DFTsyI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ujvGdmHYUvvIBFpkO0jtjuLEKtcOV49PPopp9DLJhiUlbptS2QkulkX7XCNWjur2ggFQl1CARZ9spHADuOTgPySx24p56bH/C2GyWw5Bxy835B3TmaZ6joONHluR8GCUDnaeRysGrSEIbi1S7Jn6t5UYfVMLTn96uASCSZrECl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjGBGDrJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjGBGDrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06918C4CEE3;
	Thu, 24 Apr 2025 07:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745480667;
	bh=WQTY3Mm8MiCnFy6oK4d/4XBr3DzHUYGjGKHO6DFTsyI=;
	h=Subject:From:To:Cc:Date:From;
	b=AjGBGDrJQEclguGNYeBFzu8i2PkqdWNS6gYG1PW6ZNoO0p+QXi+bCy8JZ2/oN8brp
	 FLhABThn+tPxksS+6r7qf+3RDvAlGR6c+4lv9guS9aeL3ZY1qX7dF9CoOUHjraNFHs
	 LC83r0/6iF7aNJZxcibw3neX2247D/vkksEJofElOOP6Xjs7RCxOWw5rPe+Maaij+D
	 BAn+Q4AwsWaESp9CA9eccS4bSlyAuQewJUpnV/R/8uAroR5f+DJYNAg+lbflakaazq
	 /j6yHmCFYcMjE5LZCs17e3SSwoy9casfwhO00cxCl5Ld9LbGvjUa5iXRQqNavadyYt
	 jiOLOecnURLJA==
Message-ID: <b14a64255536ee68225ea4142e26c40b9869e811.camel@kernel.org>
Subject: mptcpd is packaged on a New distribution "Kylin OS"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Thu, 24 Apr 2025 15:44:24 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

We (Kylin Software) packaged mptcpd 0.12 into our Linux distribution
"Kylin OS V11" last year. Please add this new distribution in the
"Installing mptcpd" section of https://github.com/multipath-tcp/mptcpd
and https://www.mptcp.dev/apps.html#linux-distributions for us:

	Kylin OS V11, 0.12

Thank you so much,
-Geliang
