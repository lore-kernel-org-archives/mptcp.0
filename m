Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3C68
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638900504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29+BX2goGVzcgr8aT/E4FkPVCEhiwDcZXhl4ymynx8s=;
	b=R11MzPIgx3yuaXDML01bzelKpqLWnmJQvQVyMjPHGvoZiGW1EZU/hIj5ZFLOvovBcxNFWB
	H3xchhu0Zsm9800iuTUMMSy7u28j9vvAHO0XM4+4bFso0chEOYUIPed8B0b/W53ZypGq/J
	4njY8rX5axnuZVgsa8HEgXv1/9bBqpg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360--TkXa_QcNOeQGBXdXqSH7Q-1; Tue, 07 Dec 2021 13:08:22 -0500
X-MC-Unique: -TkXa_QcNOeQGBXdXqSH7Q-1
Received: by mail-wr1-f70.google.com with SMTP id x17-20020a5d6511000000b0019838caab88so3253328wru.6
        for <mptcp@lists.linux.dev>; Tue, 07 Dec 2021 10:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=29+BX2goGVzcgr8aT/E4FkPVCEhiwDcZXhl4ymynx8s=;
        b=7Oc2a+ECScpeXVzOBZgKAwh95vdnY1Wk5/DloqlHjEQNBQcsB7jopXucc6DDSiBb0H
         PIVYXzMQWzmB5WNaPOqUvYhEiyldSot9MmaB09NpbBkykjAHM+iVxFgdkSGgS9uFVIcA
         O5zbvLEXd9d4pFg40DhrvsZbp0fAJo66Q9HoPzC2KwaaD8i+m+GiQIqjuWlFwQZ/MPxN
         JwJtOvXCrdUz490XwO38HTXVmEbHITb45tidywEULmSfTDcNd9lWAM/H582MiG/dfbBX
         vM+NhGQpICUlXFYhSWHLfAx42hAxOVHGkVYZ2ku4ssH71LmwI+16ehf0LaC5yVuO7W5F
         Qi4w==
X-Gm-Message-State: AOAM533L5Q+qqNujjsJiD8r/XXGCNHVwL6XTJcVOEN7/XEaB7K3PDj0F
	7lgqJSy4XQqftN6J4qCwEz4JoMewpyoMZTtPJUkiiKP5BmayfRZpHaj/McvnwBBp7ryIcamDkD+
	fGupQBgWTkiKDPoA=
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr9102569wmq.50.1638900501024;
        Tue, 07 Dec 2021 10:08:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBZEQVKXJX3yT5b+AuW+zHl8KqnjQAqtp2KSIqsd+2m6tXxQAU1eYe1JgiocvMaigso253hg==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr9102540wmq.50.1638900500814;
        Tue, 07 Dec 2021 10:08:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id b15sm664130wri.62.2021.12.07.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:08:20 -0800 (PST)
Message-ID: <7839afba78fe97868d9674cf7dd6b44174be5e2f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: keep track of local endpoint
 still available for each msk
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Florian Westphal
	 <fwestpha@redhat.com>, Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 07 Dec 2021 19:08:19 +0100
In-Reply-To: <b4d0359bad87ee5bd0431be516aa1fc1574a7851.camel@redhat.com>
References: <cover.1638544716.git.pabeni@redhat.com>
	 <20e1d11df9396b33ab49b07204bd8b7db2e21a01.1638544716.git.pabeni@redhat.com>
	 <e5ea098-af36-e35-1813-f97d7a187ffa@linux.intel.com>
	 <b17fea76ad24e5a1cc6b793427f827ba9ea3c887.camel@redhat.com>
	 <b4d0359bad87ee5bd0431be516aa1fc1574a7851.camel@redhat.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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
Content-Transfer-Encoding: 8bit

On Tue, 2021-12-07 at 12:28 +0100, Paolo Abeni wrote:
> On Mon, 2021-12-06 at 11:18 +0100, Paolo Abeni wrote:
> > On Fri, 2021-12-03 at 17:05 -0800, Mat Martineau wrote:
> > 
> > > If you have peer A with one interface and peer B with two, it seems like 
> > > this should be allowed:
> > > 
> > > Peer A connects to Peer B endpoint 0
> > > Peer B announces endpoint 1
> > > Peer A sends an MP_JOIN to Peer B interface 1
> > > 
> > > From the description above, it sounds like peer A would not be able to 
> > > create that second subflow.
> > 
> > Well, AFAICS the peer A will actually create the subflow, if the limits
> > allow that, both with or without this patch.
> > Specifically:
> > 
> > 1) no endpoint configured, add_addr_accepted >=1, subflows >=1 on peer
> > A -> the subflow to peer be interface 1 will be created (with or
> > without this patch) because we don't have any other additional
> > constraint beyond the limits. 
> > 
> > 2) endpoint configured on peer A matching the MPC subflow source
> > address -> again the subflow towards peer B endpoint 1 will be created,
> > because that will be the first time the PM will use the peer A
> > endpoint.
> 
> Thinking again about this last scenario, I think there is something to
> improve:
> 
> if peer A connects to peer B using the local endpoint address, it can
> later use again such address for additional sublflows, as the MPC
> subflow is no accounted by the current version of this patch. I'll cook
> a v5 adding such account, too - and possibly a related self-tests

While working on the above I stumbed upon the following:

if we create a subflow towards the peer using a local address with no 
local endpoint defined on top of it - it can happen for a multi-homed
system in response to incoming ADD_ADDR - the current code pick a
join_id == 0 for such subflow, see:

https://elixir.bootlin.com/linux/latest/source/net/mptcp/pm_netlink.c#L923

That choice is wrong: it violates the RFC and confuses the endpoint
accounting.

I don't see a good way to address the above, except a quite radical
change: refusing to create such subflow. That would require moving the
join_id lookup from mptcp_subflow_connect() to 
inet_csk(ssk)->icsk_af_ops->rebuild_header(), but it should address
some 'wrong address id == 0' issues that Davide noted in the past.

Comments more than welcome!

/P

