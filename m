Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13412F23
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668093407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txjJdnHd8FwmHGpW4eXiKjldihG44Ve2ZUcUmm0CiqQ=;
	b=HDX1hhBQ7t1j16qMuflC0NgL3YTeOxJB6EyRCdRUTlenuKPksebOxRRi/1h+dxZrJ2oOpF
	L1VOS9rQafOVmMNTRjnm/YmI6CNTvMe0AZrV6idzNkia8DYTbijyMvQ2k2Mb1IZut6V9Cq
	FYOEtT301xTnbaoCcH4BcuESKCuJOH4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-Pcevzy3xOAqZKBc9XeCi9Q-1; Thu, 10 Nov 2022 10:16:46 -0500
X-MC-Unique: Pcevzy3xOAqZKBc9XeCi9Q-1
Received: by mail-pg1-f200.google.com with SMTP id l63-20020a639142000000b0046f5bbb7372so1146901pge.23
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 07:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txjJdnHd8FwmHGpW4eXiKjldihG44Ve2ZUcUmm0CiqQ=;
        b=gCjeGXf1i9Gefy+ErixcT0U/MdlZOMcFU1gr3gv90caf45dhDBim1X6G8jCH/XoVbA
         8FGD50/1nbBcm9Coeg3wHKKAwFb2UHP/bpJQxhTGhHGmzmtlg2aqjGytrFyQtZT0/nRd
         r9i2WQ6sset0AVQH8XYxmBWXeXhXPmOBrwxU5vEyNXcy7Hu8+5ZhxyjZIAiGegh/qIMw
         QxA/ms8+6wDTY34P1xBQCSHVpq4pMBUgoGKY419Ww4BPlPvjjWBVlKGEgXFSfTxqS57j
         73SNS+7KfMW/QpwesGepB2s5/D9x9NtAfSRV85yfre58WWlBtThXWMbiiMX0LO5o4Liy
         1CPg==
X-Gm-Message-State: ACrzQf2Yk4JaWjy7u91fzoMrTnToIPyw0Q6wl2vK0dULvUxw/H/YaKFD
	DP9au8OJKfyXQmCym4QVlLc477EmuwG/AisM89HOULAEbN87KzmrLbRrDGRFppaPoI+9ozcnjN5
	79Dgcwsy2UuWIvkU=
X-Received: by 2002:a17:902:d708:b0:187:2721:68ca with SMTP id w8-20020a170902d70800b00187272168camr54762707ply.92.1668093405032;
        Thu, 10 Nov 2022 07:16:45 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5kpTiavWVwXxGGm+FAgzU1WmRfZ2UJ61EJz0WznPoMQHkuB+N1puyQBrHSiDq6GgKvOr4O2Q==
X-Received: by 2002:a17:902:d708:b0:187:2721:68ca with SMTP id w8-20020a170902d70800b00187272168camr54762686ply.92.1668093404705;
        Thu, 10 Nov 2022 07:16:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b0016c0c82e85csm11346611plb.75.2022.11.10.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:16:44 -0800 (PST)
Message-ID: <31e92725f4ba400a3a4814c5488e8ef590f6e3a9.camel@redhat.com>
Subject: Re: [PATCH net-next] Squash-to: "selftests: mptcp: mptfo
 Initiator/Listener"
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Thu, 10 Nov 2022 16:16:37 +0100
In-Reply-To: <9c47d201-e38e-b0e2-6397-c612e679f16e@shytyi.net>
References: <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
	 <41b40e837c47147ce713ae0d35a916471d36f82d.1667993466.git.pabeni@redhat.com>
	 <9c47d201-e38e-b0e2-6397-c612e679f16e@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2022-11-09 at 19:15 +0100, Dmytro Shytyi wrote:
> > @@ -374,13 +375,15 @@ static int sock_connect_mptcp(const char * const remoteaddr,
> >   			set_mark(sock, cfg_mark);
> >   
> >   		if (cfg_sockopt_types.mptfo) {
> 
> Below I used  (wlen == 0) check to avoid possible multiple times 
> execution in the loop of double/triple/..-time offset of read(infd,).
> 
> Example: 1st enterance of the loop will read() from infd and set offset 
> 0+X in infd, thus 2nd enterance of the loop will start reading from X, so
> 
> we could loose the previous data  (data between 0 and X) by attempting 
> the sendto in a loop.
> 
> Should we drop this check or this assumption is not relevant in the 
> current context?

Yup, you are right, we must preserve the len check here and do the read
only when !wbuf->len ...
> 
> > -			if (wlen == 0)
> > -				wlen = read(infd, wbuf, sizeof(wbuf));
> > +			winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
> >   
> > -			syn_copied = sendto(sock, wbuf, wlen, MSG_FASTOPEN,
> > +			syn_copied = sendto(sock, winfo->buf, winfo->len, MSG_FASTOPEN,
> >   					    a->ai_addr, a->ai_addrlen);
> > +			if (syn_copied < 0)
> > +				perror("sendto");
> >   			if (syn_copied) {

... additionally drop the perror() here (the relevant one is below) and
explicitly check that syn_copied is not an error code:

			if (syn_copied >= 0) {

I would opt for more squash-to patches...

Thanks,

Paolo

