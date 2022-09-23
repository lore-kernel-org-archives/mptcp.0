Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7B3D63
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663940468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaOBt8Vj1L5hapRWD88cdOkKyoL2yP7AjKFb42aCTxE=;
	b=jOYYqRU7jxE45Z7/7b5TQ0GXEXz6sfgSxG1463mdhZbe8vKdTHcf0UQXulUF0bh3GNvNSv
	KnyMhrKNsmhpZ7ZASI+IGQrotzRFm2oFTwjCjBCDg3bL6g/8ns0sc9U3teS5kBDrGvok8R
	kmrLSKzXnkpp+aW/t7TpfLVqUt5D79I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-Jod92UDwNPih43E33O7LtA-1; Fri, 23 Sep 2022 09:41:07 -0400
X-MC-Unique: Jod92UDwNPih43E33O7LtA-1
Received: by mail-qk1-f198.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so21605qko.17
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 06:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=FaOBt8Vj1L5hapRWD88cdOkKyoL2yP7AjKFb42aCTxE=;
        b=u52mOJ3rQPHUUFy30Pzbl6E3KtEm3Wm3RDni+dGnNcGO9Sw39gg7mzsxKqAM5kfPzp
         abtGwOwDh0Gc/GS8PCbCOLhRfTKb0VfU/BdH8EdFwbfgSpSTzksMySKUYjLrZV8qarl8
         AqZPh8iQx3WkBf67FI9jb7X90KmYd0CwZPc8BCIShHzyJT4w1fcpS0CVNIjJlVDY4C6p
         WLjpLNh4MQB3wIvAO6Z7AP7ErRDnR790/qRI3JHWiVjAt5Xc240TTbRE4oyg3HFZZx+8
         J7wsgjqdxp9zJJMVDjzqaDUEVrXgBofswStTxdiIGJhKxjjETQwVBmVAFnfWcWR/OyZQ
         xNyg==
X-Gm-Message-State: ACrzQf1u4H4FgbX/efIRYDd+YPbMvPrXzU2ShTpiJQ7/gMhPO8SkpPjl
	5RtqJQQYT5eOCzTsauAS9eSRNpCvDFP+yUtq9BsGepMFivxXcmA4XmEeJHK/cxlSjUVeZH3iLaa
	GpGzHcYuJEwwrTbs=
X-Received: by 2002:a05:6214:508f:b0:4aa:a63d:ad12 with SMTP id kk15-20020a056214508f00b004aaa63dad12mr6965615qvb.123.1663940466473;
        Fri, 23 Sep 2022 06:41:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM49UySTSS77f+OdvU9tVt57kIYPPy3VnSHjIq+/zw+jVx3fHa/TAs/F5chlOb6IbjNBJmIlIw==
X-Received: by 2002:a05:6214:508f:b0:4aa:a63d:ad12 with SMTP id kk15-20020a056214508f00b004aaa63dad12mr6965598qvb.123.1663940466168;
        Fri, 23 Sep 2022 06:41:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id t9-20020a05620a450900b006cbc00db595sm5704858qkp.23.2022.09.23.06.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:41:05 -0700 (PDT)
Message-ID: <7f43bbeb39794139fb8c9ae26851bfeea4e5a965.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 0/4] mptcp: add support for
 TCP_FASTOPEN_CONNECT, sender side only
From: Paolo Abeni <pabeni@redhat.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 23 Sep 2022 15:41:03 +0200
In-Reply-To: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
References: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
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

On Fri, 2022-09-23 at 14:19 +0200, Benjamin Hesmans wrote:
> The series only considers the sender side.
> 
> Compared to the previous RFC patches, these ones focus on
> the sender side only. It corresponds to the 4 first patches from the RFC
> series.
> 
> The sending part is less complex and even if it looks like we are
> converging for the receive part, there are still discussions on-going
> there.
> 
> Again, thank you Dmytro for the previous work done. As already discussed
> on the ML and meeting, this approach was slightly different from what
> Dmytro originally proposed. Here tcp_sendmsg_fastopen() is exported and
> re-used and TCP_FASTOPEN_CONNECT is supported.
> 
> MSG_FASTOPEN will be handled by Dmytro's patches.
> 
> Individual changelogs have been added per patch.
> 
> We would like to credit Sébastien Barré, Gregory Detal, Olivier
> Bonaventure and Christoph Paasch for the original idea of supporting TFO
> in MPTCP, see https://datatracker.ietf.org/doc/draft-barre-mptcp-tfo/
> 
> It would be very nice to have these patches accepted in the future
> kernel 6.1 which will be the next LTS picked by many vendors: the
> modifications are quite small, well isolated and re-using what is done
> in TCP for years.
> 
> v3:
> - Add Dmytro SoB as kindly asked at the last meeting, the code is still
>   the same.
> 
> v2:
> - Drop support for MSG_FASTOPEN because we were not sure that it was the
>   correct way to do it.
> - latest patch of the series: apply comment from Paolo concerning
>   mptcp_poll()
> 
> Benjamin Hesmans (3):
>   mptcp: add TCP_FASTOPEN_CONNECT socket option
>   tcp: export tcp_sendmsg_fastopen
>   mptcp: poll allow write call before actual connect
> 
> Dmytro Shytyi (1):
>   mptcp: handle defer connect in mptcp_sendmsg
> 
>  include/net/tcp.h    |  2 ++
>  net/ipv4/tcp.c       |  5 ++---
>  net/mptcp/protocol.c | 26 ++++++++++++++++++++++++++
>  net/mptcp/sockopt.c  | 19 ++++++++++++++++++-
>  4 files changed, 48 insertions(+), 4 deletions(-)

As noted in last public mtg code-wise LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


