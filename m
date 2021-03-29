Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BF70
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617025985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5vR3v2Y6NKUJE9k58jrD/2+Fr0oDAcKpEoMhlMFjdE=;
	b=MSRSTuDNfed4+3p6XH/z0s/T8hv/dkBrViWPW5N1Hydi1SFAoRM45ufmKE2V82L5Y5JhYv
	iW/9wRsSatIDJqCnFPYLl5bp96Ntn+PPs27IPh4jad7R8j1aI/CsnBckaDrQg/Ow/32grQ
	AnQvZ1EMXldIjWcXGKgZCBlR3i41CJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-CjA3O4EIMrmWMBA-kTYzzQ-1; Mon, 29 Mar 2021 09:53:01 -0400
X-MC-Unique: CjA3O4EIMrmWMBA-kTYzzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1436F83DD21;
	Mon, 29 Mar 2021 13:53:00 +0000 (UTC)
Received: from ovpn-114-151.ams2.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F39431001281;
	Mon, 29 Mar 2021 13:52:58 +0000 (UTC)
Message-ID: <4deca7f4a462e10a2bf0dd416b9cee5ab37ba260.camel@redhat.com>
Subject: Re: [MPTCP] [MPTCP][PATCH v2 mptcp-next 1/5] mptcp: export
 mptcp_subflow_active
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev
Date: Mon, 29 Mar 2021 15:52:57 +0200
In-Reply-To: <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com>
	 <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-24 at 16:51 +0800, Geliang Tang wrote:
> This patch exported the static function mptcp_subflow_active.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/protocol.c | 2 +-
>  net/mptcp/protocol.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d7e7e13fba8..3ad236689480 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -399,7 +399,7 @@ static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
>  	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
>  }
>  
> -static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> +bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  {
>  	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);

possibly is better to simply move the function definition to the
protocol.h header, as 'static inline' one.

Thanks!

Paolo

