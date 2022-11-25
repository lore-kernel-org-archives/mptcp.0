Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAE5C9B
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669389396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hVJ2LmhtEaqHiPxwdt5kB9xG2nMdxn7kehi62EDgc4=;
	b=VvoYPSpFI8BQpoQyitesWxVbTuV+l6MYHhbvWE70bb+Tx0Fs638sqv/TbhAXhdVaBBEMfG
	NWX7KcqdoSg5tNmEG7YVvqenbwY4u2Yz6DjYhN2+7QG3W4JJRWcQFa+WmTMktk7KYex94y
	/YQ1eTXM7cUiP28UtbEpZCjkTQsLftg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-fp57WVjCOeC-K59BQm57kA-1; Fri, 25 Nov 2022 10:16:35 -0500
X-MC-Unique: fp57WVjCOeC-K59BQm57kA-1
Received: by mail-qk1-f199.google.com with SMTP id y22-20020a05620a25d600b006fc49e06062so4190761qko.4
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 07:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hVJ2LmhtEaqHiPxwdt5kB9xG2nMdxn7kehi62EDgc4=;
        b=PG3XdtvBVJ/p22xpOhKkVH+J4GwnTLvRIKQ93D+dDU+Z0cKC23joWDcGIfbU08Hzu1
         aRqw+TzHwcA18FOtZp9Uqc0JRXiIV+6RU9dK1ack2nKsKAM06RlshQM1ltWkFn5aM5rQ
         s7dXW9wM58z2adVviz8OJMVlrRYdOiDk/GwC8pRc36d5evKECSQzuZ93D77nyGOAzAPV
         M7C2W8e3n+fbd42XUa8OL9YhfrE3FOXqx1qNserM9mQ+SFZ4uhziYxwY8KJvX9OA2feV
         4esn02IOndcFOeiwiY/+z6Unes/Dds5XoKlAM1ccXEANu6C1I5qA9Vw2VqD60Z2Fj/AQ
         ERnw==
X-Gm-Message-State: ANoB5pm/qD2ysJReJqmM2s2HZChiURGsOk4niBN9tt3c/QN8+MzmXhVq
	eTbOoL6g/9riwElLsV9Bca7JWDQey+Uv+bgaPyiawxfS4+JNUqpGbh21YhWy/O+abA2Qw08o9kC
	HzfbXOxfR4kFtYxs=
X-Received: by 2002:a05:620a:16c5:b0:6fa:9834:ce59 with SMTP id a5-20020a05620a16c500b006fa9834ce59mr34220446qkn.276.1669389394715;
        Fri, 25 Nov 2022 07:16:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ChEQ52V1I9hsYa82Gro2GmKOva18xGT//jT38Vo/+kBuaTnRE8YuY926BUx+/lzGl/YdPKg==
X-Received: by 2002:a05:620a:16c5:b0:6fa:9834:ce59 with SMTP id a5-20020a05620a16c500b006fa9834ce59mr34220423qkn.276.1669389394376;
        Fri, 25 Nov 2022 07:16:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id br7-20020a05620a460700b006faa2c0100bsm2912874qkb.110.2022.11.25.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:16:34 -0800 (PST)
Message-ID: <bd8f3e4cbf84a3beaf2cd5cbf6f6aa0cb69c8d71.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: add support for TCP_FASTOPEN_KEY
 sockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 25 Nov 2022 16:16:31 +0100
In-Reply-To: <20221125145257.123844-1-matthieu.baerts@tessares.net>
References: <20221125145257.123844-1-matthieu.baerts@tessares.net>
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

On Fri, 2022-11-25 at 15:52 +0100, Matthieu Baerts wrote:
> The goal of this socket option is to set different keys per listener,
> see commit 1fba70e5b6be ("tcp: socket option to set TCP fast open key")
> for more details about this socket option.
> 
> The only thing to do here with MPTCP is to relay the request to the
> first subflow like it is already done for the other TCP_FASTOPEN* socket
> options.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Paolo Abeni <pabeni@redhat.com>

