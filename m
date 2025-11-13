Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33330102A
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018768; cv=none; b=A76QrKVIvPSkUL2IoqCfIR9ANcI5f9JFyN02df16JO104RVjVir6zBQ9E9ODZP4Lvax1K2QExfNIjNN+coMHlZJbeIrQRRRpptMVEQ/qS/LAul1MJR3yz6HnKpb7nrIge/vIYE7xwBaFNM6dvCevZ/Wtxj8xrdqqqJU+2OD7sn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018768; c=relaxed/simple;
	bh=kKY8FQbRz50Euv7nTi24SiBzShEtuBowOd0aeRF78ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lI22EC8fUoFylhlxSx52cdbFIhPRzSUI/aB7x/Q9HQgl232mQbMZGAJv2FrfRKiOtd6J4IE7lWDTMr6gf9LZeor8JM1qvNSzT/m8OFjv1oHioMENruUU8dLnurLj526kfceJtfCR+OLQRN5twainOLMWstck1w7Lw/JEHSxv4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iU/RD68H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iU/RD68H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763018764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMMRWO+7FiMvueuzRiiULgCPqSyakWRF4ndtIYi3/2s=;
	b=iU/RD68HG63Jf7Ande3egKryqF5F2aFNLkRDPDLTUBNoCIUe0TLRqRScxD9jd0Cp2H9IbB
	ULJJNHR1GRN0T2DaeI/1QYBjG9zDG1+ZL5Gy2Uu1a71cnuFjacUxiUXS59K0iqV5VlLu6g
	aTAAImy8kOuINhQXdtQCPWLPx5Ybx5o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-TrKfF6-9Oh2irFoNFDkFSA-1; Thu, 13 Nov 2025 02:26:02 -0500
X-MC-Unique: TrKfF6-9Oh2irFoNFDkFSA-1
X-Mimecast-MFC-AGG-ID: TrKfF6-9Oh2irFoNFDkFSA_1763018762
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4777885a071so2625125e9.3
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 23:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763018761; x=1763623561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMMRWO+7FiMvueuzRiiULgCPqSyakWRF4ndtIYi3/2s=;
        b=desnxqgYPct9VdJXXp3v8Ftu+mCzFhsDwQhNvMctQMQe3oQHloOXwdW/t9BF0WB2Lu
         bh9KthNXRvyf2PKFexICESYFXV1uh5eaI2ZebQ1vmYOWeUKUHs+UNG58CC6gbtNMfiD6
         fhxWP3gpivVpbkBRVFg7nldriYxYhE6q/iJmBbc826yqfC5p3CeFCpMMaP7ve8eIPLNJ
         gwL74YPXX+3fpu9eBBL+4iALGlBDAeS4YAQCueibI9ySWEL2M6Yfu3FDWpCmSacqnb5z
         g8b0WhiPHxaV3UeN3+BWwBtBq599RWEjAOZTGWer38a4wiXCVyLJ8bSMl+yduC4CWhKk
         e6nA==
X-Forwarded-Encrypted: i=1; AJvYcCVr3iE3CJkT9ekPwsxl4ogqug0insKmNc6LRLtz5aAgGmUEDWeD87e6JTb0BooUPwgX/UCmEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjAN/ookxR27ZnCw8GFJZj+19+shp2MKXUx3B21tIvwPpIsxSE
	E1x+D6Qyflim0ATRhN1X+KOtJlsFXDIfzP8SAjlgyTDP/8n/MzsdiO3h8MQe5gK6vIqHifQ6ruV
	1iYX0ETkZ438ZSjOr/OlsH9MN6lUlQwjYWDt1W03ApgB+b5E4HGYWRT7B
