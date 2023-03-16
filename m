Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F026FD0
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 18:26:04 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id fd5so11184483edb.7
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678991162;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ly7vWtIP/5z78aRqytEaMrwqtd+ZzxgBQ7zThsxVNMc=;
        b=LyP3rvk36qzhCGgGAS3p3oECpo5mMS6vuRPRuwpGpdBsqBtMFju3WrSzvNcihslPAX
         W9IUbszAH2ZDYb+OboXf5ARtvlekf7BrMwmstiQ6m/5v9UaSsEvTxZOQJzfgVTU95Awh
         zq1CKTBvb3YdeC7FKGLa25VgPScKWRc53a4QjzBo3Pwa50f6LE+Ks75Ag1wpLryBkH+J
         58ip4+cSql8iMITZ3L+S3LDpKKE++cthsbb1G/eeuOKaFmZiPrTB97ZGnvz12B/MX2jA
         +fvtAqWPI+bqtwGQTa6tLGVFVYvbn4cKmHM8qCMnhHvRKBUDl+QDTskRuttERC5XvWtZ
         zLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991162;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly7vWtIP/5z78aRqytEaMrwqtd+ZzxgBQ7zThsxVNMc=;
        b=c6mInc3UvgzMtmI4caHT8XfLde6Kfw94kFWXIEvregSuP6eHaQsDFzuURWBh3ooLXM
         ZMDoAGeSeDHW+XyYT4FJ0DtaJYhn6p1v9NETbVBIXHPHNxoj367BTTcofsipduvfWwb4
         QKtz6TOu68TBRTAF+Yypdq5Vp4QnSkfnFOkHn/vHJvUSHXCVPPmiuQ4wUoqfDEaorotJ
         pgt3v1HNUH+ylIBAYs4l9RbKyPkUwnB5WQ+ymv3FIBqrsOMrKTCslZO+MG/P6Axd5wE6
         z6nLbX/y/ReYkA/NLkI+T86s/Lfzg9jemJneQXahnbtHXwITgHYzdZng6WM4afDoO+PA
         1IPQ==
X-Gm-Message-State: AO0yUKVtaYTA5A9wGK7MCDpvwhswq/IQUz6FLXiUTPbdr6JYR+tQWJFG
	CjhFoPjnkfoBWOH29kBvWZGhBw==
X-Google-Smtp-Source: AK7set+luFHawSkpgIetpYWFHA48hPJuPxGCS5dOkr1ZqY49WiyWkEQXX0rQBqufFwzAMt3UJX/x8g==
X-Received: by 2002:a17:907:9494:b0:92e:efa:b9b4 with SMTP id dm20-20020a170907949400b0092e0efab9b4mr14039596ejc.22.1678991162295;
        Thu, 16 Mar 2023 11:26:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f605:63cd:a743:20d5? ([2a02:578:8593:1200:f605:63cd:a743:20d5])
        by smtp.gmail.com with ESMTPSA id oy17-20020a170907105100b008e385438c76sm4144233ejb.55.2023.03.16.11.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:26:02 -0700 (PDT)
Message-ID: <067bd46b-9c12-36cd-8ea5-3667669dc6cf@tessares.net>
Date: Thu, 16 Mar 2023 19:26:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v5 3/7] mptcp: close remote subflow when
 destroying it
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
 <d47a06abb5dae1f333a496183da5ba3e51e5a98e.1678778977.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d47a06abb5dae1f333a496183da5ba3e51e5a98e.1678778977.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/03/2023 08:31, Geliang Tang wrote:
> Not only close the local subflow but also send RM_ADDR by invoking
> mptcp_pm_remove_addr() to close the remote subflow when a subflow is
> destroyed by userspace PM.

Should it not be the responsibility of the userspace PM daemon to send
this RM_ADDR?

Do you maybe have a use case where it is interesting to force sending
this RM_ADDR when asking for a destroy?

Maybe we could do that only if the userspace PM asks for that by setting
a new attribute or flag? (if there is an interest)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
