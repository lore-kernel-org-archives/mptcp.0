Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B02C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 09:53:25 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id b13so7304069edd.8
        for <mptcp@lists.linux.dev>; Thu, 06 Jan 2022 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pRJBS6lXEZ5TxcuhMBCSIGaMcVsLmCI94jByJ5KWz18=;
        b=dQPY+bQQapYlcg7N/j2JKBFYmTasdnAX4zIR1OYPF0yBxG8o/J4dz3RvwI9eqNp6Nx
         7sXwewL3uPgk23FHICDGcGfutz+kMlsw1VsZVe3dZIfSYFuFL2B7wJ5YA/c/B5dA2rcN
         OxhC3Xhj1Gthv8U6o795q9XkUBiJd4vBYbwkor2WUpLaN0KdE+3ZTE1mzqvM1y1EKj6+
         XNZKpp4F/R1KB9gJHEaePUG+aOdvV2QQ8M2rahRS3Y7zXOjsRd6iVpLFVem2Qq/t8mZ9
         L6t6aq4C+KZMV4DAcQq4aDEQi60N9f0MYg5slCw7kIcvAEBTxb+tb07hWtP7M6wgHpPv
         0Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pRJBS6lXEZ5TxcuhMBCSIGaMcVsLmCI94jByJ5KWz18=;
        b=AR74vjIPlh3mv4+WAh3bve0hROo9EUWCFbpoZItqvyu9nGAX/3iSt9s8Q0bKLfTCUL
         STThtnIe3TOzePfjpIrhX9fEr8BXXw7c7gS5dnHrqTk/BEp7SmkB2SLTqaAILSkoqxQo
         emMhaq92AF1pu5KhU3RX1FGbqe7CcquClRHU5IhoyvEZOiOlS7kdqUPB+3VeciUsZj1S
         Wd6UobDMolNode45JvDwGnC6WqWVwPXteFQ09ihn2hBwTukiID5dV6GJSB2YyDuYPjXw
         pJWQG6vT39LjYZsvogsbsT7bs4uEBuq2duStui8ImEjx+u2ulxC5BU4YUHYnQSgqRA4s
         SkVg==
X-Gm-Message-State: AOAM5315B77eyJk038WHPmv20AwF1z1+1QPUX0LDpYJ+g6ujF5LJZ9yu
	bc5rTYzymRINY0qemoIQ5uWnMphkIH1A3w3ttY0=
X-Google-Smtp-Source: ABdhPJy9JJJYEy5/Dg6QgHnKt2qb/kUAvHkLFZVKgl+K1jlq6uMF5IJZE52w+ZDpfeBSfp4Twx816Q==
X-Received: by 2002:a17:907:9717:: with SMTP id jg23mr49588452ejc.593.1641462803971;
        Thu, 06 Jan 2022 01:53:23 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f806:b935:3199:df74? ([2a02:578:8593:1200:f806:b935:3199:df74])
        by smtp.gmail.com with ESMTPSA id ht16sm373566ejc.4.2022.01.06.01.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 01:53:23 -0800 (PST)
Message-ID: <fc3b17c5-6d28-8a38-65c8-a85ab735b9e2@tessares.net>
Date: Thu, 6 Jan 2022 10:53:23 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next v8 0/8] Clarify when options can be used
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
 <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/01/2022 03:58, Geliang Tang wrote:
> Hi Matt,
> 
> Thank you so much for this new version. Good catch on patch 2. It works on
> my test and all looks good to me...
> 
> Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>

Great, thank you for having checked that!

> ... except patch 6.
> 
> I thinks we'd better to drop patch 6 ("mptcp: allow sending both ADD_ADDR
> and RM_ADDR"). Since ADD_ADDR suboption is too big, we had made a lot of
> efforts to let ADD_ADDR not to be sent with other subopthins. I thinks it's
> better not to let ADD_ADDR sent with others by ourselves.

ADD_ADDR suboption can be too big in some cases but not all the time.
If I remember well, we decided to have a dedicated ACK to simplify the
code: not having the ADD_ADDR removing the DSS options in some cases but
not all, also simplifying packetdrill tests.

Here, the idea is to add the RM_ADDR if asked and if there is room, just
like what we do in mptcp_write_options().

> On the other hand, I'm not sure our code can deal with ADD_ADDR and RM_ADDR
> together correctly, it's not tested.

Good point, we need a test validating that.

I'm not even sure we can have a test because each netlink command will
cause the corresponding option to be sent: depending on the timing, when
the next packet is sent, we might have one or two options to be sent.

If we drop patch 6, we need to replace it with a patch updating the new
comment at the beginning of mptcp_write_options() and not allowing
ADD_ADDR to be sent with RM_ADDR + MP_PRIO as we currently do.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
