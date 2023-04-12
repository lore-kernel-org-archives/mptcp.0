Received: from a3.inai.de (a3.inai.de [88.198.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBB7482
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 18:25:04 +0000 (UTC)
Received: by a3.inai.de (Postfix, from userid 25121)
	id 010ED587752ED; Wed, 12 Apr 2023 20:24:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id F34D560C0978F;
	Wed, 12 Apr 2023 20:24:59 +0200 (CEST)
Date: Wed, 12 Apr 2023 20:24:59 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
    netfilter-devel@vger.kernel.org, davem@davemloft.net, 
    netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
    mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev
Subject: Re: [PATCH net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
 IPPROTO_UAPI_MAX
In-Reply-To: <4fa60957-2718-cac2-4b01-12aaf48b76b4@tessares.net>
Message-ID: <4r3sqop-o651-6o1q-578-o4p519668073@vanv.qr>
References: <20230406092558.459491-1-pablo@netfilter.org> <ca12e402-96f1-b1d2-70ad-30e532f9026c@tessares.net> <20230412072104.61910016@kernel.org> <405a8fa2-4a71-71c8-7715-10d3d2301dac@tessares.net> <689os02o-r5o8-so9-rq11-p62223p87ns3@vanv.qr>
 <4fa60957-2718-cac2-4b01-12aaf48b76b4@tessares.net>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wednesday 2023-04-12 18:44, Matthieu Baerts wrote:
>
>> Makes me wonder why MPTCP got 262 instead of just 257.
>
>Just in case a uint8 is used somewhere, we fallback to TCP (6):
>
>  IPPROTO_MPTCP & 0xff = IPPROTO_TCP
>
>Instead of IPPROTO_ICMP (1).
>
>We did that to be on the safe side, not knowing all the different
>userspace implementations :)

Silent failure? That's terrible.

	int IPPROTO_MPTCP = 257;
	socket(AF_INET, SOCK_STREAM, (uint8_t)IPPROTO_MPTCP);

on the other hand would immediately fail with EPROTONOSUPP
and make hidden uint8 truncation readily visible.
