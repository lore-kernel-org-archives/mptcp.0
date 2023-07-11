Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEB18C10
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 12:30:40 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-991f956fb5aso652040166b.0
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689078639; x=1691670639;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmbOIQyXJ3Pqn5xsl22r8mQNDsYjJ6LK13/kvht3paI=;
        b=QTLfAj7lvWST2mmcGDaU7oghUvDC31RjDWS/bsbxOMAyd1IklS4u9VNQBfvsrJoq7j
         mx7HeKpl0f4vQLqS6e/5nBT1IuDpjXYSUsVpw8xFW43kHZmdgVaWkqKCBxkvEkkp8IE+
         PHf+jBL0Al60aAk9sY8b7g3KwOaWYmVypBko4ctAO0ix8tpbWspYXUPZW8RImJnYbNK5
         s71sCh6tJUwwO4zC7OUXZb19bXj6vxfd95GgSGDHRwMKRnbWZwgRj84goj0i5lBZLNse
         tCCIGqlJH5VzcAnD5vwjwMdF1RVFUcA82UukBxlG8uJ3SQO5/ECXzdFMCAavmnBmeSTH
         wgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078639; x=1691670639;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmbOIQyXJ3Pqn5xsl22r8mQNDsYjJ6LK13/kvht3paI=;
        b=NPJLeHT1NNcCSFcZo24B+fwLNoT0v9pTD0uIbE6tfnV+qf44VgCln/XTLxxfmLxMlg
         +jkAOVy+vOA1YK681eGmfEg2zePtCOd4NfZ1Wkyiq0s5KwFQTVCXPkL2Y/P3T7mAeUco
         P8NftBt9rOe5270/owYtoB4orDSQ0wtc8gojqZZWJ7ugOhAYyBygvAjK7gXK5zumo3jp
         eyYEb/yon5mZj49Exo43Pux2fg/ILpOq8DeeZ3Jiz1ZmtTzg4ioAf9XkrBACwyxVreHs
         7Dfio7IKQLGEP7FMPy9bU/pHcNvtdpXCoVT16ir9Ei49smBEoSb1Ds26PS5QkuEQfpF2
         BmwA==
X-Gm-Message-State: ABy/qLZ9jrsqNMDtSJiur2PlVVHNiE19i+Q8F5kBmmRTXOTBqdDlfmWi
	eetPC6Q8jKGlntTK/1nZXus5RKikFLYkiXYXTNwnaQ==
X-Google-Smtp-Source: APBJJlHIShPnW3WhfLDg6uUnbkXoBBiMFK3QQ+YrWO1ZL2L3/9D6HCDR0DPLqzhNa511F0sTNTpPTw==
X-Received: by 2002:a17:906:7e07:b0:993:8d16:4c22 with SMTP id e7-20020a1709067e0700b009938d164c22mr12891886ejr.75.1689078638503;
        Tue, 11 Jul 2023 05:30:38 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:311:9dd3:e9de:8b52? ([2a02:578:8593:1200:311:9dd3:e9de:8b52])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709061c0500b0099307520b8csm1110191ejg.29.2023.07.11.05.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:30:38 -0700 (PDT)
Message-ID: <fd3f4e54-bda1-eb56-02a0-c51475b63daf@tessares.net>
Date: Tue, 11 Jul 2023 14:30:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 5/6] mptcp: sockopt: set val in a generic way
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
 <20230707-mptcp-unify-sockopt-issue-353-v1-5-693e15c06646@tessares.net>
 <04b15a240e3f84e7de1f4593f8b70b1b0a88ddd4.camel@redhat.com>
 <a70351da-2894-fb4b-7dd3-4b611a5534e3@tessares.net>
In-Reply-To: <a70351da-2894-fb4b-7dd3-4b611a5534e3@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/07/2023 11:43, Matthieu Baerts wrote:
> On 10/07/2023 19:05, Paolo Abeni wrote:
>> On Fri, 2023-07-07 at 18:00 +0200, Matthieu Baerts wrote:

(...)

>>> @@ -801,6 +727,32 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>>>  	return ret;
>>>  }
>>>  
>>> +static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>>> +			       sockptr_t optval, unsigned int optlen)
>>> +{
>>> +	switch (optname) {
>>> +	case IP_FREEBIND:
>>> +	case IP_TRANSPARENT:
>>> +	case IP_TOS:
>>> +		return mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optlen);
>>
>> This changes the sockopt semantic a bit, applying the
>> IP_FREEBIND/IP_TRANSPARENT to all the subflows, while before this
>> change, only the MPC subflow was rightfull affected. Likely in practice
>> there are no visible functional effect change, but it sounds confusing
>> to me.
> 
> Good point. Indeed, if there is no first subflow created before the
> establishment of the connection, we will now only set the transparent
> and freebind bits on the MPTCP socket. They will be set when a new
> subflow has been created in the "sync()" part (which is maybe fine?)

Thinking about that, with the same logic (the sync will be done later),
we could also only call mptcp_setsockopt_msk() and avoid a lock (on a
non established MPTCP connection).

> But we can call mptcp_setsockopt_first_sf_only() here if you prefer.

(We would also need to call mptcp_setsockopt_msk() as well)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
