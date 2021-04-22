Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268171
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619083226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGBqOQljpCl28uQqS/BY6jsq262l3h3HDRdwV6IDZlw=;
	b=WREpiQEZRmQyDFCUeWJbQKLjw9TuLVZR9+R825yYnVbxosen79+0FWNWlKp2dX+/QKzk+W
	8snaAXW47ygJrc5gjfcEZeZgJoC4Kb9bzYhpwj+DQ4fpp56yikNP/m1qW0mURoEbpxXQht
	JIWy36wo2fB52BKzqiUEg2noP83Q1PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-997grxiQNKWdWVWHeDHYEg-1; Thu, 22 Apr 2021 05:20:24 -0400
X-MC-Unique: 997grxiQNKWdWVWHeDHYEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6376218397A5;
	Thu, 22 Apr 2021 09:20:23 +0000 (UTC)
Received: from ovpn-112-252.ams2.redhat.com (ovpn-112-252.ams2.redhat.com [10.36.112.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C5465C23E;
	Thu, 22 Apr 2021 09:20:21 +0000 (UTC)
Message-ID: <ee6e9dfea82040c3ae0dfec28bde6dfa5e5c72a5.camel@redhat.com>
Subject: Re: [PATCH] mptcp: remove redundant couters reset in
 pm_nl_init_net()
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Date: Thu, 22 Apr 2021 11:20:16 +0200
In-Reply-To: <1fc15c8b-ba1c-a1d9-d204-8087d93b73e3@163.com>
References: <1fc15c8b-ba1c-a1d9-d204-8087d93b73e3@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-04-22 at 15:03 +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> Memory of struct pm_nl_pernet{} is allocated by kzalloc()
> in setup_net()->ops_init(), so it's no need to reset counters
> in pm_nl_init_net().
> 
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/pm_netlink.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6ba0408..99bb9be 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1913,7 +1913,6 @@ static int __net_init pm_nl_init_net(struct net *net)
>  	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
> 
>  	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
> -	__reset_counters(pernet);
>  	pernet->next_id = 1;
>  	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
>  	spin_lock_init(&pernet->lock);

LGTM.

I guess we could drop also bitmap_zero() and add a comment that all
fields are already initialized to 0 at allocation time.

Thanks!

Paolo

