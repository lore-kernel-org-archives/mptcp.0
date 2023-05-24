Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F117FF3
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 12:08:36 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f607dc98cdso7616875e9.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684930115; x=1687522115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+P7aBxP5n1RYBegefzKUf9y1rsijH7kHdvdIeGcHio=;
        b=ivLZ99eNU0a/CbsTvRbS9h2icq4o1BNMa0G4LTbMIJXKg07KLbI+TjaJUhGMbhjRvT
         hjdoVrTVI1QSqZM4WRSX/AD4PiIhYcDCi1EUua7VUAgRCNVsi4ioOjR8VfzOJGblSG+b
         IdwrqSrU10fgj+riDlUde+ssUOMty06g2oMu9JjyNWiQb8WOrW/JgXzDHvg112L/ArEi
         nEASuu6n7W06oDq2n3ZYRR0yRoxEVUMMFqAlXceIxAWxeQak+STk6hhKszYFwsqJ8SkK
         dQ2SGBMLmR7Mwcjyh6rv5ItwmFL+/xriSL4eykJEOvf/m3pDPkrUXVKU1h9fhdlPwrCL
         albQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684930115; x=1687522115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+P7aBxP5n1RYBegefzKUf9y1rsijH7kHdvdIeGcHio=;
        b=ErZ8QvW+UwryUkHNZgL5bRHL4ecqZJEvI9xoDah6jXDXTnxZOXQR7cj+UYC9F47KXz
         x6H03ddvrgztIkUA7GjL0Ht6zksiAyFOenxmoLMOwQ92i9s6W2WwNSt4EnAwqfkKEDes
         xGvtDUBpjIHOYW9IiIGcVKKrR8CKYFh62e/HWhclMtBycOthkbKXvbs3uA3PCaudS36F
         aZBGq0DFDXW6qoWJd2kFSx9wLQrKYwT6/tNt9Op6Jyoy1cA9f1SoFK8MU+wZe8lgyM8p
         TwJ7RG+19HQSvhk5SNW9AKrmxDWphjPEfp1ICVm2GjLt3sCkq8ovipRvWXSD8IILc0Pu
         Z2XQ==
X-Gm-Message-State: AC+VfDzHwmhwdoBoBw1CfsfMkrylGg5p83tkYphyXGhHabYTwTHANpW+
	j6z9Ho4y1Ay8NltMNYcis8K2CWOQ13vQI7bthlHCjw==
X-Google-Smtp-Source: ACHHUZ4kbE5sTIHHwQ6sqrncrWlTeCUrlYKIpUPdZmsuX1eTaQR6d5Qt/II6qdLTUPVrpVqVooe0nA==
X-Received: by 2002:a1c:f702:0:b0:3f4:fffc:add with SMTP id v2-20020a1cf702000000b003f4fffc0addmr11744553wmh.27.1684930114964;
        Wed, 24 May 2023 05:08:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id v24-20020a1cf718000000b003f606c4ad33sm2128087wmh.32.2023.05.24.05.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 05:08:34 -0700 (PDT)
Message-ID: <8522f98a-91b1-cb4d-31ea-4a7c5a7e48f0@tessares.net>
Date: Wed, 24 May 2023 14:08:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
 <fe2191fe-6842-7662-d300-0aa88cdb9827@tessares.net>
 <20230524100407.GE17561@breakpoint.cc>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230524100407.GE17561@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

Thank you for your replies!

On 24/05/2023 12:04, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
>> If we want to be even more future prove, why not having something more
>> flexible where the userspace puts flags of what it wants and then there
>> is a kind of TLV structure? Maybe it would be too complex to read/write?
>>
>>
>>   struct mptcp_tlv_info {
>>       __u32 type;
>>       __u32 length;
>>       __aligned_u64 value;
>>   };
>>
>>   struct mptcp_full_info {
>>       __u32 flags;
>>       __u32 num_subflows;
>>       __u32 num_subflows_copied;
>>       struct mptcp_tlv_info[];   /* number has to be linked to flags */
>>   };
> 
> Hmm, I think it would be better to reuse an existing scheme
> and e.g. return a netlink attribute blob in such a case,
> this would also allow sharing with the diag interface/functions.

Ah yes, good idea, I didn't think about that.

But I don't know what's best for the userspace: parsing netlink blob or
a specific structure with a size that can be expended. Netlink blob
sounds more future prove and probably easier to maintain (if it is OK to
use that with getsockopt()).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
