Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0F2F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618993075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTlR5meuig4LJI2XQ2Uw4uyD9dh4tI2ZCXvTzxGxKQE=;
	b=AJtQa7n5f4N+j7sqBkIDSoH6NaKtnveEXkjWVloqlpcNobuaMWYoAtj3TDQI3B1gGEyloo
	EV8gbLVcD95z7sYcPggDGhVBUWColN4CvKYmscTlVAFRJ6lEOCZmCbLsL9hRYpnwIEkBlU
	Ds1BTZpZGug03QQstT9Eh/qzC9B6uLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-ZJuFCteGMCeIZ-48hkiF3g-1; Wed, 21 Apr 2021 04:17:52 -0400
X-MC-Unique: ZJuFCteGMCeIZ-48hkiF3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDBEF802575;
	Wed, 21 Apr 2021 08:17:51 +0000 (UTC)
Received: from ovpn-113-128.ams2.redhat.com (ovpn-113-128.ams2.redhat.com [10.36.113.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 097C5503BA;
	Wed, 21 Apr 2021 08:17:50 +0000 (UTC)
Message-ID: <e6ebf2625a8d8e383e5cb1c62d078c49a879aa88.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: Retransmit DATA_FIN
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Wed, 21 Apr 2021 10:17:49 +0200
In-Reply-To: <20210419213836.59887-1-mathew.j.martineau@linux.intel.com>
References: <20210419213836.59887-1-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Mon, 2021-04-19 at 14:38 -0700, Mat Martineau wrote:
> With this change, the MPTCP-level retransmission timer is used to resend
> DATA_FIN. The retranmit timer is not stopped while waiting for a
> MPTCP-level ACK of DATA_FIN, and retransmitted DATA_FINs are sent on all
> subflows. The retry interval starts with a couple of attempts at
> TCP_RTO_MIN and then doubles on each attempt, up to TCP_RTO_MAX.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/146
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/protocol.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a8180a917649..1fddaeeb8051 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
>  #include <linux/atomic.h>
> +#include <linux/log2.h>
>  #include <net/sock.h>
>  #include <net/inet_common.h>
>  #include <net/inet_hashtables.h>
> @@ -402,6 +403,15 @@ static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
>  	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
>  }
>  
> +static void mptcp_set_datafin_timeout(const struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +	int retransmits = clamp_val(icsk->icsk_retransmits, 1,
> +				    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
> +
> +	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;

The patch LGTM! I have only a couple of minor comment WRT to the above.
To me something alike:
	
	mptcp_sk(sk)->timer_ival = min(TCP_RTO_MAX,
				       TCP_RTO_MIN << icsk->icsk_retransmits);

would be more readable.

Also I'm wondering if we could use  max subflows 'icsk->icsk_rto'
instead of TCP_RTO_MIN - so that e.g. we are not too "aggressive" on
slow links

The latter could be really a follow-up, if needed at all.

Thanks!

Paolo

