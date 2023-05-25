Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39911182C1
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 15:19:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so7803275e9.2
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685027962; x=1687619962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prNC3HjsZzs8eOzws+Tortx7FIJ8Ph4hgPDy/VewQss=;
        b=3jtxsxEhInrEP7IkFJuj21ZniPZWZ/oZtbdvlCPnaHm0QR7N4OcPlayoF3Ln/qGYkt
         qWE8PnNLX+Ecw4MgtVEiEWhcZ2m/mN5mh1u5u9dLgJYiKyn+cCsupAmNxEzWvdAvyMOo
         kzTAsWwMgnMzZe4N81HRc7b4Kc8SNDMLCVcIH4OBR1NuPEVatvKuM4M8ft5+svY96rbc
         +ufkbbOGNde8WIsTJugL5F4F1CtVU48DvoezV/B0/TaPhwFJmsIkI1STTeOSt8QsMkJB
         hfjk6KfCeukF9P22LM3hIJQROOy5rhXsl+bX+Eq1xbyrXeFqLF8yk4ba5AiTtjpBy53u
         xBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027962; x=1687619962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prNC3HjsZzs8eOzws+Tortx7FIJ8Ph4hgPDy/VewQss=;
        b=iU7Wc3LFVeIpBfSQXtrQLcZCXduUC5TAf4hLfyTRciFbRJ1IiFnTiscbG7M1Ac0vm6
         Qy8ItI0cV8bn8btGyfRNHy9I821AtG3QcDSRy8uNpV32kTXwI9KkJm2kRvxHRD2GnM31
         3P7XrWnIe80bs0EMR+NQM0yZIQr41kaYo//XCVnG7zuROEnT0A7blEUCTDOzOmdPkLQZ
         OxITZ0nU25ldGdPYuVWH8hiASKF2l+OH/Bx+9t/NCZOzkbrWM0qLRpr7fQCTKySMZ8dl
         JbrybN3z31VHC3VRaHkGbAm/PIpqeVmVNehmB1zfCZoFpxMATDkbhImIOQKLWKpM/2G4
         2L6g==
X-Gm-Message-State: AC+VfDwRsJZD6HcMQSMVUxMLYRLvSSavpEoCsJ0KfIMTFNo5lu3JcK8I
	3v5qDjmGrfvEWewTn399UCnhOQ==
X-Google-Smtp-Source: ACHHUZ46Mu9YHTGfZSSybsPekdOhNDENMFHvIuYo/tonrB9HfBYaTQcZJNVCcBUtfwfDnLN0BusIBg==
X-Received: by 2002:a05:600c:246:b0:3f6:244:55df with SMTP id 6-20020a05600c024600b003f6024455dfmr2837190wmj.29.1685027962077;
        Thu, 25 May 2023 08:19:22 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c228d00b003f60455de07sm2425992wmf.15.2023.05.25.08.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 08:19:21 -0700 (PDT)
Message-ID: <0259fb14-db63-5156-881a-b74d07f15c8e@tessares.net>
Date: Thu, 25 May 2023 17:19:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 mptcp-next 2/6] mptcp: track some aggregate data
 counters.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684997011.git.pabeni@redhat.com>
 <9da66102af6d8df4ae08a5a5ff8526f52e2f34b5.1684997011.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9da66102af6d8df4ae08a5a5ff8526f52e2f34b5.1684997011.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/05/2023 09:17, Paolo Abeni wrote:
> Currently there are no data transfer counters accounting for all
> the subflows used by a given MPTCP socket. The user-space can compute
> such figures aggregating the subflow info, but that is inaccurate
> if any subflow is closed before the MPTCP socket itself.
> 
> Add the new counters in the MPTCP socket itself and expose them
> via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
> acquire the relevant locks before fetching the msk data, to ensure
> better data consistency
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/uapi/linux/mptcp.h |  5 +++++
>  net/mptcp/options.c        | 10 ++++++++--
>  net/mptcp/protocol.c       | 12 +++++++++++-
>  net/mptcp/protocol.h       |  4 ++++
>  net/mptcp/sockopt.c        | 22 +++++++++++++++++-----
>  5 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 32af2d278cb4..a124be6ebbba 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -123,6 +123,11 @@ struct mptcp_info {
>  	__u8	mptcpi_local_addr_used;
>  	__u8	mptcpi_local_addr_max;
>  	__u8	mptcpi_csum_enabled;
> +	__u32	mptcpi_retransmits;
> +	__u64	mptcpi_bytes_retrans;
> +	__u64	mptcpi_bytes_sent;
> +	__u64	mptcpi_bytes_received;
> +	__u64	mptcpi_bytes_acked;

I'm sure sure I followed correctly the discussions about that with
Florian: did we not want to switch to __aligned_u64 for the new fields?
(and why not the old ones as well if it doesn't change anything but at
least it would be uniformed)

If I'm not mistaken, it would not change anything but maybe better to be
on the safe side?

It is not blocking for the moment, a squash-to patch can still be used
later (or I do the modification directly when applying the patches).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
