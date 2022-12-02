Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B141FA9
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 10:21:31 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id b2so10484625eja.7
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 02:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AE0TKJtwd9IQnencGJnEElxXNLiEn0+mC5tnxibpqHo=;
        b=rtMHpXJWNbX8FNiQYiXlZZ1aTT3z+0lAXZoPtFyvvv6RK0qE9FOpzpf9gVXKKq7Z4S
         yOXF5G0gGOKrnLXUcW10X88pQGq9PoekOIUB1ofEBf2dr8eNofCNIylr5C68CeEDoc+y
         /HZpMlmph7elZiY3qlGZWvwSC01UlEywBS6kRWzHHZKzwiSfPzAhXdCNT54Vn5q8cIsC
         CdX8qwi0zEsvE4bGvtDeuGt7+rPEmnXWPX4QBT/2ty765UqyTVTXHtJkQvw08ZigV6pr
         zWHVRNWfu2thBbau69LkPeF5L6qL8HsbDF002iXXb7OrG5zc1QQqVyzzzsODM/c6HFUU
         rt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE0TKJtwd9IQnencGJnEElxXNLiEn0+mC5tnxibpqHo=;
        b=nJsGkRjXuyCGK5i8l6SUyOqe1AaIUzTwjX21nLCs9RetRe374gvmesM/BCIZnroyP3
         +poJB+4gHIgsdJuAys34whOTBVD3NGNJpWQRAxbPR05lqsN4CC/SyeZ11wJyebfnt4rZ
         0i6qYJqb7G2d5uhPJownvMyOVa3+eTkly/pHa6ggzkEZc/uSZNthG+qZWMpMtfsw0xen
         IRXRMBeImOy8vncy0Gzg//FOGJ/r8+W4Gf2lWDIjwb5lg6mo+eX6D5kVJCL7Ktaz+9mj
         LqVcF5pc/319gAdbsSXwA4sDhN5Gj7wFG3XI58Gg541jR17Qh0qv+/S8muMiXSwb7ZrS
         xNTQ==
X-Gm-Message-State: ANoB5pnzAxQfYiI/jd9LbNlqPzeEjL9Z6ANKfPiZtvf7J9+ZIAYRP/VC
	qLx8k3o3pa2q3cb5quUvcqzRww==
X-Google-Smtp-Source: AA0mqf7MI7nZc1kPglk3dKX6GSH2uZUr2yMATDRLWsHDsQp9h6wHZ+xIVL/0p36/B1+B6Cyx0WUN1A==
X-Received: by 2002:a17:906:99d6:b0:7c0:c91c:5d38 with SMTP id s22-20020a17090699d600b007c0c91c5d38mr1077498ejn.50.1669976490081;
        Fri, 02 Dec 2022 02:21:30 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id r2-20020aa7c142000000b0046182b3ad46sm2787117edp.20.2022.12.02.02.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:21:29 -0800 (PST)
Message-ID: <4a86bc13-9f87-bea8-e4f6-db3ea9eadd3e@tessares.net>
Date: Fri, 2 Dec 2022 11:21:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 06/11] mptcp: add pm listener events
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221130140637.409926-1-matthieu.baerts@tessares.net>
 <20221130140637.409926-7-matthieu.baerts@tessares.net>
 <20221201200535.14e208ac@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221201200535.14e208ac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 02/12/2022 05:05, Jakub Kicinski wrote:
> On Wed, 30 Nov 2022 15:06:28 +0100 Matthieu Baerts wrote:
>> +	kfree_skb(skb);
> 
> nlmsg_free(), could you inspect the code and follow up?

Good catch, thank you for reporting that!

Geliang has already sent a follow up patch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
