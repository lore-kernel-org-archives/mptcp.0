Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7A173
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 10:22:11 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id u21so63443649edd.5
        for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 02:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ivlw7AFR1yqC/GlOISH9cEJ6vmpfp45E5qy7FiSUHxg=;
        b=XHlseLlT3uHs/hwyI6xMAykULwBqm87gnwaK93ydoy6dzhdJm+I3V7M4UqOf0qd4B9
         O6AVoRTEgZ39q9UmZWRxnYEZKmQ9SdADlDkPDB1Tg6whN8ZhJWT8+1PV/N8qn+Pe6WNO
         Qvr740b8vjOcgZJN7+Q1hPuzKk+ms5Ac54+kUBocvrKw5ZLhQDb3t2KjmyBL07KmBLFy
         6/J4yJMaoj0TML47Rv+fc07CWb3RoKUN2ayRNdSkj3ZeG1NO8kS549oH+XUe3Lgs/ww0
         hNMIHMZLBABsT/5m/eodP6gSK8ypW6C7EJXqKc6A3aChWZqpGan4phuBJ+43AlFcdHwz
         HDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ivlw7AFR1yqC/GlOISH9cEJ6vmpfp45E5qy7FiSUHxg=;
        b=RdT+SOQ09Vah58v/Cy0oAhu7VoiS2Jj4m060gya4moRgEijqeu/jozXg6RCBxT1njk
         cyDPHAPSpKfdNX6kMpvowFnrWhEBdI7B4ITy3w3MjIXizuOhfzeaJPxYko5kcA7ld9yM
         0YoM48As3xl0p6TwYwTjmWuiBfamYn6Sy1xZdk9F7u0gIww9WRtc8b/r05l271IZT0Gr
         rwZWHo244hsVtbjlksNd2GVG2cV217SlW3yo6Ld/1haRl8qHLepr0xlIyBGbQUpTsBW8
         T7HDRo4tLJga0nGuVVCCRpMjGxzJKx15gEPFY8KwHn4FeeCVRVOazp8pyngEFSLd6iVr
         npDA==
X-Gm-Message-State: AOAM5339ovtgF/SUVQ1bsa+d20q+WGCh2LhXX2SOe5sCP0AqE+a4B4/r
	92mBlYmfk+/eCfUWq0yOZQLwWw==
X-Google-Smtp-Source: ABdhPJzLi7CagOcKPIv0N5O4UnJWtpHK+Yx9LY3phYfndc4AENNK+va3ijczjFxf9qME1aar7fANeQ==
X-Received: by 2002:a05:6402:2802:: with SMTP id h2mr7099410ede.58.1642414930154;
        Mon, 17 Jan 2022 02:22:10 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:d062:2656:aa4c:a3d0? ([2a02:578:8593:1200:d062:2656:aa4c:a3d0])
        by smtp.gmail.com with ESMTPSA id x11sm5716938edq.55.2022.01.17.02.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:22:09 -0800 (PST)
Message-ID: <e5c6e1a3-0963-e26c-3e0e-8d7ea7126116@tessares.net>
Date: Mon, 17 Jan 2022 11:22:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Dmytro SHYTYI <dmytro@shytyi.net>,
 mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
 <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro,

On 17/01/2022 11:03, Paolo Abeni wrote:
> On Mon, 2022-01-17 at 10:58 +0100, Paolo Abeni wrote:
>>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>>> index 48d8a363319e..d7092234d442 100644
>>> --- a/include/linux/tcp.h
>>> +++ b/include/linux/tcp.h
>>> @@ -54,7 +54,14 @@ static inline unsigned int tcp_optlen(const struct sk_buff *skb)
>>>  /* TCP Fast Open */
>>>  #define TCP_FASTOPEN_COOKIE_MIN	4	/* Min Fast Open Cookie size in bytes */
>>>  #define TCP_FASTOPEN_COOKIE_MAX	16	/* Max Fast Open Cookie size in bytes */
>>> +
>>> +#if IS_ENABLED(CONFIG_MPTCP)
>>> +#define TCP_FASTOPEN_COOKIE_SIZE 4	/* the size employed by MPTCP impl. */
>>> +#else
>>>  #define TCP_FASTOPEN_COOKIE_SIZE 8	/* the size employed by this impl. */
>>> +#endif
>>
>> You really need to document this kind of changes in the code, possibly
>> referring to the RFC bits requiring it. 
> 
> Note that MPC + syn currently uses 24 bytes of TCP option spaces, and
> MPC + syn + ack is using 32 bytes, to there is enough room for 8 bytes
> cookies.

Indeed, in MPTCPv1 (RFC8684), there is more space in the MPC+SYN as
mentioned in the Appendix B you referred to.

Also, you cannot change the value here depending on the kernel
configuration: that will break TFO for "plain" TCP I suppose.

Adding this feature is quite complex because our primary goal is not to
have any impact on TCP connections without MPTCP. Any modification in
TCP code needs to be very well justified to be accepted upstream.

Do not hesitate to join one of our weekly meeting and/or IRC channel [1]
to discuss about the implementation of this feature. Because of the
task's complexity, it is probably better to discuss than having long and
probably discouraging feedback loops by email. WDYT?

[1] https://github.com/multipath-tcp/mptcp_net-next/wiki#resources

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
