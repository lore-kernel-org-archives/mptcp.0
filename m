Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788952F21
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664203983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPF1NXpRtdxdITxJzJHs+PZ/+ffZD1fhtC1yV9XVlTY=;
	b=eTqY4WWMvQkHLgesMn3Z5FEOne0k1nTCmRg7jqe0M1pTnZN7ydSSFTuwcakBbYav2rT9t1
	O4R3fxCZcqUl7gSUfRGGmIQBOv7RDt7t2zVkDMt0zS9lMYodKSy8d5O0Gj8H4vPYpL9XQb
	nVvrvXVXmfxKO0LGy8dYs0D07gWt2s8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-x00ba_KIPiOFMQjTIhvINg-1; Mon, 26 Sep 2022 10:53:02 -0400
X-MC-Unique: x00ba_KIPiOFMQjTIhvINg-1
Received: by mail-qt1-f198.google.com with SMTP id w4-20020a05622a134400b0035cbc5ec9a2so4906363qtk.14
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 07:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=EPF1NXpRtdxdITxJzJHs+PZ/+ffZD1fhtC1yV9XVlTY=;
        b=FIzDxihN97zSgFiaLz+1i7gik7mbgMb97hmhI3qAcjaZha+VDqhioqbyOkL26m0nyA
         cM/RavQLDSTLdiFP+Ls6P33Sunhl7WchSxMQ0Maq8mOVtpfRONCrZOvguW1CZ6iQcggA
         cfdi8GRhG1f3wv3tQkU6eGEIIAJFlsZkgrfiKGocp/EXgsEF6rxhcIoJBZr9HEfTGlv3
         6cnwij9v8OqJXr6aFjTb75YilJx9GI0LRRxHeETMwg1KKT9l7iq76MMvVSIwDbsrsNjZ
         A94Ca31nd0DKl1tQfuxOWfNpd2arc87RrfOwCdLd/xMuaWiTHtlObAcAkkmUFIfSs3bv
         srSA==
X-Gm-Message-State: ACrzQf23/yfNhr8dis4G0EM3wzP0ELwHkiA3hk9juu9+TRUkIQQaqLTr
	J3FluNm4GtbQ0blcCHmwv34YPiGUWMOBjG+Kax0YcrZ4n+f1ONnsxHqyinw0PvQMLbliSMiPcjq
	ZXFqrKwngGwKhRCs=
X-Received: by 2002:a0c:f506:0:b0:4ac:6d95:1045 with SMTP id j6-20020a0cf506000000b004ac6d951045mr17820594qvm.70.1664203981885;
        Mon, 26 Sep 2022 07:53:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7alVefsbOmfST8gUJ++Orc/YdptG/DiEAvxFpduFEDYtf5ptcuG0AJUmMPdNKvSmmmBEbtgg==
X-Received: by 2002:a0c:f506:0:b0:4ac:6d95:1045 with SMTP id j6-20020a0cf506000000b004ac6d951045mr17820579qvm.70.1664203981693;
        Mon, 26 Sep 2022 07:53:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-96.dyn.eolo.it. [146.241.97.96])
        by smtp.gmail.com with ESMTPSA id cf14-20020a05622a400e00b0031f41ea94easm10851232qtb.28.2022.09.26.07.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:53:01 -0700 (PDT)
Message-ID: <8a9daf89c1df988d86eac05a37c357f1a837d455.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v11 0/4] mptcp: Fast Open: Initiator
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 26 Sep 2022 16:52:58 +0200
In-Reply-To: <20220925232601.25252-1-dmytro@shytyi.net>
References: <20220925232601.25252-1-dmytro@shytyi.net>
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

On Mon, 2022-09-26 at 01:25 +0200, Dmytro Shytyi wrote:
> These patches focus on the Initiator side.
> These patches implement: sendto(..., ..., ..., MSG_FASTOPEN, ..., ...);
> We would like to credit Paulo Abeni, Mat Martineau, Matthieu Baerts and
> Benjamin Hesmans for advices and ideas that improved these patches.
> Without this collaboration this state of work would not be presented.
> 
> Origins of these patches were in the root of discovery of the
> possibility to _reuse the TCP FASTOPEN option in the linux
> upstream MPTCP_ (First commit was sent to the mailing list on 22 OCT 
> 2021: see https://lore.kernel.org/mptcp/
> 17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net/').
> 
> Dmytro Shytyi (4):
>   mptcp: add mptcp_setsockopt_fastopen
>   mptcp: add mptcp_stream_connect to *.h
>   mptcp: add mptcp_subflow_conn_sock()
>   mptcp: reuse tcp_sendmsg_fastopen()
> 
>  include/net/mptcp.h  |  9 +++++++++
>  include/net/tcp.h    |  3 +++
>  net/ipv4/tcp.c       | 21 ++++++++++++++++-----
>  net/mptcp/Makefile   |  2 +-
>  net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++----
>  net/mptcp/protocol.h |  5 +++++
>  net/mptcp/sockopt.c  |  3 +++
>  8 files changed, 105 insertions(+), 10 deletions(-)
>  create mode 100644 net/mptcp/fastopen.c
> 
Plase, on the next iteration include the rx-path-related patches (e.g.
patches 4, 5 and 6 from v9, updated with the relevant feedback).

Thanks,

Paolo

