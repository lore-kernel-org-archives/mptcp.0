Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C82C81
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 07:49:12 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id z5so88374952edd.3
        for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 23:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=jwVrd8Xq4uWEvEWlYyXIuX84Cj6LEdY/xYjiHS7Lzm0=;
        b=1EnuXe8qJltHGuCnarEnspcv0gUEiD2v0uRPmU65qz/wGHEYq3ieGU+0bKFgaqMzc3
         g8pyXr4KONzI/aw8H/Go/wLLMFTbgUGfZyHMpCQRIdetLJMGcrxRH/zUt6rZJNTh8Fox
         4uNsu1R8Up7BfuZat+Vci6NNejx9XGoJ0up+Wj/7baObB6I9Yk6+eUbxx2VwKx1bZlD9
         xvLjm/hbqt39btz4brZyPd/njOyTi+Kl5QVL9xOzTTzOFJZfbxAxziYmJLWz0hKnkzCo
         3pdcW/WEuO/XhjI4GvaJuDp52/lUmZKiqTRUIy7CTNml5pz4id0cQzTX3GHEPRDNPXPv
         Jtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=jwVrd8Xq4uWEvEWlYyXIuX84Cj6LEdY/xYjiHS7Lzm0=;
        b=k9IxDsFSTlicnRr3F3E3COVQr6WAioKHr6ANtksLM7cnM+1KW6kNHDV0Wvp9Eowr3t
         vMKi5otkmujfzKaPTQ2qNZXI45DNv9A1uGVg7S1qBXhnGPy2lKy5G7l9ywUBl2utG3u8
         1BnzMlVIRl3T7X3yfGUkU1Aq9+rE1F0DXVy6u0CPv4T28C2TLrCedJXWGHBg4HUocMrV
         VzL/VSWeMjZz44hnblk48KsifgGKx8ASrG+qwmn1q8w96FabYkuGzA4CSDrEwBm+SeB7
         KJSGGaEpLDz3EUhV+Q/keDBr2hvBw/9nSzTiBcYoI/V57xIatLMss8awVd8ZwSlhQM3b
         Nk4Q==
X-Gm-Message-State: AOAM532XLZrVg3RyBo8FEIDT5Ehbq6FR4RvJjwQWa45glrGj8d2CkEy4
	HkNV3ZYGZEP0j3wND2BWSbQbJgktZSE5U9U/aWk=
X-Google-Smtp-Source: ABdhPJy7YFz/BS8ZBRpEXO4bOHDYT25p5K4UHl1F2O7nyOLGDGcdpBb4ZWtbhehI2Z7ps27WdL/PpA==
X-Received: by 2002:a17:906:8c3:: with SMTP id o3mr5157885eje.10.1637653751105;
        Mon, 22 Nov 2021 23:49:11 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:98d4:755:5048:fe8c? ([2a02:578:8593:1200:98d4:755:5048:fe8c])
        by smtp.gmail.com with ESMTPSA id i8sm5685395edc.12.2021.11.22.23.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 23:49:10 -0800 (PST)
Message-ID: <9283af18-054b-b362-4494-ed811fcc3141@tessares.net>
Date: Tue, 23 Nov 2021 08:49:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 mptcp-next 1/2] mptcp: getsockopt: add support for
 IP_TOS
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20211122152651.28466-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20211122152651.28466-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 22/11/2021 16:26, Florian Westphal wrote:
> earlier patch added IP_TOS setsockopt support, this allows to get
> the value set by earlier setsockopt.
> 
> Extends mptcp_put_int_option to handle u8 input/output by
> adding required cast.

(apparently I missed sending this yesterday)

Good idea to make it similar to what is in ip_sockglue.c!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
