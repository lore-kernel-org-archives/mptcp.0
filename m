Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D22F84
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618831369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUJE3bPbMRQKdFV9b6EGnMxy0P1Vb6JBkE6JNO++2Vs=;
	b=gj5iD6Y1b6B4NbSrWRQ0+XjUDWennualQqRTopBZ7YjwY0FbCeeFnkL9omN/VDyuyYUN3J
	Dv/ZubA92IuRCvVVG7fOnDfL3AnVwQ+MSXvFjJ9SLlJ2KdYfRmyUc0vXTuYhNr1CVGU1Vl
	SbgwxgcUrthMUIkKZ7jn+9dMU2Xf1nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-51q23uOyMpOJ7iZ7TS1qQg-1; Mon, 19 Apr 2021 07:22:45 -0400
X-MC-Unique: 51q23uOyMpOJ7iZ7TS1qQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F19BC881282;
	Mon, 19 Apr 2021 11:22:43 +0000 (UTC)
Received: from ovpn-114-242.ams2.redhat.com (ovpn-114-242.ams2.redhat.com [10.36.114.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7BE660875;
	Mon, 19 Apr 2021 11:22:41 +0000 (UTC)
Message-ID: <d5a32d82306e89db7ff6a53c8e15d10451293a57.camel@redhat.com>
Subject: Re: [PATCH v4 1/2] mptcp: add MSG_PEEK support
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	fw@strlen.de, geliangtang@gmail.com, qitiepeng@chinatelecom.cn
Date: Mon, 19 Apr 2021 13:22:40 +0200
In-Reply-To: <1618800836-76736-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1618800836-76736-1-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-04-19 at 10:53 +0800, Yonglong Li wrote:
> This patch adds support for MSG_PEEK flag. Packets are not removed
> from the receive_queue if MSG_PEEK set in recv() system call.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/protocol.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 16d73ec..75f4420 100644
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
>  
>  	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
> @@ -1962,7 +1965,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	while (copied < len) {
>  		int bytes_read;
>  
> -		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied);
> +		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
>  		if (unlikely(bytes_read < 0)) {
>  			if (!copied)
>  				copied = bytes_read;
> @@ -2046,7 +2049,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
>  		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
>  		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
> -	mptcp_rcv_space_adjust(msk, copied);
> +	if (!(flags & MSG_PEEK))
> +		mptcp_rcv_space_adjust(msk, copied);
>  
>  	release_sock(sk);
>  	return copied;

LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>

Note that the first chunk mptcp_recvmsg() will conflict with other
pending changes ("mptcp: ignore unsupported msg flags"), but I guess
Mattbe can handle that ;) - likely no need to resubmit.

Thanks!

Paolo

