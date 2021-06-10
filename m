Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A372
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623319368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejyTZ+zSJpyVDfP65sR7DgYuwG2FjdvQ4qfHfA4RJZk=;
	b=T3KGp2gVtzelAAiQcWIBK4Z6SJVf5KHLZ+B6fRlaCH5qz1KUAM5gbbuONHcCwno94yc2o6
	L8pwa+1Muz+9dyPz/FhLCjU78W+/W6plXZ/lg7V3MdFiBkUFEVBLPClB6ZaYHIY7LKxCkk
	AffnbV+g9wACOZ3g+QwLZftV+h8pq30=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-nCR7qVraNPyAnCWVpRWERA-1; Thu, 10 Jun 2021 06:02:47 -0400
X-MC-Unique: nCR7qVraNPyAnCWVpRWERA-1
Received: by mail-wr1-f69.google.com with SMTP id z4-20020adfe5440000b0290114f89c9931so639177wrm.17
        for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 03:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ejyTZ+zSJpyVDfP65sR7DgYuwG2FjdvQ4qfHfA4RJZk=;
        b=QuHykw7lbvhtvZYlAB/yShqTwqq14SHb4EnQ7Tmr2w77mfSxc17yE3dIDs94xI4uKc
         namu+TD/+vqnCYWO8W6ezk/pch+3VSqmjALEIE20r7+jUfscayeZ1ryZdY1bEvLvHcBr
         0/DrSNA1v9gLQE8v+i9j9lxZVYFgD2sBsdOgmWqiROVbzsS/8eUPhUv0/etX6pmY+rsh
         Uk1YculS0OL/cn9pun1ZoNADmQBuLjXEnFvVRI8O4VBuqTxLfn8wGNe3Ph/NtKMpkWbK
         Vj0XXe6bQNgCqyTYcfI5z9XNWNONlK5w7QQIuOE3U4dnYTUKaFEjhWJMcKdnpEB2vrWl
         sPfg==
X-Gm-Message-State: AOAM531xFT3dK5et0hvyA3Pw2maq3lEpOGE7xa5fl/OyCW/5kSfpfFuJ
	b9tsAnTtBnspauE7QrAUrRpTMon7UFR7vEkG24UJTvQ/Blapl4wFTrF24vc4tucP/73PV5iyAW6
	7PJ0KFyp4IOKzUwo=
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr4445456wrw.297.1623319366160;
        Thu, 10 Jun 2021 03:02:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRJcWlMjfngNgJMmqzxkIUq7kg2YuOT8AAlOpvxo3wnW3FrUenrBu/8CunVilTH3FrKBQdNQ==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr4445437wrw.297.1623319365991;
        Thu, 10 Jun 2021 03:02:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id x18sm2945865wrw.19.2021.06.10.03.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:02:45 -0700 (PDT)
Message-ID: <5edd3e152879464c0f01c7cc4f620636703930dd.camel@redhat.com>
Subject: Re: [PATCH 2/3] mptcp: remove redundant req destruct in
 subflow_check_req()
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 10 Jun 2021 12:02:44 +0200
In-Reply-To: <0e1170b8-bf59-6a1c-b08e-7d06ee47f1f7@163.com>
References: <6747dc58-0dbf-b4d3-e084-85816ad5caec@163.com>
	 <c23b378662b4036a1c3fca3ac994970fd503875f.camel@redhat.com>
	 <0e1170b8-bf59-6a1c-b08e-7d06ee47f1f7@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Thu, 2021-06-10 at 11:28 +0800, Jianguo Wu wrote:
> Hi Paolo,
> 
> On 2021/6/9 22:23, Paolo Abeni wrote:
> > On Wed, 2021-06-09 at 18:39 +0800, Jianguo Wu wrote:
> > > From: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > 
> > > In subflow_check_req(), if subflow sport is mismatch, will put msk,
> > > destroy token, and destruct req, then return -EPERM, which can be
> > > done by subflow_req_destructor() via:
> > >   tcp_conn_request()
> > >     |--__reqsk_free()
> > >       |--subflow_req_destructor()
> > > So we should remove these redundant code, otherwise will call tcp_v4_reqsk_destructor()
> > > twice, and may double free inet_rsk(req)->ireq_opt.
> > 
> > _if_ I read the above correctly, there is no duplicated test, we should
> > just drop the destructor invocation otherwise we could not enforce the
> > sport check?!? am I missing something?!?
> 
> Sorry, I don't quite understand, I think the sport check is untouched by this patch.

Whoops, sorry, I misread the patch - I should fetch more coffee ;)
> 
> > > Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
> > > Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > ---
> > >  net/mptcp/subflow.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index 6b1cd42..75ed530 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -213,11 +213,6 @@ static int subflow_check_req(struct request_sock *req,
> > >  				 ntohs(inet_sk(sk_listener)->inet_sport),
> > >  				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
> > >  			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
> > > -				sock_put((struct sock *)subflow_req->msk);
> > > -				mptcp_token_destroy_request(req);
> > > -				tcp_request_sock_ops.destructor(req);
> > 
> > I mean: we just need to drop the above line.
> > 
> 
> subflow_req_destructor() will do sock_put((struct sock *)subflow_req->msk)(if subflow_req->msk not NULL),
> mptcp_token_destroy_request(req) and tcp_request_sock_ops.destructor(req).
> 
> > > -				subflow_req->msk = NULL;
> > > -				subflow_req->mp_join = 0;
> 
> and subflow_req->mp_join won't be used again, so can drop all this five lines?
> let tcp_conn_request()->__reqsk_free()->subflow_req_destructor() do this?

Yep, looks safe as-is. No changes needed to this patch, AFAICS.

Thanks!

Paolo

