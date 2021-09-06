Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E33FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630935631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI5+Dlby8UR/vrXNYuXhGv9Q+ZaVYuIc/5wODKcpLAs=;
	b=IaZeTgy/UoceFkkkoHxBRMUbfnqwP0eNA/EQMg9RK4YQJk3ozNscnk7uuqilEIboJYPwrP
	S0G/63OlPhwPvL/4bnbPhE+OKB4LzZef1KO5g+2o3CpRo2WODsOdrWTM8QgHCxmUvzX5mb
	bSyFSepll47bitC4d7T91PamQ/uEbUc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-FZW7vDVQPoahITcDVlSraQ-1; Mon, 06 Sep 2021 09:40:27 -0400
X-MC-Unique: FZW7vDVQPoahITcDVlSraQ-1
Received: by mail-wr1-f72.google.com with SMTP id h14-20020a056000000e00b001575b00eb08so1205913wrx.13
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 06:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gI5+Dlby8UR/vrXNYuXhGv9Q+ZaVYuIc/5wODKcpLAs=;
        b=YjBejWydxLpmREBZd9Ea7nTNR1hlinlXf4JAYzr6UmpMRowguVpOE76vbpk4LmZs64
         yV47X2sf4mNaN5JWQpXzpATns+UUhUw5AaU5P8hQD5iZhZmceyDbKFT4s1Vi2bpT4AHt
         vYIY345lVWpDzmNSh4hdK0fay/yw1BSzqeCJ5aGQyUZStOBBToxOXgi/st/1az7rqA7w
         E4kdwelU5CeGJRfZqD/j9yDVoq5dZCmeV8JoBx/P1vAJQtZ9MwOtZcoZE3XUVGpNQ8Hb
         z+EM4AtLorf/JL/JlZ1lAy/LSmyiAoqXFiKF6X1tRu21gtjTlH+rNgVK61hzGgZM1USv
         hGRQ==
X-Gm-Message-State: AOAM5317XRJo0JrkZtNTLa/lum0OE7+4twe7ZsM5+5V8oYKQnnwCFnm1
	+zaM6xo89/ARxuaGEmr1jmvCAqqweRYj+Ffr9LVVkF/z0fDBa2FxCi3ga4GwrBYOFELFOuzr6Ye
	j0jGmLbtgGT2LGcxa2bPeL5KC9RQ6KgNz46+R7PUen13HeWVa7JM/7imluE1OOyRW
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr13586724wrg.358.1630935626227;
        Mon, 06 Sep 2021 06:40:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy19JRbP35CIcG5FLmZ80QoHH2P1PeVSzssQLT1xk0l02npvVjKBKyMoUtATWMfhaI3Nu+iOw==
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr13586691wrg.358.1630935625917;
        Mon, 06 Sep 2021 06:40:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id u26sm8331041wrd.32.2021.09.06.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 06:40:25 -0700 (PDT)
Message-ID: <5c66a4912f61bfb4ad2df9677c3d2ac02f1ed1cc.camel@redhat.com>
Subject: Re: [RFC PATCH] selftests: mptcp: tune timeout and delay for
 simult_flows cases
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 06 Sep 2021 15:40:24 +0200
In-Reply-To: <126a63a07de5709e2702abb5f431f9128146c60a.1630922799.git.pabeni@redhat.com>
References: <126a63a07de5709e2702abb5f431f9128146c60a.1630922799.git.pabeni@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-09-06 at 12:08 +0200, Paolo Abeni wrote:
> We currently have some instabilities in the simult_flows tests-case.
> The problem boils down to the unneeded large wait introduced by the
> tests to allow for the MPJ handshake to complete, which can also
> introduce a quite relevant variance.
> 
> Do wait on a single side of the connection, remove the delay at
> shutdown time and tune the expected test time with the above.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/137
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Side note: the change in mptcp_connect.c may impact negativelly the
> mp_join self-tests. In my local experiments they are still working
> reliably, but it would be good have some spins in the slow CI/debug
> env for more consistency
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       |  1 -
>  .../selftests/net/mptcp/simult_flows.sh       | 21 +++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 89c4753c2760..8070e090688d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1010,7 +1010,6 @@ static void parse_opts(int argc, char **argv)
>  		case 'j':
>  			cfg_join = true;
>  			cfg_mode = CFG_MODE_POLL;
> -			cfg_wait = 400000;
>  			break;
>  		case 'r':
>  			cfg_remove = true;
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 910d8126af8f..8af49014a604 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -51,7 +51,7 @@ setup()
>  	sout=$(mktemp)
>  	cout=$(mktemp)
>  	capout=$(mktemp)
> -	size=$((2048 * 4096))
> +	size=$((2048 * 4096 * 4))

whooops, this change is unintended, I'll drop it in later version.

@matttbe: could you please drop it in the CI, if you pick this patch
for testing?

Thanks!

/P

