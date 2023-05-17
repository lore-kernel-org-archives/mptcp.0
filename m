Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D518B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 14:26:01 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30935d343f7so796602f8f.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684333560; x=1686925560;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECHNb7Ido6bFBJqayWP2ESOWxemoPHCtte9BHpJTXI8=;
        b=jp/BcuWfiBVZUZ4esgqrSEini9Jg/u+v9DPMiMqyp7kD84gVT0EOuqe1vGAEE46NJa
         QYhi/uUYaufiL2hcnzHTZCWXceUvOv6zSdEXpCrhOG3cOlDFWPa4g3pKW2qyF05DMFSp
         m4cB0he9Z9LSYMiO0pkpa3oCtQZaOrV3ggsIRD1It03i70gLasVVfR6MF5liUa8U6U4a
         PvHLzoPkhReRpUaIfZjrpyX1h14l+qtDAK8GCY4XCp24ntZmwXHOrlWLOfmEHU9FVwsS
         8dSPSORAyTnQ5ZuWVlGgyHN2sL0IagsJwA7FOvBVcqDVUJvEDfP2LNyjxLz/x91i6D3F
         829w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333560; x=1686925560;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECHNb7Ido6bFBJqayWP2ESOWxemoPHCtte9BHpJTXI8=;
        b=WjYWaIMCW6nGVHwzecXt/IEpXZiCXwQKXQfG7lEkdiTrmS9+PGYEfWWpMwkSjsLjuT
         pZqewPfxLVY0f31BMUgoSL9nN/MtZweRLJEqK+oZJOaGMC5KCIr+NZ9GTUXyxfatiYXF
         i8QVRkRIFpytJsVmuelge1nb5ovIbPMT2q70RTlHJyhHlj0fvwxz+vMDuh2tenPAuyb2
         p89frbKg6+dO/yO+sO3pxIbExyiMLs0aarJrGPabzed9JbqWZTCyxeZXGEYTAjtJSjIS
         Ccxh7mQpxXXKBJmBjiXUJOWEUaWcZmQi6E6wzFXX/3yoCwZL/ypEoVTCG3sh7/HKo6yD
         YHDw==
X-Gm-Message-State: AC+VfDxAg/K8SGJdMwRI93skuMoh3mJ1U349UojMh4t4tt08wOmUvB/9
	yOeThcPNrwmd3yYJYYv12OT+XQ==
X-Google-Smtp-Source: ACHHUZ5oX5ijYiyu6SQ6hSkuGRjDoeGZ8FXmVVJ1zYg1fL7ZxAEWFSq+hR64Qf5okp4O+xBRmd9m1g==
X-Received: by 2002:adf:ce07:0:b0:309:3b4a:cdf4 with SMTP id p7-20020adfce07000000b003093b4acdf4mr817396wrn.67.1684333559995;
        Wed, 17 May 2023 07:25:59 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id a8-20020a056000100800b00307d20546e6sm3263970wrx.27.2023.05.17.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:25:59 -0700 (PDT)
Message-ID: <af3935bd-04c2-88ea-7349-3af4ade2ad3c@tessares.net>
Date: Wed, 17 May 2023 16:25:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 1/4] mptcp: add subflow unique id
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1683212362.git.pabeni@redhat.com>
 <456718f354d8db508b2db8590d9b055d49c728e9.1683212362.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <456718f354d8db508b2db8590d9b055d49c728e9.1683212362.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/05/2023 18:39, Paolo Abeni wrote:
> The user-space need to preperly account the data received/sent by
> individual subflows. When additional subflows are created and/or
> closed during the MPTCP socket lifetime, the information currently
> exposed via MPTCP_TCPINFO are not enough: subflows are identifed only
> by the sequential position inside the info dumps, and that will change
> with the above mentioned events.
> 
> To solve the above problem, this patch introduces a new subflow identifier
> that is unique inside the given mptcp socket scope.
> 
> The initial subflow get the id 1 and the other subflows get incremental
> values at join time.
> 
> The identifier is exposed to user-space overloading tcpi_fackets in
> MPTCP_TCPINFO.

This smart idea solves the issue with MPTCP_TCPINFO but not with
MPTCP_SUBFLOW_ADDRS. But I guess for the second one, we can easily add a
new field in "struct mptcp_subflow_addrs", right? If yes, we can do that
in a new dedicated commit, that's not blocking this series I think.

We can add:

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/388

(But not the "Closes" tag then)

> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/uapi/linux/mptcp.h | 3 +++
>  net/mptcp/protocol.c       | 3 +++
>  net/mptcp/protocol.h       | 5 ++++-
>  net/mptcp/sockopt.c        | 1 +
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 32af2d278cb4..49bfbf85cb80 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -249,4 +249,7 @@ struct mptcp_subflow_addrs {
>  #define MPTCP_TCPINFO		2
>  #define MPTCP_SUBFLOW_ADDRS	3
>  
> +/* MPTCP_TCPINFO overload obsoleted tcp fields with MPTCP-specific info */
> +#define tcpi_subflow_id		tcpi_fackets

Should we eventually add a comment next to the declaration of
"tcpi_fackets" in include/uapi/linux/tcp.h to say that this field is
being used by MPTCP_TCPINFO? Or this is not needed because this is field
is only overridden when using MPTCP_TCPINFO?

I guess it will never be removed anyway. But could it be overridden by
another field at some points later?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
