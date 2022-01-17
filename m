Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CE173
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642409992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3o+EBwNxWmYcKZyMpr6i3oTkiJgvPtvKOsuQuqGimeM=;
	b=Q4xE6edp6eSjES7lEmluwrvZ2sa+q3T04yxmaeSwG+VCpbWGV0zBeG/VEDKIq8xgaYhjRZ
	kd1FjA+8mSyoBwNo7aVDngpcu/9hvCpcKjjur0+Li7KFto4Ys1HFZLrCVz5utNmwFaDrVr
	fpOK1kmvz+BTCDsZTqdYXZSHaW5t/rA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-byn0VkrYOgmFo8mNF24ulg-1; Mon, 17 Jan 2022 03:59:48 -0500
X-MC-Unique: byn0VkrYOgmFo8mNF24ulg-1
Received: by mail-qk1-f200.google.com with SMTP id o6-20020a05620a22c600b0047a9959171aso4099383qki.12
        for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 00:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3o+EBwNxWmYcKZyMpr6i3oTkiJgvPtvKOsuQuqGimeM=;
        b=jIfeBQMpK+dsER5aj6NiTgYSUK+bMQQrszSN5LNfjh2WhL6ZlWiMS9Ao+c95R2+b3P
         qr1kxD2xfjh0ZehzykWbcyIDAo78ds43NBcfTy2LzSC0wXRb7lfQgY+cXxJB63CRMfxF
         3DFqU1TlvT9gYV6ixh7rtw+1qHCsd/PlRPykitPaJq8I9OfDkccFl/hxbBnz+EoNoO4F
         z2l27scEj5/SD+IJlXzxsZlrYDGWhH4LRT0+kizabU5BThBLIKLA52BBvQoEXV4kanw3
         vOK6MaK45C4JzuYKxpnS/UH42dNu/Ig1E/58xlHOspFptZzfyDkYtdAuaGftk9ETlfbq
         HxiA==
X-Gm-Message-State: AOAM533Rvbz8+auBjqJJdGx2K8Mr9ewSGSLE1gQ6LV3tCbsvEIRNVXIq
	S+Or27Y+fX7kifgJ6hrR6H869hAWAvnp+s/IvV+ckNdINFZTcbkySW8LXtBhpY9M317xbAAe344
	t4QNzkx5yfh3N1iQ=
X-Received: by 2002:ad4:4ea6:: with SMTP id ed6mr10710188qvb.35.1642409987710;
        Mon, 17 Jan 2022 00:59:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSQZ8InQMoyHX7iE73LKund0W5mrz/rnXiJzKYNmT82sTWVxboN+7HnidPX/3wfMq/5gnnvA==
X-Received: by 2002:ad4:4ea6:: with SMTP id ed6mr10710179qvb.35.1642409987491;
        Mon, 17 Jan 2022 00:59:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id s6sm8368552qki.23.2022.01.17.00.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:59:46 -0800 (PST)
Message-ID: <eb4affeebe3b03948a2252b0d6af852751c0ac1f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 04/21] mptcp: establish subflows from
 either end of connection
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Kishen Maloor
	 <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 17 Jan 2022 09:59:43 +0100
In-Reply-To: <83f91e9b-9c20-6e83-6442-41b87139f4eb@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
	 <20220112221523.1829397-5-kishen.maloor@intel.com>
	 <83f91e9b-9c20-6e83-6442-41b87139f4eb@linux.intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2022-01-14 at 14:43 -0800, Mat Martineau wrote:
> On Wed, 12 Jan 2022, Kishen Maloor wrote:
> 
> > This change updates internal logic to permit subflows to be
> > established from either the client or server ends of MPTCP
> > connections. This symmetry and added flexibility may be
> > harnessed by PM implementations running on either end in
> > creating new subflows.
> > 
> > The essence of this change lies in not relying on the
> > "server_side" flag (which continues to be available if needed).
> > 
> 
> After this patch, server_side is unused except for some debug output. If 
> it's really no longer referenced (see below first), may be better to just 
> remove it.
> 
> > v2: check for 3rd ACK retransmission only on passive side
> > of the MPJ handshake
> > 
> > Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> > ---
> > net/mptcp/options.c  | 2 +-
> > net/mptcp/protocol.c | 5 +----
> > net/mptcp/protocol.h | 2 --
> > 3 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index cceba8c7806d..89808816db06 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -921,7 +921,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> > 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
> > 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
> > 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
> > -		    READ_ONCE(msk->pm.server_side))
> > +		    !subflow->request_join)
> > 			tcp_send_ack(ssk);
> > 		goto fully_established;
> > 	}
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4012f844eec1..408a05bff633 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3248,15 +3248,12 @@ bool mptcp_finish_join(struct sock *ssk)
> > 		return false;
> > 	}
> > 
> > -	if (!msk->pm.server_side)
> > +	if (!list_empty(&subflow->node))
> > 		goto out;
> > 
> > 	if (!mptcp_pm_allow_new_subflow(msk))
> > 		goto err_prohibited;
> > 
> > -	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
> > -		goto err_prohibited;
> > -
> > 	/* active connections are already on conn_list.
> > 	 * If we can't acquire msk socket lock here, let the release callback
> > 	 * handle it
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index e2a67d3469f6..c50247673c7e 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -908,10 +908,8 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
> > static inline bool subflow_simultaneous_connect(struct sock *sk)
> > {
> > 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> > -	struct sock *parent = subflow->conn;
> > 
> > 	return sk->sk_state == TCP_ESTABLISHED &&
> > -	       !mptcp_sk(parent)->pm.server_side &&
> > 	       !subflow->conn_finished;
> > }
> 
> Are changes in this function needed? This code was added to address
> https://github.com/multipath-tcp/mptcp_net-next/issues/35
> which was a weird case encountered with syzkaller where a socket tried to 
> connect to itself, triggering the "simultaneous open" code path. It 
> doesn't seem to be applicable to MP_JOINs.

I *think* we can reach here even with MPJ, e.g. if we have port-based
endpoint matching the src address/port - possibly syzkaller could be
able to reach such scenario.

Additionally I fear dropping the '!mptcp_sk(parent)->pm.server_side &&'
check could re-introduce the initial issue, at least for the MPC
handshake.

/P

