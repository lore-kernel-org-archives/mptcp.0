Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DF70
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616767053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwtyLHJL6UBD++LWf74xs3/iRAS3aMkppWr1XbW9Wzo=;
	b=XnkYvxssGrtG0vVrho/F61H+aMtb7R9HSXpqheP8IBtK6c5aFhX/QI665qgksjDumK9Xjh
	0pXhI4U1uKKuYQn089E9ywD81rOtBINcm6L+IV9WUhZFJworkb88i4Kx3XNDkhGigxOPpg
	0w3lo1V7D4MjJToQrHnPYrTI7dwcfnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-ZOaXetmfP7Ct-2OB1xDEBw-1; Fri, 26 Mar 2021 09:57:30 -0400
X-MC-Unique: ZOaXetmfP7Ct-2OB1xDEBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BD3EC1A0;
	Fri, 26 Mar 2021 13:57:29 +0000 (UTC)
Received: from [10.40.194.217] (unknown [10.40.194.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A8A3C13441;
	Fri, 26 Mar 2021 13:57:28 +0000 (UTC)
Message-ID: <1f0281f6f7c57b3ff142e3322fc32a1873e01d07.camel@redhat.com>
Subject: Re: [PATCH net-next] mptcp: drop all sub-options except ADD_ADDR
 when the echo bit is set
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616761454.git.dcaratti@redhat.com>
References: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616761454.git.dcaratti@redhat.com>
Organization: red hat
Date: Fri, 26 Mar 2021 14:57:22 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-03-26 at 13:28 +0100, Davide Caratti wrote:
> Current Linux carries echo-ed ADD_ADDR over pure TCP ACKs, so there is no
> need to add a DSS element that would fit only ADD_ADDR with IPv4 address.
> Drop the DSS from echo-ed ADD_ADDR, regardless of the IP version.
> 
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

please note: testing this commit with current packetdrill will fail,
because the expected format of outbound echoed ADD_ADDR will fail.

In parallel with this "harmonization" of IPv4 / IPv6 echo-ed ADD_ADDRs
the kernel, I'm working on packetdrill to fix the support for IPv6 in
ADD_ADDR [1]. Non-echoed ADD_ADDRs are still "non-harmonized", so you
will notice the DSS sub-option on IPv4 and no other sub-option except
ADD_ADDR on IPv6.

So, server scripts using ADD_ADDR will still need 2 separate files for
IPv4 and IPv6, while it will be possible to run the same client script
on IPv4 and IPv6.

@matthieu, just writing few notes here as probably the CI you are
running will be "glitching" because of these changes. Sorry for the
inconvenience :]

-- 
davide

[1] https://github.com/multipath-tcp/packetdrill/pull/49






> ---
>  net/mptcp/options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c7eb61d0564c..d51c3ad54d9a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -624,7 +624,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>  	int len;
>  
> 
> 
> 
>  	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> -	     mptcp_pm_should_add_signal_port(msk)) &&
> +	     mptcp_pm_should_add_signal_port(msk) ||
> +	     mptcp_pm_should_add_signal_echo(msk)) &&
>  	    skb && skb_is_tcp_pure_ack(skb)) {
>  		pr_debug("drop other suboptions");
>  		opts->suboptions = 0;


