Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A4C8F4
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 09:56:56 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q1lEj-0002hR-QG; Wed, 24 May 2023 11:56:53 +0200
Date: Wed, 24 May 2023 11:56:53 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Message-ID: <20230524095653.GD17561@breakpoint.cc>
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
 <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> Isn't num_subflows_copied always implied? == min(num_subflows_user,
> num_subflows_kern).

Right, userspace can infer the correct number, i.e.
num_subflows_kern would always be the "actual" used number.

num_subflows_user > num_subflows_kern:

Userspace can safely access "num_subflows_kern" entries
(contain no garbage).

num_subflows_user < num_subflows_kern:
Userspace can safely access "num_subflows_user" entries
(info arrays did not have enough space for all subflows).

I added the "num_subflows_copied" for ease-of-use on userspace
side but I agree that its not required and userspace has
enough info to figure out which upper cap to use.

> Otherwise LGTM, I'll try to have a spin.

Thanks Paolo.
