Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742B168A3
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 16:03:04 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so2570261e87.2
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688140982; x=1690732982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVgOz9x0rbCFFbKPE7AT3Y0wyF4LoN0D2krwUaiVo8Q=;
        b=xFQXxj5k/gMaCis6UOlEZMxh54WOVgkikGuJMi39eIyJzhmUcRyslkbN/ji6dSc3pV
         EtiSJ6XrhVq5ytsKHuJkoErDtCcETkR+sxoDbOeZeRFdXgGHTAUB1kzFiPP+P2D7ht5e
         SYAY8pLyTT2YH30Zvi/+8hp4yKoXglXOlpGn0aAKcd8GMYqv/+Pw1tSUumz+Gz04GMux
         3QOUrNKBlITJPEhc9rogrj/BZV9gU+JYdl9l0sYsdn1XknYsOANKbZHm8bxu6xsLSYqp
         wy85IfsMHZUzw35YkUVVR6avPRS4PWI0NTsnKACCIMqY9X2eaRqVJ19JCmWktXcKjdvv
         Qpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688140982; x=1690732982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVgOz9x0rbCFFbKPE7AT3Y0wyF4LoN0D2krwUaiVo8Q=;
        b=kJNjtejFZxizt6ATqhe+7FBy6ShuwagEor7+QibxUuk3kXQhIm+QsWVfd/r+s0IQTD
         2ZJ4g0JBcmUSd/Li0weo2JIOUpAvBlq/P7jGLorApF8xxeCwMKKUT0Yj08Os0B2CoMBM
         9GnFt1yexsuh0xiV+c2HuURVB1NeiEMKNGoucHnl6tgQJntsI4P7sSVVVh0/m/6uqriN
         RujvMUtNXDVkDFtEiBrKQglQoLQ57yLCshiJO95m8EsQaz/nbEVB8kzl7ffuiYZCdf0g
         fIgyymf9fSCu6SyUWWQsvkE2kTVbRRCS77Ow+w2Dq5IWBy3F7Rop8l88E05zdvD0TrBt
         Um5A==
X-Gm-Message-State: ABy/qLYaKDMeeWXX3rgv1ut8fS8rTgTDcPqC2ckDWQkHr8Sl1oArQNI3
	gn9ud2qRHh1ZKJjqyTb3gsuCRA==
X-Google-Smtp-Source: APBJJlHgL9JWdGgbqyl7mydKZUX6JfuX3KTyBKvnY+D07zOO46zlyEttPQ/YEN9xN3DGalp6TV6shg==
X-Received: by 2002:a05:6512:70c:b0:4fb:7b2a:78de with SMTP id b12-20020a056512070c00b004fb7b2a78demr2502015lfs.45.1688140982346;
        Fri, 30 Jun 2023 09:03:02 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7d492000000b0051da4b5bc8fsm4085227edr.20.2023.06.30.09.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:03:02 -0700 (PDT)
Message-ID: <724f9aa6-b66a-700c-a411-5aa19768af53@tessares.net>
Date: Fri, 30 Jun 2023 18:03:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH iperf3] add MPTCPv1 support
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for this, that would be helpful!

The code looks good to me, I just have one suggestion for the commit
message, one "typo" with the alignment and one small suggestion in the
code. Please see below.

I think you can create a new PR on esnet/iperf repo (and mention it
replaces the one of Paolo).


On 27/06/2023 07:20, Geliang Tang wrote:
> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in the
> upstream Linux kernel since v5.16.
> 
> MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
> The only required dependency is the 'IPPROTO_MPTCP' protocol number
> definition, which should be provided by the netinet/in.h header.

I quickly looked at the comments that have been posted on Paolo's PR on
Github and it looks like the blocking one was that the configure.ac file
has not been modified to check if the feature was available or not.

I think you should mention in the commit message that there is no need
to check for IPPROTO_MPTCP support in configure.ac at build time, it is
at runtime we will see if the kernel being use supports or not MPTCP.

