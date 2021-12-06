Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F12C80
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 15:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A441FC341F8;
	Mon,  6 Dec 2021 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1638806006;
	bh=LVzcOfoJv9Y3eoCAXke2gDeYUbUcFGp9/7s2MGxf4ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gWOwEZOYaB1xlh+objmSG7XkvqGq938QSclF5vC7e0gdV+UhpsY9/U3J8aFXgMjUI
	 7FTtvxlVNuYwZ4kMx1xzZ5sELb646y/B6i2Iw/lXm64mrs93jguTUus2E5En3LZs86
	 k6+PAhcgSQGvlqDmvhYJQCi/Ld3EVQ2nbFBv7IiqvX14NE/QhlnlKjpVY0LwotOsjW
	 djk1o3bNN5R1AJ6+B7Kwyz23RZvpcSd8Oym2SyGWqVrmCemCwi7aScsjugYRdUgwi6
	 mpe3KxBipb6a1fZ0ihPEOb2R9xOnAZFOPjetslcONwW9JrzUpB0OpZ+mVGuUTc0YBQ
	 z7JEQF71JZfUg==
Date: Mon, 6 Dec 2021 07:53:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <mptcp@lists.linux.dev>, syzkaller-bugs@googlegroups.com,
 <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
Subject: Re: [PATCH mptcp] mptcp: remove tcp ulp setsockopt support
Message-ID: <20211206075326.700f2078@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211205192700.25396-1-fw@strlen.de>
References: <00000000000040972505d24e88e3@google.com>
	<20211205192700.25396-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Dec 2021 20:27:00 +0100 Florian Westphal wrote:
> TCP_ULP setsockopt cannot be used for mptcp because its already
> used internally to plumb subflow (tcp) sockets to the mptcp layer.
> 
> syzbot managed to trigger a crash for mptcp connections that are
> in fallback mode:

Fallback mode meaning ops are NULL? I'm slightly confused by this
report.

> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> CPU: 1 PID: 1083 Comm: syz-executor.3 Not tainted 5.16.0-rc2-syzkaller #0
> RIP: 0010:tls_build_proto net/tls/tls_main.c:776 [inline]
> [..]
>  __tcp_set_ulp net/ipv4/tcp_ulp.c:139 [inline]
>  tcp_set_ulp+0x428/0x4c0 net/ipv4/tcp_ulp.c:160
>  do_tcp_setsockopt+0x455/0x37c0 net/ipv4/tcp.c:3391
>  mptcp_setsockopt+0x1b47/0x2400 net/mptcp/sockopt.c:638
> 
> Remove support for TCP_ULP setsockopt.
> 
> Reported-by: syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
> Signed-off-by: Florian Westphal <fw@strlen.de>
