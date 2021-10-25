Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B02C9F
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 12:38:04 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id n1so16020158edd.0
        for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vz8Wx55FOhXXwv0vCw+wxEfos+WRXKpKqpn2JuzLwtc=;
        b=6hk4/G31Z4nuJC10BvM1eYyOS0a5PGFxRPxRoFYkkzmc8o/yb2pnFbEhuW2dsLDJzt
         Z/v1IoBDrO9lgU7KgWXixigzlnA5cNczevwF0rHcRgHHMRQtXNGRioUSUuKX/lAnus7/
         x3ae7SR+2RqQhQ/al/7f9cIHZohU8Rmgjb6Y2RojejcHERZVvrA9eWmp6PEDv0MVxlB9
         IXVtJ40OHAygP1GPf8S08Zt8nqh2R8mrA1ApX3MGIWXCLh43vuzRFMNg6/9j5AwmDDVi
         hP4Z8pWLuX8QFR2hgWbeMNPiIcTmGM/2U1s1xnehTNv9fWboe3Yw/2f9rWl8d4GIqlgs
         0eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vz8Wx55FOhXXwv0vCw+wxEfos+WRXKpKqpn2JuzLwtc=;
        b=YeIZeBnBZ5rGNDWKIFd/wHkcGevDYzO0V3eqY/LVmrsv1H612LYcxFS1zTQOQyLKkP
         5paNWkXpe4Z2i73v0Icw4Ene4Klnq1sZjW7Czi9u/neALEwyTLgLYH0a5lR7JDZh1KS5
         FbURDNMBBiGB+lhZXHO4uUZnaPaKjcxrgCq57DrsSJsz+6B9sfktBp4QO3u/V4vIsWHq
         iwFK0UjhmAvgXo/EF97oTogwjLXI/t6QLVKl+xyM1dCNdvFhgzYFS9Om5q6oUSQRBBfE
         61FcNKcyRsK52UCFB0Bc7TdXnHfzqUITCCv0rfFKiqrHGFve/069tl7NckmJVhnOw3xW
         0gJQ==
X-Gm-Message-State: AOAM530OHQxzwuIaFeyZuKm0dDVE3pU0ySKWa9CzrIwaGbP+hOGZE4vu
	BnoU7ztrjnFn47WnMWeAIQiqp8vo6yNuzdAV
X-Google-Smtp-Source: ABdhPJx/eHuyfzS1+3DnnrhjJeSvOE2PXnmCBFGQSrpV/YxH3Nk34qTh64yQYa/zSRXl/qaRScmwLg==
X-Received: by 2002:a17:906:d046:: with SMTP id bo6mr21669154ejb.278.1635165468071;
        Mon, 25 Oct 2021 05:37:48 -0700 (PDT)
Received: from [10.124.6.48] ([195.181.172.148])
        by smtp.gmail.com with ESMTPSA id f12sm9346227edx.90.2021.10.25.05.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 05:37:47 -0700 (PDT)
Message-ID: <868a9dcc-9001-cdd8-c655-dabe7b8f9222@tessares.net>
Date: Mon, 25 Oct 2021 14:37:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp <mptcp@lists.linux.dev>,
 mathewjmartineau <mathew.j.martineau@linux.intel.com>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net>
 <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
 <17cb73b1343.c752fede1729351.6463099199494289591@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <17cb73b1343.c752fede1729351.6463099199494289591@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro,

On 25/10/2021 13:34, Dmytro Shytyi wrote:
> 
> ---- On Fri, 22 Oct 2021 11:22:31 +0200 Matthieu Baerts <matthieu.baerts@tessares.net> wrote ----
> 
>  > Hi Dmytro, 
>  >  

Small detail: it looks like your email client is adding unusual spaces
before ">" to quote the previous message. That's not a big issue but it
makes other email clients and even lore [1] not interpreting that as
quotes, e.g. on lore, you can see the quotes are in blue in my reply and
Mat's one but not in yours.

[1]
https://lore.kernel.org/mptcp/17cb73b1343.c752fede1729351.6463099199494289591@shytyi.net/T/#t

(...)

>  > I hope this might help reviewing the new versions ;-) 
>  
> Thank you, Metthieu. 
> I'm working on PATCH net-next v2 net: mptcp. It will include all your comments, except this one:
> 
>  > It looks like you don't use it. Does the compiler not complain about that? 
>  >  
>  > > +       tp->fastopen_req = kzalloc(sizeof(*tp->fatopen_req), 
>  > > +                                  ssk->sk->sk_allocation); 
> Compiler not compalin about that because it is used in the code.

In the version you sent, in mptcp_sendmsg_fastopen_cookie_send() you are
indeed using it but not it in mptcp_sendmsg_fastopen_cookie_req(), no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
