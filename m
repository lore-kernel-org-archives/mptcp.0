Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C77B
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664362942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGMvSEiBMHKgniJ7sqJQQ6Qlpd1iQZmv4yTi+akjblk=;
	b=CDxQPYVzwn8NCMeffeIN2ymnRx6oRrib6pwynUbhEduvSimP5XRC764ye/vtriVt0GVMZN
	KZnXgAK38GLj0puloDvbjpMwyNtSeIxwzQGIfO6UFSZG5+lSdUcywi2V0i4W5OlYNMYLRF
	m1HyxFEqegiQyKOIRta2xuZjvfcdD8s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-4VNjUQu_OjCB4e6U-uNX_w-1; Wed, 28 Sep 2022 07:02:11 -0400
X-MC-Unique: 4VNjUQu_OjCB4e6U-uNX_w-1
Received: by mail-qt1-f197.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so8697107qtb.13
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 04:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=GGMvSEiBMHKgniJ7sqJQQ6Qlpd1iQZmv4yTi+akjblk=;
        b=nsepJGSTT+LBcIKqRXBH5KD3XrixJZHUrUXt+GP7eDYAU8P2OSJXutBpT+GwBYnfP4
         Qk1NuwwSVSQk8LYv1+T1l4Sv/kIBecvChRoB1I7+3moCc8HDGbOxenECnU7rZ6hBjrIQ
         kpQ7NRVO2K56yVRVEJ/2E26ZJW+rv3WBsrb8OqVE982+G042LR86J8ajCU0sfUOIUf2q
         WcBwUbyUKOwA0vCzRrtE05H0dyRNhEfn/w4zYUj+WgstT2tRMKre7UB5XVJwl529FSFJ
         XctHA5vOs+Fx6Pi4icSxvLxyfkcuXcHBn9o3nkizJSZrg5Cytknrb2vPkBcTMzOY7uvo
         Xl8A==
X-Gm-Message-State: ACrzQf1NT1wbPtovNUdYyv3EZ+WafWL8vGUhcd5FQ2WmRwkG37FFJhl0
	YrydiSfBxL3PVKLMQFLwqvhgGeD9+FjBRSvDcRy78MtWve87kx4jxZ/ferB4vhuagV5MtQtX6gD
	myDvs8GtQYCeoHDA=
X-Received: by 2002:a05:620a:1793:b0:6ce:a093:f190 with SMTP id ay19-20020a05620a179300b006cea093f190mr20784347qkb.282.1664362930840;
        Wed, 28 Sep 2022 04:02:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54CQE9xTXy0xoCabfNu40phN4mWZUatm17QC/xwAGMjTxsNODunhLuj3G+Umm/UKgnAYMpeQ==
X-Received: by 2002:a05:620a:1793:b0:6ce:a093:f190 with SMTP id ay19-20020a05620a179300b006cea093f190mr20784317qkb.282.1664362930458;
        Wed, 28 Sep 2022 04:02:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id s6-20020ae9de06000000b006cf36d46902sm2758600qkf.66.2022.09.28.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:02:09 -0700 (PDT)
Message-ID: <5b186defb2217a8de5ef73c4a8f0809dac920d07.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/4] mptcp: update __mptcp_push_pending
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 28 Sep 2022 13:02:07 +0200
In-Reply-To: <0b90e9ec304d919c833863e056f8e6c7b62d0dc2.1664358100.git.geliang.tang@suse.com>
References: <cover.1664358100.git.geliang.tang@suse.com>
	 <0b90e9ec304d919c833863e056f8e6c7b62d0dc2.1664358100.git.geliang.tang@suse.com>
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

On Wed, 2022-09-28 at 17:48 +0800, Geliang Tang wrote:
> To support redundant package schedulers more easily, this patch moves the
> packet scheduler out of the dfrags loop in __mptcp_push_pending(), invoke
> mptcp_sched_get_send() only once. 

I fear the above will make cause hitting HoL blocking [more]
frequently/easily. I'm not sure if the simult_flows.sh self test will
catch that, but you should see a measurably worse running time for such
test - in non debug build, as the average of multiple runs.

I'm sorry, I can't see a feasible way out here :(

/P

