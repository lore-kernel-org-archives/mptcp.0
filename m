Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4120E4
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 11:06:29 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id a3so7137450wrt.6
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP3lCi4NJuaIOlKV4uS9sC4HS8GI3bVrkiowavBSUnw=;
        b=0csHyA9r2p5ZlCb009TbrqQtpjgSyEKxu8VzF8102U09XpY63OPk4tewkFJdQNDLmW
         jfIUht5s1GHWuGgrAraM9PZBcXl28IXX06i5+JtcRjheG67U4T1YEZXdU6hB/v5OE8xR
         XaKdp48hlaeBizslgwKO6NiAbRURo97PQaeXa7vAduTUuJCqvO5Ub5fkZLLCA3mTmoWj
         v3W7I3TjnO8/y9c+N7LTHRwRbr81xLX5s3csFtlzH67+Laq/QrA5WbIiqT6WroviQL1w
         ccSuupSaTRsnq2xZ6oaKx5aowoNIoTWPPHQg8N5/GcYBvCPIiaCXDNs+bWK+VQq4oQQj
         wRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP3lCi4NJuaIOlKV4uS9sC4HS8GI3bVrkiowavBSUnw=;
        b=N2o7RhuHVfkLZ1LRBWW3IsJuOfWl9AFbC9nQ0QbXqTgp4r0EWDVcYeMy8RxP0k4gWy
         SnT85mDDQGldf2vIPiik7cW85oUymgDpjYIbiWtGXjqJgdAY++BkdrIGQb/ArA5Cm+qI
         EHBwNnqUUduU3boBVDQn6EXN4sTOUsvvjww16f57qgU0nAdLy0ZjtgQ2za2QSTluf6UW
         Hu84lpPUWwyEnNSv+ftamnZcJ0wdeouIvg+KL5HpDCaahyQZJGYFEukiMGWLFwZrLyXB
         m5bPpLWpJ5wB0ZTG2Exkh/jdWFWcnDrh4M334DYPEi9PdzPR3oJnB2SAcadV1uBt0GeQ
         Yhkg==
X-Gm-Message-State: AO0yUKW5CUOHlntj3ryM0S6mF7dhO23Y7fOGt6/ruVbw/JFLgxh5poF1
	r5RaY/tyrUgGx0wty2g/WF11JtY7vWPJfC9q
X-Google-Smtp-Source: AK7set+PsgaUlKB3cXwDfpcdg7UqXagaNfMV776sZ69sJ3qs7gcRLbjGf//H0+0QfdRky9pQSyVc6A==
X-Received: by 2002:a5d:6f03:0:b0:2bf:b672:689b with SMTP id ay3-20020a5d6f03000000b002bfb672689bmr2635731wrb.62.1675163187372;
        Tue, 31 Jan 2023 03:06:27 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:8fe6:f95f:22e9:6db7? ([2a02:578:8593:1200:8fe6:f95f:22e9:6db7])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6e89000000b002bfe266d710sm9572215wrz.90.2023.01.31.03.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 03:06:26 -0800 (PST)
Message-ID: <92a8c03f-8e18-1ac5-253c-9c7653ea5cc0@tessares.net>
Date: Tue, 31 Jan 2023 12:06:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net] selftests: mptcp: allow more slack for slow
 test-case
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <9da09e4407af3ccd51489686c71a3c07c2cb6d3b.1675101940.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9da09e4407af3ccd51489686c71a3c07c2cb6d3b.1675101940.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 30/01/2023 19:06, Paolo Abeni wrote:
> A test-case is frequently failing on some extremelly slow VMs.
> The mptcp transfer completes before the script is able to do
> all the required PM manipulation.
> 
> Address the issue in the simplest possible way, making the
> transfer even more slow.
> 
> Additionally dump more info in case of failures, to help debugging
> similar problems in the future.

Thank you for looking at this!

> Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this is just a wild guess, since I can't repro the issue at all. Ideally
> it would be great to have a loop with mpj 115 to validate this

It looks like I can still reproduce it on my side when I stress the host
and lower the priority of the VM as mentioned on the ticket:

https://github.com/multipath-tcp/mptcp_net-next/issues/323

I also have the long waiting time after having displayed the 2 OK
messages as described on the ticket but no more ignored error is
displayed, I guess this is fixed by one of your recent patch :-)

For the "long waiting time" issue, it is longer with the patch but not
new: it was already present before your modification. I can share a
patch to stop the transfer earlier and avoid waiting for nothing.


Just one detail below:

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 387abdcec011..4e428871f961 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1704,7 +1704,12 @@ chk_subflow_nr()
>  		echo "[ ok ]"
>  	fi
>  
> -	[ "${dump_stats}" = 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni | grep token; ip -n $ns1 mptcp endpoint )
> +	if [ "${dump_stats}" = 1 ]; then

I just noticed 'dump_stats' var is not reset/init (and marked as local)
at the beginning of the function.

I can add:

  local dump_stats

above as part of this fix if that's OK for you :)

Other than that:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
