Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526258F5D
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 16:05:06 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id gu23so8817301ejb.10
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nQTK2OItVcR6CPv5eNc0RYK6VoIBVj+fNbFdWAjGCM=;
        b=h4/VXAfQLMkR5JNwoykzDDjIZ50TUDbp7Sf5yvNY59fXrCUNyjQQ02Cdj1Rd0eZX3q
         WchXObSgWlHJCLuiRsOtNFK1v3P96bVu0zQcM8ZkeW85jMJjdxUt1ESktGcfbwjZulL3
         2H99uxIvvuFG47ITNOZuiqA/eqB8iCk5wpmdB5LTA8sQHwQRV73LSuRYj29GwFwBewYQ
         +9QcILgZhF+vbVHEooTBY0fZehi5Jhazlef3pVkADJBrhjg+PIBnFGU0uV5L9ve759Vn
         RJGccwf0qNv8sUnH6nDknSpk0sQlQCaFTSAW9MsGJm9dmiQk68mb3UuHZMvDAhZ9LIyD
         1V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nQTK2OItVcR6CPv5eNc0RYK6VoIBVj+fNbFdWAjGCM=;
        b=bwk/rLtHUNveI104KujEn/KcleH4cZIm+C/PwwxuxDfsV9Na5Q45eyZYIRKTcF3e7E
         ROPilcD83OGIIdY7QyVjRDdNzGpo4a9RSnnQkpw6bO/2NInRL1DJpPb1aRf9NsiiynLn
         ws5OrUpFEmYb6XD3KOzRLl8QBijwSO4ZT1ZCqp55UuWICWs878h+bTCU5Nh6uTTBQeqU
         DAqGXg4mdA6L4qNuugeyc6HOxTIYrR0CDkQRZYK5jSv77+jzj15X3uPeQZ+k/eW6NZYM
         xlV7uQstfXD3ybjMu7DlQmigYM4dDynWBsbvJLnER6h5ebuqnJJca6QM8JOjMRyfZlKQ
         ro0g==
X-Gm-Message-State: ANoB5pkBNCQA0XZoJ/z6Y9ypfrqEF8DB+vzVukWSjtCT1RbjAHhg/syd
	pRaBzOfRG2AJeJdGHdBJ40LXx6dDBt+T+9XfYpA=
X-Google-Smtp-Source: AA0mqf7JcMbWo2Zq8k0xtAGLUvxOA7PhuhiaBJRLsAqNsFFeRMqSF6hRrVQLHdaxBhiXTBBe4fVS+w==
X-Received: by 2002:a17:906:2645:b0:781:d0c1:4434 with SMTP id i5-20020a170906264500b00781d0c14434mr43805133ejc.756.1669651504342;
        Mon, 28 Nov 2022 08:05:04 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709061d4400b0078d76ee7543sm5100336ejh.222.2022.11.28.08.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 08:05:03 -0800 (PST)
Message-ID: <9a04313e-9874-ff64-64a5-d1d367125dc7@tessares.net>
Date: Mon, 28 Nov 2022 17:05:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: menglong8.dong@gmail.com, Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev, mathew.j.martineau@linux.intel.com,
 Paolo Abeni <pabeni@redhat.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221122034923.804955-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong Dong,

On 22/11/2022 04:49, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> use. In the 3th patch, we make mptcp_connect can exit when receive
> 'SIGUSR1' with '-r' flag. And in the 4th patch, we add the testing
> for this commit.
> 
> With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
> I belive that the testing of diag.sh can pass now. In fallback and
> simultaneous close case, the msk can't release normal (sometimes?) without
> that commit, and makes the testing fail. Enn...let's just see that the
> CI is saying~
> 
> 
> Changes since v6:
> - check all processes exit in flush_pids() in the 4th patch

Thank you for the new version!

We discussed about this series at the last weekly meeting we had and
globally, it looks good.

However, Paolo mentioned that it is a bit of a shame we need to increase
the complexity of the code for the stats. I agree with you but during
the meeting, we didn't find obvious better ways to avoid having to add a
new flag. I will let a bit more time for Paolo just in case he has
another brilliant idea :)

Other than that, I have some small suggestions for the patch 4/4 but I
can do the modifications when applying the patches later if no other
modifications are needed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
