Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5A2F3F
	for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677076373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJWBx1EEe24wnYc6dOKphC1tRymYTGFXTTRJhvOF1XE=;
	b=bTIiaNz2lcSKsM6a5njoI1KTNVGG72lGO4a2uldwTbgljkEC7abwrutixeeQelN1ujMKGw
	2vLW+eRVmoBcDhA0Vaf6VT8gYxGAcgW0CN03vbnp23MqyO+YPrB9JljFm2ozHlsY+kuAQf
	2Zv0oC39OFpfy7Gz4H/Fm77ToXSATSs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-9Fo3Ewl-NkWdjjRqSSNMFg-1; Wed, 22 Feb 2023 09:32:51 -0500
X-MC-Unique: 9Fo3Ewl-NkWdjjRqSSNMFg-1
Received: by mail-qt1-f197.google.com with SMTP id a18-20020ac84d92000000b003bd0eb1b44fso3358614qtw.6
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 06:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677076368;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlbRYLDanzWF8gn4ZDe7lEFAlDBXYwsuVZ7TG/f7WWg=;
        b=HkzpDSL6kujBzdwr6ZKW8eLP+F7pWYwHwaMle+zL3vtn3Xsa/BblI4bucyGBq7OmeS
         Z9YovwerBBABsuxl1oqJcLLWh7v+ITMW4m+reZNOjWqtYSsbKApkYkHP6sN+U6JAnGHo
         8s1PDQa6OIZB1Lp1ETq70Ro0WFrwa9XPXbdWlWfqHLS5quyD5hgi+2cUL4Pwxg/htklL
         Hxht54qTxR9rjJfs+Hzl7Y3qdfwlCRkXpKEJr/62O1yKe3qPF3cwjBr+FbzIuI3noG2W
         O/tuTw0piLWnwNsG4ISlUfth0vsHEwlYJpupjWa4LdRLdu1uJ1uZujqvDLBXo3O0kI0A
         +A9w==
X-Gm-Message-State: AO0yUKUPxrFVKFG1r9/0wfZ885c4Nu3jDH+Ybms7OliTCNoHAIo831jT
	+rEYtkO+4TFxBbzdKCqog9gi/HZfO5czbsR5865E1M/uMNwHYXSFHJK/rMHqdxYNafU3k84SGpk
	bRSuJd/ED1sclSbvBiTzX
X-Received: by 2002:a05:622a:2c2:b0:3b8:5dfe:c3dc with SMTP id a2-20020a05622a02c200b003b85dfec3dcmr17148223qtx.3.1677076367890;
        Wed, 22 Feb 2023 06:32:47 -0800 (PST)
X-Google-Smtp-Source: AK7set9cluo0njVzgKxIdx6zukF+uDjd18LfI1+nifBRb9HGOVHLZKFnoSSKM6+45VyX6B2F9In0aw==
X-Received: by 2002:a05:622a:2c2:b0:3b8:5dfe:c3dc with SMTP id a2-20020a05622a02c200b003b85dfec3dcmr17148194qtx.3.1677076367573;
        Wed, 22 Feb 2023 06:32:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id m16-20020ac866d0000000b003b835e7e283sm2530357qtp.44.2023.02.22.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:32:47 -0800 (PST)
Message-ID: <5634a811ff8da65d6063ec03218a6462f5a189e7.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: avoid setting TCP_CLOSE state twice
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 22 Feb 2023 15:32:43 +0100
In-Reply-To: <20230221-mptcp-warn-tcp-done-close-v1-1-d248242b29b6@tessares.net>
References: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
	 <20230221-mptcp-warn-tcp-done-close-v1-1-d248242b29b6@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-02-21 at 18:54 +0100, Matthieu Baerts wrote:
> tcp_set_state() is called from tcp_done() already.
>=20
> There is then no need to first set the state to TCP_CLOSE, then call
> tcp_done().
>=20
> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/362
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/subflow.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 28c64811a8af..a36d1b1088d7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -406,7 +406,6 @@ void mptcp_subflow_reset(struct sock *ssk)
>  =09/* must hold: tcp_done() could drop last reference on parent */
>  =09sock_hold(sk);
> =20
> -=09tcp_set_state(ssk, TCP_CLOSE);
>  =09tcp_send_active_reset(ssk, GFP_ATOMIC);
>  =09tcp_done(ssk);
>  =09if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags)=
 &&
>=20

I think this one could be squashed to:

mptcp: fix possible deadlock in subflow_error_report

WDYT?

thanks,

Paolo

