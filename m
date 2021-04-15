Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119A71
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618487668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Iu9aLNlJfPhlLsbG76IcVQiG2CNNaq4b7JTQ45NxuA=;
	b=Ecc4TYD3x4xrpzpn9T2+9TrqYU8pedzOunVRsO2s3OOlvzbbWy7meAuF9B5d6in7RU4n1a
	qhYHcyx5+gSQApq4Iv7CYfCOHr0hRqxDcxvlv2Wf6N7Xe7Rh4fy+xae4pHYCU3yM7wa/rO
	fP6IW36afOh3GcV6o/gFnBY+aNs3NBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-1Ja7RNsVOd2DZ7Vga4nZrw-1; Thu, 15 Apr 2021 07:54:27 -0400
X-MC-Unique: 1Ja7RNsVOd2DZ7Vga4nZrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BECCB87A82A;
	Thu, 15 Apr 2021 11:54:25 +0000 (UTC)
Received: from ovpn-115-128.ams2.redhat.com (ovpn-115-128.ams2.redhat.com [10.36.115.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A1A255D71F;
	Thu, 15 Apr 2021 11:54:23 +0000 (UTC)
Message-ID: <cb2f684fa9dc1db6d8ddab1e091249cb08798758.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] mptcp: add MSG_PEEK support
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev, 
	mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	fw@strlen.de, wujianguo@chinatelecom.cn
Date: Thu, 15 Apr 2021 13:54:22 +0200
In-Reply-To: <1618456752-139032-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1618456752-139032-1-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-04-15 at 11:19 +0800, Yonglong Li wrote:
> This patch adds support for MSG_PEEK flag. Packets are not removed
> from the receive_queue if MSG_PEEK set in recv() system call.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/protocol.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0437fe4..521e67b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1739,12 +1739,12 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
>  
>  static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>  				struct msghdr *msg,
> -				size_t len)
> +				size_t len, int flags)
>  {
> -	struct sk_buff *skb;
> +	struct sk_buff *skb, *tmp;
>  	int copied = 0;
>  
> -	while ((skb = skb_peek(&msk->receive_queue)) != NULL) {
> +	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
>  		u32 offset = MPTCP_SKB_CB(skb)->offset;
>  		u32 data_len = skb->len - offset;
>  		u32 count = min_t(size_t, len - copied, data_len);
> @@ -1760,15 +1760,18 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>  		copied += count;
>  
>  		if (count < data_len) {
> -			MPTCP_SKB_CB(skb)->offset += count;
> +			if (!(flags & MSG_PEEK))
> +				MPTCP_SKB_CB(skb)->offset += count;
>  			break;
>  		}
>  
> -		/* we will bulk release the skb memory later */
> -		skb->destructor = NULL;
> -		msk->rmem_released += skb->truesize;
> -		__skb_unlink(skb, &msk->receive_queue);
> -		__kfree_skb(skb);
> +		if (!(flags & MSG_PEEK)) {
> +			/* we will bulk release the skb memory later */
> +			skb->destructor = NULL;
> +			msk->rmem_released += skb->truesize;
> +			__skb_unlink(skb, &msk->receive_queue);
> +			__kfree_skb(skb);
> +		}
>  
>  		if (copied >= len)
>  			break;
> @@ -1945,7 +1948,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	int target;
>  	long timeo;
>  
> -	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
> +	if (flags & ~(MSG_PEEK | MSG_WAITALL | MSG_DONTWAIT))
>  		return -EOPNOTSUPP;

Ooops... the existing code (prior to your patch) is pure nonsense here.

Is probably better just drop this check entirely.

Thanks!

Paolo

