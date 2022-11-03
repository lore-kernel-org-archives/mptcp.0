Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146A7488
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 15:41:29 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id k8so3406351wrh.1
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUxa6t41kEWFVl+EswbCw+JknsvieKNGUaKeawL4THs=;
        b=3dWbhqKX4GOc3hPOhnM7lFqPPPSrqfbg3RIgLtSseoc6sSWnaLm9WU9Iq47OUFPkyE
         EhmoSezgwcSH51EEU3qgX0fJAhAitMe7xUvg0FEBnM0cjx1aNIE1laXYr7yvaAqa+I5Y
         xospp/Yl0rvwi0jNG4Vwyq5OawrbkItRWixstiFqb9F6tBZVNyHRfh9TQ/tSOY81YwOL
         7DB3G43zJ+z3ikEY/jggC3lLnu2KMarfA3SyLkZd9BBNzncw76kvD9DpcgAXL3SkiXxH
         +PHAwQ8OIMYiNs83V2vs5EbzthMI7L+FEBOrGe2RNOUR72vbwhQjflP0I3iUOT5BuTfZ
         B3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUxa6t41kEWFVl+EswbCw+JknsvieKNGUaKeawL4THs=;
        b=6SAYlXi0UytXhkvDR+UxzzRZODq3tLnGwZh7aq70K2/cQHKhRKPfsRykcPzZv0pJP4
         HnX0nUYrR2gxCuXWs0Kl6zLH3iJTxuB3KbEDne/4sBVd2Q6LwHmG25NJ5Ymu5YOjRuig
         Nyt6oUBdRRctIMDIWH1l4FSudtxAyYr4obbI85HpEZDJjXa0Z50WUDTNobBx9aBGrMrM
         rsiXvWAQI7JE1hhyxbbHmKNFI2ePdinWn4Wgwp8+PaOPvoMgdfIiduM0OlF2OIBuLsqs
         AAa8Kh1QtGH0mN//Sz/rO8X5XhzPbEdDNsMLtkHIVYR0t/hxlA1LnAJcNCno5fJq3lBh
         C80Q==
X-Gm-Message-State: ACrzQf23+bVrfEOPzkRtBdeE3RrknAxrbp3nHCwlrhTz11MRV+CljhJM
	k+wd0PA2oOvi3AwvOpxG9JIOzmua56tXx5sb
X-Google-Smtp-Source: AMsMyM5doT82W9FA3lpLTMmou7D/FSnDQtjvIDmY8rsK1E65n+jFwzOoTXdwl7VlGJeR5TtPaCq8iA==
X-Received: by 2002:a5d:4cd2:0:b0:236:ca9e:79d8 with SMTP id c18-20020a5d4cd2000000b00236ca9e79d8mr14487844wrt.234.1667490087438;
        Thu, 03 Nov 2022 08:41:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f4ce:89a5:47d5:7afb? ([2a02:578:8593:1200:f4ce:89a5:47d5:7afb])
        by smtp.gmail.com with ESMTPSA id g39-20020a05600c4ca700b003cf537ec2efsm194904wmp.36.2022.11.03.08.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:41:26 -0700 (PDT)
Message-ID: <363780ba-0904-784b-281d-67f26dff0641@tessares.net>
Date: Thu, 3 Nov 2022 16:41:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next] mptcp: Fix grammar in a comment
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20221101205538.13892-1-mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221101205538.13892-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 01/11/2022 21:55, Mat Martineau wrote:
> We kept getting initial patches from new contributors to remove a
> duplicate 'the' (since grammar checking scripts flag it), but submitters
> never followed up after code review.

Thank you for taking care of this!

This looks good to me of course. Just a small question: do we need to
mention anybody? Maybe not these new contributors as they seem to ignore
the previous requests but maybe Bagas Sanjaya who commented on netdev?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
