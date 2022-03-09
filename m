Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE407C
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 12:53:58 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nRvp9-0004bz-RK; Wed, 09 Mar 2022 13:53:51 +0100
Date: Wed, 9 Mar 2022 13:53:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Message-ID: <20220309125351.GB26501@breakpoint.cc>
References: <20220224155010.23676-1-fw@strlen.de>
 <20220224155010.23676-4-fw@strlen.de>
 <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com>
 <20220308184531.GA22024@breakpoint.cc>
 <d796fef2-d380-c92a-7516-617992a20460@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d796fef2-d380-c92a-7516-617992a20460@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kishen Maloor <kishen.maloor@intel.com> wrote:
> >> Over a newly established MPTCP connection following listen(s1), the PM can issue an 
> >> ADD_ADDR with B. In light of this change there would be no listener created for B. 
> >> But if the remote endpoint immediately established a subflow in response (to the 
> >> ADD_ADDR), then that would create a subflow (connection) socket at B.
> >> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).
> > 
> > Why would that fail? You can bind x:y even if there is an established
> > connection from x:y to q:r.
> 
> If I establish an MPTCP connection using mptcp_connect individually as 
> Client and Server, then I am unable to bind a 3rd (new) Server process at the Client's 
> addr+port [1]. Why is this the case?

Whats [1]?
I suspect this patch series needs following addition in patch 3:

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -337,6 +337,8 @@ static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_joi
 	if (!tb)
 		return -ENOMEM;
 
+	ssock->sk->sk_reuse = 1;
+	ssock->sk->sk_reuseport = 1;
 	inet_csk(ssock->sk)->icsk_bind_hash = tb;
 	return 0;
 }

After that, follwing sequence should work:

1. bind(0.0.0.0, p1) // listen, accept etc, initial subflow established
2. announce p2
3. receive join on addr, p2
4. bind(0.0.0.0, p2)

4) should work because sk used for endpoint in 3) has reuse flag set
and is not in listen state.

cf. include/net/inet_hashtables.h, line 47:
2) If all sockets have sk->sk_reuse set, and none of them
   TCP_LISTEN state, the port may be shared.

> However, I am viewing this matter in light of your changes wherein a connection 
> socket is established without there having been a bound listener at that 
> addr+port. In that case, I was wondering if the above situation [1] would apply on a
> subsequent bind(). If it does, then we could encounter a race such as I described. 

If so, we should consider dropping support for address announcements
with ports, it seems too fragile.
