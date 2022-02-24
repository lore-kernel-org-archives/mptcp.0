Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0DB7A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:47:58 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id bq11so3215284edb.2
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EGXEmCPCPwgWhI6gV5WxhiD/1XcE3fA6ilcv5aAUeqk=;
        b=3a0mXKfcVVfKs/WbqQG/AlBc5Duhr/RvT0JqfOVB4z976+PBHr1TU2YYo+wrGjorT7
         EsMtyzXimQ+qHvuGiLv5ZQ1WfnTT3TAd31eSuuyeMDBJARMvaoxpRLbGU0TIQkpAv41U
         z65UYeFY5KV7ztHZ55SCgTCRymLoaEaAffNnZK/XN7X2H8dWudq4yv3tlbjeC7080nmS
         mEXMgSThK+h5nUTtDOplvw/yw/uO4IQZc+3mZDQ1U/XpFCO3bwtC4cgeN/vWHeUjVNnn
         D4OA6hy9EHfGQSE/irJgs8GxYtArjQzZJ94VenUr6VreRykWgjporif4zzuXKSZLpmpa
         ShMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EGXEmCPCPwgWhI6gV5WxhiD/1XcE3fA6ilcv5aAUeqk=;
        b=CgvjHHmWtJbnKk01d3grS1Pf/0BD5Kd1npmLx7FprFn+qNBsZgie9YQh/c/dIzbqhA
         +TO3z0a/VpA1GFr9bXyrWbjRUZhdVb1j3oNfy2Mo8dYoLXcyTK0CKtqWpX92chB63rjd
         lSm6scqRzwsGgwkuljG2u3J8xf3QBAj5xKngbhQxIVvWLzSQ7hhTcF+x+RQbPLIC6Khy
         0XVxICnbZaZGxF7FzIulIKKn1z3LAU/rY/N3gASwUAukCaI7HsoWkqCm5HMcwtwVwxjW
         FFP9oEPOm7/D9M5TppPmzyAT7OJQWvLZt/50E3qDagnLFOdVtC6xbWvEgfxZeQ1DIjfJ
         Dlyg==
X-Gm-Message-State: AOAM532Zv55+p5mvq/x0KFJn4AshxnJ5l5qOB4oCT3jPRVpGyxnde+Hb
	OxVn/6dE7XB791T+H4nudJeESA==
X-Google-Smtp-Source: ABdhPJw61RJhKghcUKPn3I6cDE5D6uf0wIQKEGsp2rtLRziRrj4MpRAw8P9mupxIxWoS7CR4sLFrEg==
X-Received: by 2002:a05:6402:4309:b0:410:db71:b5ce with SMTP id m9-20020a056402430900b00410db71b5cemr2669966edc.432.1645714076342;
        Thu, 24 Feb 2022 06:47:56 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f22sm1444498edf.95.2022.02.24.06.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:47:55 -0800 (PST)
Message-ID: <37193c04-675e-543b-ca83-159d9fe0ed5b@tessares.net>
Date: Thu, 24 Feb 2022 15:47:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v3 11/12] selftests: mptcp: join: make it
 shellcheck compliant
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
 <20220224135619.2523272-12-matthieu.baerts@tessares.net>
 <CA+WQbwtTtGd18FQ9ndWoMR2dvnD_X7i+PbjuCS6ESFD9yLE4bw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwtTtGd18FQ9ndWoMR2dvnD_X7i+PbjuCS6ESFD9yLE4bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 24/02/2022 15:34, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年2月24日周四 21:57写道：

(...)

>> @@ -713,7 +716,7 @@ do_transfer()
>>                                         ./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
>>                                                 $extra_args $connect_addr > "$cout" &
>>         else
>> -               cat "$cinfail" | tee "$cinsent" | \
>> +               tee "$cinsent"< "$cinfail" | \
> 
> Here a space is missing before '<'.

Good point, I accidentally removed it just before the "commit --amend"
apparently...

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
