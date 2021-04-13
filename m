Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C071
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618308611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GVsXsvqebX0E/yTW/AFYhDzkrrVjaVeJqSN2Kd2Hto=;
	b=WpO0bqDNyTgYoIYet0MYfyCfD39I3Fi4lWu0Y9tgXkjbLCwZ1CbJXbtDgZP+nwkZB+bQnM
	WW8Q7BLryfMfyrVS2FAFsY1AY4FQ2EDLtbJuKBjzY21IPl9ddMwObrB0A3DPqssQvovtPy
	pD0f0+4jUOppbeT3IruN37xuwIGtVjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-cCvpG-G_OMCg2TzKS6VikQ-1; Tue, 13 Apr 2021 06:10:09 -0400
X-MC-Unique: cCvpG-G_OMCg2TzKS6VikQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7BC983DD20;
	Tue, 13 Apr 2021 10:10:08 +0000 (UTC)
Received: from ovpn-115-101.ams2.redhat.com (ovpn-115-101.ams2.redhat.com [10.36.115.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3E5219D80;
	Tue, 13 Apr 2021 10:10:07 +0000 (UTC)
Message-ID: <c15d98d06c49a1f49c09fe68cdf8cbfc471af498.camel@redhat.com>
Subject: Re: [PATCH mptcp 03/10] mptcp: setsockopt: handle SO_KEEPALIVE and
 SO_PRIORITY
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Tue, 13 Apr 2021 12:10:06 +0200
In-Reply-To: <20210408184936.6245-4-fw@strlen.de>
References: <20210408184936.6245-1-fw@strlen.de>
	 <20210408184936.6245-4-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-04-08 at 20:49 +0200, Florian Westphal wrote:
> start with something simple: both take an integer value, both
> need to be mirrored to all subflows.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/sockopt.c | 106 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index b1950be15abe..43da4696336f 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -45,6 +45,90 @@ static u32 sockopt_seq_reset(const struct sock *sk)
>  	return sk->sk_state << 24u;
>  }
>  
> +static void sockopt_seq_inc(struct mptcp_sock *msk)
> +{
> +	u32 seq = msk->setsockopt_seq & 0x00ffffff;
> +
> +	msk->setsockopt_seq = sockopt_seq_reset((struct sock *)msk) + seq + 1;

if setsockopt_seq == 0x00ffffff, than this will change the 'state'
related part of setsockopt_seq???

Should the above instead be:

	u32 seq = (msk->setsockopt_seq + 1) & 0x00ffffff;
	
	msk->setsockopt_seq = sockopt_seq_reset((struct sock *)msk) + seq;

Note: I *think* that a wrap-around is not a problem. Since the sequence
contains the 'state' tag, a wrap around could possibly cause a wrong
synchronization only if it occours in-between the subflow creation and
the next join_list - a very short period of time -> more than
reasonably impossible. In all other cases there should be mismatch of
the 'state' part.

Cheers,

Paolo