If IPPROTO_MPTCP is not supported by the kernel being tested, it is
normal to fail because the feature is not available.

The only thing I see we could do is to restrict this feature to Linux
builds. But this can be done later if they ask for it I guess.

> This patch adds a new flag --mptcp to support MPTCPv1. It can be used
> like this:
> 
>  > iperf3 --mptcp -s
>  > iperf3 --mptcp -c 127.0.0.1
> 
> Linked: https://github.com/esnet/iperf/pull/1166
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  src/iperf.h            |  5 +++++
>  src/iperf_api.c        |  4 ++++
>  src/iperf_api.h        |  1 +
>  src/iperf_client_api.c |  2 +-
>  src/iperf_locale.c     |  1 +
>  src/iperf_tcp.c        |  4 ++--
>  src/iperf_tcp.h        |  1 -
>  src/iperf_udp.c        |  2 +-
>  src/net.c              | 14 +++++++-------
>  src/net.h              |  4 ++--
>  10 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/src/iperf.h b/src/iperf.h
> index 0051a30..89af39b 100644
> --- a/src/iperf.h
> +++ b/src/iperf.h
> @@ -63,6 +63,10 @@
>  # endif
>  #endif
>  
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
>  #include "timer.h"
>  #include "queue.h"
>  #include "cjson.h"
> @@ -167,6 +171,7 @@ struct iperf_settings
>      int       idle_timeout;         /* server idle time timeout */
>      unsigned int snd_timeout; /* Timeout for sending tcp messages in active mode, in us */
>      struct iperf_time rcv_timeout;  /* Timeout for receiving messages in active mode, in us */
> +    int       mptcp;
>  };
>  
>  struct iperf_test;
> diff --git a/src/iperf_api.c b/src/iperf_api.c
> index a2cd53a..e19ca38 100644
> --- a/src/iperf_api.c
> +++ b/src/iperf_api.c
> @@ -1104,6 +1104,7 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
>          {"idle-timeout", required_argument, NULL, OPT_IDLE_TIMEOUT},
>          {"rcv-timeout", required_argument, NULL, OPT_RCV_TIMEOUT},
>          {"snd-timeout", required_argument, NULL, OPT_SND_TIMEOUT},
> +        {"mptcp", no_argument, NULL, OPT_MPTCP},
>          {"debug", optional_argument, NULL, 'd'},
>          {"help", no_argument, NULL, 'h'},
>          {NULL, 0, NULL, 0}
> @@ -1594,6 +1595,9 @@ iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
>  		test->settings->connect_timeout = unit_atoi(optarg);
>  		client_flag = 1;
>  		break;
> +            case OPT_MPTCP:
> +                test->settings->mptcp = 1;
> +                break;

It looks like you used spaces instead of tabs here.

(the whole iperf3 code doesn't look like they are using one or the other
in a consistent way but I guess it is best to imitate what is done here
just above/below)

>  	    case 'h':
>  		usage_long(stdout);
>  		exit(0);

(...)

> --- a/src/net.h
> +++ b/src/net.h
> @@ -28,8 +28,8 @@
>  #define __NET_H
>  
>  int timeout_connect(int s, const struct sockaddr *name, socklen_t namelen, int timeout);
> -int create_socket(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
> -int netdial(int domain, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout);
> +int create_socket(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, struct addrinfo **server_res_out);
> +int netdial(int domain, int type, int proto, const char *local, const char *bind_dev, int local_port, const char *server, int port, int timeout);
>  int netannounce(int domain, int proto, const char *local, const char *bind_dev, int port);

I don't know if you should rename proto to type in netannounce() as well
just for consistency reasons. Up to you

>  int Nread(int fd, char *buf, size_t count, int prot);
>  int Nwrite(int fd, const char *buf, size_t count, int prot) /* __attribute__((hot)) */;

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
