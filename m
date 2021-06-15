Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065B70
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 15:19:33 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1ltAqa-0000wc-3t; Tue, 15 Jun 2021 17:19:24 +0200
Date: Tue, 15 Jun 2021 17:19:24 +0200
From: Florian Westphal <fw@strlen.de>
To: wujianguo106@163.com
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v4 4/4] mptcp: avoid processing packet if a subflow reset
Message-ID: <20210615151924.GD1425@breakpoint.cc>
References: <1623726146-5911-1-git-send-email-wujianguo106@163.com>
 <1623726146-5911-5-git-send-email-wujianguo106@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623726146-5911-5-git-send-email-wujianguo106@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

wujianguo106@163.com <wujianguo106@163.com> wrote:
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1aec01686c1a..01a1bf60b187 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -926,6 +926,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  	return true;
>  
>  reset:
> +	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;

Magic.  Please at least add a comment here.