X-Gm-Gg: ASbGncvlaWuZU6DlYiOwvn/fZrFTuW+b/b4KRmsHEhJhljDu2QtTM+rBxUBnazuILD5
	YANT1jR+V18s9A8gWCz9rb9uDlDMEO6UJCney8qc5PaHJXqozcM97oaLDS4KF06j/50XWuhwqk3
	gMXCh69IkpL91ogPWqSkYkSKaGb0tRppDrK8aYx+wt0IZoNhk/+bnQz+eQa/eUvBCIY9v+sVsU6
	Ha3mU1ms5SZ0Rzj2ALHzqRnEwr9ouzxEeap5Dekd9rQS8SqzR+8fGg1/iyi8K19Yep1OQxXAHl5
	stssgP5QcW8w95iCdYTk261SOVrgOYWqgZj2HrdI/ZCsDGHdc/GlGSY53NN30FbnzziW3b9YMj2
	vmWnpstUue+UE
X-Received: by 2002:a05:600c:1c24:b0:477:67ca:cdbb with SMTP id 5b1f17b1804b1-477870b4636mr56025605e9.36.1763018761645;
        Wed, 12 Nov 2025 23:26:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYowpZo4vBkkPtxu1CjWglgL59pDiozG7KopjfEBZ761hW6geRVbj7rwF76H+VIRToEIbG5Q==
X-Received: by 2002:a05:600c:1c24:b0:477:67ca:cdbb with SMTP id 5b1f17b1804b1-477870b4636mr56025375e9.36.1763018761207;
        Wed, 12 Nov 2025 23:26:01 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcf9f27sm12986855e9.11.2025.11.12.23.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 23:26:00 -0800 (PST)
Message-ID: <45c6a268-3501-47da-b1ef-fbf3012a791c@redhat.com>
Date: Thu, 13 Nov 2025 08:25:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: get stats just before
 timing out
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
 <20251108-slft-timeout-stats-v1-4-c2234d277318@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251108-slft-timeout-stats-v1-4-c2234d277318@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fz-pKIssYvSGw_73z1pcTx6BiHPWQbug_206HwSIRF8_1763018762
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/25 3:20 PM, Matthieu Baerts (NGI0) wrote:
> Recently, some debugging happened around a test that was timing out. The
> stats were showing connections being closed which was confusing because
> the closing state was caused by the timeout stopping the transfer.
> 
> To avoid such confusion, the timeout is no longer done per mptcp_connect
> process, but separately. In case of timeout, the stats are now printed,
> then the apps are killed.
> 
> The stats will still be printed after the kill, but that's fine, and
> this might even be useful, just in case. Timeout should be exceptional.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This is very useful, thanks!

> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 21 +++++++++-------
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 29 +++++++++++-----------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 13 ++++++++++
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 21 +++++++++-------
>  tools/testing/selftests/net/mptcp/simult_flows.sh  | 24 ++++++++++--------
>  5 files changed, 66 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 1149bd150d6a..6bff77ed0a74 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -391,26 +391,29 @@ do_transfer()
>  		mptcp_lib_nstat_init "${connector_ns}"
>  	fi
>  
> -	timeout ${timeout_test} \
> -		ip netns exec ${listener_ns} \
> -			./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> -				$extra_args $local_addr < "$sin" > "$sout" &
> +	ip netns exec ${listener_ns} \
> +		./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> +			$extra_args $local_addr < "$sin" > "$sout" &
>  	local spid=$!
>  
>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
>  
>  	local start
>  	start=$(date +%s%3N)
> -	timeout ${timeout_test} \
> -		ip netns exec ${connector_ns} \
> -			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> -				$extra_args $connect_addr < "$cin" > "$cout" &
> +	ip netns exec ${connector_ns} \
> +		./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> +			$extra_args $connect_addr < "$cin" > "$cout" &
>  	local cpid=$!
>  
> +	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
> +		"${connector_ns}" "${port}" "${cpid}" "${spid}" &

I'm still debugging some timeouts caused by `${timeout_poll}`. In such
cases the process still terminates and closes the relevant fd. I'm
wondering additionally setting ${timeout_test} to a lower value of
${timeout_poll}?

BTW I'm testing with CONFIG_PREEMPT=y and possibly I'm seeing the
timeout due to such setting triggering some race we don't observe with
vng defaults: it's very easily reproducible on mptcp_connect.sh
"disconnect" case.

/P

