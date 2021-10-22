Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A368
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 01:06:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="216361956"
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="216361956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:06:56 -0700
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="463858542"
Received: from rmarti10-mobl1.amr.corp.intel.com ([10.252.134.41])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:06:56 -0700
Date: Thu, 21 Oct 2021 18:06:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>, Christoph Paasch <cpaasch@apple.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: infinite mapping
 receiving"
In-Reply-To: <39044f0b1da24b4228ed186a751b893a94e9d56b.1634796076.git.geliang.tang@suse.com>
Message-ID: <ef557ead-87c8-8fbe-cca1-63396bdb8f40@linux.intel.com>
References: <39044f0b1da24b4228ed186a751b893a94e9d56b.1634796076.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 21 Oct 2021, Geliang Tang wrote:

> Please update the commit log too:
>
> '''
> This patch added the infinite mapping receiving logic.
>
> In mptcp_incoming_options(), invoke the new helper function
> mptcp_infinite_map_received() to check whether the infinite mapping
> is received. If it is, set the infinite_map flag of struct mptcp_ext.
>
> In get_mapping_status(), if the infinite mapping is received, set the
> map_data_len of the subflow to 0.
>
> In subflow_check_data_avail(), only reset the subflow when the map_data_len
> of the subflow is non-zero.
> '''
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/options.c | 16 +++++++++++++---
> net/mptcp/subflow.c |  2 +-
> 2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f4591421ed22..0144cc97a123 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1077,6 +1077,14 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
> 	return hmac == mp_opt->ahmac;
> }
>
> +static bool mptcp_infinite_map_received(struct mptcp_options_received *mp_opt)
> +{
> +	if (mp_opt->use_map && !mp_opt->data_len)
> +		return true;
> +
> +	return false;
> +}
> +
> /* Return false if a subflow has been reset, else return true */
> bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> {
> @@ -1085,7 +1093,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	struct mptcp_options_received mp_opt;
> 	struct mptcp_ext *mpext;
>
> -	if (__mptcp_check_fallback(msk)) {
> +	mptcp_get_options(sk, skb, &mp_opt);

Now this will scan through all TCP options on every packet after fallback, 
to catch a rare infinite mapping in a case where we are only looking for 
one after sending MP_FAIL. While it's not super expensive, it's still 
extra work that adds up over the life of a connection. More importantly, I 
think this is showing how infinite mapping fallback is probably more 
complicated than I thought.


For "infinite mapping fallback", there seem to be two separate parts of 
fallback to keep track of:

  * Transmit fallback: This peer has sent an infinite mapping already
    (after receiving an MP_FAIL) and should not send any new MPTCP options.

  * Receive fallback: This peer has received an infinite mapping, and will
    ignore MPTCP options on all incoming packets.

The RFC does say that a receiver of MP_FAIL must send an MP_FAIL so both 
directions fall back, but with packets in flight there's still some time 
where fallback has only happened in one direction:

1. Peer A sends MP_FAIL
2. Peer B receives MP_FAIL
3. Peer B sends MP_FAIL (on an ack or data packet) and infinite mapping 
(on next data packet)
    * Peer B enters "transmit fallback" at this time.
4. Peer A receives MP_FAIL, sends infinite mapping on next data packet.
    * Peer B enters "transmit fallback" when sending infinite mapping
5. Peer A receives infinite mapping
    * Peer A enters "receive fallback", fallback complete on this peer
6. Peer B receives infinite mapping
    * Peer B enters "receive fallback", fallback complete on this peer

Steps 4 and 5 could be reversed, we can't assume which order Peer B will 
send the mapping and the MP_FAIL.

Another layer of complexity is that MP_FAIL can be lost if it's not in a 
data packet, so we probably need to keep sending MP_FAIL until an infinite 
mapping is received (like multipath-tcp.org does). This also implies that 
the receive code should ignore repeated MP_FAILs.



I also noticed that the multipath-tcp.org kernel does something 
interesting with connections that are entering fallback with MP_FAIL: 
packets that contain a regular mapping (not infinite) are dropped after 
MP_FAIL is sent but an infinite mapping has not been received yet. Look at 
mptcp_detect_mapping() and "Ignore packets which do not announce fallback" 
comment text in mptcp_input.c.

I think the reasoning may be that the bad checksum that triggered the 
MP_FAIL has dropped some data, so to get the data stream back in a good 
state we need to wait for the infinite mapping as a signal that the other 
peer received the MP_FAIL and has resent data starting from the last 
DATA_ACKed byte.

@Christoph, does that sound correct? ^^^^
'git blame' said I should ask you :)

> +
> +	if (__mptcp_check_fallback(msk) && !mptcp_infinite_map_received(&mp_opt)) {
> 		/* Keep it simple and unconditionally trigger send data cleanup and
> 		 * pending queue spooling. We will need to acquire the data lock
> 		 * for more accurate checks, and once the lock is acquired, such
> @@ -1099,8 +1109,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 		return true;
> 	}
>
> -	mptcp_get_options(sk, skb, &mp_opt);
> -
> 	/* The subflow can be in close state only if check_fully_established()
> 	 * just sent a reset. If so, tell the caller to ignore the current packet.
> 	 */
> @@ -1202,6 +1210,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>
> 		if (mpext->csum_reqd)
> 			mpext->csum = mp_opt.csum;
> +		if (mptcp_infinite_map_received(&mp_opt))
> +			mpext->infinite_map = 1;
> 	}
>
> 	return true;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 9e54122f18f4..bb7d8685ffd4 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -938,7 +938,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 	if (!skb)
> 		return MAPPING_EMPTY;
>
> -	if (mptcp_check_fallback(ssk))
> +	if (mptcp_check_fallback(ssk) && !mptcp_check_infinite_map(skb))
> 		return MAPPING_DUMMY;
>
> 	mpext = mptcp_get_ext(skb);
> -- 
> 2.26.2

--
Mat Martineau
Intel
