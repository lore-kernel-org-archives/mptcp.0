Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A2182C1
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 15:20:23 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-30aa76048fbso1591951f8f.2
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685028021; x=1687620021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wJHlpJDJh2+6kqJbLgeeKao/qL0KsbFrL/1i0VmgX4=;
        b=vYrtnBV2htRhFoEEZFFS2aBEDgAo4rGv3fs6kVwvmPg8jMmjI4YykoiFdUGathESVw
         0ihO46i0GDy3xgTd637i1AGF0f4P2wXszdl/pb2VQSELtseQvFh3Pnj5SGeoRiUPeecX
         qpUZ4YrO36aSo1BuwQJq0ZBJlJiAxYXmzNDfExZhPbomrJ0oAfvJopnCk8xWZ5pJHRAR
         NHNhlGX5xcsgcOGdgXWe9JhaheiOGrWcVje4GR0kaaS/5wY5P6gc6HoGG6bwyjnoxdWm
         Q++n1+9q2TfzKLtvrGURiN7xlpea18p14Bg2IvLDrkPWIUiryxc+tpH3imXWacWx7kbs
         QpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685028021; x=1687620021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wJHlpJDJh2+6kqJbLgeeKao/qL0KsbFrL/1i0VmgX4=;
        b=L+NCX7ZdDe/mI/K4/EVoAtNDDXiWzWtbOpg9kkY+umMylvdJomdvSJZ+48PtLhDQNT
         LQUwIF3hnOW3Kxf9DrSlI+RcxTdBNy8JfjP6KmdM7CGWgNkQuvLboG+96kZWZQjSvRCK
         qdeapQ9qCxitatDHOaeCGBu+gHh9dtxtz7itcK4O4/T2k4/xZ0u9au5c6h33KUL4xlOO
         Tqbsp38cAdEjFtQNLd/67V+l111z/xPiPL65+Sgnpv/NJfgCqaecT/4VY6Vujvtxo/pH
         HUtgugPPj7kHqm7TskFnYvs6g+6PFA/hBbZcQb/vSnnIkhgKBCyHG+c5TN/gS2KyWT9G
         jvgg==
X-Gm-Message-State: AC+VfDwTJNe5AevV3pfdPHAhfb4fLOZ4SxUUfU7SCD7nxymXHlONQgC2
	QeREeIAczHQ8jPBbXQaJekadJg==
X-Google-Smtp-Source: ACHHUZ7MeFy0LS+KJa99m912SmuUOsTOkk8qAHPk50S+VVsL3GAji3Dp6K5ywkb7j4mLA9kqXFuYHw==
X-Received: by 2002:a5d:4fc2:0:b0:309:4620:e155 with SMTP id h2-20020a5d4fc2000000b003094620e155mr2849202wrw.49.1685028021457;
        Thu, 25 May 2023 08:20:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id c4-20020adfe744000000b003047d5b8817sm2135109wrn.80.2023.05.25.08.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 08:20:21 -0700 (PDT)
Message-ID: <da4cf0aa-04b7-007e-0905-c3710f0fa08b@tessares.net>
Date: Thu, 25 May 2023 17:20:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 mptcp-next 5/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684997011.git.pabeni@redhat.com>
 <6445ff289e2784aca7f93847fea85abf304c9d50.1684997011.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6445ff289e2784aca7f93847fea85abf304c9d50.1684997011.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/05/2023 09:17, Paolo Abeni wrote:
> Some user-space applications want to monitor the subflows utilization.
> 
> Dumping the per subflow tcp_info is not enough, as the PM could close
> and re-create the subflows under-the-hood, fooling the accounting.
> Even checking the src/dst addresses used by each subflow could not
> be enough, because new subflows could re-use the same address/port of
> the just closed one.
> 
> This patch introduces a new socket option, allow dumping all the relevant
> information all-at-once (everything, everywhere...), in a consistent
> manner.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v5 -> v6:
>  - fix compiler warning - unused variable
>
> v4 -> v5:
>  - full_info struct re-design (Florian)
>  - fix build issue on 32 bit hosts

Thank you for the update! I find the new version clearer, hopefully
easier to maintain and to use from the userspace side.

(...)

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 770279e0a598..bfbe0378e997 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -14,7 +14,8 @@
>  #include <net/mptcp.h>
>  #include "protocol.h"
>  
> -#define MIN_INFO_OPTLEN_SIZE	16
> +#define MIN_INFO_OPTLEN_SIZE		16
> +#define MIN_FULL_INFO_OPTLEN_SIZE	40
>  
>  static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
>  {
> @@ -977,7 +978,8 @@ static int mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
>  }
>  
>  static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
> -				  char __user *optval, int __user *optlen)
> +				  char __user *optval,
> +				  int __user *optlen)

Do you mind if I undo this modification when applying the patch?
Or did you do that on purpose?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
