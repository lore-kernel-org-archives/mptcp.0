Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953872
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 10:05:16 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:58532.1823805586
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-5d495c7d07f24bf8992a3e83ecb28c7d (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id D598C2800A2;
	Mon, 12 Jul 2021 17:55:23 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 5d495c7d07f24bf8992a3e83ecb28c7d for pabeni@redhat.com;
	Mon Jul 12 17:55:22 2021
X-Transaction-ID: 5d495c7d07f24bf8992a3e83ecb28c7d
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: fix ADD_ADDR and
 RM_ADDR maybe flush addr_signal each other"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev,
 Paolo Abeni <pabeni@redhat.com>
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
 <5802c6e8aac9d3a6502fd3a8e9cdda01f658dbcf.1626016245.git.geliangtang@gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <11cc4e68-8daa-0148-15ef-6b3bbccabc96@chinatelecom.cn>
Date: Mon, 12 Jul 2021 17:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5802c6e8aac9d3a6502fd3a8e9cdda01f658dbcf.1626016245.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 2021/7/11 23:15, Geliang Tang wrote:
> Add READ_ONCE() for reading msk->pm.addr_signal.
> 
> Use mptcp_pm_should_add_signal_echo instead of open coding.
> 
> Use '&=' to clear flag.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/pm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index c9622696716e..be16da2dcb6b 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -257,6 +257,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
>  {
>  	int ret = false;
> +	u8 add_addr;
>  
>  	spin_lock_bh(&msk->pm.lock);
>  
> @@ -271,10 +272,12 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  		goto out_unlock;
>  
>  	*saddr = msk->pm.local;
> -	if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
> -		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO));
> +	add_addr = READ_ONCE(msk->pm.addr_signal);
> +	if (mptcp_pm_should_add_signal_echo(msk))
> +		add_addr &= ~BIT(MPTCP_ADD_ADDR_ECHO);
>  	else
> -		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL));
> +		add_addr &= ~BIT(MPTCP_ADD_ADDR_SIGNAL);
> +	WRITE_ONCE(msk->pm.addr_signal, add_addr);
>  	ret = true;
>  
>  out_unlock:
> @@ -294,7 +297,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  	if (!mptcp_pm_should_rm_signal(msk))
>  		goto out_unlock;
>  
> -	rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
> +	rm_addr = READ_ONCE(msk->pm.addr_signal);
> +	rm_addr &= ~BIT(MPTCP_RM_ADDR_SIGNAL);
>  	len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>  	if (len < 0) {
>  		WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> 

These chunk of code is under the pm.lock so It is no need to use READ_ONCE() as Paolo saied before.

-- 
Li YongLong
