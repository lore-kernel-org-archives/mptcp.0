Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D995168
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 10:30:42 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:50602.484945237
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-17fc7d0516274f1db992d7526d33a1ae (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 096CD280098;
	Tue, 13 Jul 2021 18:30:35 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 17fc7d0516274f1db992d7526d33a1ae for mptcp@lists.linux.dev;
	Tue Jul 13 18:30:34 2021
X-Transaction-ID: 17fc7d0516274f1db992d7526d33a1ae
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove
 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
 <7eaa18f3391aa9862bb8274f6288ed1888af8f72.1626158161.git.geliangtang@gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <1e219d3d-9ea5-26ec-ae2c-dac4563bd345@chinatelecom.cn>
Date: Tue, 13 Jul 2021 18:30:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7eaa18f3391aa9862bb8274f6288ed1888af8f72.1626158161.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 2021/7/13 14:44, Geliang Tang wrote:
> Keep the debug info for "send ack".
> 
> Don't drop mptcp_pm_should_add_signal_ipv6() and
> mptcp_pm_should_add_signal_port().
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/pm_netlink.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3e35720317ae..2cd6caaedb08 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -543,8 +543,11 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
>  		bool slow;
>  
>  		spin_unlock_bh(&msk->pm.lock);
> -		pr_debug("send ack for %s",
> -			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
> +		pr_debug("send ack for %s%s%s",
> +			 mptcp_pm_should_add_signal_addr(msk) ? "add_addr" :
> +			 (mptcp_pm_should_add_signal_echo(msk) ? "add_echo" : "rm_addr"),
> +			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
> +			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
>  
>  		slow = lock_sock_fast(ssk);
>  		tcp_send_ack(ssk);
> 
Hi Geliang,

I think the debug log will be incorrect if add_addr and add_echo events trigger at the same time.
WDYT?

-- 
Li YongLong
