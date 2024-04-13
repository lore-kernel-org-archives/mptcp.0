Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0841E891
	for <mptcp@lists.linux.dev>; Sat, 13 Apr 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713026721; cv=none; b=W+8IlPyJEC/5gbOuwPAnsCWCRP0lHYYNRQJodgifETDUqW4eJyr/a3gBRdVpiCQ6tlEcbmj3j5ipI4YIvKC1/ZFUy8h8k4IEPk+GMG5FOknaLfwfhrQBKT9cSyIM+10+5QrXMLyCTIhLVUbLH7ksfr04QMQ18Xfi1t43RnFkA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713026721; c=relaxed/simple;
	bh=PSejv3wYmsFleA1hJ0BcjHUG7LsWO1m7TNaYBaCINPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIAmsc2TeDBDMrT/F44lQBV6bx4n/Wg2oUoR88aFK6j0rGg6tTdfgxHmxID2kFDuS7QF0LkLM8GlSJpYSu4HlrlZpKF6SNi8BTUinnd2EAjrIN8Z41N5fqwRc8q7vOYJlQV2BHfgwwxKj10puxId3xl20yUHGqUbiZIw5th8VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrbpgpBC; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrbpgpBC"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36b0e1301e3so5074575ab.2
        for <mptcp@lists.linux.dev>; Sat, 13 Apr 2024 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713026719; x=1713631519; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AWoi7AcWMFrM9AuKQoXehk+tHcCjKtQiu66Iwn+m2w=;
        b=JrbpgpBCbsLbDhIJtWSNPXzKZGetPIOBZRZkfVknRS+axs9KhnFs6zRN1pM31oazz8
         8t6w7QdtYbauM0dAyDljsGRH64pSoT239LP3XHwAH9l2puYaP11MiT+xa8ld/Pk7gV9B
         YvHUK6Nrz+VK7KzI27Xgwc1/IbaNbXqxF6TJhOLHR/xoVJuZI+BN94z7sxMFbBSJd53W
         XnUp1qCcCe+CrcROW5rMlHNVxkyKjEAVrm57IqGldoYnpfOFQ9Lmmva3ka7T6802vnlj
         zL4rNuJfI0t22/StFwm0tyAwy2gTvy/cQfSQrsMv+CAanxbK2g9cutetIvY6MIlEwese
         aaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713026719; x=1713631519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AWoi7AcWMFrM9AuKQoXehk+tHcCjKtQiu66Iwn+m2w=;
        b=IIuO9TwVV2/uOnZzwoojVtR1QZP+K7Lnl2gNFQLksXXuv0Ous7KuiuSI9xwvs0ia6U
         qZeFPSd1hXcabqAl5Dv97wucNz6oiMi84/F/83/bnLQuGRsB5Jc2RZUytQLGTCGtaDuL
         FoDBJKWJBaOpmPwP3E5BYSdRzpYf7pBWLbF6RctIRFVB6wBramdvnPQ+QUbqKzR2eFXW
         RgsvR8yM2H3mkPNzFubin1SgCjjjNdpORTUtQomYALov6IU12NvC7m4b0IXTlsyu+h9t
         +x0HSgFKBpU8caM3tptO5VBtFfYj0RimBHOIy9Bix/nBJwe09N6WYzikLRp86wMpwVut
         KXog==
X-Forwarded-Encrypted: i=1; AJvYcCWglX2x22xto0SyuxOSh5qbcAz+cPoGgek3VLyHW6CWh8SmdZFXzhbQcRxHL6002I5eEyZgmsyisV/0zHWY6yWzIr17pjc=
X-Gm-Message-State: AOJu0Yziw2G1CL31QRfgyF8x0QrOjqFzWkhpNG8HILDC8i+Ilsobfjqf
	Gg6FfXiz1TCjRLbRWRaljMYYyd/qRQj4RBJ/NNQ3LE/f7W4LrHAwHxjSRA==
X-Google-Smtp-Source: AGHT+IEArR68JchitJk+iKq+CDG6LfBrmucdDPCF9/7R1BU3ZawZGdLkvQOpMdnIneKpjvAzObMwaw==
X-Received: by 2002:a05:6e02:1689:b0:36a:1e10:6820 with SMTP id f9-20020a056e02168900b0036a1e106820mr6687857ila.23.1713026719388;
        Sat, 13 Apr 2024 09:45:19 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:91c:ed53:dd92:4d73? ([2601:282:1e82:2350:91c:ed53:dd92:4d73])
        by smtp.googlemail.com with ESMTPSA id l17-20020a05663814d100b0047f1e195368sm1767578jak.136.2024.04.13.09.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 09:45:19 -0700 (PDT)
Message-ID: <69e00bd0-a1d7-4021-ada9-9d344e0e84e4@gmail.com>
Date: Sat, 13 Apr 2024 10:45:17 -0600
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ss: mptcp: print out last time counters
Content-Language: en-US
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Stephen Hemminger <stephen@networkplumber.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-v1-1-7985c7c395b9@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-v1-1-7985c7c395b9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 2:19 AM, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <geliang@kernel.org>
> 
> Three new "last time" counters have been added to "struct mptcp_info":
> last_data_sent, last_data_recv and last_ack_recv. They have been added
> in commit 18d82cde7432 ("mptcp: add last time fields in mptcp_info") in
> net-next recently.
> 
> This patch prints out these new counters into mptcp_stats output in ss.
> 
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/uapi/linux/mptcp.h | 4 ++++
>  misc/ss.c                  | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index c2e6f3be..a0da2632 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h

uapi headers are synced using scripts, meaning at best uapi updates
should be a separate patch (the updates can also be omitted).

> @@ -56,6 +56,10 @@ struct mptcp_info {
>  	__u64	mptcpi_bytes_received;
>  	__u64	mptcpi_bytes_acked;
>  	__u8	mptcpi_subflows_total;
> +	__u8	reserved[3];
> +	__u32	mptcpi_last_data_sent;
> +	__u32	mptcpi_last_data_recv;
> +	__u32	mptcpi_last_ack_recv;
>  };
>  
>  /* MPTCP Reset reason codes, rfc8684 */
> diff --git a/misc/ss.c b/misc/ss.c
> index 87008d7c..81b813c1 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -3279,6 +3279,12 @@ static void mptcp_stats_print(struct mptcp_info *s)
>  		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
>  	if (s->mptcpi_subflows_total)
>  		out(" subflows_total:%u", s->mptcpi_subflows_total);
> +	if (s->mptcpi_last_data_sent)
> +		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
> +	if (s->mptcpi_last_data_recv)
> +		out(" last_data_recv:%u", s->mptcpi_last_data_recv);
> +	if (s->mptcpi_last_ack_recv)
> +		out(" last_ack_recv:%u", s->mptcpi_last_ack_recv);
>  }
>  

applied to iproute2-next

