Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AED7475
	for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 17:32:05 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id fd5so23233663edb.7
        for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679074323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBQZtC+0eLGVRdevYQZTCzh9Pc2ZrfmWETKrta2FZlI=;
        b=DGWApvCuqSnmrxlbunp6S4NSspRrHvVwXKGzPPeIEyEF+5t0ZJQJGZXtzNtrgMbo2o
         4/D9LPJBAXryZ/r3HMix1Pc27X34y6WDqDDrsYcgAgeBrWz9xJI8sDtgQF6tO1KH9fd+
         AlP8fyYtQ+wvhHI+GtG0tQqv7j7zqcRZb6nkM7Tuh6EbXLn4k9k0apTXEOFDyJibSeMf
         LZ+e70+IYiTJPBnw32g39svpB6v4f3/ThjSfqjwKaeu8GEy2gVr0+dZO7pASNg3EMK2e
         rWVBMeAIWUY9DJ9gxtCBQoPm7SFSHbHHBoJTrhpMr8tlpLqrDOnp/ptsevS9qULLX/fu
         uw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBQZtC+0eLGVRdevYQZTCzh9Pc2ZrfmWETKrta2FZlI=;
        b=AOawKWbsQSu63kHXZlSScxBxIDpfeMK9EPCmJ77hFZRKThN3hN0g8jSmaFYNOwf08J
         tAUBozTWj3jj0rLEaWItF93tliCoBQqlR9UuiUCWS+Iq+znbuDe+/s4DaU7C88EdHlmh
         3mItB1T0Me6zqqVPElPhg3FO7ztV9o+aFwCYdAFcaVU8zHzsouiKsn4PpBlFqt+kXdYi
         ljSxmwydOGPRHdrH0g1hS06cWbKGhJfUsS5865XwVjnRJC8CBujlCSFUqek7wnCmT67o
         6z3nBeTtjgOjvk5vy7Cgg3IhBOMleTCHJ/wGxBUBf6kHO9nOHw/j3argH6kg7RWMtfIO
         FK6Q==
X-Gm-Message-State: AO0yUKVxLce9ea2HGR70w6i5V4QiR7c08gVBNjeDBawYJ9Bi32sOa+VE
	BQFDvKNsJnFNv7sgIQkvBg+zxQ==
X-Google-Smtp-Source: AK7set/Io+9nIBkV3nfTTlHpLyL63wJeICZLWQDgKoPp8r0nvwh2ySlASagnN9zUjuEW5ZPazOc3vQ==
X-Received: by 2002:aa7:c948:0:b0:4ab:d1f4:4b88 with SMTP id h8-20020aa7c948000000b004abd1f44b88mr3306180edt.41.1679074323472;
        Fri, 17 Mar 2023 10:32:03 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i23-20020a0564020f1700b00500383a202csm1347885eda.6.2023.03.17.10.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:32:03 -0700 (PDT)
Message-ID: <b9b3e7a2-788b-13ca-91a6-3017c8afbbf4@tessares.net>
Date: Fri, 17 Mar 2023 18:32:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next 09/10] mptcp: preserve const qualifier in
 mptcp_sk()
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Simon Horman <simon.horman@corigine.com>,
 Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230317155539.2552954-1-edumazet@google.com>
 <20230317155539.2552954-10-edumazet@google.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230317155539.2552954-10-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 17/03/2023 16:55, Eric Dumazet wrote:
> We can change mptcp_sk() to propagate its argument const qualifier,
> thanks to container_of_const().
> 
> We need to change few things to avoid build errors:
> 
> mptcp_set_datafin_timeout() and mptcp_rtx_head() have to accept
> non-const sk pointers.
> 
> @msk local variable in mptcp_pending_tail() must be const.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Matthieu Baerts <matthieu.baerts@tessares.net>

Good idea!

Thank you for this patch and for having Cced me.

It looks good to me. I just have one question below if you don't mind.

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 61fd8eabfca2028680e04558b4baca9f48bbaaaa..4ed8ffffb1ca473179217e640a23bc268742628d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

(...)

> @@ -381,7 +378,7 @@ static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
>  	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
>  }
>  
> -static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
> +static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)

It was not clear to me why you had to remove the "const" qualifier here
and not just have to add one when assigning the msk just below. But then
I looked at what was behind the list_first_entry_or_null() macro used in
this function and understood what was the issue.


My naive approach would be to modify this macro but I guess we don't
want to go down that road, right?

-------------------- 8< --------------------
diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad4d..cd770766f451 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -550,7 +550,7 @@ static inline void list_splice_tail_init(struct
list_head *list,
  * Note that if the list is empty, it returns NULL.
  */
 #define list_first_entry_or_null(ptr, type, member) ({ \
-       struct list_head *head__ = (ptr); \
+       const struct list_head *head__ = (ptr); \
        struct list_head *pos__ = READ_ONCE(head__->next); \
        pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
 })
-------------------- 8< --------------------


It looks safe to me to do that but I would not trust myself on a Friday
evening :)
(I'm sure I'm missing something, I'm sorry if it is completely wrong)

Anyway if we cannot modify list_first_entry_or_null() one way or
another, I'm fine with your modification!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt

>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
