Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460EF63A0
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 17:18:52 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id g12so3744130wrs.10
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0db7cGjFpLrsxaZTlCWvccufRkXThv+YBUa7Argu0Qc=;
        b=ElS79yJaVI28Wb1/75frRsJu2ddidX3w7ZH5B1Q130lJfivFQQma3d3e6l8s7xxQry
         Ac5jQxQDKtNiwaLfLUIHnJvkWgOX+VyJ2zdUn0GVwGONatqiB6E0EosntbFGQjkccyNq
         UYJBRsy8f2lTqVD34TSYt8+l2GM/FsPvoDgk4qZhSYb5oLGjOZIzxGFNdoRkTZOmFUIb
         pZ5JE7pwqKuZx2WCjVIHMMG4nVFsWICTyph4HZXwTBFsS8qoJ+f9q1/ROHQrYHB8CjUC
         bLQy7z31BNvcV5uVYbfm/G8mz6xDvjO4FFMeLSkufcsoQRbKV2SfU5Fh5wQUu+R6MyAw
         GbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0db7cGjFpLrsxaZTlCWvccufRkXThv+YBUa7Argu0Qc=;
        b=zC3JdDlrJPP9or7N+JpdRUQcwWyIqB4Zl9EDroTGfwGuwVPH24nJE/r67v04y1J49/
         PcURKuhz6XA5C6hweiFLjIjavUvn9kR8g1xIw1K6twRLcYWwKODafZT1dv2210ctNDzh
         ZQU3yWjYwznevXp/74y1v2TdSPzyA4HIpHy0lXJ4vRB6GfuwxnZAbaygS9MBBga5dG5o
         fRnRmkYlOJLHTKtKDcuhIv+jIq3j8sFLsDrtOu3lsjVQ7sxRuVGso3zclUknEtv9PzXR
         ozLjbWQ2d75dPzeY2NYOXWUcpSWsHMfGdsq6XdU0L5l+vTH+CIz08Kyd+Z+7B/Shx1qg
         jqbw==
X-Gm-Message-State: ACrzQf3acYy9Z1pI+J8NIydq30j0Apo1PUHfKNLmI8ZvJ9lts6Oi+mOV
	1MOKK6P0DAMkXDYxgK6lFRARhZELBq4rUY7k
X-Google-Smtp-Source: AMsMyM5beCu9f2fd5ApXNYABzg34bPSFvkt1loGai8Xyuf5Sjeg+KFEEvhltW3ePr30wvs04VH/Hiw==
X-Received: by 2002:adf:f342:0:b0:236:9035:31b6 with SMTP id e2-20020adff342000000b00236903531b6mr19462284wrp.200.1667495931067;
        Thu, 03 Nov 2022 10:18:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f4ce:89a5:47d5:7afb? ([2a02:578:8593:1200:f4ce:89a5:47d5:7afb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b003c71358a42dsm650628wmq.18.2022.11.03.10.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:18:50 -0700 (PDT)
Message-ID: <181df718-eed0-8c74-452b-a7865e53e003@tessares.net>
Date: Thu, 3 Nov 2022 18:18:50 +0100
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
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <20221101205538.13892-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221101205538.13892-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 01/11/2022 21:55, Mat Martineau wrote:
> We kept getting initial patches from new contributors to remove a
> duplicate 'the' (since grammar checking scripts flag it), but submitters
> never followed up after code review.

Thank you for the patch!

As discussed at the last meeting, OK to apply as it is:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (feat. for net-next):

New patches for t/upstream:
- c98a6a04fe47: mptcp: Fix grammar in a comment
- Results: c40114c3c367..5b48361cc96d (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221103T171741

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
