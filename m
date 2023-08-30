Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A21377
	for <mptcp@lists.linux.dev>; Wed, 30 Aug 2023 03:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87F31C433C8;
	Wed, 30 Aug 2023 03:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693367887;
	bh=mPKk2+swFtGFWy8pTYH1vfYUh7/3u0eFDl38x3vBbbc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ADgZbQkup9SM4uuEjVXPl0kZb5qU5cRxcBUYIV68ssaOHHCZrS2+ntwfLz0HT21Ih
	 e386cEZAZNnNJznyld2KJf/v8fe7MjFSYHeqn2jCi/au5X8+GFJAJs2UqaMkjl13Pt
	 tBWufYtEAuzWRPX8V1l2CtngKltT6f7/s0ANkfkNNyVfix0L9B91QYMTHLJdOVoFVq
	 IlamCyGNhuWsTR9+yFkPDS5wrnr9z9xFHderl/6D+AsGosodrxgWcJDG1GU30wgN9F
	 bxisMSAemfMVycuM7wn1I11u7D6rtj9+5B2G88KHjzTBzjQzbN1UyndsBWNsRv7wH+
	 v1R8ONmU6MaSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A11CE29F34;
	Wed, 30 Aug 2023 03:58:07 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.6-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
References: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.6-rc1
X-PR-Tracked-Commit-Id: 53f3811dfd5e39507ee3aaea1be09aabce8f9c98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adfd671676c922bada16477eb68b5eb5f065addc
Message-Id: <169336788741.6268.886734446514047714.pr-tracker-bot@kernel.org>
Date: Wed, 30 Aug 2023 03:58:07 +0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joel Granados <joel.granados@gmail.com>, linux-fsdevel@vger.kernel.org, rds-devel@oss.oracle.com, "David S. Miller" <davem@davemloft.net>, Florian Westphal <fw@strlen.de>, willy@infradead.org, Jan Karcher <jaka@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@verge.net.au>, Tony Lu <tonylu@linux.alibaba.com>, linux-wpan@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Will Deacon <will@kernel.org>, Julian Anastasov <ja@ssi.bg>, netfilter-devel@vger.kernel.org, Joerg Reuter <jreuter@yaina.de>, linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, linux-sctp@vger.kernel.org, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-hams@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, coreteam@netfilte
 r.org, Ralf Baechle <ralf@linux-mips.org>, Steffen Klassert <steffen.klassert@secunet.com>, Pablo Neira Ayuso <pablo@netfilter.org>, keescook@chromium.org, Roopa Prabhu <roopa@nvidia.com>, David Ahern <dsahern@kernel.org>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Jozsef Kadlecsik <kadlec@netfilter.org>, Wenjia Zhang <wenjia@linux.ibm.com>, josh@joshtriplett.org, Alexander Aring <alex.aring@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Iurii Zaikin <yzaikin@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, bridge@lists.linux-foundation.org, Karsten Graul <kgraul@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Miquel 
 Raynal <miquel.raynal@bootlin.com>, Jakub Kicinski <kuba@kernel.org>, Joel Granados <j.granados@samsung.com>, mcgrof@kernel.org
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 29 Aug 2023 13:44:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adfd671676c922bada16477eb68b5eb5f065addc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
