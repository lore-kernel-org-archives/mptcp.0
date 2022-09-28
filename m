Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF890EA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664357181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5D1M0lVvJyjlUgVM/IpQhsv/ILwb3Pq3JmXgNBl+5iU=;
	b=MKRH87JIuDJb2qhbwi0EA0pfJJIlILuNGmNc/e8F1g6vYp/pjkN0J9j/lOUR/Lv/p8B9LP
	UG+sIT3LSGzMNd44VnhuiQtAn0Li+hc2hHWQ0e/Lad0t8i42CIT4FIDwX90AQvXv4y44Fg
	HWXfCphhpjk+LdvFhx4hCsZNg9GGCgo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-aE8xzG_WPJWnuyQqVhxhFQ-1; Wed, 28 Sep 2022 05:26:18 -0400
X-MC-Unique: aE8xzG_WPJWnuyQqVhxhFQ-1
Received: by mail-wm1-f72.google.com with SMTP id 84-20020a1c0257000000b003b4be28d7e3so900025wmc.0
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5D1M0lVvJyjlUgVM/IpQhsv/ILwb3Pq3JmXgNBl+5iU=;
        b=fAE9l8X4UGQEn6dIsuX7fpDVgJTE/JWRtRrBOCpxX3CWYd5/KVXwD+qOoZt596TqSe
         nVbc1++gcWv3U/cZqqCEGCYrz7PFem0OTtUH7uckulEUrVsQI89iVyLJD5fjp57dGyZE
         XByxZN0/Jvpvj0pDGvPkuHAB6M8OfRke9+M5na3qpnt3xi6XeGXqR3y1U9+hIEuM1FFa
         aXJV+AH4yyYrG8fsi9S2p/nZo3kWb4BYuTwbbvYaGuul1z64LxjL2JRutNRO+WCrrYHz
         BjMWyKU4aQL9YalpHpPGeZQ6qZPpadhhwwr+bcKDLfY7lQcr665RsmvacCr+uuoKw32U
         6YgQ==
X-Gm-Message-State: ACrzQf0PfZ4/l4TzO5TiF8V00+um7j8ZbDhqsb/S2OMe26238D7Mui8U
	u+nzh4al1SXIxvWCvSFVUF8jfe4NKRVQUVUgt+bBxc12tdXGwDf3ELFMuerOqjIvHMy6cSR2tzN
	4r4FZBLrxKWmeqVE=
X-Received: by 2002:a5d:6ace:0:b0:22a:f444:2ad3 with SMTP id u14-20020a5d6ace000000b0022af4442ad3mr19504899wrw.21.1664357177104;
        Wed, 28 Sep 2022 02:26:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78U6xpKbLcjN2T4lD6eQzLHSJ3owCN7ElnvgUnJspU0K12K/0JD5uZOmAVuUCW4BXNNk3eXA==
X-Received: by 2002:a5d:6ace:0:b0:22a:f444:2ad3 with SMTP id u14-20020a5d6ace000000b0022af4442ad3mr19504879wrw.21.1664357176839;
        Wed, 28 Sep 2022 02:26:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c348300b003b3365b38f9sm1277783wmq.10.2022.09.28.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:26:16 -0700 (PDT)
Message-ID: <c6834954d5e8de9ebbd6281b144abf55b7ce2752.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 4/7] mptcp: sockopt: make
 'tcp_fastopen_connect' generic
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 28 Sep 2022 11:26:15 +0200
In-Reply-To: <20220927225341.14165-5-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-5-dmytro@shytyi.net>
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

On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> This is patch provided by Matthieu. As it seems it not yet merged I
> temprorarly integrated in into my series for compilation.
> 'https://lore.kernel.org/mptcp/
> 20220927150306.1552795-1-matthieu.baerts@tessares.net/T/'
> When it will be merged I will delete it from this set of patches.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

You don't need to include this patch into this series, just rebase the
series on top of Mat patches.


Cheers,

Paolo

