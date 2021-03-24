Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBE6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616603697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sm7W1EB+93IO9Mnt2uF2S8MM1OkNjlvgF07kjR8vm4o=;
	b=K/KabWKnbze8ZaR/WBPBzfsVxrb4ihERQxFssJR8KmL1RJsNHy9MVvIiA8Vt/N+zWf8Mn8
	uy0O3LYRICzXyMx2OFp7a6rzdt3Ui+X+LXVvf13iDCwC033h6maHcBsqJfzJVjV4wvAaDz
	fEU9dLxY+IJMkEvpa68WjimzoDTp3OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-w5NlyP_TMgmb4EMTkOSLug-1; Wed, 24 Mar 2021 12:34:56 -0400
X-MC-Unique: w5NlyP_TMgmb4EMTkOSLug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2530918C8C01;
	Wed, 24 Mar 2021 16:34:55 +0000 (UTC)
Received: from ovpn-114-21.ams2.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1DA05D9CA;
	Wed, 24 Mar 2021 16:34:53 +0000 (UTC)
Message-ID: <1c0d6fff2e9c3aa94d427d836d5922597adba644.camel@redhat.com>
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 3/8] mptcp: setsockopt: handle
 receive/send buffer and device bind
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Cc: mptcp@lists.01.org
Date: Wed, 24 Mar 2021 17:34:52 +0100
In-Reply-To: <20210324131546.13730-4-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
	 <20210324131546.13730-4-fw@strlen.de>
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

On Wed, 2021-03-24 at 14:15 +0100, Florian Westphal wrote:
> @@ -441,6 +465,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  	}
>  
>  	ssk->sk_priority = sk->sk_priority;
> +	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> +
> +	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
> +		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
> +	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
> +		WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);

Don't we need also:

	ssk->sk_userlocks = sk->sk_userlocks;

?

Otherwise tcp could still autotune under the wood ?

Thanks!

Paolo

