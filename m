Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1522F42
	for <mptcp@lists.linux.dev>; Wed,  7 Sep 2022 18:58:28 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id q21so13407852edc.9
        for <mptcp@lists.linux.dev>; Wed, 07 Sep 2022 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=h/bA+Ve4f/V9jQbCN/x4RKc9/kVDw9cBxXxwKpXfags=;
        b=b/1QcJAMhCe/7BwC9qs846fbM2zznFi7Fjv+7Sj61UoDME5bKp/0ZMNs6zuZkTvdKD
         HQvSNrSUaWeVPIJUQprdeRPh+GTEBbKHKFE4/gGZqloX3tmzVok6iJFd7t8g/2MDEj0n
         Ca1E5rmsts5YAZNWjUpOq4HYLw9zBWPLtZFsmOkC2JD2RqA3FZU5To/GfmGN4DiTe7gF
         E5Wn84uYyqrh9rvEDiAtc+lJloBqbVKdLYv/0FkGqmJckivLau/R36tO1z2MuWtSBGqq
         gkdxK4aWnvIyM/kqZ0dYjm+FPACfix8Jr04Cueq6c08PqvTV4xGFnFXpJFLRVKiL2pUP
         HPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=h/bA+Ve4f/V9jQbCN/x4RKc9/kVDw9cBxXxwKpXfags=;
        b=7mMqbhSn3Wj/mqgmmWTqZiGZA5j7mnmxWJVA5pwlSCXOc2WvNo3fUAzKGmFtj56U0d
         l3FK4SSb8nvSui3417ulDG7EcShD9Gylc7uDGBkP1y3PTKRYFhsdXCyjqutL98QLV3g2
         AXyTfIM5HU29nfVwdrVFra6o5Y2QrsmZ/A5ni42edN6SpLW4BwFbjq7seLlOeiUkPMu+
         +4TjA+IXp3obZJCK6g9EpvVj5Ui9bynB+JsX/Q8SLkmXZDx6xXQUHbAngMHgP0kRiSnl
         uJSIwOA+nHTQvQYfo5l3WaDeLIC6nFYmhz2ruyDcsd73m2WVpKryyDhk3FMroFS3cr50
         y09g==
X-Gm-Message-State: ACgBeo198a8xGnrTUmH9+GRq+gXpJCPxNBnqfLrpKmUIxcCOMLKY70bs
	lkAJxDe6KvYmei2jW2trlQn0qxaE5udbqIB8
X-Google-Smtp-Source: AA6agR4zFWNmyUKtstYUQoY/nammWT/ro9hRfPtEUbP1QE2nU9txTCWYSOPPD7i5sWgaqMgIPCh3vg==
X-Received: by 2002:a05:6402:35d6:b0:44e:f45a:8f79 with SMTP id z22-20020a05640235d600b0044ef45a8f79mr4240355edc.393.1662577106983;
        Wed, 07 Sep 2022 11:58:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1e19:3513:f3b9:c81f? ([2a02:578:8593:1200:1e19:3513:f3b9:c81f])
        by smtp.gmail.com with ESMTPSA id p25-20020aa7d319000000b0044ee2869ef7sm3562079edq.4.2022.09.07.11.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 11:58:26 -0700 (PDT)
Message-ID: <d1a4123f-c173-00d6-6ac8-c6fdd978b078@tessares.net>
Date: Wed, 7 Sep 2022 20:58:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 mptcp-next 3/3] selftests: mptcp: update and extend
 fastclose test-cases
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
 <27d535b3cc0cd665ba6404056aa51fb4a1628f44.1662051551.git.pabeni@redhat.com>
 <d7a536f8-ac96-0b8b-7460-2a240aeb2d32@tessares.net>
In-Reply-To: <d7a536f8-ac96-0b8b-7460-2a240aeb2d32@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2022 19:22, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 01/09/2022 19:31, Paolo Abeni wrote:
>> After the previous patches, the MPTCP protocol can generate
>> fast-closes on both ends of the connection. Rework the relevant
>> test-case to carefully trigger the fast-close code-path on a
>> single end at the time, while ensuring than a predictable amount
>> of data is spooled on both ends.
>>
>> Additionally add another test-cases for the passive socket
>> fast-close.
> 
> Thank you for the v3!

One last thing: it looks like some packetdrill tests -- dss and syscalls
-- will need to be adapted as well because in some situations, a RST is
now going to be sent instead of a FIN.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
