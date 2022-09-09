Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031304A2D
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 15:39:41 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id o25so3412673wrf.9
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uaqvVoGs7fE1kYaPrmZkHDDM4IW5asg9zw1b/TKtp9M=;
        b=WOP02ckJCcAniC69xpHAAdI3lwtLg20NrR5AtHa2vK6N6MCf1MZBdK1g12sKStSYsq
         tQnIDqygqko6HhON80dKZqXVTskoTtWGcHmO/TVzYdRs3Y8cylrOMD9KAFLmGasdu1t4
         oFJvuiygGQthhtQeV6q/xkJvnt9+piUHOUXpAjIORSzNioGflgzlUf8i+pi1eMfoHBDz
         cVdUWVCLEqWzdCndUuDnkxer+BmxUbo6YMOv4Hnkjoj9Y2sX41L2hIk0FDe4u3hHKd2q
         J+1rc/y4hI61N4486BkVzV7NLFiPx/ngpz6bU3HMp/qYLZw5BvbSM6nV7H8z+3Fz9kyo
         qpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uaqvVoGs7fE1kYaPrmZkHDDM4IW5asg9zw1b/TKtp9M=;
        b=sjKPchFCAYeMZi6aLFEvvEFNofsU2D45+0pbLErRkOF3JFytI38U1fMEh6r8o7oGMl
         T9s4s5NW/faUlYMwG6PABUA829oqTTKsqrYDjOZJZGS9GKRcGJRe0As9Y9ZywUQjwGSB
         wQBfIV0kUwxgdXPZwMqU7uiuAK3VfsTGu59ib/MsJWc1QykiBU6p8oJwYy0tqGGE5GYQ
         M+XT7xHJ6D2hD0XGfhp419UbJGq2fnNxgZdZcIeL/bHHn2pwTCPcIhHyCoJCjZagF3Zl
         6YpaXesZsIuaVQPmOhKSEFwRlqUWUTmqDIdlw0vvEMnIwUj7+tiEsxlsDWL6LwZg5ByG
         DVhg==
X-Gm-Message-State: ACgBeo2sm059c4q7P0MJRCVk04dCxke8+6TkLDUNGRGvCom/ehVSjZmf
	JvBXXazGoU+j+pi3bYpA6dGiOw==
X-Google-Smtp-Source: AA6agR7XkIuKJqIoo3InSylWByy9mS61jEMdiiicSZKPnQGZHODWPxa+rR/6eR7HB33s+vMsMAVjjQ==
X-Received: by 2002:a5d:4d0c:0:b0:228:cd9f:5a4c with SMTP id z12-20020a5d4d0c000000b00228cd9f5a4cmr8727170wrt.138.1662737979811;
        Fri, 09 Sep 2022 08:39:39 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm985014wrq.81.2022.09.09.08.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:39:39 -0700 (PDT)
Message-ID: <8b87693f-66a7-67ce-752e-d98df7162552@tessares.net>
Date: Fri, 9 Sep 2022 17:39:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: update and extend
 fastclose test-cases
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com>
 <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/09/2022 10:49, Paolo Abeni wrote:
> After the previous patches, the MPTCP protocol can generate
> fast-closes on both ends of the connection. Rework the relevant
> test-case to carefully trigger the fast-close code-path on a
> single end at the time, while ensuring than a predictable amount
> of data is spooled on both ends.
> 
> Additionally add another test-cases for the passive socket
> fast-close.

Thank you for the v4!

The whole series looks good to me.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>


I wanted to apply it but I just realised that like with the previous
version Patchew didn't apply this v4 as well. Maybe because there is no
cover-letter?

I just applied these patches manually and I will wait for the CI to send
its report before applying them.

https://github.com/multipath-tcp/mptcp_net-next/commits/patchew/904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 24d4e9cb617e..7e4ce3caa5ed 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -72,6 +72,8 @@ static int cfg_wait;
>  static uint32_t cfg_mark;
>  static char *cfg_input;
>  static int cfg_repeat = 1;
> +static int cfg_truncate;
> +static int cfg_rcv_trunc;
>  
>  struct cfg_cmsg_types {
>  	unsigned int cmsg_enabled:1;
> @@ -95,11 +97,15 @@ static struct cfg_sockopt_types cfg_sockopt_types;
>  
>  static void die_usage(void)
>  {
> -	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-i file] [-I num] [-j] [-l] "
> +	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-f offset] [-i file] [-I num] [-j] [-l] "
>  		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-j] [-l] [-r num] "
>  		"[-s MPTCP|TCP] [-S num] [-r num] [-t num] [-T num] [-u] [-w sec] connect_address\n");
>  	fprintf(stderr, "\t-6 use ipv6\n");
>  	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
> +	fprintf(stderr, "\t-f offset -- stop the I/O after receiving and sending the specified amount "
> +		"of bytes. If there are unread bytes in the receive queue, that will cause a MPTCP "
> +		"fastclose at close/shutdown. If offset is negative, expect the peer to close before "
> +		"all the local data as been sent, thus toleration errors on write and EPIPE signals\n");

Just a small typo here that I can fix when applying (if I don't forget):

  s/as/has/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
