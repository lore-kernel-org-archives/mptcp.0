Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5A79C9
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668445704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obznp/OrZBkVkCDrlAUchoB/z457QPfqCzipofwIpFs=;
	b=UURszuhaI1qFlK4Huqc/vaxeNk+QgCynWGlwcUiShNM17tFfRwpDPdWQ8nk08pa9lgija7
	nHQEp0VLd1oGs6faAaBkAUaHhPDTGlBLk6vBRMWhISJwazTMjO72VMJ5zBpBlyQLLO/39W
	zDoOArPuzgwapzSbHy37JtPczl2yo/E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-262-vybREyRCNjiO5bxun7-r1Q-1; Mon, 14 Nov 2022 12:08:14 -0500
X-MC-Unique: vybREyRCNjiO5bxun7-r1Q-1
Received: by mail-qv1-f70.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso8799288qvr.0
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 09:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obznp/OrZBkVkCDrlAUchoB/z457QPfqCzipofwIpFs=;
        b=BIBQ0jNjufIG4kSJfq7CHsTrGHSg6uVqxe59Ye/d2LA0HT9bDSd/ccSvBgXqLrXxvc
         LrW8nNpGks0KXDbZf4NzxxCnrkegr78PeKGqzMGYiWt9T+aBLkoten2/mwBja3A6ybju
         VLvu7zIyvIZthpgzxQydysK8INuXh8BeCV40MjdJRDDR9fIpJvK1cnv1j17Ysc/IPueZ
         azRS4BiZhQWTIPwAfv/QskqP+eTU2jm+xV8wxSSTOXacIA9s8YHLNHz2Yby4uS5AB6gX
         QNoEc+ixCIthlqttJ9GmvV4Fx0agcj2OKaBS0zl9fZbHS98djStVt2k8hhnOJOlqy+Ix
         kaHg==
X-Gm-Message-State: ANoB5pmhwTd+l+1g5rb2/qSyoBmFRD6m/7RXs2G4xiFpefOvRn0DPNnd
	EfLPNA+TiW84zqAETER/GDzPRiSm/LJxKygkiijmi7V4W5NavBdC3yAAiJvQWu4/umBmAfQfKq5
	0paH/7YWhg0Kbpfo=
X-Received: by 2002:a05:620a:1a07:b0:6fa:4af5:701c with SMTP id bk7-20020a05620a1a0700b006fa4af5701cmr12108847qkb.13.1668445693988;
        Mon, 14 Nov 2022 09:08:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Dgq40qWB7vEV5kt8EnI4bUfpLFKSOxAXELmjppjjbESFHSDsJTeowSIRfQxa6fFAVDtYi8g==
X-Received: by 2002:a05:620a:1a07:b0:6fa:4af5:701c with SMTP id bk7-20020a05620a1a0700b006fa4af5701cmr12108821qkb.13.1668445693676;
        Mon, 14 Nov 2022 09:08:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a430a00b006eed75805a2sm6717571qko.126.2022.11.14.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:08:13 -0800 (PST)
Message-ID: <0a7f892acf37dfeea5f0ee072f76b526e9345c1f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/5] mptcp: uniform code style and fix
 checkpatch splats
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Date: Mon, 14 Nov 2022 18:08:10 +0100
In-Reply-To: <1a4372b7-3206-162c-c198-c16891391f01@tessares.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
	 <1a4372b7-3206-162c-c198-c16891391f01@tessares.net>
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
Content-Transfer-Encoding: 7bit

On Mon, 2022-11-14 at 17:58 +0100, Matthieu Baerts wrote:
> Hello,
> 
> On 14/11/2022 17:45, Matthieu Baerts wrote:
> > Just some small quick fixes about "issues" I saw when I applied the patches last
> > week. Nothing important: function names, place in the .h and small checkpatch
> > splats.
> 
> An additional thing to do is to update the commit message of the first
> patch of the "TFO listener" series which is currently:
> 
>   mptcp: introduce MSG_FASTOPEN flag
> 
>   In the following patches we will analyse the MSG_FASTOPEN flag
>   in the mptcp_sendmsg() and invoke the MPTFO.
> 
> Maybe by:
> 
>   mptcp: add MSG_FASTOPEN sendmsg flag support
> 
>   Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") from
>   Paolo Abeni, all the infrastructure is now in place to support this
>   flag.
> 
>   The remaining action to do is to allow it and treat it as a fastopen
>   message to be able to access this:
> 
>     sendto(sockfd, ..., ..., MSG_FASTOPEN, ..., ...);
> 
> What do you think?

Possibly something a little less verbose? Alike:

"""
mptcp: add MSG_FASTOPEN sendmsg flag support

Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") all the
infrastructure is now in place to support the MSG_FASTOPEN flag, we
just need to call into the fastopen path in mptcp_sendmsg()
"""

?

