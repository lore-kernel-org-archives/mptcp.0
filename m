Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D568
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 09:44:57 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id l25so40280761eda.11
        for <mptcp@lists.linux.dev>; Mon, 06 Dec 2021 01:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F2EfkTq3ss+qCaUKOaiJrQOTicc1nTrvg0q9lBJ1VfE=;
        b=KNs8r3LcQ5uMV3MRWZYo4JF7fkvLXngL/K08gmSqYodimtRB1zZoOX4QD0FjXa0UqZ
         QPsiee6cuUHC9Uby5C5YgRFGbeyTl5Ecc3KymeYBafLMMoMryXasxdjSr1fbdZhnkHcm
         qY1BCqm6Q41EbRfVY70NgViGCA6JV6lA1Zlmj0nW2/HOE4UL2UC9uD0poW4c9LQ6RXZ4
         AjRLW0deP3Op1xkxcDsEJQ0EEhzsXN77HKc7Ejr6sCtSdmWU1aU886MNxIj3lH4EJrCU
         XgOZEC6umuArWKLFpPPA3ORxPYQdJciC62ei6e8hA7rhaqhqxxet8x47fLyd+ySpgNTp
         m0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F2EfkTq3ss+qCaUKOaiJrQOTicc1nTrvg0q9lBJ1VfE=;
        b=3bi00cN1X/AXHjlrPKyf0bPoEAT8pFDEgct5fy+JI6Sg0IMIpFciXu2oLRfSW72fsx
         q6Zk7yKWy3FgcN1Xjdt5qwmlJTnydcgesJLzgGZ8iuWYb+ymudgBXA4RDxtKWn6NSFaj
         qEc0MjUikekgIkMsWRwRQEqo59i6Wax/vyWdm9qKEz86YAAGqSDsvtaqKLaWH3XohfH2
         rFXEeE2hENJK4Wv13Gf158dTuI6x4zPi/87cUf6n7oj592SgGv8y3T4SBDAV0FDCdMD8
         ZCCIi6yvq4f/pIJPwmSmIiefNSWnsDN/wSGE4y+oszdSui81Y2JHkBov8meFPxF62oSw
         ob+Q==
X-Gm-Message-State: AOAM532+OD776ZmdGpRsgR/0E2oHFNvy8OC0jAMNvmPINKSuiH0ZHqxM
	XKMinfSqQEBOUjCaM7IVXxfoO5O/Pa/ee8rw
X-Google-Smtp-Source: ABdhPJwbEjhKEyWD+HIW9zDlp2pXlrs3/HzVzMniSbrYQKKxFLpzAemNUSSzF1ydtf+xRPtwtYqfSQ==
X-Received: by 2002:aa7:cd5c:: with SMTP id v28mr52976668edw.6.1638783895930;
        Mon, 06 Dec 2021 01:44:55 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id d18sm7605712edj.23.2021.12.06.01.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 01:44:55 -0800 (PST)
Message-ID: <61ea8986-10c2-1d4f-6c35-2c910dbdcf89@tessares.net>
Date: Mon, 6 Dec 2021 10:44:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp] mptcp: remove tcp ulp setsockopt support
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
References: <00000000000040972505d24e88e3@google.com>
 <20211205192700.25396-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211205192700.25396-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

(without netdev and syzbot ML)

On 05/12/2021 20:27, Florian Westphal wrote:
> TCP_ULP setsockopt cannot be used for mptcp because its already
> used internally to plumb subflow (tcp) sockets to the mptcp layer.
> 
> syzbot managed to trigger a crash for mptcp connections that are
> in fallback mode:
> 
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> CPU: 1 PID: 1083 Comm: syz-executor.3 Not tainted 5.16.0-rc2-syzkaller #0
> RIP: 0010:tls_build_proto net/tls/tls_main.c:776 [inline]
> [..]
>  __tcp_set_ulp net/ipv4/tcp_ulp.c:139 [inline]
>  tcp_set_ulp+0x428/0x4c0 net/ipv4/tcp_ulp.c:160
>  do_tcp_setsockopt+0x455/0x37c0 net/ipv4/tcp.c:3391
>  mptcp_setsockopt+0x1b47/0x2400 net/mptcp/sockopt.c:638
> 
> Remove support for TCP_ULP setsockopt.

Good catch!
Indeed, it doesn't make sense to support TCP_ULP.

> Reported-by: syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
> Signed-off-by: Florian Westphal <fw@strlen.de>

I guess we need a Fixes tag here:

Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")

BTW, did you send this patch to netdev ML on purpose?
I guess this is fine but they will probably ask for the Fixes tag as it
looks like a bug-fix. Do you want me to reply to this email on netdev
and include this "Fixes" tag in my email?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
