Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E16105
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663596405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDQuQX3lHM+cAUQD6hBHQn+GXr1/D+dF36i6Sg3VxFw=;
	b=SPFQWleKsTLuB8HgW1bZyjKCg5TgMC6UrNXJ4CwSCQYBh4aiHfnyh3t6G+jnpdOzUbiHmY
	uwDlZfRUrHnoBMYHI7zTJW/K/t4KxYfHyEU3xUbnD1W/930dEe2Xfrx4Rd+gU3o+Tjoqlg
	CVZfH16ygHeFLjxWYJ4NR+PYaYC9xXM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-gxSc0qS_MDav-vPFB3uqIg-1; Mon, 19 Sep 2022 10:06:44 -0400
X-MC-Unique: gxSc0qS_MDav-vPFB3uqIg-1
Received: by mail-wr1-f69.google.com with SMTP id d9-20020adfa349000000b0022ad6fb2845so1594618wrb.17
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 07:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=cDQuQX3lHM+cAUQD6hBHQn+GXr1/D+dF36i6Sg3VxFw=;
        b=TG0lxAWNY883rRAQcgdW846/YSr/cqA13ACNpd2PP7gi76Xi/Ba3cjGOttcB0qEBlL
         OqfO6Giy8UHu/HO30iiEEwSpcV4Y+k/c/2Iiww+ahon9NJhmUqxXj3D+jqYn/pqin4wX
         uHxq1Kl4QOBggcR4w/rskLub3GMvnRfp+m8JCmGCHiKbKMevbVmBobR3hLoTy7y+mPhd
         1tFjZ015n/vsii3Xv29UE83oBlvUHD+d4lA5Auj3fqLN89K2JNT2EPJsUuwsPXTxafBv
         OkG28+pX+RKlWbaQO732BBV+Dv4MhEb5OtFcCncJpfmdkUHtUFjMSStyjqdbOLgL45sd
         V//w==
X-Gm-Message-State: ACrzQf2XuZRUWZ3yQuU1cS+bPj4NOJG2SiTSlQhGvHdpMWqQRprmf09c
	Gt4344yRbMvqJPvtVjufIayl/VjePJJh722ofVZRyzPbVjwogrGmahimH0Id+vXFwra7HGViE9n
	Lxz4hCTwXzu60nHs=
X-Received: by 2002:a5d:5503:0:b0:22a:2fd7:d778 with SMTP id b3-20020a5d5503000000b0022a2fd7d778mr10407210wrv.44.1663596402993;
        Mon, 19 Sep 2022 07:06:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5qLas3gNXsd6ZAcy6OxPBTpJgCKW6rZ7n7ZIqPrw9itUiKTTsGGpZkcYOzHh0SZXm6TIIN6A==
X-Received: by 2002:a5d:5503:0:b0:22a:2fd7:d778 with SMTP id b3-20020a5d5503000000b0022a2fd7d778mr10407197wrv.44.1663596402801;
        Mon, 19 Sep 2022 07:06:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id y16-20020adfdf10000000b0022af6c93340sm5916471wrl.17.2022.09.19.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:06:41 -0700 (PDT)
Message-ID: <30a517a1b28201dc53d3008d5903542342df7c4b.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 10/11] mptcp_fastopen_add_skb()
 helpers (skb to msk)
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 16:06:41 +0200
In-Reply-To: <20220917222853.2406-11-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-11-dmytro@shytyi.net>
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

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> Set of helpers for mptcp_skb_add(). Some functions are inspired from tcp
> fastopen.c file. This chain helps to add “skb” to 
> “&msk->sk_receive_queue”
> Example: “subflow_v4_conn_request”->”mptcp_conn_request”->
> ”mptcp_try_fastopen”->”mptcp_fastopen_create_child”->
> ”mptcp_fastopen_add_skb”
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

I think this hooking is not necessary. Leveraging the existing TFO
implementation and doing delayed ack_seq initialization, as in Benjamin
series should suffice. 

Thanks,

Paolo

