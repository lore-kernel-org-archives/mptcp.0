Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D02CA0
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 10:58:54 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1muBhr-00084A-V8; Mon, 06 Dec 2021 11:58:52 +0100
Date: Mon, 6 Dec 2021 11:58:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp] mptcp: remove tcp ulp setsockopt support
Message-ID: <20211206105851.GA30918@breakpoint.cc>
References: <00000000000040972505d24e88e3@google.com>
 <20211205192700.25396-1-fw@strlen.de>
 <61ea8986-10c2-1d4f-6c35-2c910dbdcf89@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ea8986-10c2-1d4f-6c35-2c910dbdcf89@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> BTW, did you send this patch to netdev ML on purpose?

Yes, it was a reply to syzbot report.

> I guess this is fine but they will probably ask for the Fixes tag as it
> looks like a bug-fix. Do you want me to reply to this email on netdev
> and include this "Fixes" tag in my email?

I think it can go in via mptcp tree.
This patch is fine but there is still another ULP bug left, will send a
patch soon.
