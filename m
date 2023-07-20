Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC3171D2
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 08:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689840908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZFutkrH2f4wYNv5ivPI0gd6g5QJETda19qUOFnIveo=;
	b=VuF+qfYLcKI4Fj80WSRSk5wMs5HfySY8ItAnydHOaUyEWLkvfW0a0VGnxy/Uzc147rwRFh
	tRBwdyjnnAAslRYMf8HEZw5AOpWuhrysnNNH1d4gll5srzHm3j6gPce3PiMqme4B/aKdS9
	3lSVP81gFWl4tqtXw6XSb31MHi2Yp0c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-AgmnByEJNDiR6UuWakZZ7Q-1; Thu, 20 Jul 2023 04:15:07 -0400
X-MC-Unique: AgmnByEJNDiR6UuWakZZ7Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-403a1b0e259so1606781cf.1
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 01:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689840906; x=1690445706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZFutkrH2f4wYNv5ivPI0gd6g5QJETda19qUOFnIveo=;
        b=jxMuBMoK2MgLGQ9BFJ05OuLJX5jxjZuxCet4eWzHxF2dKpR/Jj4dZGP+7IRmQ75ruq
         GgfVMGnS7wWJzPHXuzqBaY7GK8V7eA5VlQwChn2qhPrLo0hOk+PKER8HiacrJl5sKgk/
         YmwlEFqzOQ0cSbgn0toEXN0aeZyV2mTgzL9BrnA4Isbt0JO79xL9HNn1G6DJgKn7/DVW
         ZCmuNCmEj+J94vG5q/a+9DkQWS0tSh6Hh6/gcZo/0upULulFZeW1AvtPxfvaTvzoIbq4
         nD3l5Jk9BrDjYWLFOThc1Fs4LkBhKqz23a0im7mSOHR7QpK/nst8ZQSvqjgKi+uppxdZ
         8vAQ==
X-Gm-Message-State: ABy/qLYB2h7ZO++rFk/a4L2Lu1R/ZvEMY41kg0J/a84G51D3/9PBDa6y
	fg9ChrZLz0MQCQ6t+L01GKQrd6sPhITi2Wt3reBGuKuRNwWRdsiQkpF6S8mCCLRPiAdRpHz77vv
	LrOh3zBUrT4ys8HtVtZCqvFZF955vjBI9QNEd4YLtfjnkSeZg3vGAHOltvzDlVIYrzUtwPpAZ
X-Received: by 2002:ac8:5a8d:0:b0:400:8036:6f05 with SMTP id c13-20020ac85a8d000000b0040080366f05mr2584173qtc.2.1689840906420;
        Thu, 20 Jul 2023 01:15:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGXVTh9dPCtGSLtizCyjMp8SmEgJgsELlAzRtZ2bqmTV+JWSYgGyYVtOKSzLvUv4Ixr6gIthA==
X-Received: by 2002:ac8:5a8d:0:b0:400:8036:6f05 with SMTP id c13-20020ac85a8d000000b0040080366f05mr2584156qtc.2.1689840905978;
        Thu, 20 Jul 2023 01:15:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id u8-20020a05622a17c800b004039a43ddbasm157279qtk.53.2023.07.20.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:15:05 -0700 (PDT)
Message-ID: <b888ebd5f39d3f8e7b39168fd4dcebe26e44c416.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix rcv buffer auto-tuning.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 20 Jul 2023 10:15:03 +0200
In-Reply-To: <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
References: <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
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

On Thu, 2023-07-20 at 09:03 +0200, Paolo Abeni wrote:
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") brok=
e
> such assumption, and as a consequence most MPTCP connections stall on
> zero-window event due to auto-tuning changing the rcv buffer size quite
> randomly.
> Address the issue synching again the MPTCP auto-tuning code with the TCP
> one. To achieve that, factor out the windows size logic in socket
> independent helpers, and reuse them in mptcp_rcv_space_adjust(). The MPTC=
P
> level scaling_ratio is selected as the minimum one from the all the subfl=
ows,
> as a worst-case estimate.
>=20
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> I still see quite frequent failures on mptcp_join tests 19 && 20:
> 020 multi flows, signal, bidi, link fail
>       Info: Test file (size 12288 KB) for server
>       syn                                 [ ok ]
>       synack                              [ ok ]
>       ack                                 [ ok ]
>       add                                 [ ok ]
>       echo                                [ ok ]
>       stale                               [fail] got 0 stale[s] 0 recover=
[s],   expected stale in range [1..-1],  stale-recover delta 1
>=20
> I *think* such failures are still caused by dfa2f0483360 ("tcp: get
> rid of sysctl_tcp_adv_win_scale") because it should change (increase?) th=
e
> rcv buffer/adv win size, and such tests depends on the transferred files
> being significantly larger then the adv win. Since the current breakage i=
s
> pretty bad and the above needs more investigation, sharing it now.
>=20
> @Matttbe: fill free to adjust the tag whatever it fit you better!!!

At very least this needs a:

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")

/P

