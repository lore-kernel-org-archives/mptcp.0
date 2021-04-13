Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38F71
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618306198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvY5wxRvQckhFhvJvUUknFz0saQ8kTXpX7mEXYPggq8=;
	b=c/QL2RbycaEeoTxq8Oqs95kQ5hrIyY0MvM8klzqB4nhgBoAlX4lG9nqAmH6g24RXrKKvQB
	xEeKiMADvEfgFo7720RhuR5IlqQixxou7NgTiOv+Xd5G5xMr2Uok1fhTHo8OFF4ZgyHJ4I
	ycpion+4NVWCB6Skis28uj3i5Yj5elE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-4O9p3KupMoST1_w_AVSxwA-1; Tue, 13 Apr 2021 05:29:55 -0400
X-MC-Unique: 4O9p3KupMoST1_w_AVSxwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33F8FA40CC;
	Tue, 13 Apr 2021 09:29:52 +0000 (UTC)
Received: from ovpn-115-101.ams2.redhat.com (ovpn-115-101.ams2.redhat.com [10.36.115.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EB535D9DE;
	Tue, 13 Apr 2021 09:29:49 +0000 (UTC)
Message-ID: <1d72e6b0f7e0838f388725b9504e0b0fe2e19a93.camel@redhat.com>
Subject: Re: [PATCH] mptcp: add MSG_PEEK support
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev, 
	mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	fw@strlen.de
Date: Tue, 13 Apr 2021 11:29:48 +0200
In-Reply-To: <1618298656-123756-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1618298656-123756-1-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Tue, 2021-04-13 at 15:24 +0800, Yonglong Li wrote:
> This patch adds support for MSG_PEEK flag. Packets are not removed
> from the receive_queue if MSG_PEEK set in recv() system call.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/protocol.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2d895c3..65448e1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1710,12 +1710,13 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
>  
>  static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>  				struct msghdr *msg,
> -				size_t len)
> +				size_t len, int flags)
>  {
>  	struct sk_buff *skb;
>  	int copied = 0;
>  
> -	while ((skb = skb_peek(&msk->receive_queue)) != NULL) {
> +	skb = skb_peek(&msk->receive_queue);
> +	while (!(skb == NULL || skb == (struct sk_buff *)(&msk->receive_queue))) {

I think you can replace the above construct with skb_queue_walk_safe().
Will be cleaner and will avoid the skb_peek()/skb = skb->next later.

>  		u32 offset = MPTCP_SKB_CB(skb)->offset;
>  		u32 data_len = skb->len - offset;
>  		u32 count = min_t(size_t, len - copied, data_len);
> @@ -1731,15 +1732,21 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
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
> +		if (!(flags & MSG_PEEK))
> +			/* we will bulk release the skb memory later */

It looks like there is a missing bracket here.

> +			skb->destructor = NULL;
> +			msk->rmem_released += skb->truesize;
> +			__skb_unlink(skb, &msk->receive_queue);
> +			__kfree_skb(skb);
> +			skb = skb_peek(&msk->receive_queue);
> +		}else{

Uhm... this causes a compiler error due to missing paired opening
bracket.

Additional minor hint, a space is needed before and after the 'else'

> +		    skb = skb->next;
> +		}
>  
>  		if (copied >= len)
>  			break;
> @@ -1933,7 +1940,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	while (copied < len) {
>  		int bytes_read;
>  
> -		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied);
> +		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
>  		if (unlikely(bytes_read < 0)) {
>  			if (!copied)
>  				copied = bytes_read;
> @@ -2017,7 +2024,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
>  		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
>  		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
> -	mptcp_rcv_space_adjust(msk, copied);
> +	if (!(flags & MSG_PEEK))
> +		mptcp_rcv_space_adjust(msk, copied);
>  
>  	release_sock(sk);
>  	return copied;

This lacks some other changes in mptcp_recvmsg().
Currently mptcp_recvmsg() fails with -EOPNOTSUPP if an unsupported flag
is provided as an argument, and MSG_PEEK is not yet in the supported
list.

Side note: we need to change the above: mptcp_recvmsg() should silently
ignore unsupported flags.

Finally you should add some self-tests for the new feature (in a
separate patch). You could extend the 'mptcp_connect.c' program and add
some new script in the 'mptcp' self-test directory. That will allow you
to test your code, as needed.

If you are interested in larger contribution to the MPTCP protocol, I
suggest to try to join the public mtg we have every week:

https://github.com/multipath-tcp/mptcp_net-next/wiki/Meetings

The current timeslot is likely unfortunate, but we could change that.

Cheers,

Paolo

