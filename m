Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79F748D
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 16:58:15 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id f5so29886499ejc.5
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rim/BbVz2vO5xv23Vaa9q6UHpkvTTLwCy9cz26VViwM=;
        b=wDpfggATTvaLMs27d9ZaFNDy3q2ScynzBqdH0VEhRhJkQEMW4vDfwKaq6pbeJXoJNy
         o7+uVv8Ixo/WqsUpQZpC+xqPTytUqOlVPiXBWO+M/LqA6/q89oZT2kY/GwJrEmiIxY8y
         xWMzLhZxfTMu9wMZja3i5Cvi77ayeF90J3YV8l2HuoLkIYQaKa+6WteDzSk1GXYRQh8I
         +oPqGy7d33OcbZ35ASsbv9G+9pphffBj+ZHGyIIbhM4ZskQ+mMiGYAuLMNthoWANNAZk
         2wW1xOh/HPsool5Q8p8k6j3br9Qjrzpxn7r/14ewAHCrwmuPMaZxvtSaAtcAkL5+j07/
         4TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rim/BbVz2vO5xv23Vaa9q6UHpkvTTLwCy9cz26VViwM=;
        b=JPng5389C9/1Xsu0HCXyuh4tBTVxQ2TPZA8mGtYwTqmWQSpwEREWyGFSVucxHWpSjz
         p6PGe7m/vJjoYTrT4YXvjMWmGWog4l4nJ4qBxNGHfjrpCGIwXN5gHrxAciTblc6aar8G
         aLldGzNb90P2zG+uAC5j4IlaSsfzq8pIVPlDDaTamGFjfVx0G/0OujARehk/uKCkX/6q
         Ko9N7gqJeqQ46qV6j5fmP55N08lAqTZfVOlXWQMSujvRhLk3Ij/Ut8V3uzlSkiBlkom3
         bocEw6LcXV68ExcYVbb80t5DPPAKk/9dltoeXdd7vuYhxdbVxgGGD2AoKUqaS1LjE9Cb
         8aAg==
X-Gm-Message-State: ANoB5pkxoknP+cWimK2KwrjxM4a12+aQr/F1+QXir+mOWnH46F6qfraG
	BfkSKfykyKz48HPNOyg29ixvDRg85egvOgUKA1k=
X-Google-Smtp-Source: AA0mqf5k5MtqBDw1CaSzqnQxovij7azkOO4c9t9RFmz27JofeFupItahYSMEnBuKvC5AsUBLObd4kg==
X-Received: by 2002:a17:906:7c8d:b0:7af:1233:948d with SMTP id w13-20020a1709067c8d00b007af1233948dmr1735319ejo.698.1668445093414;
        Mon, 14 Nov 2022 08:58:13 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id ku22-20020a170907789600b00787a6adab7csm2395805ejc.147.2022.11.14.08.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:58:12 -0800 (PST)
Message-ID: <1a4372b7-3206-162c-c198-c16891391f01@tessares.net>
Date: Mon, 14 Nov 2022 17:58:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/5] mptcp: uniform code style and fix
 checkpatch splats
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Dmytro Shytyi <dmytro@shytyi.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221114164601.861295-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 14/11/2022 17:45, Matthieu Baerts wrote:
> Just some small quick fixes about "issues" I saw when I applied the patches last
> week. Nothing important: function names, place in the .h and small checkpatch
> splats.

An additional thing to do is to update the commit message of the first
patch of the "TFO listener" series which is currently:

  mptcp: introduce MSG_FASTOPEN flag

  In the following patches we will analyse the MSG_FASTOPEN flag
  in the mptcp_sendmsg() and invoke the MPTFO.

Maybe by:

  mptcp: add MSG_FASTOPEN sendmsg flag support

  Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") from
  Paolo Abeni, all the infrastructure is now in place to support this
  flag.

  The remaining action to do is to allow it and treat it as a fastopen
  message to be able to access this:

    sendto(sockfd, ..., ..., MSG_FASTOPEN, ..., ...);

What do you think?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
