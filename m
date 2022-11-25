Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5082F41
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 22:35:08 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id d1so8626884wrs.12
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 14:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMIe8WzYew8Aq7jUaZLEA+Ww6ePxrAf2PLP3rlGKBR4=;
        b=tdIJlXyy31Q3SOjzIYTv/84bZtCk6joyJjP/ldIz826ru6PVFwrw3oSKv2RTcEWs3e
         z5I+EWaOxuuvmvgQGchd39lCM6A2aImHlS8FScB/Dj49F3p+lTQfgEQoEeoPM8XO4M7z
         DODGHwjxue3RGLSfLUN/g5zhh77YCsMqazHVW10AqcaUaTTSXtycdykTyUQbSIRN76yI
         i54FY7uJU42Ntb+62u0KBynx9Wzd/f9eMR9vUfJK4SeBn9lbBAQNuwP0WW19PdmnULyh
         PaV9ruxZp39TW10Qy86/zoF3aYRd6ffw+vNYyAqxsb0EpSLTsq1Y/2uUXDs+uGZzYG3t
         mO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMIe8WzYew8Aq7jUaZLEA+Ww6ePxrAf2PLP3rlGKBR4=;
        b=7keGzjYiWZsaJh1T4V3ciVQQwk94peh2fk8KRM6bBA4F/fQMB0ftRPAu/9J5QPmRoP
         7D1HjFUdaTQKsBFeibTV3tqB8l6vfx/36fZcLvHcn1WwwDexeZ+wpvvGguXMYxv3J5sg
         80a5HvEMgFvH8UVxFv+o3+niV/bxuP5dcDv70xMqIf2C55J78t0lepKM5kwQ5r37mlkM
         HIW9UxMpP0Isvgl84I3kWhl4LBbYgc4z25SiabLMeng1VfKqfY446Q8+j7I++Km974ig
         p8y1Ox0eTvhwwIy1ieO0H4kwiqmTsrTh02Rbujy6YIvuf9bXletP/yH9/wKQvUTEW96X
         WRDA==
X-Gm-Message-State: ANoB5pmEhHkL2eSYvyJ56qwyggz9NtdD+n6Aub28rbE0VRxqFlPHMEdw
	ip53GJfhAX5NdVteiZOaC9A1vVrIHWVZ2uOs
X-Google-Smtp-Source: AA0mqf4GjjTqYSehMXMaMSfZgVGt5uiNiO4Z/vtwvg8acYQd55KqarQdNlAeyIvuaeAyfy1jEPAZXw==
X-Received: by 2002:a05:6000:10c6:b0:241:d021:52d3 with SMTP id b6-20020a05600010c600b00241d02152d3mr17486978wrx.540.1669415706692;
        Fri, 25 Nov 2022 14:35:06 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:290:7ca:2a3e:9f9e? ([2a02:578:8593:1200:290:7ca:2a3e:9f9e])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003d04e4ed873sm709763wmq.22.2022.11.25.14.35.06
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 14:35:06 -0800 (PST)
Message-ID: <b2c2b1f3-82af-f987-b7e5-f6106270aff8@tessares.net>
Date: Fri, 25 Nov 2022 23:35:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add
 subflow_v(4,6)_send_synack()"
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20221125212028.702058-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221125212028.702058-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 25/11/2022 22:20, Matthieu Baerts wrote:
> This is a small cleanup, just to avoid duplicating the whole function
> for v4 and v6 while the only difference between the two is one call to a
> different send_synack() function.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/subflow.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 05099b3760b5..2ff3840fc058 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -307,12 +307,9 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>  	return NULL;
>  }
>  
> -static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
> -				  struct flowi *fl,
> -				  struct request_sock *req,
> -				  struct tcp_fastopen_cookie *foc,
> -				  enum tcp_synack_type synack_type,
> -				  struct sk_buff *syn_skb)
> +static void subflow_send_synack(const struct sock *sk, struct request_sock *req,

I just applied this patch with a small change:

    s/subflow_send_synack/subflow_prep_synack/

- 61e817662ce3: "squashed" in "mptcp: add subflow_v(4,6)_send_synack()"
- Results: 2deca8211919..ace83548981f (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221125T222831

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
