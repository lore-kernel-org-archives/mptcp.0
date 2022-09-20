Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC47462
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663689898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+E6UPKT4AwAofvuRvLs/ujwWY4SzHkxoqAYCLaGVfM=;
	b=DIxowozDzpZBqu6XLxysjKdnwK4VX7KldxSc8xdTzW1Qyiz6YmiHkjZwcPPSd1Y2SytxEq
	B31moOb9EkRM6RPT8IBacgky9aYR/DlZWFhNFoX+bESYou3d5VL7L6rVQqJZwOGnzUwllD
	fffjlT6xv6zvTIMXzpeYhuSxXyINAAk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-gIVuODJ_MbamVk5Fn6EFlQ-1; Tue, 20 Sep 2022 12:04:56 -0400
X-MC-Unique: gIVuODJ_MbamVk5Fn6EFlQ-1
Received: by mail-qk1-f200.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so2273336qko.17
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 09:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=7+E6UPKT4AwAofvuRvLs/ujwWY4SzHkxoqAYCLaGVfM=;
        b=Tux+NIP4XxgAtItqZ489neMRxytdfj2bvHB6NOLox3MWkVXL+CT6egVkrgsNTGH4nI
         JStz7e5tfuFCnpOcotgwSx7HryH6ZafPfpL04yhMQVNvo8qqmXhnDiHKTyqIU91yPsuN
         9JfagNXzjv7UYKspFVQ+OHwGNotCnsADp8QNyompK9TDEWBwRF4A0eGZtImTGT//7zY7
         q5vfGk+0SEBFrD1z/U6qJ82dmwy3bS5rx3GEIhlAZNNQaDT1LbGh1z0ZzvyCVbq0i+c0
         RA+tm4+68/qfRio+wT60yD/Tkqir5fBXz6zc3XAcTacxIxo52aHhHHMr46iBDRP3Y2Wn
         XaRg==
X-Gm-Message-State: ACrzQf0ONo6/qkWOM50QmskbnmurypWG8x/FBtrEe9/XFpxVI6/1nzkO
	vuD3Zaq4tZzCHo02X8ZMTlMVx7iQNKkaVUP3a2/gLVUQtrkdIl2rsOwQfzW5HDCP0IploWQfADL
	/5f6JUDUBCbU8BX8=
X-Received: by 2002:a37:9a8d:0:b0:6cd:f1b6:cf0 with SMTP id c135-20020a379a8d000000b006cdf1b60cf0mr17134256qke.677.1663689896003;
        Tue, 20 Sep 2022 09:04:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6sIxznP+KnNeR3GN822+OIOll+6OgkV1jZrbrG7m3YGEzkT5ahcrxHI7fpiFVi3Jq7se7TPg==
X-Received: by 2002:a37:9a8d:0:b0:6cd:f1b6:cf0 with SMTP id c135-20020a379a8d000000b006cdf1b60cf0mr17134220qke.677.1663689895606;
        Tue, 20 Sep 2022 09:04:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id e3-20020ac84903000000b00342fa1f4a10sm120416qtq.61.2022.09.20.09.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:04:55 -0700 (PDT)
Message-ID: <82941fcc7bb1ad0fcb98c56551d7e126a6dcfc20.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v8 5/7] Fix unxpctd val of
 subflow->map_seq(dscrd packet)
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Tue, 20 Sep 2022 18:04:52 +0200
In-Reply-To: <20220920125243.2880-6-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
	 <20220920125243.2880-6-dmytro@shytyi.net>
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

On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
> Fix unexpected value of subflow->map_seq (discarded and after
> retransmitted 2nd packet(1st after TFO)).

The above is confusing, it looks like the previous patches 
intentionally added a bug that is fixed here. If so it's better re-
order the series, moving this one early-on.

> We use mptcp_gen_msk_ackseq_fasopen()
> when we know this is the first chunk of data after TFO.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/options.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8852a13cfe62..8e937a422909 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1212,6 +1212,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  			mpext->dsn64 = 1;
>  			mpext->mpc_map = 1;
>  			mpext->data_fin = 0;
> +			
> +			if (msk->is_mptfo) {
> +				mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
> +				mpext->data_seq = READ_ONCE(msk->ack_seq);
> +			}

With the changes suggested on the next patch the above chunk should not
be needed.

In any case I think it's better to properly keep msk->ack_seq unchanged
after that the TFO syn data landed into the msk receive queue, instead
of resetting it later.

Cheers,

Paolo

