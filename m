Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801A3C14
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 15:49:51 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id 13so32353276ejn.3
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIRa709YVE/0UEBOWdUwSWDVQKAsslVjc4o0egwjMNA=;
        b=78qv3eV7d3ZW0TUA+KPB/aUUfYTwpjmHogK3ghemdh2IaddbBgYouC/Y6IUBNbUqK4
         jKxKuTBxjxJKsnsYE/9Egu4UL7dIK5zhkJMQzn6A89gOIsRqJFQP+WFXts4nvvNOgN9M
         oNXlEgR/VZh5cxZtre2F7rj3FY22S+xJVWO2vE7+BydmV2NFPdqSqEqV01zjKwFUfkWl
         7PKgLXHP7llju/NLArsIYRcruUtju9cDGVmOAhZKv1etVgXMZAywXPKhC6CRNJLrWX9F
         houMjA8Q99mqxLD+7g46dS9sjF/emMwGzYkgNvz9UsaIt3xzIA2NJh3z4AI1nCfPPRuJ
         1JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIRa709YVE/0UEBOWdUwSWDVQKAsslVjc4o0egwjMNA=;
        b=VulLktQFT9K9YgxwBGTzBjOLq6bu6YUeDjHrfWQ4RwNiNkpAcw1wBITN4ECd7wpuC0
         ajVxHMpuNLL2tsIH9iyQ6+4nVqDNylMMsNXfB6Ps7l9BzxLDBKmorm9zY6xMoqPqehZM
         0Qy+x8Bua9rsMQ5q4QYu2+wfOo6jm70UB0Epv6cNLHr48s3kjZRX6dnqJNud89rkzQJ9
         TxDPe8AX+qG7SdO8hnyTjWZ3JtzyRt9B6momtqVAt6VXwrVwGzwN01j9yatse9c4Z1gZ
         SbcEveuhQ0Pw0LFjD+i5UINq3m0PLOH7ESeG84pYYcTOQ8glDXoUMDlt+udg/R4WzpwC
         Z1yQ==
X-Gm-Message-State: ACrzQf2t9452RhZAqMWlTrUWUFgtukcVmWRmAaULOFqbBFLFNMg3RL+3
	4QfCgZIrnu841ZTO5iYqAPqRBczp1a/jOw==
X-Google-Smtp-Source: AMsMyM5nlW60FhzXDpTuVzefQc9cPnyX5lAG4LxnIBK0k/03sRDR0CzZVC9K/Ub7+ivPoQL5kkIPRQ==
X-Received: by 2002:a17:907:971e:b0:78d:e7ed:7585 with SMTP id jg30-20020a170907971e00b0078de7ed7585mr1830002ejc.258.1665503389498;
        Tue, 11 Oct 2022 08:49:49 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5e67:4302:73e:68b8? ([2a02:578:8593:1200:5e67:4302:73e:68b8])
        by smtp.gmail.com with ESMTPSA id d23-20020a170906305700b0078d3e54aca1sm4834499ejd.75.2022.10.11.08.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 08:49:49 -0700 (PDT)
Message-ID: <eb9ace54-579b-f27a-aa78-f1a2cf4b175e@tessares.net>
Date: Tue, 11 Oct 2022 17:49:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH mptcp-next v14 5/5] selftests: mptcp: mptfo
 Initiator/Listener
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Dmytro Shytyi <dmytro@shytyi.net>,
 mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20221010221809.1792-1-dmytro@shytyi.net>
 <20221010221809.1792-6-dmytro@shytyi.net>
 <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Dmytro,

On 11/10/2022 17:33, Paolo Abeni wrote:
> On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
>> This patch adds the selftests support for mptfo in mptcp_connect.c,.sh
>> We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
>> We call sendto() instead of connect().
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

(...)

>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> index 621af6895f4d..d2328f94d1df 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> @@ -677,6 +677,58 @@ run_tests()
>>  	run_tests_lo $1 $2 $3 0
>>  }
> 
> I guess mptcp_join.sh would be a better location. @Mat[s]: wdyt?

We only need to test with one subflow. Then mptcp_connect.sh should be
fine, no?

I know Dmytro likes to duplicate code ( :) ) but I think run_tests_lo()
should be re-used. In this case, we reduce the modification to a few
lines (e.g. what is done in run_tests_peekmode()).

Then if we limit the validation to 2 tests: one in v4 and one in v6
(between two fixed ns, could even be the same ns ), we are OK, no? More
complex stuff can be added using packetdrill. WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
