Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FBA17E
	for <mptcp@lists.linux.dev>; Tue,  1 Mar 2022 08:36:13 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:48530.1706408446
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-110.80.1.45 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 59F2728008F;
	Tue,  1 Mar 2022 16:25:32 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id ff8964c84bf0445f9e9e77b1f8ab1da4 for matthieu.baerts@tessares.net;
	Tue, 01 Mar 2022 16:25:35 CST
X-Transaction-ID: ff8964c84bf0445f9e9e77b1f8ab1da4
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH] mptcp: send ADD_ADDR echo before create subflows
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net
References: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <1c479ab9-69ff-2931-c27a-0da5d70e66e3@chinatelecom.cn>
Date: Tue, 1 Mar 2022 16:25:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

I have have send corresponding pull-request to packdrill:
https://github.com/multipath-tcp/packetdrill/pull/80

On 2/25/2022 4:53 PM, Yonglong Li wrote:
> In some corner case, It may receive ADD_ADDR retransmit package
> before created subflows done.
> It's more reasonable to send ADD_ADDR echo before creating subflows.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/pm_netlink.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e3b0384..c1f4bef 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -650,7 +650,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	unsigned int add_addr_accept_max;
>  	struct mptcp_addr_info remote;
>  	unsigned int subflows_max;
> -	bool reset_port = false;
>  	int i, nr;
>  
>  	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
> @@ -661,14 +660,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  		 msk->pm.remote.family);
>  
>  	remote = msk->pm.remote;
> +	mptcp_pm_announce_addr(msk, &remote, true);
> +	mptcp_pm_nl_addr_send_ack(msk);
> +
>  	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
> -		goto add_addr_echo;
> +		return;
>  
>  	/* pick id 0 port, if none is provided the remote address */
> -	if (!remote.port) {
> -		reset_port = true;
> +	if (!remote.port)
>  		remote.port = sk->sk_dport;
> -	}
>  
>  	/* connect to the specified remote address, using whatever
>  	 * local address the routing configuration will pick.
> @@ -684,14 +684,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	for (i = 0; i < nr; i++)
>  		__mptcp_subflow_connect(sk, &addrs[i], &remote);
>  	spin_lock_bh(&msk->pm.lock);
> -
> -	/* be sure to echo exactly the received address */
> -	if (reset_port)
> -		remote.port = 0;
> -
> -add_addr_echo:
> -	mptcp_pm_announce_addr(msk, &remote, true);
> -	mptcp_pm_nl_addr_send_ack(msk);
>  }
>  
>  void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 

-- 
Li YongLong
