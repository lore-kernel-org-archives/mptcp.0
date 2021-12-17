Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BD168
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 16:29:19 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id y22so9970726edq.2
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=t1eY6i4NamCEonhkukz7iQrx0ADRdA+C4n7Nqi9UZP4=;
        b=MCHE6cZn55jEYxGETPEff+RzyOjLr6Ae8hHDZnLbiIBOBBdDp2KhiTpGCz1RvK0eOk
         /t+JQfZXNcz9ZeYhg/pfRTrxvF3ZMmpWBCwyN/1ye3RTOBLDC4Emku10snsJ1X+fDNMn
         0a/jXDscWhMt4BLItjZ9cFIld1cnHYw0h0PTnB2S4kAqdvEENYwYERAm8Ev9IwW0INWG
         jFFjQ3zKx4CeL4VyZ/LTMMc+FDzxIBgW4nXhPWCc7NiWT3VCGG0HyY0bzLnyFRSS6mOU
         intE3u1qM+F8DjoYce7RDb8FL42gjVijoEbfry8Qv9FPNbW3vuNUYPlzv494K8/95/1p
         JDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t1eY6i4NamCEonhkukz7iQrx0ADRdA+C4n7Nqi9UZP4=;
        b=E83KdkG8gsR0EC9BSHQcLUxoQ0Ipr55B4o8BnbCzqmq5Nh0jgNMSGDic53p/hG0iLx
         XzELlVVQLXRPbeI2Ov05GPSB19TaRSlZPgM54i8d9ZTP5OLB0bSEw6VRTB5hABHvdkz7
         frij2etehpQXEvSOX8uKe+5rQPXOQ2Ds6gqSHwnAG3FqbGyA7c9a1BBMa/PeR2Nc/Jvf
         wSxIwtR5363aE1QNbg1zWARv8mtUw2536+X4MW4o9bDNqoNXg+gskZvnGiwxtFCh4xdW
         OSc8sphrwYFVpRC8Mqn1jR47vMsEJsDz3uvlHvNWlfEonS6pXDcX+4TU9OdeY/BG8uHl
         WpBw==
X-Gm-Message-State: AOAM5331RTzEDeXIUqxbBfp/jYOseMHW6iaYYfBLT4FwB/ddd8rg0rUp
	VkrsKV0+MHUd7mruA3gKGe7qmf9U3hV/nA==
X-Google-Smtp-Source: ABdhPJyKhIjBUG1G+ZNT4x6ia+mGMsgV8p1i/tn1QfTkF6yOu/FLPEZdEDXZCU6ih6ya1ZYgWUz1CA==
X-Received: by 2002:a17:907:8a1b:: with SMTP id sc27mr3033462ejc.572.1639758557983;
        Fri, 17 Dec 2021 08:29:17 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id qb31sm121676ejc.76.2021.12.17.08.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:29:17 -0800 (PST)
Message-ID: <e9dd7944-6eb5-b96e-4192-d52c98decffc@tessares.net>
Date: Fri, 17 Dec 2021 17:29:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 07/21] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-8-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211216222314.1244708-8-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

On 16/12/2021 23:23, Kishen Maloor wrote:
> This change updates mptcp_pm_nl_create_listen_socket() to create
> listening sockets bound to IPv6 addresses (where IPv6 is supported).

Should we consider this as a bug?

I understand we change the behaviour but I guess we should have done
that from the beginning to support IPv6 and v6-mapped addresses, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
