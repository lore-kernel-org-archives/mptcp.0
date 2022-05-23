Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DE258E
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 15:40:08 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so11540817wme.5
        for <mptcp@lists.linux.dev>; Mon, 23 May 2022 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=3OEp5Jz/5EIXUqtUQVEhf71/dZlPta4EpofeKqo2qHY=;
        b=XUVsVUswxb9oab9d7zDElRe6E8tlCcw9OLQeNGlCxRmIeGvoXFZS261evLLfLn+b21
         JK65b+3bpO+XRBXa2CDEVnYzIONW+mvSSdVDDYdZm56K1c6+Vj/Pj8+GZovYNbvt09/h
         7i0SoluPLzFNIQL/HbJhqiQiyoh/3GriSvJgKL/2XVw0AR/cqlxnnY0kL2dD/ZxvdcI2
         GHjxcydJ6VzIaIeggpg5n671GsBl9HOZufO7Pv3oiyIHBGJz2rXnyRZ0Nl43iiTxxWJI
         GT2BUz+295AEm401K1RHKUKEO3PnuG2EpNGf3eUqDY5fi3b7BTzbvk6UhTOLcaErBXa/
         DXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3OEp5Jz/5EIXUqtUQVEhf71/dZlPta4EpofeKqo2qHY=;
        b=EvbKM0QC7wW9ud791kHJi+o7eNdKLKwGV7ECh34ahGw5cWQRjwZZ8rxAczD1fee+LA
         KOOM92e9iIjA2We5yp1KGj4rUGSFgQw52z3856Ztmvll3A8KJB3GI48puVKfrjUGI233
         7Umgf3gKlkT1YPsjh0D2/HJawDARdWHKc0TK0yqw8O5Zuecb6FqVhotOrj38T6TrPrHQ
         wTohXz9iC8S2cvKWg5kXLiG9Cl7cFDoRXI+9YONa06G+HThOneVz+Ar+OdKQW/T0AW9o
         wiPXHkeET7bu/oq1pOoHNyENJxXcNoULKcIzt1iXl4/3H7JXZp85kkZJ4m4SnypjmkAU
         HluQ==
X-Gm-Message-State: AOAM531SBBuNM03I7ZlllxGvO+zo1BhvdKhlpJ9FkbKEC7pcuLJeI0Cm
	sFQIKHUkP+aV4UmtFaEgAMiSO+QR/zBqFuBZ
X-Google-Smtp-Source: ABdhPJzFwNwOZkvg1d0HmW2kflClPAubZnXIO2QwYRXOsE8ljdS4Gvibf7O4IwZgV+cQSWYrdzuf0w==
X-Received: by 2002:a05:600c:3041:b0:394:8835:2223 with SMTP id n1-20020a05600c304100b0039488352223mr21189078wmh.160.1653320406757;
        Mon, 23 May 2022 08:40:06 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id x6-20020a7bc206000000b003942a244f53sm9010914wmi.44.2022.05.23.08.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:40:06 -0700 (PDT)
Message-ID: <a2af92c5-5258-cd5c-33e4-c745281422a5@tessares.net>
Date: Mon, 23 May 2022 17:40:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Patch "mptcp: strict local address ID selection" has been added
 to the 5.17-stable tree
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220523030625.741995-1-sashal@kernel.org>
 <4668b747-35fa-d6b0-8390-24c0f8f62a71@tessares.net>
In-Reply-To: <4668b747-35fa-d6b0-8390-24c0f8f62a71@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/05/2022 17:33, Matthieu Baerts wrote:
> Hi Mat, Paolo,
> 
> (- stable list and netdev maintainers, + mptcp list)
> 
> On 23/05/2022 05:06, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     mptcp: strict local address ID selection
>>
>> to the 5.17-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      mptcp-strict-local-address-id-selection.patch
>> and it can be found in the queue-5.17 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
> 
> 
> Do we want the patch below to be backported to stable?
> 
> It think it is slightly changing the behaviour and we might not want it
> there, no?

(...)

>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index aec767ee047a..e4413b3e50c2 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -442,7 +442,8 @@ struct mptcp_subflow_context {
>>  		rx_eof : 1,
>>  		can_ack : 1,        /* only after processing the remote a key */
>>  		disposable : 1,	    /* ctx can be free at ulp release time */
>> -		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
>> +		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
>> +		local_id_valid : 1; /* local_id is correctly initialized */

I guess the reason this patch has been added to the stable queue is
because this patch adds 'local_id_valid' element here in
'mptcp_subflow_context' structure.

If you look at "mptcp: Do TCP fallback on early DSS checksum failure"
patch, Mat added 'valid_csum_seen' just after 'local_id_valid'.

If we don't want  "mptcp: strict local address ID selection" to be
backported, we can probably easily resolve the conflict and send a new
version adding 'valid_csum_seen' just after 'stale'.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
