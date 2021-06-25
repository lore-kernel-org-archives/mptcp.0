Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FA168
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624617938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1NZt1o0Kl/e3aGWrGu2lfxohypq50dhZZ5lC3t9u1U=;
	b=LaeKlc3VFXiO6ARasjuKo/g/Z1+GilKeGPTHdI+sAFYvdfTECcH497ZL4KAR4GTfCPjHtz
	ZkZUMtOGOCCMn2hKkPcnGy+lP84EnUrAMsiqM1GprtLDllhDwRYApu5RlPhaCh8soSHzcV
	iY/69JToZ4ZrrCsDWuWNax/zW7Kv4U8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-BrXyVxKzNISmudqLwoOaVA-1; Fri, 25 Jun 2021 06:45:37 -0400
X-MC-Unique: BrXyVxKzNISmudqLwoOaVA-1
Received: by mail-wr1-f69.google.com with SMTP id g8-20020a5d54080000b0290124a2d22ff8so2770724wrv.4
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=D1NZt1o0Kl/e3aGWrGu2lfxohypq50dhZZ5lC3t9u1U=;
        b=LMBTM8dRTVrQo/1HXkH6TEUfSX4vnptWVCUs6wGgrrf79DvEWFZhBWPkf3H3Dh0xFM
         ebzLc/usWjBMJpYcKlvWK9tyxuz/BYrmpIbPuw4ABzSz6wKR2qSDA3r4YqfIXKIiSCZT
         JOkx9a71Gq3E2inPx6l2Zb+aokFi++XRsY6RKp5ZdNC0wfLHuEvQvsMwqF8Khy8fsv5o
         HJWm5G2KYdIf/QpHXfDO7jUDx8z/DRcNhiTga0uY0kj6naYdt3vl2essMC5ZJeLNiPgy
         bBoDwCMJOU9eMFObAaGars7cns9QKgWGh/DUygXK+X5dOHiFrvzZUbEmNp0iTtVoHP5W
         YyYg==
X-Gm-Message-State: AOAM531/On3T7invEh79fctotMs5nf6ymMLB0ld3ZS5lU+1iFHjyQlFi
	+p1NCLMbtEqnNVn9sSNogNr5x4nQj7wYq3oz70MqUbpmYOpCK0iEdjdurcoU9TZaPLS9wr6A0Jd
	OoH+/ACcfZyHTwVQ=
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr10184459wrk.197.1624617936368;
        Fri, 25 Jun 2021 03:45:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxkEmA//0jlRWurLq8cpvrj5IFq5U8t+GO/grriiFl7OoG6bLvNoEcHonpXfTUTlY+xVNpwg==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr10184440wrk.197.1624617936160;
        Fri, 25 Jun 2021 03:45:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id g15sm5566243wri.75.2021.06.25.03.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:45:35 -0700 (PDT)
Message-ID: <9d8a2d8ae7930e741f5441a36ef19d8039731a02.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v7 4/5] mptcp: avoid processing packet if a
 subflow reset
From: Paolo Abeni <pabeni@redhat.com>
To: wujianguo106@163.com, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com
Date: Fri, 25 Jun 2021 12:45:35 +0200
In-Reply-To: <1624609559-6786-5-git-send-email-wujianguo106@163.com>
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
	 <1624609559-6786-5-git-send-email-wujianguo106@163.com>
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

Hi,

I'm sorry for the partial feedback in my previous reply.

On Fri, 2021-06-25 at 16:25 +0800, wujianguo106@163.com wrote:
> @@ -856,7 +856,8 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
>  static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  				    struct mptcp_subflow_context *subflow,
>  				    struct sk_buff *skb,
> -				    struct mptcp_options_received *mp_opt)
> +				    struct mptcp_options_received *mp_opt,
> +				    bool *subflow_is_rst)

This additional argument is not needed...

[...]
> @@ -1053,12 +1057,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  			__mptcp_check_push(subflow->conn, sk);
>  		__mptcp_data_acked(subflow->conn);
>  		mptcp_data_unlock(subflow->conn);
> -		return;
> +		return 1;
>  	}
>  
>  	mptcp_get_options(sk, skb, &mp_opt);
> -	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> -		return;
> +	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt, &subflow_is_rst))
> +		return subflow_is_rst ? 0 : 1;


... here you can simply:

		return sk->sk_state != TCP_CLOSE;

plus some comment above alike:

"""the subflow can be in close state only if check_fully_established()
just sent a reset. If so, tell the caller to ignore the current
packet"""

/P

