Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA170
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617026628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/agwjUCyBtUHhqS5G+t6ls0k8Xg3Fkvz/DEaGi/A0Q=;
	b=BqA2L4F5P3djtU2NpkE+3ZNGRZDmxhaZvJCTUxnX7yipab12scVW8VTuuv3iiLJc2YTW/G
	4xOY0IwO9jfS6e/bxmD2hZ6Ff1+g7p9fI3VEvrPPQPj7hYjjDSMR+uGA6sO51W97RW6+zj
	KcCup9gbg21G6jbeOM3U2PCrE2M7T4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-f5QI2GgkP7WQHBubXZxj6g-1; Mon, 29 Mar 2021 10:03:06 -0400
X-MC-Unique: f5QI2GgkP7WQHBubXZxj6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4621A0CA7;
	Mon, 29 Mar 2021 14:03:05 +0000 (UTC)
Received: from ovpn-114-151.ams2.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6E9760C28;
	Mon, 29 Mar 2021 14:03:04 +0000 (UTC)
Message-ID: <53c0bcd6a552191a70ee1d2675dd0054bb75d099.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 4/5] mptcp: add tracepoint in
 ack_update_msk
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev
Date: Mon, 29 Mar 2021 16:03:03 +0200
In-Reply-To: <0662c0637222901b447135bb10aaad7dea9b4a49.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com>
	 <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
	 <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com>
	 <9b74169474a157c54953de796bc35ef54a710a18.1616575602.git.geliangtang@gmail.com>
	 <0662c0637222901b447135bb10aaad7dea9b4a49.1616575602.git.geliangtang@gmail.com>
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

On Wed, 2021-03-24 at 16:51 +0800, Geliang Tang wrote:
> This patch added a tracepoint in ack_update_msk() to track the
> incoming data_ack and window/snd_una updates.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/trace/events/mptcp.h | 25 +++++++++++++++++++++++++
>  net/mptcp/options.c          |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 503a6098909d..2b8ae5e81cd1 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -91,6 +91,31 @@ DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
>  	TP_PROTO(struct mptcp_ext *mpext),
>  	TP_ARGS(mpext));
>  
> +TRACE_EVENT(ack_update_msk,
> +
> +	TP_PROTO(u64 data_ack, u64 old_snd_una, u64 new_snd_una, u64 new_wnd_end),
> +
> +	TP_ARGS(data_ack, old_snd_una, new_snd_una, new_wnd_end),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, data_ack)
> +		__field(u64, old_snd_una)
> +		__field(u64, new_snd_una)
> +		__field(u64, new_wnd_end)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->data_ack = data_ack;
> +		__entry->old_snd_una = old_snd_una;
> +		__entry->new_snd_una = new_snd_una;
> +		__entry->new_wnd_end = new_wnd_end;
> +	),
> +
> +	TP_printk("data_ack=%llu old_snd_una=%llu new_snd_una=%llu new_wnd_end=%llu",
> +		  __entry->data_ack, __entry->old_snd_una,
> +		  __entry->new_snd_una, __entry->new_wnd_end)
> +);
> +
>  #endif /* _TRACE_MPTCP_H */
>  
>  /* This part must be outside protection */
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c7eb61d0564c..87bd1bfde964 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -13,6 +13,8 @@
>  #include "protocol.h"
>  #include "mib.h"
>  
> +#include <trace/events/mptcp.h>
> +
>  static bool mptcp_cap_flag_sha256(u8 flags)
>  {
>  	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
> @@ -942,6 +944,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
>  		__mptcp_data_acked(sk);
>  	}
>  	mptcp_data_unlock(sk);
> +	trace_ack_update_msk(mp_opt->data_ack, old_snd_una, new_snd_una, new_wnd_end);

Here it would be nice add also 'msk->wnd_end' as an argument and dump
it in the trace event, so that trace point could tell us always the new
windows end value.

Thanks!

Paolo

