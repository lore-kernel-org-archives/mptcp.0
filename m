Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777642596
	for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 17:00:38 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id l29so9012476edj.7
        for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqlE9ovMLknLU0oeylsQEydbxAZ8zHexT5Sun0Cfeq0=;
        b=UXQhnKQwgwool8og8kT176VSPXovXQ/b3KUThOCirzizYEwyuSx9I/A9FiOf4Ix/QU
         r3XSujHQQ7lq19NBJCW5r45exhFWvnhiZGAk3bOt1dpDJWrbO/nTwQ7SG1QirJVNjDFX
         3ly1DuQE6Dvg2CL3cv0OUyLDtpDC8ub3LAyCaUSceREJYPmGYWA3N+P8XQwDJ7Tx4k72
         PI1w6vdGSAGIqsDpmNAMVYjqlVvv4cy1fdviynsRyFzNBnSyjb0kMunwjx9wl8QWrpV+
         aaIL9mk3f1ZxHIHla+Ev83zjH5/1HdgKqldYqjzjmrV2Zvea1//iGSXqlgHhJRbyYDjF
         T5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqlE9ovMLknLU0oeylsQEydbxAZ8zHexT5Sun0Cfeq0=;
        b=dAzlAl5+Kw1eow/eUvIbtf5FGOCW90WDdvX+q5wZl+sfj6vButSWXAE/UgtteR1B30
         dERUIYDtM7PPaNuXbxJS6utnjGCwVJduK2AnspNjXtqJFPPzpxgprz1cRt9Je4MGCPrN
         Oo1yezwEZH2ZYPl8WyjNDuOPND5d4DzqHzDAGc8TgfI6XwOGs9x14IqozOoWBo8mEetS
         jQ9W6fIIxOXHwa1khdLQ0ajewSM0ohXIJfnEec4TKnATztGCACV/Q7yUDM+oYDTEvHQN
         rY/X6w/nG/35hQR3fiYxufxQI7nn8R5Dwrl55dYOfG9erbMEzIV6wHl88S9qPclJKNgg
         AuYw==
X-Gm-Message-State: AFqh2kqR7jVfop4mKXtW/pXjnjyKB+4L5VgffmYPg7ukAbqo2KTx2ISs
	HgdgxCRlMrU6hE2ouWe3LUIr6FYKTrKELZ2kOSg=
X-Google-Smtp-Source: AMrXdXt1rhuwahMS3JQkboXIdej2Bx+DjOlnEnm2/PkLXPN25Ja0onkrXplYcSGU2p5urwr/PZ0EmQ==
X-Received: by 2002:aa7:d3d9:0:b0:46b:1715:e64 with SMTP id o25-20020aa7d3d9000000b0046b17150e64mr17735973edr.18.1672074036511;
        Mon, 26 Dec 2022 09:00:36 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id da20-20020a056402177400b0046fb9492961sm4801860edb.25.2022.12.26.09.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 09:00:36 -0800 (PST)
Message-ID: <5078260a-db63-a111-bd8b-4d9731d2ce0a@tessares.net>
Date: Mon, 26 Dec 2022 18:00:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 mptcp-next 1/3] mptcp: explicitly specify sock family
 at subflow creation time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671821017.git.pabeni@redhat.com>
 <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671821017.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671821017.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/12/2022 20:00, Paolo Abeni wrote:
> Let the caller specify the to-be-created subflow family. No
> functional change intended, will be leveraged by the next
> patch.

If I'm not mistaken, there is a functional change ... (see below)

(...)

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index bd387d4b5a38..ec54413fb31f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1547,7 +1547,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>  	if (!mptcp_is_fully_established(sk))
>  		goto err_out;
>  
> -	err = mptcp_subflow_create_socket(sk, &sf);
> +	err = mptcp_subflow_create_socket(sk, loc->family, &sf);

This seems to allow the userspace PM to create subflows for different
family than the one of the MPTCP socket.

A detail but maybe this should be mentioned in the commit message?

(and I suppose the userspace PM should be modified to check subflows can
be created but that's for an additional commit)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
