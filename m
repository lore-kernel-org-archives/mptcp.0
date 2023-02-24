Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7F539D
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 14:02:39 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id d30so13929297eda.4
        for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuCTXBAb5Q7rFZLV/MSV5PgvyHQbRqCxvADaDU/wtkI=;
        b=1/w55iv//usuV3cj1Jv9pUe6+4hL67f+2NQ/lZdt6g87S3hNBNGolUf97Uif0vWjFJ
         SMpUwIb0Qn20dlBTXKi6IOoN1TU33vHBP4R/9qSt3PL+tTQVgzgVUb64ztOhq52HT3iv
         HGLRYkw9eXegREVRudYJQUq5i2ABJI+bN+CseXQc9jfRf6s64/iV0WbPfpCqzttOSgTX
         71DeLh83N6gH1W5ZGwB41wONxv6jmxVKFDVzukFfU+YI4ZG624EKcj2DzoDY/A2xVfih
         xqRa2Ck8kQMJ19WxOJy+DrJ1fQAYhUig4DXsootN3SneGRbloTiUHRdjgUSfaQkIiDz3
         p09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuCTXBAb5Q7rFZLV/MSV5PgvyHQbRqCxvADaDU/wtkI=;
        b=Jt0AH1j4O3Fnr3MwdwSNPZuEP7UzUwQsSz2wd07NPgKdJGuuLQn3lBcSPaRBUrek52
         Za7Ahu/mm90HU46VfptRhP7532SincpzOlcreGD+GggAPyI9l8cwq8kM0slaAvXagm/R
         HO8ER8MTWIm6dOm93vhBxBiJ3QjnMBH2cdzndgVL4g9F7IpYshvcuAGodvrRztMVRVh9
         83Mg6vtzIHDEnHZpsm2LTKZfqfU6ssO7Cpl2cwlpsfIzcC0vuXPvc4mvAKshXpL+eSno
         UtGI5vQ74snq5VkeK6SGnH4LdW3e5ZUCOi0JdMQ06IGt+rru97NYeYTY6QkBuqLdGr4P
         74QA==
X-Gm-Message-State: AO0yUKU6lEh6rpBXOPu9ZtnQBMf0c6bOUvywN7suKn5dlQ05sBJk5AMg
	44LWWsMjPWoMP61AoPGpY850OA==
X-Google-Smtp-Source: AK7set/O2gXO+qtEyzgpn4y0SHrB7AnjencTukzPW36VymJMao1NjEJl+8TzvJP66Hwx8MXoOoak8A==
X-Received: by 2002:a05:6402:1853:b0:4ad:a70c:f9d8 with SMTP id v19-20020a056402185300b004ada70cf9d8mr15451037edy.16.1677247357182;
        Fri, 24 Feb 2023 06:02:37 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id lx22-20020a170906af1600b008ec4333fd65sm2292251ejb.188.2023.02.24.06.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 06:02:36 -0800 (PST)
Message-ID: <c5acf58e-8bf4-be18-13c0-891af8146c5c@tessares.net>
Date: Fri, 24 Feb 2023 15:02:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive in
 mptcp_pm_nl_create_listen_socket()
To: Paolo Abeni <pabeni@redhat.com>, Christoph Paasch <cpaasch@apple.com>
References: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/02/2023 13:01, Paolo Abeni wrote:
> Christoph reports a lockdep splat in the mptcp_subflow_create_socket()
> error path, when such function is invoked by
> mptcp_pm_nl_create_listen_socket().
> 
> Such code path acquires two separates, nested socket lock, with the
> internal lock operation lacking the "nested" annotation. Adding that
> in sock_release() for mptcp's sake only could be confusing.
> 
> Instead just add a new lockclass to the in-kernel msk socket,
> re-initializing the lockdep infra after the socket creation.
> 
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener creation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the fix!

It looks "simpler" than expected, no? :)

The modification seems to make sense to me:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I guess we can also add:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/354

It would be good if Christoph could validate this modification :)
I can wait a bit before including this patch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
