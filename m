Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE070
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617026449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qe2qlT7O4dqls2A7lbZFbfw6TmFkjjPaPcAkc9BljkY=;
	b=VJYgI0B831Hlc9Sb0L/M0IQLRzy331cjY+pjnnzt1dZGkjcnkrkJOrRWjFd8mL5+OcSCFR
	7+Bjvpj+Q8zhfyaqeTJzOsbegBdIBk/PvL/5VOd8WHHPGlAE7U+0eSxPQsQrzNGp2MSMn8
	xFF62igMBUOU+A2BfrqibWbmxTzWbaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-cJbwmi-hMymYpiSwtj1dEA-1; Mon, 29 Mar 2021 10:00:44 -0400
X-MC-Unique: cJbwmi-hMymYpiSwtj1dEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32D784B9A1;
	Mon, 29 Mar 2021 14:00:40 +0000 (UTC)
Received: from ovpn-114-151.ams2.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B254966FFF;
	Mon, 29 Mar 2021 14:00:39 +0000 (UTC)
Message-ID: <a45fe0aeffd06c3a30e57753159c8e3db1bd0e18.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 3/5] mptcp: add tracepoint in
 get_mapping_status
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev
Date: Mon, 29 Mar 2021 16:00:38 +0200
In-Reply-To: <9b74169474a157c54953de796bc35ef54a710a18.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com>
	 <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
	 <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com>
	 <9b74169474a157c54953de796bc35ef54a710a18.1616575602.git.geliangtang@gmail.com>
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

On Wed, 2021-03-24 at 16:51 +0800, Geliang Tang wrote:
> This patch added a tracepoint in the mapping status function
> get_mapping_status() to dump every mpext field.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/trace/events/mptcp.h | 54 ++++++++++++++++++++++++++++++++++++
>  net/mptcp/subflow.c          |  6 ++--
>  2 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 06908ea6afb4..503a6098909d 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -37,6 +37,60 @@ TRACE_EVENT(mptcp_subflow_get_send,
>  		  __entry->backup, __entry->ratio)
>  );
>  
> +DECLARE_EVENT_CLASS(mptcp_dump_mpext,
> +
> +	TP_PROTO(struct mptcp_ext *mpext),
> +
> +	TP_ARGS(mpext),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, data_ack)
> +		__field(u32, data_ack32)
> +		__field(u64, data_seq)
> +		__field(u32, subflow_seq)
> +		__field(u16, data_len)
> +		__field(u8, use_map)
> +		__field(u8, dsn64)
> +		__field(u8, data_fin)
> +		__field(u8, use_ack)
> +		__field(u8, ack64)
> +		__field(u8, mpc_map)
> +		__field(u8, frozen)
> +		__field(u8, reset_transient)
> +		__field(u8, reset_reason)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->data_ack = mpext->data_ack;
> +		__entry->data_ack32 = mpext->data_ack32;

Here it's probaly better dump only one of __entry->data_ack and 
and mpext->data_ack32:

		__entry->data_ack = mpext->ack64 ? mpext->data_ack : mpext->data_ack32;

Thanks!

Paolo

