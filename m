Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658185F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 17:20:25 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lS0zN-0002UD-Vo; Thu, 01 Apr 2021 19:20:14 +0200
Date: Thu, 1 Apr 2021 19:20:13 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 2/2] mptcp: revert "mptcp: provide subflow aware
 release function"
Message-ID: <20210401172013.GD13699@breakpoint.cc>
References: <cover.1617295578.git.pabeni@redhat.com>
 <ad4571485ca31026738cf57d67d68d681997a012.1617295578.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4571485ca31026738cf57d67d68d681997a012.1617295578.git.pabeni@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> This change reverts commit ad98dd37051e ("mptcp: provide subflow aware
> release function"). The latter introduced a deadlock spotted by
> syzkaller and is not needed anymore after the previous commit.
> 
> Fixes: ad98dd37051e ("mptcp: provide subflow aware release function")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Paolo, thanks for passing this to -net.

Acked-by: Florian Westphal <fw@strlen.de>
