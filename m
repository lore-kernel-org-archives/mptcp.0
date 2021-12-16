Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E12C82
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 15:29:16 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id r11so87426208edd.9
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=8A3sm+2Kr5dCBC4QGLmYpxLuY38eCshXGYlUts2VKQ4=;
        b=7vvgZr2vQQ/PjKgezg088yjhMbG2pqK7cI8UfP5Ihyy/kwvjBfFnlZgBiXAzpHl/Vd
         apaSFdyPcuT5viUFS0kdVII8pjV54FvnrMz725aIleYmOv+aKEcjmMmrjssH2a1p75T8
         6zw8S8ocLU4FO5qb8WVhtNsvhT7eDs19+ecPJtpxAT7xwsjahX1XKUmmYAnqjw0wGJ+Q
         DZrGoAvfIqg5ChNgiHloF1U2zM+/o6cdHnTgwAv10iQADbzDRxzGPvMawUwChqOQZ9ZK
         QdeGWgWYmQM3hZM7oXUzgb0/tc94wO7QZ/AFQvZwxk3CdYYFCGuw8/KpWxQaP7rProYS
         jUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=8A3sm+2Kr5dCBC4QGLmYpxLuY38eCshXGYlUts2VKQ4=;
        b=XB7Mkrw0JAawX1wkLzcIB4K9rUxrP/JXbQ66BiXZqsp3jUEWJ2n1OuV/2Txi/+q5N+
         STqHBv+u1xZsnek6KCD6U57D7XnlPxxvktByqggN4Shvbk0AIgcTEzJfQOI8I0MRpGGo
         h0JydvVsGHzPdkyIjr59gp/iUCs3V62tA6qVehBjhWNlTPfsIl6JnTSa+ADZqNePP4mL
         qWklhzyd6LwGjmqV6tidAUbXraEJDHv3xlZyfTaw00ifvjO6lG4vav1PZ9g1uzz8Z2V+
         en387Eh1NAjUxFqx6xpoT79e2jkKC0x6JIF2zcK6+2eWelgjGS4efFLdjVUouPpIiSPR
         SMNw==
X-Gm-Message-State: AOAM532e1YTVPgC1WSP5/4R9H+ESi5lDrHiUqHbHxgpjXyQ4dAabzgP1
	bPbynOGtLNmzqS/MkpZsZVCPRg==
X-Google-Smtp-Source: ABdhPJwGid6aIzspVupOEXxY9E0Prbkc3B5MS6EQA/yKqHCjiXh/kYSOcOXthdOspmyo2Va8yXfXaw==
X-Received: by 2002:a17:906:8285:: with SMTP id h5mr7893456ejx.618.1639668554059;
        Thu, 16 Dec 2021 07:29:14 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id lv19sm1913260ejb.54.2021.12.16.07.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:29:13 -0800 (PST)
Message-ID: <0b0337f6-a2bd-76a3-761f-e688407462d1@tessares.net>
Date: Thu, 16 Dec 2021 16:29:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next v4 0/6] mptcp: Add userspace PM mode to bypass
 kernel PM
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 16/12/2021 01:33, Mat Martineau wrote:
> One part of supporting userspace path managers is to prevent the
> in-kernel PM from acting on userspace-managed MPTCP connections.
> 
> These patches:
> 
>  * Add a per-MPTCP-socket 'pm_type'. A mix of kernel-managed and
>    userspace-managed connections are supported within each namespace.
> 
>  * Conditionally decouple incoming ADD_ADDR/RM_ADDR and subflow changes
>    from the in-kernel PM. Netlink events are still triggered, and ADD_ADDR
>    echo handling is still in kernel code even if path management is
>    otherwise handled in userspace.
> 
>  * Add a sysctl for setting the per-namespace default for in-kernel vs
>    userspace path management of new MPTCP sockets. This is an integer
>    value to allow extensibility.
> 
>  * Add selftests to confirm that the in-kernel PM is bypassed.

Thank you for the patches and the reviews!

Just applied in our tree (new feat. for net-next) with Paolo's ACK:

- b27a8a51fc93: mptcp: Remove redundant assignments in path manager init
- d9fae9ab22a1: mptcp: Add a member to mptcp_pm_data to track kernel vs
userspace mode
- 136ded889aa6: mptcp: Bypass kernel PM when userspace PM is enabled
- 08c305f2bca4: mptcp: Make kernel path manager check for
userspace-managed sockets
- 9864091e402f: mptcp: Add a per-namespace sysctl to set the default
path manager type
- 693a40231edf: selftests: mptcp: Add tests for userspace PM type
- Results: 1fdc9db07613..f83839879847

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211216T152900
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
