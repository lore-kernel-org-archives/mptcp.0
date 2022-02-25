Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F423A1
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 14:29:54 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a8so11205389ejc.8
        for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6NCNS9iNKqZsyzB7pU6Hyy24pSOAaDZqfjtV+LXuJNQ=;
        b=crMqOc20OKGVv/YZFCngd+0eTMGlRJswfO7UKe7uZIIzYecAs9ChpIJauQoh4f8s0Z
         MXKrvq8bGo+QISgCsIexo0khs14DnqzZTpsAAkrmj6XTlb+zz/OOLvlhmAl7W/zuVn+W
         /PGtRoY62DHHNWv5+u7mVGj8Q6ID0EeUPBzSYMyLSEkMQ8FHxhnLag8SSgTAvSgM0Awx
         8z1fZKd0UWbKTxdWuQ0VTDJvaZw4vn2EVFfIj5BXa2fVlRZ43IOl+OnwbFwQkOuPTMBh
         yuGN5IKZ8ng48B+zwCEg59WBRLKPaFM1+tG4pnH1NmnBnHKy7mrPYnCPgfoWrTkwY3uF
         enEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6NCNS9iNKqZsyzB7pU6Hyy24pSOAaDZqfjtV+LXuJNQ=;
        b=FpfiRd44ARxLKGhVZqJ3QbIitjmREPEZ81yap+3h7XwNSMsnYwlgvZ8h75zacUTnNJ
         4S8fnUcGvrkjxYFxCTUMWvr3xmG9OoTNysF6KDir0txwYPEFPnORHYE3u0ui9uVto0k4
         o/IyfMV5gkD5ZEJPtxhsqXmRTQx0aj+SfOi18xOEwWyNkSx1sF87xJ84pw4pXzTDTBe1
         qqpLSKcTDkYY8fkjdjQJwqRvLKtMMAsPRx7q9nS4iYBMwrwjWzP7ugNfERkbMbu0Mi3u
         mIZeY+Yf3DB0VR1+xquAKVoyztJ4qS8cbgW9slWFRTH9r2XtVU4NOTrk7/278X7GolUd
         W5iQ==
X-Gm-Message-State: AOAM530JBwc30i0WK4krHYHlzBzCbE2HBP0DjxeslP/q9OI42R+Vjv/k
	I9IFLSh5YzImMhgwHoKRA1Fkx16C0kaDRbe+
X-Google-Smtp-Source: ABdhPJwO5OBCRo4G1aojJRK5TWeSAA9kMLS+0ocoFNMSNWxuh/a+RAfh03sFnZWe7nMyuHfGW8vUZw==
X-Received: by 2002:a17:906:53d2:b0:6ce:791a:31a0 with SMTP id p18-20020a17090653d200b006ce791a31a0mr6318154ejo.59.1645799393101;
        Fri, 25 Feb 2022 06:29:53 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:46bf:f117:2ce:9a9d? ([2a02:578:8593:1200:46bf:f117:2ce:9a9d])
        by smtp.gmail.com with ESMTPSA id my14-20020a1709065a4e00b006be97e14e5csm1066985ejc.95.2022.02.25.06.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 06:29:52 -0800 (PST)
Message-ID: <51d6dcef-d37d-ab20-e708-e0a1ad262249@tessares.net>
Date: Fri, 25 Feb 2022 15:29:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: drop msg argument of
 chk_csum_nr
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <87d043bc528d81560d964f3536fb549d3ae75a8c.1645744986.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <87d043bc528d81560d964f3536fb549d3ae75a8c.1645744986.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/02/2022 00:23, Geliang Tang wrote:
> This patch dropped the msg argument of chk_csum_nr, to unify chk_csum_nr
> with other chk_*_nr functions.

Indeed, clearer that way.

I just applied it after having applied my series not to force having Mat
to review a v5. I applied this patch just before my series in this
export branch to have the conflicts only with what I modified and detail
them here.

Now applied in our tree (feat. for net-next) with my RvB tag:

- 18e3e20c00bd: selftests: mptcp: drop msg argument of chk_csum_nr
- 8d7b2460bdcc: conflict in
t/selftests-mptcp-join-option-to-execute-specific-tests
- aea568a1459a: conflict in
t/selftests-mptcp-join-alt.-to-exec-specific-tests
- 265b6ab36dc3: conflict in t/selftests-mptcp-join-avoid-backquotes
- Results: 64843b43f8de..bdecb241572c

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220225T135310
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
