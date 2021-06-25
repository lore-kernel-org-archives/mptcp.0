Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA454177
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 09:07:23 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id i5so12481618eds.1
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HHQ3srj+Qr4MqU6yvmiottlBYfGGUzRueeE71PA89lc=;
        b=u6vtXxU49nDWxLDLBgTBxmFnjHgugfS702n8nlzoGpZP/C0LBTTEvmgg++qykHm3xq
         LNy4qoFgZL543ay8NlTkGtosgcpXCvCpovi01LgKK7R/bW4swqfG9CfJt8OHZ76sGXCn
         uRaIXECueMVDmjLPWZY6T7cBobAQoZEqbGUWI8mrawMk2xHKb8EhL9rjsOa71BVMGlF9
         GbuOYTaB+ZuJAMsAEX5ucz4B+S3qQ5KGTToBIwULVrrNo5dAGhsR6NYOueumBPYjVzWt
         ejZMukKtkLcL9Szz7KLX4Cua2YLfzmMcRrEMf5NQ8eP1L/sdXfY6iSL800qpupwPdxCb
         DtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHQ3srj+Qr4MqU6yvmiottlBYfGGUzRueeE71PA89lc=;
        b=Iy6xsx+T94OA5ahvcBq1zlUVWVPZWiEM7Y29PUVfBf2Nt3BDe47ubsJaTnXxy+Z+74
         Jv6pAjFHwmhomHpWoXeKvS8xxNB5xBmF56k57t8onpl35rf/pZ3LpV4iGugM5P3SmgzO
         ZlC3307ySYi2ahq0NaILwPVRzvQR0yZtW9Ly6uwmSzQSnbSb4LmIDDGnHP17auaZq6rT
         BzVgpZ7cb8D93TpJr5nhKVhXENwqHEYdXV5303jNNMB34Bc7/zLmXjT2GrzauyH/eEwU
         uHlKhiZJVY7gZZMmePE2Kc2SLDNSUfCDb9zbs13sdCDfsT8QYJ0G7OUJnnpyb+LA/hsa
         jfNA==
X-Gm-Message-State: AOAM530HNekartDM4buc/3NzsZtYqrzZ+a0nlALYix+7BpaGskFi8c0n
	FnWDy5NIQItYh5CG9CEMEb4nlQ==
X-Google-Smtp-Source: ABdhPJxLQjSkbzI8++df5tbsUl7hOsVyVvfJnlSYv69aZWcEY65Rv7ctLt7xt4fVo3X7vqJRbhlTrA==
X-Received: by 2002:aa7:d751:: with SMTP id a17mr1499095eds.324.1624612042259;
        Fri, 25 Jun 2021 02:07:22 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:3f3:57d7:aba5:347d])
        by smtp.gmail.com with ESMTPSA id dj24sm3539483edb.21.2021.06.25.02.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 02:07:22 -0700 (PDT)
To: wujianguo106@163.com, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, mathew.j.martineau@linux.intel.com
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
 <1624609559-6786-5-git-send-email-wujianguo106@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net v7 4/5] mptcp: avoid processing packet if a
 subflow reset
Message-ID: <a3caa434-2e3a-3370-c3d5-466023923436@tessares.net>
Date: Fri, 25 Jun 2021 11:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1624609559-6786-5-git-send-email-wujianguo106@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Jianguo,

Thank you for working on that!

On 25/06/2021 10:25, wujianguo106@163.com wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> If check_fully_established() causes a subflow reset, it should not
> continue to process the packet in tcp_data_queue().
> Add a return value to mptcp_incoming_options(), and return 0 if a
> subflow has been reset, else return 1.

A small detail but it looks strange to me to return +1.
Maybe clearer to return -1 in case of error or return a boolean?

If you decide to return -1, please check for '< 0':

  if (mptcp_incoming_options(...) < 0) // error: we discard
      goto discard;

and not:

  if (mptcp_incoming_options(...)) // no error but we discard??
      goto discard;

(Or replace subflow_is_rst by subflow_is_accepted and return this
variable but it might be strange to return that if you don't have a DSS,
etc.)

But if it is only me who find "strange" to return 0/+1, fine not to
change but it looks uncommon and maybe a source of misinterpretation :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
