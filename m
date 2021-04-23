Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F370
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619190152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29zdYhEkWS+HQrCf04WcNslWzr4JIi4OvOaLOxfOTs8=;
	b=ZBhCgTqn8i7zjUSXiKIh6kSnPD+aodVCd3ZR79l64xdlyHWQIJIB2omKXc9Vsb35k/gUC7
	iKa4inBGktAzvet7GFZkSy+I9pp5vVMq1VOiF++J85WqKhF+q+swqotCC3uTNF9JoFavgz
	5mPGxwWXMuOdXlvYrkFx0UFDgvDuMQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-5vN7znPnP3KH2XYSxVzZlQ-1; Fri, 23 Apr 2021 11:02:28 -0400
X-MC-Unique: 5vN7znPnP3KH2XYSxVzZlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E30319253C3;
	Fri, 23 Apr 2021 15:02:27 +0000 (UTC)
Received: from ovpn-115-60.ams2.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F70460854;
	Fri, 23 Apr 2021 15:02:25 +0000 (UTC)
Message-ID: <b4e59773a54b1640d54bbd900a45b7a26e1549cd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash-to: mptcp: Retransmit DATA_FIN (again)
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: matthieu.baerts@tessares.net
Date: Fri, 23 Apr 2021 17:02:24 +0200
In-Reply-To: <20210423011108.179263-1-mathew.j.martineau@linux.intel.com>
References: <20210423011108.179263-1-mathew.j.martineau@linux.intel.com>
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

On Thu, 2021-04-22 at 18:11 -0700, Mat Martineau wrote:
> Previous testing happened to involve cases where data had been sent and
> the retrans timer was already running. Packetdrill testing revealed that
> the timer was not being started in cases where no data had been
> transmitted, so __mptcp_retrans() was never called. This change starts
> the timer when the original DATA_FIN is sent, if the timer is not
> already running.
> 
> Packetdrill PR is forthcoming.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6cbddfc18158..aec8e77b18e4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2497,6 +2497,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
>  			pr_debug("Sending DATA_FIN on subflow %p", ssk);
>  			mptcp_set_timeout(sk, ssk);
>  			tcp_send_ack(ssk);
> +			if (!mptcp_timer_pending(sk))
> +				mptcp_reset_timer(sk);
>  		}
>  		break;
>  	}

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

