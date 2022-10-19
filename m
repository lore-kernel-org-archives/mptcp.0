Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A17E
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666193699; x=1697729699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3yKd9UNHKi+g+UkzbUEW5vBMya1NlvJMwjke/PB7QA=;
  b=jcHy/tH18zur4hJnecmWCiyfUoZjTiphA0S1JJ2TNtuQKFbG3aqfDl8O
   o/D2nIk1ZDTWnEH5pe90csVs4mep4e+O/o+FdMdpP9jmk01DDlwMAhBLo
   kdMUqKUZzYBioHcpzlXl+LwF3srdExyve8Vbu7GGz1p964ywWTbAKSU3I
   Q=;
X-IronPort-AV: E=Sophos;i="5.95,196,1661817600"; 
   d="scan'208";a="234356101"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 15:34:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 9817AA2753;
	Wed, 19 Oct 2022 15:34:48 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 19 Oct 2022 15:34:47 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.128) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.15;
 Wed, 19 Oct 2022 15:34:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <matthieu.baerts@tessares.net>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<mathew.j.martineau@linux.intel.com>, <mptcp@lists.linux.dev>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH v1 net-next 1/5] inet6: Remove inet6_destroy_sock() in sk->sk_prot->destroy().
Date: Wed, 19 Oct 2022 08:34:37 -0700
Message-ID: <20221019153437.67054-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2b8c8764-052a-97b3-bf5b-8335a75c11d9@tessares.net>
References: <2b8c8764-052a-97b3-bf5b-8335a75c11d9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.128]
X-ClientProxiedBy: EX13D48UWB001.ant.amazon.com (10.43.163.80) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Wed, 19 Oct 2022 15:22:40 +0200
> Hi Kuniyuki,
> 
> +cc MPTCP ML.
> 
> On 18/10/2022 21:09, Kuniyuki Iwashima wrote:
> > After commit d38afeec26ed ("tcp/udp: Call inet6_destroy_sock()
> > in IPv6 sk->sk_destruct()."), we call inet6_destroy_sock() in
> > sk->sk_destruct() by setting inet6_sock_destruct() to it to make
> > sure we do not leak inet6-specific resources.
> > 
> > Now we can remove unnecessary inet6_destroy_sock() calls in
> > sk->sk_prot->destroy().
> > 
> > DCCP and SCTP have their own sk->sk_destruct() function, so we
> > change them separately in the following patches.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Thank you for the cc!
> Please next time also cc MPTCP ML if you don't mind.

Sure!


> 
> (...)
> 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index f599ad44ed24..7cc9c542c768 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -17,9 +17,6 @@
> >  #include <net/protocol.h>
> >  #include <net/tcp.h>
> >  #include <net/tcp_states.h>
> > -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > -#include <net/transp_v6.h>
> > -#endif
> 
> Please keep this include: it is needed to access "tcpv6_prot" (as
> reported by the kernel bot).

Will add it back in v2.

I wonder why allmodconfig couldn't catch this and noticed MPTCP
cannot be modulised.
I'll test all(yes|mod|no)config from next time :)


> 
> >  #include <net/mptcp.h>
> >  #include <net/xfrm.h>
> >  #include <asm/ioctls.h>
> > @@ -3898,12 +3895,6 @@ static const struct proto_ops mptcp_v6_stream_ops = {
> >  
> >  static struct proto mptcp_v6_prot;
> >  
> > -static void mptcp_v6_destroy(struct sock *sk)
> > -{
> > -	mptcp_destroy(sk);
> > -	inet6_destroy_sock(sk);
> > -}
> > -
> >  static struct inet_protosw mptcp_v6_protosw = {
> >  	.type		= SOCK_STREAM,
> >  	.protocol	= IPPROTO_MPTCP,
> > @@ -3919,7 +3910,6 @@ int __init mptcp_proto_v6_init(void)
> >  	mptcp_v6_prot = mptcp_prot;
> >  	strcpy(mptcp_v6_prot.name, "MPTCPv6");
> >  	mptcp_v6_prot.slab = NULL;
> > -	mptcp_v6_prot.destroy = mptcp_v6_destroy;
> >  	mptcp_v6_prot.obj_size = sizeof(struct mptcp6_sock);
> >  
> >  	err = proto_register(&mptcp_v6_prot, 1);
> 
> I see that for MPTCP IPv6 sockets, sk->sk_destruct is now set to
> inet6_sock_destruct() which calls inet6_destroy_sock() via
> inet6_cleanup_sock().
> 
> So all good for the MPTCP part (if you re-add the include ;) ).

Thank you!


> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
