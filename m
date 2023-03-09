Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3339D50B
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 15:07:38 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id h14so2203220wru.4
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 07:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678374457;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEz5yI3gKdjpRDYM4isqKbVKOKISAPc1g+Kue/NOmPs=;
        b=zVeEQ0sbY7pvBz8mUiICiBnxw75mmct6JVRabJ2S6fh5zNKAY4Ex/oAKSmgLiXu4ni
         w+t3FgMR6ZxLB3eCij32Rv9vHtJJc8mOeqs1KYhI2uG3hr10GDRR/xc0wCp3A5qzHFfK
         xHfVjetwOGCI24L+BGpiNujZhwaej1V3lOyQwuAs3tz/h7Vxap0lXc5EV5tqW5s3BKv2
         abMZIj0VrkVNEq2zXZA7UjlmL4jwLLYT7P9TsG42hx8QWxnA/S/pZaME09IwLH8+kNCv
         FaXX0IQG8tJkf9GwM3dP8q+06pgCSxdx2HpFbhINgzKnVSlvPQLXIyfH41O6rwr96s1v
         2opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374457;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEz5yI3gKdjpRDYM4isqKbVKOKISAPc1g+Kue/NOmPs=;
        b=R+AyxeojAUfWGu5lDqVemKbWiwlAy1ryvew2KXtDw2kuaAZgNwlXyrNeEt+FDFbtTz
         omzhoyA/gWRwHU8eJtPV7aQfGA3dkIvjS68MrkJWhnUaYnX4OsF2ruth0zT38Ddb0rEh
         YhxpYz9nMfl8FobKqtMB1Mleq4rwrYUJhfFMd9W55LOuDMQNE1nPi/eujgYWujxAKSIW
         vHkaMWTP7PChlTFIEa3u5Alf3x5j0qhVbYKoyXJ8XsFAsPxSFTkIqvDVnJhm6OoLsL4e
         AFVZTmywiNDGaXPXVhgMd588RjSeo1X0QBc4KbwGbKW4kxv1gvosSu6RM+OsSbhHIEs0
         aa3w==
X-Gm-Message-State: AO0yUKXeGNcVKmlM4JxmcMQhbqkiwjj3VgTIMYw/3FopcjXg5UvXq9EM
	JWihjwiKRyeDJRYJJuc+L99taETtTLrnPbiDBfERyg==
X-Google-Smtp-Source: AK7set8Mss36YX5/ovjH51oQH84XvKBmQ2RmcYlX3AGgm+Ij887pFP9JrU3Te4gs1n6+aBz7ze8OOQ==
X-Received: by 2002:adf:dc89:0:b0:2c7:1d0d:7183 with SMTP id r9-20020adfdc89000000b002c71d0d7183mr13720292wrj.9.1678374456746;
        Thu, 09 Mar 2023 07:07:36 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:1a5f:4992:ae80:6267? ([2a02:578:8593:1200:1a5f:4992:ae80:6267])
        by smtp.gmail.com with ESMTPSA id b12-20020adff24c000000b002c556a4f1casm17808331wrp.42.2023.03.09.07.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 07:07:36 -0800 (PST)
Message-ID: <7cae33f2-343f-dcbf-d527-7ea279ec43c4@tessares.net>
Date: Thu, 9 Mar 2023 16:07:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v4] selftests: mptcp: add mptcp_info tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <4b8fae0280f74cb4678677a112113bbbc2b27d5a.1678365107.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4b8fae0280f74cb4678677a112113bbbc2b27d5a.1678365107.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/03/2023 13:33, Geliang Tang wrote:
> This patch adds the mptcp_info fields tests in endpoint_tests(). Add a
> new function chk_mptcp_info() to check the given number of the given
> mptcp_info field.

Thank you for this v4, it looks good to me!

Now in our tree (feat. for net-next) with my RvB tag:

New patches for t/upstream:
- c896d1975c77: selftests: mptcp: add mptcp_info tests
- Results: 9779a995c2fe..6a60ac3765b9 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230309T150631

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
