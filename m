Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE26121
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 22:01:51 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nLuH1-00050e-1T; Sun, 20 Feb 2022 23:01:43 +0100
Date: Sun, 20 Feb 2022 23:01:43 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 4/5] mptcp: handle join requests via pernet
 listen socket
Message-ID: <20220220220143.GA18967@breakpoint.cc>
References: <20220217142538.7849-1-fw@strlen.de>
 <20220217142538.7849-5-fw@strlen.de>
 <5cbaa9-26e5-4ce0-7950-3ff131f9f3f8@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbaa9-26e5-4ce0-7950-3ff131f9f3f8@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > If so, the pernet listener is returned and tcp processing resumes.
> > Otherwise, handling is intentical.
> 
> Typo: identical

Thanks, fixed both typos.

> > This patch does not cover timewait sockets.
> > 
> Can you elaborate on what properly covering timewait sockets would look
> like? Does the approach used by multipath-tcp.org (handling token lookup
> after inet_lookup_listener() / case TCP_TW_SYN in tcp_v4_rcv()) fit?

Looks like its as simple as:

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2189,6 +2189,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 							iph->daddr, th->dest,
 							inet_iif(skb),
 							sdif);
+		if (!sk2)
+			sk2 = mptcp_handle_join(AF_INET, skb);
+
 		if (sk2) {
 			inet_twsk_deschedule_put(inet_twsk(sk));
 			sk = sk2;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3b8608d35dcd..f2f2308c6bda 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1833,6 +1833,9 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 					    ntohs(th->dest),
 					    tcp_v6_iif_l3_slave(skb),
 					    sdif);
+		if (!sk2)
+			sk2 = mptcp_handle_join(AF_INET6, skb);
+
 		if (sk2) {
 			struct inet_timewait_sock *tw = inet_twsk(sk);
 			inet_twsk_deschedule_put(tw);

I think I'll squash this into the previous patch and will just remove
the timewait-socket bit from this patch.

> > +	case AF_INET6:
> > +		lsk = pernet->join6.sk;
> > +		break;
> 
> As kbuild noted, missing an
> 
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 
> check here.

Added.
